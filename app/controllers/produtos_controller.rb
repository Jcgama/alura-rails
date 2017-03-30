class ProdutosController < ApplicationController
  # Para as actions listadas no only: chamar set_produto, que instancia um objeto do Model Produto com o id
  before_action :set_produto, only: [:destroy]
  
  def index
    @produtos_por_nome = Produto.order(:nome).limit 9
    @produtos_por_preco = Produto.order(:preco).limit 2
  end
  
  def new
    @produto = Produto.new
  end
  
  def create
    @produto = Produto.create produto_params
    redirect_to root_path
  end
  
  def busca
    @nome_a_buscar = params[:nome]
    @produtos = Produto.where "nome like ?","%#{@nome_a_buscar}%"
  end
  
  def destroy
    # @produto foi setado na before_action
    @produto.destroy
    redirect_to root_path
  end
  
  def set_produto
    @produto = Produto.find(params[:id])
  end
  
  # Nunca confie em parâmetros da assustadora internet. Aqui vão os permitidos.
  def produto_params
    params.require(:produto).permit(:nome,:descricao,:quantidade,:preco)
  end
  
end
