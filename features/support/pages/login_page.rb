class LoginPage < SitePrism::Page
    #set_url = comando do SitePrism para armazenar url que será chamada no load no step correspondente
    #como a URL foi definida no env.rb agora só é necessário passar a rota.
    set_url '/'
    element :input_email, 'input[placeholder="example@gmail.com"]'
    element :input_senha, 'input[type=password]'
    element :botao_logar, 'button[id*=btLogin]'
    element :alert, '.alert-login'

    #button[id*=btnLogin] * = contem 
    #button[id^=btnLogin] ^ = começa com
    #button[id$=btnLogin] $ = termina com

    #metodo encapsulando a ação de logar recebendo email e senha
    def logar(email, senha)
        input_email.set email
        input_senha.set senha
        botao_logar.click
    end

end