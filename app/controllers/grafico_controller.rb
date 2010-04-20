class GraficoController < ApplicationController
  before_filter :load_unidades
  def index

  end

  def grafico_demanda_geral
    @graph = open_flash_chart_object(600,300,"/grafico/graph_code_demanda_geral")
  end  

  def crianca_por_unidade        
  end

  def search
      input = params[:contact][:grafico_id]
      @graph = open_flash_chart_object(600,300,"/grafico/graph_por_unidade?unidade=#{input}",false,'/')
      render :action => "crianca_por_unidade"
  end

  def graph_code_demanda_geral
    title = Title.new("Demanda Geral")
    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# of #total#<br>#percent# of 100%'
    pie.colours = ["#d01f3c", "#356aa0", "#C79810"]
    pie.values  = [PieValue.new(Crianca.c.length,"Crianças Cadastradas"),PieValue.new(Crianca.b_u.length,"Crianças Matriculadas"), PieValue.new(Crianca.b_dm.length,"Crianças Não Matriculadas")]
    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.x_axis = nil
    render :text => chart.to_s
  end
  
  def graph_por_unidade    
    unidade = params[:unidade]
    title = Title.new("Demanda por Unidade: " + Crianca.nome_unidade(unidade))
    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# of #total#<br>#percent# of 100%'
    pie.colours = ["#d01f3c", "#356aa0", "#C79810"]
    todas_criancas = Crianca.todas_crianca_por_unidade(unidade)
    matriculada = Crianca.matriculas_crianca_por_unidade(unidade)
    nao_matriculada = Crianca.nao_matriculas_crianca_por_unidade(unidade)
    pie.values  = [PieValue.new(todas_criancas.length,"Crianças Cadastradas na unidade: " + (todas_criancas.length).to_s),PieValue.new(matriculada.length,"Crianças Matriculadas na unidade: " + (matriculada.length).to_s), PieValue.new(nao_matriculada.length,"Crianças Não Matriculadas: " + (nao_matriculada.length).to_s)]
    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.x_axis = nil
    render :text => chart.to_s
  end





protected

  def load_unidades
    @unidades = Unidade.all
  end
end
