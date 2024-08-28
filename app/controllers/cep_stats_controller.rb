class CepStatsController < ApplicationController
  def show
    @cep_stat = CepStat.find params[:id]
  end

  def most_searched
    @most_searched_cep_stats = CepStat.order(search_quantity: :desc).limit(5)
  end

  def ceps_by_state
    state_ceps = CepStat.where(state: params[:state]).order(search_quantity: :desc).limit(5)

    return render status: :not_found, json: [] if state_ceps.empty?

    render json: state_ceps.to_json(only: %i[id cep state city])
  end
end
