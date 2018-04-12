Dado('que estou autenticado com {string} e {string}') do |email, senha|
    #load = carrega a URL definida no sitePrism com set_url
    @login.load     
    #chamando o metodo logar passando email e senha
    @login.logar(email, senha)
    #Recurso do siteprism que leva em consideração o wait max time do capybara
    @tasks.wait_for_table_body
end

Dado('acesso meu perfil') do
    #Usa um ou outro
    #@perfil.load # usuario acessa via URL (exemplo: favoritos)
    
    #agora com a nav virando section chama a pagina de task que enxerga a nav e depois a section representada pela nav
    #usuario acessa via link no menu superior (navbar)
     @tasks.nav.menu_usuario.click
     @tasks.nav.meu_perfil.click
end

Quando('completo meu cadastro com empresa {string} e {string}') do |empresa, cargo|
    @perfil.atualiza(empresa, cargo)
end

Então('vejo a mensagem {string}') do |mensagem|
    @perfil.wait_for_formulario
    #sleep 15 #Aplicação esta muito lenta e acaba dando timeout do max_default_time do capybara
    #Erro acontecia pois o foto do perfil era muito grande e aparentemente sempre carregava ao salvar o perfil e demorava. Colocado imagem menor e voltou a carregar rapido.
    expect(@perfil.formulario).to have_content mensagem

end

# Upload foto

Dado("eu tenho uma foto muito bonita") do
    #File.join = recurso do ruby
    #Dir.pwd = indentificar que esta no diretorio local de execução do cucumber
    @minha_foto = File.join(Dir.pwd, 'features/support/fixtures/ninja.jpg')
    @minha_foto
end

Quando("faço o upload da minha foto") do
    @perfil.upload(@minha_foto)
end

Então("devo ver a mensagem de upload com o texto {string}") do |mensagem|
    expect(@perfil.formulario).to have_content mensagem
end