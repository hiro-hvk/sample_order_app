class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    @search = Subject.all.search(params[:q]) # .searchメソッドでモデルオブジェクトも生成？
    @delivery = @search.result.page(params[:page]).per(10) #viewのkaminariの表示件数を5件に設定
    @subjects = @delivery.all.order(created_at: :desc) #deliveryは引き渡しという意味
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    
    @subjects.inject(0) { |sum, subject_cost|
      @price_total = sum += subject_cost.quantity.to_i * (subject_cost.hvk.to_i + subject_cost.fujii.to_i + subject_cost.imamoto.to_i)
    }
    
    @subjects.inject(0) { |sum, subject_cost|
      @hvk_total = sum += (subject_cost.quantity.to_i * subject_cost.hvk.to_i)
      #@imamoto_total = sum + (subject_cost.quantity.to_i * subject_cost.imamoto.to_i)
    }
    
    @subjects.inject(0) { |sum, subject_cost|
      @fujii_total = sum + (subject_cost.quantity.to_i * subject_cost.fujii.to_i)
    }
    
    @subjects.inject(0) { |sum, subject_cost|
      @imamoto_total = sum + (subject_cost.quantity.to_i * subject_cost.imamoto.to_i)
    }
    
    @subjects.inject(0) { |sum, subject_cost|
      @selling_price_total = sum + (subject_cost.quantity.to_i * subject_cost.selling_price.to_i)
    }
    
    if @price_total.to_i != 0
      @grossmargin_rate = ((@selling_price_total.to_f.quo(@price_total.to_f))*100).round # 粗利益率 = 売価の合計 / 原価の合計
    end
    
    @gross_profit = @selling_price_total - @price_total # 粗利益 = 売上合計 - 原価合計
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
    @subject.costs.build
  end

  # GET /subjects/1/edit
  def edit
    @subject = Subject.find(params[:id])
    #@subject.costs.order(:id)
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    @subject = Subject.find(params[:id])
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
      @subjects = @subject.costs.order(:id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(
        :title, :remarks, :order_number, :delivery_date,
        costs_attributes: [:id, :user_id, :subject_id, :sign, :material, :product, :product_model, :pressure, :size, :quantity, :unit, :hvk, :fujii, :imamoto, :selling_price, :remarks, :_destroy]
        )
    end
    
end
