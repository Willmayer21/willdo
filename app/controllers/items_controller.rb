class ItemsController < ApplicationController
  def index
  end

  def show
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
  end

  def destroy
  end

  private

  # def item_params
  #   params.expect(item: [ :name ])
  # end

  # def list_params
  #   params.expect(item: [ :list, :list_id ])
  # end
end
