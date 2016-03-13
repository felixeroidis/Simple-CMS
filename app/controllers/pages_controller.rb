class PagesController < ApplicationController
  before_action :confirm_logged_in
  before_action :find_page, only: [:show, :edit, :update, :delete, :destroy]
  
  #layout false #cause we will work with layout later
  layout "admin"
  def index
    #@subjects = Subject.order("position ASC")
    @pages = Page.sorted #using scope    
  end

  def show
    #No needs to find the record because we used before_action to do it.
    #@subject = Subject.find(1)  #find(params[:id])
  end

  def new
    @page = Page.new({:name =>'Default'})
    @subjects = Subject.order('position ASC') #to use with the select() in page new and edit
    @page_count = Page.count + 1
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      flash[:notice] = "Page '#{@page.name}' created successfully"
      redirect_to(:action =>'index')
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
      render('new')
    end
  end

  def edit
    #No needs to find the record because we used before_action to do it.
    @page_count = Page.count
    @subjects = Subject.order('position ASC')
  end

  def update
    #No needs to find the record because we used before_action to do it.
    #@subject.update_attributes(subject_params)     
    if @page.update(page_params)
      flash[:notice] = "Page '#{@page.name}' updated successfully"
      redirect_to(:action => 'show', :id => @page.id)
    else
      @page_count = Page.count
      @subjects = Subject.order('position ASC')
      render('edit')
    end
  end
  

  def delete
    #No needs to find the record because we used before_action to do it.
  end

  def destroy
    #No needs to find the record because we used before_action to do it.
    @page.destroy
    flash[:notice] = "Page '#{@page.name}' destroyed successfully"
    redirect_to(:action =>'index')
  end



  private

  def find_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end
end

