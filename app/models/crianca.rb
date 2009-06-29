class Crianca < ActiveRecord::Base
  belongs_to :unidade
  belongs_to :grupo
  belongs_to :regiao


  def trabalha?
    if self.trabalha then
      return 'Sim'
    else 
      return 'Não'
    end
  end

  def regiao_unidade
   @unidades = Unidade.find_by_regiao_id(params[:crianca_regiao_id])
   render :update do |page|  
      page.replace_html 'regiao', :partial => 'regiao_unidade'
#     page.replace_html "unidade", :inline => "<%= select "unidade", "id", @unidades %>"
   end  

  end

  def verifica_trabalha
    if trabalha == true then
       @vtrabalha = 'SIM'
    else
       @vtrabalha = 'NÃO'
    end
  end

  def verifica_matricula
    if matricula == 1 then
      @vmatriculado = 'SIM'
    else
      @vmatriculado = 'NÃO'
    end
  end

  def status
    if matricula == 1 then
      @status = 1
    else
      @status = 0
    end
  end

  def conf_status
    if status == 0 then
      @conf_status = 'MATRICULADO'
    else
      @conf_status = 'AGUARDANDO'
    end
    
  end
  def onde_matricula
    if unidade_matricula == 0 then
      @unmats = ''
    else
      @unmats = Unidade.find_by_id(unidade_matricula).nome
    end
  end

end

#   @unidades = Unidade.find :all, :conditions => {:regiao_id => params[:crianca_regiao_id]}
#    render :update do |page|
#      page.replace_html 'regiao', :partial => 'reg_unidades'
#    end


#    @unidades = Unidade.find :all, :conditions => {:regiao_id => params[:crianca_regiao_id]}
#    render :update do |page|
#      page.replace_html 'regiao', :partial => 'regiao_unidade'
#    end

