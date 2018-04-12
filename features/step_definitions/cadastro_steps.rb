Dado("que eu acessei a página de cadastro") do
  @cadastro.load
  expect(@cadastro.subtitulo_page.text).to eql 'Criar uma conta Mark7'
end

Dado('possuo os seguintes dados:') do |table|
  # criei a variavel tabela cadastro com @ para ser enxergada em todo os cenários
  # comando .rows_hash => transforma a tabela em um objeto hash (igual array)
  @table_cadastro = table.rows_hash
  
end

Quando("faço o meu cadastro") do
  
  #------ Sem Page Object ------------------
  # fill in ..., with: => preencha com (vai preencher o campo com os dados passados) funciona quando o campo tem 'id' ou 'name' no html
  # Estavamos usando sem pag object ... com pagem object a implementação esta na classe cadastro
  #fill_in 'register_name', with: @cadastro['Nome']
  #fill_in 'register_email', with: @cadastro['Email']
 
  # exemplo caso o campo senha não tiversse id nem name poderiamos montar um css e manda pelo comando find
  # fill_in 'register_password', with: @cadastro['Senha']
  #find('input[type=password]').set @cadastro['Senha']

  # Click_button => Comando do capybara que procura um botão com este nome(valor) para clicar
  # click_button 'Cadastrar'
  #find('button[type=submit]').click

  #------ Com Page Object ------------------

  #chamando metodo do page object cadastro
  @cadastro.cadastro_user(@table_cadastro)
end

Então('sou redirecionado para o meu painel de tarefas') do
  @tasks.wait_for_table_body
  expect(@tasks.titulo.text).to eql 'Painel de Atividades'
end

Então("devo ver uma mensagem de alerta {string}") do |mensagem_alerta|
    expect(@cadastro.alert.text).to have_content mensagem_alerta
end