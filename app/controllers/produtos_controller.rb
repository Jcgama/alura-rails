class ProdutosController < ApplicationController
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
  
  def destroy
    @produto.destroy
    redirect_to root_path
  end
  
  def set_produto
    @produto = Produto.find(params[:id])
  end
  
  def produto_params
    params.require(:produto).permit(:nome,:descricao,:quantidade,:preco)
  end
  
end
