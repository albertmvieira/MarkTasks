Before do
  # Acessando API para deletar email do usuario para não ter problemas de massa
  visit 'https://marktasks.herokuapp.com/api/reset/albert@qaninja.io?clean=full'

  # instanciando as classes (que estão no Page objects)
  @login = LoginPage.new
  @tasks = TarefasPage.new
  @perfil = PerfilPage.new
  @cadastro = CadastroPage.new

  #comando capybara para ajustar tamanho minimo da janela do browser caso necessário
  #usar quando necessário ou software precisar se adequar ao padrão de tela especifico
  #page.current_window.resize_to(1280, 800)
end

Before('@auth') do
  @login.load
  #chamando o metodo logar passando email e senha
  @login.logar('albert@teste.com', '123456')
end

# After tageado será executado somente nos cenários que tiverem esta tag e após execução
After('@logout') do
  @tasks.nav.bye
end

After('@perfil_logout') do
  @perfil.nav.bye
end

# Pegar as propriedades do cenário para poder gerar o print
After do |scenario|
  #retirando os espaços vazios dos nomes dos cenarios e substituindo por _
  # e passando comando downcase! para deixar em caixa baixa
  nome_cenario =  scenario.name.tr(' ', '_').downcase!
  
  #gsub - substring do ruby com regex para substituir caracteres especiais por nada e não dar problema ao salvar print de cenário outline (esquema do cenario)
  nome_cenario = nome_cenario.gsub(/([_@#!%()\-=;><,{}\~\[\]\.\/\?\"\*\^\$\+\-]+)/, '')
  #montando a estrutura para montar o screeshot com o caminho, nome do cenario e extensão
  screenshot = "logs/shots/#{nome_cenario}.png"

  #recurso do capybara para salvar screenshot
  page.save_screenshot(screenshot)

  #recurso do cucumber embed para anexar um screenshot no relatório
  #variavel, tipo da imagem, e texto que sera exibido para acesso ao print
  embed(screenshot, 'image/png', 'Clique para ver a evidência!')
end