class PaymentsController < ApplicationController
    before_action :authenticate_user!
  
    # GET /payments or /payments.json
    def index
      @payments = payment.limit(100)
    end
  
    # GET /payments/new
    def new
      @payment = payment.new
    end
  
    # POST /payments or /payments.json
    def create
      @payment = payment.new(payment_params)
  
      respond_to do |format|
        if @payment.save
          format.html { redirect_to payment_url(@payment), notice: "Débito criado." }
          format.json { render :show, status: :created, location: @payment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /payments/1 or /payments/1.json
    def destroy
      @payment = payment.find(params[:id])
      @payment.destroy!
  
      respond_to do |format|
        format.html { redirect_to payments_url, notice: "Débito removido." }
        format.json { head :no_content }
      end
    end
  
    private
  
      # Only allow a list of trusted parameters through.
      def payment_params
        params.require(:payment).permit(:person_id, :amount, :observation)
      end
  end
  