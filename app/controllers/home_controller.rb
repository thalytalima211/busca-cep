class HomeController < ApplicationController
  def index
    if params[:cep]
      cep = params[:cep].gsub('-', '')
      response = Faraday.get("https://cep.awesomeapi.com.br/json/#{cep}")
      if response.status == 200
        data = JSON.parse response.body
        new_cep = CepStat.create! cep: data['cep'], address: data['address'], state: data['state'], city: data['city'],
                                  district: data['district'], latitude: data['lat'], longitude: data['lng'],
                                  ddd: data['ddd']
        redirect_to cep_stat_path new_cep
      elsif response.status == 404
        redirect_to root_path, notice: "O CEP #{params[:cep]} não foi encontrado! Verifique o código e tente novamente."
      elsif response.status == 400
        redirect_to root_path, notice: 'CEP inválido! Siga o formato (XXXXX-XXX).'
      end
    end
  end
end
