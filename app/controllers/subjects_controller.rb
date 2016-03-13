class SubjectsController < ApplicationController
  before_action :confirm_logged_in
  before_action :find_subject, only: [:show, :edit, :update, :delete, :destroy]
  
  #layout false #cause we will work with layout later
  layout "admin"
  def index
    #@subjects = Subject.order("position ASC")
    @subjects = Subject.sorted #using scope    
  end

  def show
    #No needs to find the record because we used before_action to do it.
    #@subject = Subject.find(1)  #find(params[:id])
  end

  def new
    @subject = Subject.new({:name =>'Default'})
    @subject_count = Subject.count + 1
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      flash[:notice] = "Subject '#{@subject.name}' created successfully"
      redirect_to(:action =>'index')
    else
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    #No needs to find the record because we used before_action to do it.
    @subject_count = Subject.count
  end

  def update
    #No needs to find the record because we used before_action to do it.
    #@subject.update_attributes(subject_params)     
    if @subject.update(subject_params)
      flash[:notice] = "Subject '#{@subject.name}' updated successfully"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      @subject_count = Subject.count
      render('edit')
    end
  end
  

  def delete
    #No needs to find the record because we used before_action to do it.
  end

  def destroy
    #No needs to find the record because we used before_action to do it.
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed successfully"
    redirect_to(:action =>'index')
  end



  private

  def find_subject
    @subject = Subject.find(params[:id])    
  end

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at, :updated_at)
  end
end
