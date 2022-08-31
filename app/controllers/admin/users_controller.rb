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
                redirect_to admin_user_path(@user), notice: "ユーザーの更新に成功しました"
            else
                render :edit, status: :unprocessable_entity
            end
    end

    def index
        @users = User.all
    end

    def destroy
        @user = User.find(params[:id])
        @users = User.all
            if @user.destroy
                redirect_to admin_users_path, notice: "削除が完了しました"
            else
                render :index, status: :unprocessable_entity
            end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :admin)
    end

end
