require_relative "config/application"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "pry"

# usuário acessa a url "localhost:4567/"
get "/" do
  # pegar todos Restaurants do BD
  # (se criamos uma variável de instância, a mesma estará disponível
  # na view que chamarmos)
  @restaurants = Restaurant.all

  # chamar a view index.erb
  erb :index
end

# usuário acessa a url "localhost:4567/restaurant_details/???"
# como o '???' é dinâmico, podemos guardar o que quer que ele
# seja colocando ':alguma_coisa' dentro da url que iremos aceitar
# (no nosso caso colocamos ':id')
get '/restaurant_details/:id' do
  # tudo que vem da View para o controller está guardado em params
  # Tudo que vem da View para o controller está guardado em params
  # TUdo que vem da View para o controller está guardado em params
  # TUDo que vem da View para o controller está guardado em params
  # TUDO QUE VEM DA VIEW PARA O CONTROLLER ESTÁ GUARDADO EM PARAMS

  # pegar um restaurante pelo id
  # (se criamos uma variável de instância, a mesma estará disponível
  # na view que chamarmos)
  @restaurant = Restaurant.find(params[:id])

  # mandar o restaurante para a view 'restaurant_details.erb'
  erb :restaurant_details
end


# como não queremos que o usuário seja capaz de acessar essa página
# digitando o link na url (apenas submetendo o formulário), aceitamos
# apenas requisição do tipo POST à url "localhost:4567/new_restaurant"
post '/new_restaurant' do

  # criamos um novo Restaurant com as informações vindas do formulário
  @restaurant = Restaurant.new(
    name: params[:restaurant_name], # vindo de <input name="restaurant_name">
    address: params[:restaurant_address] # vindo de <input name="restaurant_address">
  )

  # salvamos o restaurante no BD
  @restaurant.save

  # redirecionamos o usuário para outra página
  redirect "/restaurant_details/#{@restaurant.id}"
end
