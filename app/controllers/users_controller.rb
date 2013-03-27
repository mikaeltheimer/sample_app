class UsersController < ApplicationController
  
  # vérifier que le bon utilisateur est signed-in pour
  # pouvoir accéder aux fonctions edit et update
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
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
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private
  
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
        # notice: "texte" <=> flash[:notice] = "texte"
        # valable avec :error mais pas avec :success
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
