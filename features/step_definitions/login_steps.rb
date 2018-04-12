Quando("faço login com {string} e {string}") do |email, senha|
    @email = email
    #load = carrega a URL definida no sitePrism com set_url
    @login.load
    #chamando o metodo logar passando email e senha
    @login.logar(email, senha)
  end
  

  Então("sou autenticado com sucesso") do
    #agora com a nav virando section chama a pagina de task que enxerga a nav e depois a section representada pela nav
    expect(@tasks.nav.menu_usuario.text).to eql @email
  end
  
  Então("vejo o meu painel de atividades") do
    expect(@tasks.titulo.text).to eql 'Painel de Atividades'
  end
  
  Então("devo ver a mensagem {string}") do |mensagem_alerta|
    expect(@login.alert.text).to eql mensagem_alerta
  end

  Então("não sou autenticado") do
    #Valida se o elemento não existe na pagina - has_no_titulo? é um recurso do SitePrism
    expect(@tasks.has_no_titulo?).to be false
  end