class UsersController < ApplicationController
  before_filter :logged_in?

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "New account was successfully created."
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
    @current_user = current_user
    if @current_user.id.to_s == params[:id] 
      @back_path = home_path
    else
      respond_to do |format|
        format.html { redirect_to home_path, notice: "You can't edit other user's personal information." }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
         format.html { redirect_to home_path, notice: "User information was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
