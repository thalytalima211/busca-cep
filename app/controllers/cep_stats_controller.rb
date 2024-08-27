class CepStatsController < ApplicationController
  def show
    @cep_stat = CepStat.find params[:id]
  end
end
