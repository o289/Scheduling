class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :find_params, only: [:show,:edit,:update,:destroy]
    def index
        @tasks = Task.all
        @task = Task.new
    end

    def show
    end
    
    def create
        @task = Task.new(task_params)
        @task.user_id = current_user.id
        if @task.save
            redirect_tasks
        end
    end
    
    def edit
        if @task.user != current_user
            redirect_to root_path, alert: '不正アクセスです。'
        end
    end
    
    def update
        if @task.update(task_params)
            redirect_tasks
        else
            render 'edit'
        end
    end
    
    
    def destroy
        @task.destroy  
        redirect_tasks
    end


    private
    def task_params
        params.require(:task).permit( :title, :in_detail, :start_time )
    end

    def find_params
        @task = Task.find(params[:id])
    end
    def redirect_tasks
        redirect_to root_path
    end
end
