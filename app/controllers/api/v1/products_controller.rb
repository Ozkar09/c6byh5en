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
    @product = Product.find(params[:id])
    respond_to :json
      if @product.update(product_params)
        render json: @product.to_json, status: 200
      else
        render json: @product.errors.full_messages, status: 422
      end
  end

  def destroy
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.destroy
        format.json { render json: @product, status: 204, location: @product }
      else
        format.json { render json: @product.errors.full_messages, status: 422}
      end
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :price)
    end
end
