class UsersController < ApplicationController
  before_action :log_into_the_system , except: [:show , :index , :new , :create, :following , :followers]
  before_action :correct_user , only: [:edit , :update , :destroy]
  before_action :standart_user , only: [:show, :following , :followers]

  def index
    @users=User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user=User.new(user_params)
     
      if @user.save
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
        render :new 
        flash[:alert] = 'ALL BAD!' 
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
    if current_user?(@user)
      @posts = Post.where("user_id IN (?) OR user_id=?" , @user.following_ids , @user.id).paginate(:page => params[:page], :per_page => 6)
      @post=Post.new
    else
      @posts = Post.where("user_id=?" , @user.id).paginate(:page => params[:page], :per_page => 6)
    end
  end

  def destroy
    if current_user?(@user)
      log_out
    end
    @user.destroy
    redirect_to root_url
  end

  def following
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
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
