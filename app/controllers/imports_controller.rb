class ImportsController < ApplicationController

  def new
    @import = Import.new
    @sgid=params[:sgid]
  end

  def create
    @sgid=params[:sgid]
    @import = Import.new(params[:import])

    respond_to do |format|
      if @import.save
        flash[:notice] = 'CSV data was successfully imported.'
        format.html { redirect_to :action=>'show', :id=>@import.id, :sgid=>@sgid }
      else
        flash[:error] = 'CSV data import failed.'
        format.html { render :action => "new" }
      end
    end
  end

  def show
    @import = Import.find(params[:id])
  end

  def proc_excel

    @import = Import.find(params[:id])
        redirect_to :controller => :student_groups, :action => 'assign_roles_excel', :id=>params[:sgid] ,:imid=>@import.id

  end

  def proc_csv

    @import = Import.find(params[:id])
    lines = parse_csv_file(@import.csv.path)
    lines.shift # comment this line out if your CSV file doesn't contain a header row

    if lines.size > 0
      @import.processed = lines.size
      lines.each do |line|
        case @import.datatype
          when "users_without_roles"
            new_bulk_user(line)
            when "users_with_roles"
              @flag=true
        end
      end

      @import.save



      flash[:notice] = "CSV data processing was successful."
      redirect_to :action => "show", :id => @import.id
    else
      flash[:error] = "CSV data processing failed."
      render :action => "show", :id => @import.id
    end
  end

  private

  def parse_csv_file(path_to_csv)
    lines = []

    #if not installed run, sudo gem install fastercsv
    #http://fastercsv.rubyforge.org/
    require 'fastercsv'
    require 'csv'

    if CSV.const_defined? :Reader
      csv = FasterCSV
    else
      csv = CSV
    end

    csv.foreach(path_to_csv) do |row|
      lines << row
    end
    lines
  end

  def new_bulk_user(line)
    params = Hash.new
    params[:user] = Hash.new
    params[:user][:identifier] = line[0]
    params[:user][:first_name] = line[1]
    params[:user][:last_name] = line[2]
    params[:user][:username] = line[3]
    params[:user][:facilitator_group_id] = FacilitatorGroup.find(:first, :conditions=>["name=?", line[4]]).id
    params[:user][:admin] = line[5]
    params[:user][:educator] = line[6]
    params[:user][:email] = line[7]
    params[:user][:password] = line[8]
    params[:user][:password_confirmation] = line[8]

    if !line[4].blank?
      if FacilitatorGroup.exists?(["name=? and client_id=?", line[4], Client.find(:first, :conditions=>["name=?", line[9]]).id])
      else
        @new_sg=FacilitatorGroup.new
        @new_sg.name=line[4]
        @new_sg.client_id=Client.find(:first, :conditions=>["name=?", line[9]]).id
        @new_sg.save
        params[:user][:facilitator_group_id] = FacilitatorGroup.find(:first, :conditions=>["name=?", line[4]]).id
      end
    end
    if User.find(:first, :conditions=>["username=?", line[3]]).blank?
      @user = User.new(params[:user])
      if @user.save!
        UserMailer.deliver_welcome_email(@user)
      end
    else
      @user=User.find(:first, :conditions=>['username=?', line[3]])
      @user.update_attributes(params[:user])
      if @user.save!
        #        UserMailer.deliver_welcome_email(@user)
      end
    end

  end
end