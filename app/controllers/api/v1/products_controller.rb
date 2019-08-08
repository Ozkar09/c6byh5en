class Api::V1::ProductsController < ApplicationController

  def index
    @products = Product.all
    render json: @products.as_json
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.json { render json: @product, status: :created, location: @product }
      else
        format.json { render json: @product.errors.full_messages, status: 422}
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.update(params[:id], product_params)
  end

  private
    def product_params
      params.require(:product).permit(:name, :price)
    end
end
