class ListsController < ApplicationController
  before_action :authenticated?
  before_action :set_list, only: %i[ show edit edit_name update destroy ]
  def index
    # @lists = List.all
    @lists = Current.user.lists
  end

  def show
    @items = @list.items.order(completed: :asc)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = Current.user.id
    if @list.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def edit_name
  end

  def update
    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.expect(list: [ :name ])
  end

  def set_list
    @list = List.find(params[:id])
  end
end
