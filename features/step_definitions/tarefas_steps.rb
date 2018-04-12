Dado("que eu tenho uma tarefa com os atributos:") do |table|
    @tarefa = table.rows_hash
    #Usando interpolação de strings
    @tarefa['titulo'] = "#{@tarefa['titulo']} #{Faker::Lorem.characters(10)}"
  end 
  
  Dado("eu quero taguear esta tarefa com:") do |table|
    @tags = table.hashes
  end

  Dado("eu já cadastrei esta tarefa e não tinha percebido") do
    @tasks.botao_novo.click
    @tasks.adicionar.nova(@tarefa, @tags)
  end
  
  Quando("faço o cadastro desta tarefa") do
    @tasks.botao_novo.click
    @tasks.adicionar.nova(@tarefa, @tags)
  end
  
  Então("devo ver este cadastro com status {string}") do |status_tarefa|
    @tasks.wait_for_itens
    expect(@tasks.itens.first).to have_content status_tarefa

    @tasks.busca(@tarefa['titulo'])
    
    expect(@tasks.itens.size).to eql 1
  end

  Então("devo ver a mensagem {string} ao tentar fazer o cadastro") do |mensagem|
    expect(@tasks.adicionar.mensagem.text).to eql mensagem
  end

  # Remover Tarefas

  Dado("que eu tenho uma tarefa cadastrada") do
    @tarefa_para_remover = {
      'titulo' => "Tarefa muito legal para remover - #{Faker::Lorem.characters(10)}",
      'data' => '01/12/2018'
    }
    @tags = []

    @tasks.botao_novo.click
    @tasks.adicionar.nova(@tarefa_para_remover, @tags)
  end
  
  Quando("eu solicito a exclusão desta tarefa") do
    @tasks.wait_for_itens
    @tasks.apagar_por_titulo(@tarefa_para_remover['titulo'])
    sleep 1 #think time do usuario lendo modal
  end
  
  Quando("confirmo a solicitação") do
    @tasks.confirma_modal.click
  end

  Quando("cancelo a solicitação") do
    @tasks.cancela_modal.click
  end
  
  Então("esta tarefa não deve ser exibida na lista") do
    
    #validando através do botão de busca da pagina
    #@tasks.busca(@tarefa_para_remover['titulo'])
    #expect(@tasks.conteudo_pagina).to have_content 'Hmm... nenhuma tarefa encontrada :('

    #validando percorrendo a lista na tela
    @tasks.wait_for_itens
    expect(@tasks.itens).not_to have_content @tarefa_para_remover['titulo']

    #com selenium puro
    #resultado = @tasks.itens.include?(@tarefa_para_remover['titulo'])
    #expect(resultado).to be false
  end

  Então("esta tarefa permanece cadastrada na lista") do
    @tasks.busca(@tarefa_para_remover['titulo'])
    expect(@tasks.itens.first).to have_content @tarefa_para_remover['titulo']
  end
