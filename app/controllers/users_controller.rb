class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :find_params, only: [:show, :edit, :update, :destroy, :user_tasks]

    def index
        @users = User.where.not(id: current_user.id)
    end
    def show       
        @current_entry = Entry.where(user_id: current_user.id)
        @another_entry = Entry.where(user_id: @user.id)
        unless @user.id == current_user.id
            @current_entry.each do |current|
                @another_entry.each do |another|
                if current.room_id == another.room_id then
                    @is_room = true
                    @room_id = current.room_id
                end
                end
            end
        if @is_room
        else
            @room = Room.new
            @entry = Entry.new
        end
        end
    end

    def edit
        if @user != current_user
            redirect_to root_path, alert: '不正アクセスです。'
        end
    end

    def update
        if @user.update(user_params)
            redirect_tasks notice: '更新完了'
        else
            render :edit, status: :unprocessable_entity 
        end
    end

    def destroy
        if @user.destroy
            flash[:success] = 'user was successfully deleted.'
            redirect_tasks
        else
            flash[:error] = 'Something went wrong'
            render :index
        end    
    end
    

    def followings
        user = User.find(params[:id])
        @users = user.followings
    end

    def followers
        user = User.find(params[:id])
        @users = user.followers
    end

    def user_tasks
        
    end

    private
    # 保存するパラメータを記載
    def user_params
        params.require(:user).permit(:name, :profile, :email, :image)
    end

    # ユーザーを取得する
    def find_params
        @user = User.find(params[:id])
    end

    # トップページに遷移する
    def redirect_tasks(current_user)
        redirect_to root_path
    end

    
end
