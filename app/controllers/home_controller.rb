class HomeController < ApplicationController
  def index
    return unless params[:cep]

    cep = CepStat.find_by cep: params[:cep]
    if cep
      cep.search_quantity = cep.search_quantity + 1
      cep.save!
      redirect_to cep_stat_path cep
    else
      load_cep_data
    end
  end

  private

  def load_cep_data
    cep_number = params[:cep].gsub('-', '')
    response = Faraday.get("https://cep.awesomeapi.com.br/json/#{cep_number}")
    status =  response.status
    if status == 200
      data = JSON.parse response.body
      new_cep = CepStat.create! cep_params(data)
      redirect_to cep_stat_path new_cep
    else
      handle_error_response status
    end
  end

  def handle_error_response(status)
    case status
    when 404
      redirect_to root_path, notice: I18n.t('alerts.cep_stat.cep_not_found')
    when 400
      redirect_to root_path, notice: I18n.t('alerts.cep_stat.cep_invalid')
    end
  end

  def cep_params(data)
    { cep: params[:cep], address: data['address'], state: data['state'], city: data['city'], district: data['district'],
      latitude: data['lat'], longitude: data['lng'], ddd: data['ddd'] }
  end
end
