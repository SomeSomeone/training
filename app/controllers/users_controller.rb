class UsersController < ApplicationController

  def index
    @users=User.all
  end

  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)
     respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user, notice: 'Comment was successfully create.' }
        format.json { render @user, status: :ok, location: @user }
      else
       format.html { render :new , alert: 'ALL BAD!' }
       format.json { render json: @user, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
     respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user=User.find(params[:id])
    @posts = Post.where("user_id=?" , @user.id)
  end

  def destroy
    @user=User.find(params[:id])
    if current_user?(@user)
      log_out
    end
    @user.destroy
    redirect_to root_url

  end
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar)
    end
end
