#language:pt

Funcionalidade: Cadastro 
	Sendo um usuário que possui muitas tarefas
	Posso fazer meu cadastro no sistema
	Para poder gerenciar as minhas tarefas

    @smoke @cadastro
	Cenário: Cadastro simplificado

        Dado que eu acessei a página de cadastro
        E possuo os seguintes dados:
            | Nome  | Albert            |
            | Email | albert@qaninja.io |
            | Senha | 123456            |
        Quando faço o meu cadastro
        Então sou redirecionado para o meu painel de tarefas

    #Outline (Este cenário é o outline em inglês - para poder usar uma lista de massa de teste)
    @tentativa_cadastro
    Esquema do Cenario: Tentativa de cadastro
     
        Dado que eu acessei a página de cadastro
        E possuo os seguintes dados:
            | Nome  | <nome>   |
            | Email | <email>  |
            | Senha | <senha>  |
        Quando faço o meu cadastro
        Então devo ver uma mensagem de alerta "<alerta>"
    
    Exemplos:
        |nome       |email          	|senha  	    |alerta                 					|
        |Albert     |					|123456 	    |Email é obrigatório.						|
        |Albert     |albert@qaninja.io	|		    	|Informe uma senha.							|
        |Albert     |albert@qaninja.io	|12345	    	|Sua senha deve ter pelo menos 6 caracteres.|
        |Albert     |albert@qaninja.io	|1234	    	|Sua senha deve ter pelo menos 6 caracteres.|
        |Albert     |albert@qaninja.io	|123	    	|Sua senha deve ter pelo menos 6 caracteres.|
        |Albert     |albert@qaninja.io	|12		    	|Sua senha deve ter pelo menos 6 caracteres.|
        |Albert     |albert@qaninja.io	|1		    	|Sua senha deve ter pelo menos 6 caracteres.|

    #Usando o cenário Outline não precisa repetir todos os testes separados sendo que todos tem o mesmo fluxo e só muda a mensagem
    
    # Cenário: Senha não informada

    #     Dado que eu acessei a página de cadastro
    #     E possuo os seguintes dados:
    #         | Nome  | Albert            |
    #         | Email | albert@qaninja.io |
    #         | Senha |                   |
    #     Quando faço o meu cadastro
    #     Então devo ver uma mensagem de alerta "Informe uma senha."

    # @doing
    # Cenário: Mínimo de caracteres para senha

    #     Dado que eu acessei a página de cadastro
    #     E possuo os seguintes dados:
    #         | Nome  | Albert               |
    #         | Email | albert@qaninja.io    |
    #         | Senha | 12345                |
    #     Quando faço o meu cadastro
    #     Então devo ver uma mensagem de alerta "Sua senha deve ter pelo menos 6 caracteres."