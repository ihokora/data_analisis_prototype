class DatasetsController < ApplicationController
  before_action :set_dataset, only: [:show, :update, :destroy]

  # GET /datasets
  def index
    @datasets = Dataset.all

    render json: @datasets
  end

  # GET /datasets/1
  def show
    render json: @dataset
  end

  # POST /datasets
  def create
    @dataset = Dataset.new(dataset_params)
    data_x = @dataset[:data_x].split(",").map(&:to_i)
    stats = DescriptiveStatistics::Stats.new(data_x)
    stats = stats.descriptive_statistics
    if @dataset.save
      render json: stats, status: :created #location: @dataset
    else
      render json: @dataset.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /datasets/1
  def update
    if @dataset.update(dataset_params)
      render json: @dataset
    else
      render json: @dataset.errors, status: :unprocessable_entity
    end
  end

  # DELETE /datasets/1
  def destroy
    @dataset.destroy
  end

  # GET statistics info
  def stats

    render json: data_x
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dataset
      @dataset = Dataset.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dataset_params
      params.permit(:data_x, :data_y)
    end


end
