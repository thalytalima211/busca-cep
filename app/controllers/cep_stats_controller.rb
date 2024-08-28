class CepStatsController < ApplicationController
  def show
    @cep_stat = CepStat.find params[:id]
  end

  def most_searched
    @most_searched_cep_stats = CepStat.order(search_quantity: :desc).limit(5)
  end
end
