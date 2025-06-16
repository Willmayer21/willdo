class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: [ :show, :edit, :update, :destroy, :toggle ]
  def index
  end

  def show
  end

  def new
    @item = Item.new(list_id: @list.id)
  end

  def create
    @item = Item.new(name: params[:item][:name], list_id: params[:list_id])
    if @item.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to list_item_path(@list, @item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to list_path(@list)
  end

  def toggle
    @item.update(completed: !@item.completed)
    target = params[:from_list] == "true" ? list_path(@list) : list_item_path(@item)
    redirect_to target
    # if params[:from_list] == "true"
    #   redirect_to list_path(@list)
    # elsif params[:from_item] == "true"
    #   redirect_to list_item_path(@item)
    # end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params.expect(item: [ :name ])
  end

  # def list_params
  #   params.expect(item: [ :list, :list_id ])
  # end
end
