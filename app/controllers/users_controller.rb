class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem


  def index

  end

  # render new.rhtml
  def new
  end

  def aviso
      render :update do |page|
        page.replace_html 'loginnn', :partial => 'aviso'
      end

  end

  def listar_user_cad
    render :partial => 'listar_usuarios_cadastrados'
  end


  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
            render :action => 'aviso'
      flash[:notice] = "BEM VINDO AO SISTEMA PONTUA."
    else
      render :action => 'new'
    end
  end


  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "SENHA EFETUADA COM SUCESSO!"
    end
    redirect_back_or_default('/')
  end

  def show
    @user = current_user
  end

  


end
