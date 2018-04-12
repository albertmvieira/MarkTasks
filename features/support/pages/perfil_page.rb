require_relative 'sections'

class PerfilPage < SitePrism::Page

    set_url '/user_settings/profile'

    #criado seção para avar pois ela não é uma página e esta acessível a todos
    # nome da sessão :nav (reperesentado pela classe Navbar (passando o id master da do menu navbar))
    section :nav, Navbar, '#navbar'

    #fazendo a busca no css com regular expression $ (termina com)
    element :input_empresa, 'input[name$=company]'
    element :combo_cargo, 'select[name$=job]'
    element :salvar, '#form-submit-button'
    element :formulario, '.panel-body'

    def atualiza(empresa, cargo)
        input_empresa.set empresa
        #para o campo de combo box pode ser usado o seguinte recurso
        #da um .find na variavel e na option busca o texto comparando com o cargo vindo da variavel e pede para seleciona .select_option
        combo_cargo.find('option', text: cargo).select_option               
        salvar.click
    end

    def upload(foto)
        #recurso do capybara para anexar arquivo passando o elemento - tem que ser com id ou name do elemento
        attach_file('profile-avatar', foto)
    end

end