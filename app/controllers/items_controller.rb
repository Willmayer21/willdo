class ItemsController < ApplicationController
  def index
  end

  def show
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])
  end

  def new
    @list = List.find(params[:list_id])
    @item = Item.new(list_id: @list.id)
  end

  def create
    @list = List.find(params[:list_id])
    @item = Item.new(name: params[:item][:name], list_id: params[:list_id])
    if @item.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @list = List.find(params[:list_id])
    @item = Item.find_by(id: params[:id], list_id: @list.id)
  end

  def update
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to list_item_path(@list, @item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @item = Item.find_by(id: params[:id], list_id: @list.id)
    @item.destroy
    redirect_to list_path(@list)
  end

  private

  def item_params
    params.expect(item: [ :name ])
  end

  # def list_params
  #   params.expect(item: [ :list, :list_id ])
  # end
end
