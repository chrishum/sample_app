class UsersController < ApplicationController
  before_filter :authenticate,       :only => [:index, :edit, :update]
  before_filter :correct_user,       :only => [:edit, :update]
  before_filter :admin_user,         :only => :destroy
  before_filter :not_current_user,   :only => :destroy
  before_filter :non_signed_in_user, :only => [:new, :create]
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @user.password = ""
      @user.password_confirmation = ""
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user && current_user.admin?
    end
    
    def non_signed_in_user
      redirect_to(root_path) unless !signed_in?
    end
    
    def not_current_user
      @user = User.find(params[:id])
      redirect_to(users_path) if current_user?(@user)
    end
end
