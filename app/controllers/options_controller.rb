class OptionsController < ApplicationController
  # GET /options
  # GET /options.xml
  def index
    if(params[:qid].nil?)
      @options=Option.all
    else
    @question=Question.find(params[:qid])
    @options = @question.options

    end
    @no_of_options=0
    if(@question.type_id != 3)
      if(@question.type_id==1)
        @no_of_options=4

      else
        @no_of_options=2
      end
      end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @options }
    end
  end

  # GET /options/1
  # GET /options/1.xml
  def show
    @option = Option.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @option }
    end
  end

  # GET /options/new
  # GET /options/new.xml
  def new
    #@option = Option.new
    x=0

    @question=Question.find(params[:qid])

    if(@question.type_id==1)
      x=4-@question.options.count
    elsif(@question.type_id==2)
      x=2-@question.options.count
    else
      x=0
    end
       @options = Array.new(x){Option.new }


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @option }
    end
  end

  # GET /options/1/edit
  def edit

    @option = Option.find(params[:id])
  end

  # POST /options
  # POST /options.xml
  def create
    #@option = Option.new(params[:option])

    f=0
     @options = params[:options].values.collect{ |option| Option.new(option) }
     @options.each do |o|
       if o.save
         f=1
       else
         f=0
                   end

	 end
	@question=Question.find(@options[0].question_id)
    respond_to do |format|
      if f==1
        format.html { redirect_to(:controller => :questions,:action=>"index",:qid=>@question.questionnaire_id, :notice => 'Options were successfully created.') }
        format.xml  { render :xml => @option, :status => :created, :location => @option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /options/1
  # PUT /options/1.xml
  def update
    @option = Option.find(params[:id])

    respond_to do |format|
      if @option.update_attributes(params[:option])
        format.html { redirect_to(@option, :notice => 'Options were successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.xml
  def destroy
    @option = Option.find(params[:id])
    @qid=@option.question_id
    @option.destroy

    respond_to do |format|
      format.html { redirect_to(options_url(:qid=>@qid)) }
      format.xml  { head :ok }
    end
  end
end
