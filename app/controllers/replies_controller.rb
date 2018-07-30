class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reply, only: [:show, :edit, :update, :destroy]
  before_action :set_discussion, except: [:new]
  
  def create
    @reply = Discussion.replies.create(params[:reply]).permit(:reply, :discussion_id)
    @reply.user_id = current_user.id
    
    respond_to do |format|
      if @reply.save
        format.html { redirect_to discussion_path(@discussion) }
        format.js # render create.js.erb
      else
        format.html { redirect_to discussion_path(@discussion), notice: "Your reply was not saved. Please try again" }
        format.js
      end
    end
  end
  
  def new
  end
  
  def destroy 
    @reply = Discussion.replies.find(params[:id])
    @reply.destroy
    
    respond_to do |format|
      
      format.html {redirect to discussion_path(@discussion), notice: "You reply was successfully destroyed" }
    end
  end
  
  def edit
    @discussion = Discussion.find(params[:discussion_id])
    @reply = @discussion.replies.find(params[:id])
  end
  
  def update
    @reply = @discussion.replies.find(params[:id])
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to discussion_path(@discussion), notice: 'Reply was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  
  private
  
  def set_reply
    @reply = Reply.find(params[:id])
  end
  
  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end
  
  def reply_params 
    params.require(:reply).permit(:reply)
  end
  
end