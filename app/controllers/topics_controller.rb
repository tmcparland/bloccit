class TopicsController < ApplicationController
  
   before_action :require_sign_in, except: [:index, :show]
   before_action :authorize_edit, only: [:edit, :update]
   before_action :authorize_create_and_delete, only: [:new, :create, :destroy]
    
  def index
      @topics = Topic.all
  end
    
  def show
      @topic = Topic.find(params[:id])
  end
    
  def new
      @topic = Topic.new
  end
    
  def create
    @topic = Topic.new(topic_params)
 
    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end
    
  def edit
      @topic = Topic.find(params[:id])
  end
    
  def update
    @topic = Topic.find(params[:id])
 
    @topic.assign_attributes(topic_params)
 
    if @topic.save
      flash[:notice] = "Topic was updated successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
 
    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
  end
  
   private
 
   def topic_params
     params.require(:topic).permit(:name, :description, :public)
   end

   def authorize_edit
     unless current_user.mod? || current_user.admin?
      flash[:error] = "You are not authorized to do that."
      redirect_to topics_path
     end
   end

   def authorize_create_and_delete
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to topics_path
     end
   end
end
