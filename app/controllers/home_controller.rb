class HomeController < ApplicationController
  def index
    if params[:cep]
      response = Faraday.get("https://cep.awesomeapi.com.br/json/#{params[:cep]}")
      data = JSON.parse response.body
      new_cep = CepStat.create! cep: data['cep'], address: data['address'], state: data['state'], city: data['city'],
                                district: data['district'], latitude: data['lat'], longitude: data['lng'],
                                ddd: data['ddd']
      redirect_to cep_stat_path new_cep
    end
  end
end
