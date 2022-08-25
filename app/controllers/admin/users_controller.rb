class Admin::UsersController < ApplicationController
    before_action :admin_true?

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to admin_user_path(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        @tasks = Task.all.includes(:user)
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to admin_user_path(@user)
        else
            render :new
        end
    end

    def index
        @users = User.all
    end

    def destroy
        @user.destroy

        respond_to do |format|
          flash.now[:danger] = '削除が完了しました'
          format.html { redirect_to admin_users_url, notice: "削除が完了しました" }
          format.json { head :no_content }
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :admin)
    end

end
