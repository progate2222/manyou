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
        respond_to do |format|
            if @user.update(user_params)
              format.html { redirect_to admin_user_path(@user), notice: "ユーザーの更新に成功しました" }
              format.json { render :show, status: :ok, location: @user }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        # if @user.update(user_params)
        #     redirect_to admin_user_path(@user)
        # else
        #     render :new
        # end
    end

    def index
        @users = User.all
    end

    def destroy
        @user.destroy

        respond_to do |format|
            if @user.destroy(user_params)
                format.html { redirect_to admin_users_path, notice: "削除が完了しました" }
                format.json { render :index, status: :ok, location: @user }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
        #   flash.now[:danger] = '削除が完了しました'
        #   format.html { redirect_to admin_users_url, notice: "削除が完了しました" }
        #   format.json { head :no_content }
    end 

    private

    def user_params
        params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :admin)
    end

end
