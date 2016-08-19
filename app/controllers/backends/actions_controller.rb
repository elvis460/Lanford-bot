class Backends::ActionsController < BackendsController
  before_action :find_action, only: [:show,:edit,:destroy,:update]

  def index
    @actions = Action.all
  end

  def show
    @products = @action.products
  end

  def product_button
    @product = Product.find(params[:id])
    @product_buttons = @product.product_buttons
  end

  def edit
    @products = @action.products
  end

  def update
    params[:act][:product_title].each_with_index do |title,index|
      product = @action.products[index]
      product.update(title: title,subtitle: params[:act][:product_subtitle][index],item_url: params[:act][:product_item_url][index],image_url: params[:act][:product_image_url][index])
      product.product_buttons[0].update(button_type: 'web_url',title: params[:act][:product_button_title][index*2],url: params[:act][:product_button_url][index*2])
      product.product_buttons[1].update(button_type: 'postback',title: params[:act][:product_button_title][(index*2)+1],payload: params[:act][:product_button_payload][index])
    end
    if @action.save
      redirect_to backends_actions_path
    else
      render :new
    end
  end

  def new
    @action = Action.new
  end

  def create
    @action = Action.create(name: params[:act][:name],action_type: params[:act][:action_type])
    params[:act][:product_title].each_with_index do |title,index|
      product = @action.products.create(title: title,subtitle: params[:act][:product_subtitle][index],item_url: params[:act][:product_item_url][index],image_url: params[:act][:product_image_url][index])
      product.product_buttons.create(button_type: 'web_url',title: params[:act][:product_button_title][index*2],url: params[:act][:product_button_url][index*2])
      product.product_buttons.create(button_type: 'postback',title: params[:act][:product_button_title][(index*2)+1],payload: params[:act][:product_button_payload][index])
    end
    if @action.save
      redirect_to backends_actions_path
    else
      render :new
    end
  end
  private
  def find_action
    @action = Action.find(params[:id])
  end
end
