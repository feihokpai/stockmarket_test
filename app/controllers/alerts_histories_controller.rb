class AlertsHistoriesController < ApplicationController
  before_action :set_alerts_history, only: %i[ show edit update destroy ]

  # GET /alerts_histories or /alerts_histories.json
  def index
    @alerts_histories = AlertsHistory.all
  end

  # GET /alerts_histories/1 or /alerts_histories/1.json
  def show
  end

  # GET /alerts_histories/new
  def new
    @alerts_history = AlertsHistory.new
  end

  # GET /alerts_histories/1/edit
  def edit
  end

  # POST /alerts_histories or /alerts_histories.json
  def create
    @alerts_history = AlertsHistory.new(alerts_history_params)

    respond_to do |format|
      if @alerts_history.save
        format.html { redirect_to alerts_history_url(@alerts_history), notice: "Alerts history was successfully created." }
        format.json { render :show, status: :created, location: @alerts_history }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alerts_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alerts_histories/1 or /alerts_histories/1.json
  def update
    respond_to do |format|
      if @alerts_history.update(alerts_history_params)
        format.html { redirect_to alerts_history_url(@alerts_history), notice: "Alerts history was successfully updated." }
        format.json { render :show, status: :ok, location: @alerts_history }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alerts_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alerts_histories/1 or /alerts_histories/1.json
  def destroy
    @alerts_history.destroy

    respond_to do |format|
      format.html { redirect_to alerts_histories_url, notice: "Alerts history was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alerts_history
      @alerts_history = AlertsHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alerts_history_params
      params.require(:alerts_history).permit(:description)
    end
end
