class ProdutosController < ApplicationController
  # Para as actions listadas no only: chamar set_produto, que instancia um objeto do Model Produto com o id
  before_action :set_produto, only: [:destroy,:edit,:update]
  
  def index
    @produtos_por_nome = Produto.order(:nome).limit 9
  end
  
  def new
    @produto = Produto.new
    renderiza(:new)
  end
  
  def create
    @produto = Produto.new produto_params
    if @produto.save
      sucesso("Produto criado com sucesso")  
    else
      renderiza(:new)
    end
    
  end
  
  def busca
    @nome_a_buscar = params[:nome]
    @produtos = Produto.where "nome like ?","%#{@nome_a_buscar}%"
  end
  
  def destroy
    # @produto foi setado na before_action
    @produto.destroy
    mensagem = "Produto deletado com sucesso."
    sucesso(mensagem)
  end
  
  def edit
    renderiza(:edit)
  end
  
  def update
    if @produto.update(produto_params)
      sucesso("Produto atualizado com sucesso!")
    else
      renderiza(:edit)
    end
  end
  
  
  private
  
  # Instancia o produto pelo id
  def set_produto
    @produto = Produto.find(params[:id])
  end
  # Popula o array de depto e chama a view
  def renderiza(view)
    @departamentos = Departamento.all
    render view
  end
  
  # Nunca confie em parâmetros da assustadora internet. Aqui vão os permitidos.
  def produto_params
    params.require(:produto).permit(:nome,:descricao,:quantidade,:preco, :departamento_id)
  end
  
  # recebe uma string para exibir como mensagem e redireciona para root
  def sucesso(mensagem)
    flash[:notice] = mensagem
    redirect_to root_path
  end
  
end
