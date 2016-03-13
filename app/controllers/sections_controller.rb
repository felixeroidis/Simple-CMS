class SectionsController < ApplicationController
  before_action :confirm_logged_in
  before_action :find_section, only: [:show, :edit, :update, :delete, :destroy]
  
  #layout false #cause we will work with layout later
  layout "admin"
  def index
    #@subjects = Subject.order("position ASC")
    @sections = Section.sorted #using scope    
  end

  def show
    #No needs to find the record because we used before_action to do it.
    #@subject = Subject.find(1)  #find(params[:id])
  end

  def new
    @section = Section.new({:name =>'Default'})
    @pages= Page.order('position ASC')
    @section_count = Section.count + 1
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      flash[:notice] = "Section '#{@section.name}' created successfully"
      redirect_to(:action =>'index')
    else
      @pages= Page.order('position ASC')
      @section_count = Section.count + 1
      render('new')
    end
  end

  def edit
    #No needs to find the record because we used before_action to do it.
    @pages= Page.order('position ASC')
    @section_count = Section.count
  end

  def update
    #No needs to find the record because we used before_action to do it.
    #@subject.update_attributes(subject_params)     
    if @section.update(section_params)
      flash[:notice] = "Section '#{@section.name}' updated successfully"
      redirect_to(:action => 'show', :id => @section.id)
    else
      @pages= Page.order('position ASC')
      render('edit')
    end
  end
  

  def delete
    #No needs to find the record because we used before_action to do it.
  end

  def destroy
    #No needs to find the record because we used before_action to do it.
    @section.destroy
    flash[:notice] = "Section '#{@section.name}' destroyed successfully"
    redirect_to(:action =>'index')
  end


  private

  def find_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:page_id, :content_type, :content, :name, :position, :visible)
  end
end
