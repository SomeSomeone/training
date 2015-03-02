class UsersController < ApplicationController
  before_action :log_into_the_system , except: [:show , :index , :new]
  before_action :correct_user , only: [:edit , :update , :destroy]
  before_action :standart_user , only: [:show]

  def index
    @users=User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
     
     respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user, notice: 'Comment was successfully create.' }
        format.json { render :show, status: :ok, location: @user }
      else
       format.html { render :new , alert: 'ALL BAD!' }
       format.json { render json: @user, status: :unprocessable_entity }
      end
    end
  end



  def update
    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @posts = Post.where("user_id=?" , @user.id).paginate(:page => params[:page], :per_page => 6)
  end

  def destroy
    if current_user?(@user)
      log_out
    end
    @user.destroy
    redirect_to root_url
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
    def correct_user
      @user=current_user
    end

    def standart_user
      @user=User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar)
    end
end
