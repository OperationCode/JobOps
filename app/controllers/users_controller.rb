class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = User.find_by_id(current_user.id)
    @twitter_user = User.new.twitter_user(current_user.id)
    @facebook_user = User.new.facebook_user(current_user.id)
    if !@facebook_user.nil?
      @facebook_user = @facebook_user.fetch
    end
    render :template => 'users/profile/show'
  end

  def show
    @user = User.find(params[:id])
    @twitter_user = User.new.twitter_user(current_user.id)
    render :template => 'users/profile/show'
  end

  def edit
    @user = User.find(params[:id])
    render :template => 'users/profile/edit'
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
         if @user.update_attributes(params[:user])
           format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
           format.xml  { head :ok }
         else
           format.html { render :action => "edit" }
           format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
         end
    end
  end

end
