class StocksController < ApplicationController
  before_action :load_wallets, only: %i[ new edit ]
  before_action :set_stock, only: %i[show edit update destroy update_price_with_api]


  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to wallet_path(@stock.wallet_id), notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }        
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to stock_url(@stock), notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_price_with_api
    api = MarketStackApi.new
    price = api.last_price_of(@stock.symbol, fake_request: false)
    @stock.update({ price: }) if price.present?

    notice = 'Price was updated using API.'
    notice = 'No prices returned from API.' if price.blank?
    redirect_to wallet_path(@stock.wallet_id), notice: notice
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find_by(id: params[:id])
      @stock = Stock.find_by(id: params[:stock_id]) if @stock.nil?
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:symbol, :price, :wallet_id)
    end

    def load_wallets
      @wallet = Wallet.find(params[:wallet_id]) 
      @wallets = Wallet.where({user: current_user})
    end
end
