class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.created_desc(params[:page])
    # @tasks = Task.all.created_desc(params[:page])
    # @tasks = Task.all.page(params[:page]).order(created_at: :desc).per(5)
    # @tasks = Task.all.page(params[:page]).order(params[:sort]).per(5)

    @tasks = Task.all.deadline_desc(params[:page]) if params[:sort_expired] == "true"
      # @tasks = Task.all.deadline_desc(params[:page])
      # @tasks = Task.all.page(params[:page]).order(deadline: :desc).per(5)

    @tasks = Task.all.priority_asc(params[:page]) if params[:sort_priority] == "true"

    if params[:name_search].present? && params[:status_search].present?
      @tasks = @tasks.name_search(params[:name_search]).status_search(params[:status_search])
      # @tasks = @tasks.where('name LIKE ?', "%#{params[:name_search]}%").where(status: params[:status_search])
    elsif params[:name_search].present?
      @tasks = @tasks.name_search(params[:name_search])
      # @tasks = @tasks.where('name LIKE ?', "%#{params[:name_search]}%")
    elsif params[:status_search].present?
      @tasks = @tasks.status_search(params[:status_search])
    end

    # @tasks = Task.name_status_search(params[:name_search], params[:status_search[]).name_search(params[:name_search])]).status_search(params[:status_search])


  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        flash.now[:danger] = '新規作成が完了しました'
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        flash.now[:danger] = '更新が完了しました'
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      flash.now[:danger] = '削除が完了しました'
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :detail, :deadline, :status, :priority)
    end
end
