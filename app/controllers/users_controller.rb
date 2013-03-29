class UsersController < ApplicationController
  
  # vérifier que le bon utilisateur est signed-in pour
  # pouvoir accéder aux fonctions edit et update
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :not_signed_in_user, only: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
  	else
  		flash.now[:error] = "Oops, looks like something went wrong!"
      render 'new'
  	end
  end

  def edit
    # @user = User.find(params[:id])
    # plus besoin car défini dans l'action correct_user
  end

  def update
    # @user = User.find(params[:id])
    # plus besoin car défini dans l'action correct_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      flash.now[:error] = "Oops, looks like something went wrong!"
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    if current_user?(@user)
      redirect_to users_path, notice: "You can't delete yourself..."
    else
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    end
  end

  private

    def not_signed_in_user
      unless !signed_in?
        redirect_to root_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
