class BriefingsController < ApplicationController
  def index
    @roles = Briefing.all(:conditions=>['role_id=?',params[:role]])
    @role = Role.find(params[:role])
  end

  def show
    @briefing = Briefing.find(params[:id])
  end

  def new
    @briefing = Briefing.new
    @role = Role.find(params[:role])
  end

  def create
    @briefing = Briefing.new(params[:briefing])
    if @briefing.save
      flash[:notice] = "Successfully created briefing."
      redirect_to @briefing
    else
      render :action => 'new'
    end
  end

  def edit
    @briefing = Briefing.find(params[:id])
  end

  def update
    @briefing = Briefing.find(params[:id])
    if @briefing.update_attributes(params[:briefing])
      flash[:notice] = "Successfully updated briefing."
      redirect_to @briefing
    else
      render :action => 'edit'
    end
  end

  def destroy
    @briefing = Briefing.find(params[:id])
    @briefing.destroy
    flash[:notice] = "Successfully destroyed briefing."
    redirect_to briefings_url
  end
end
