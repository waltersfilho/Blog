class CommentsController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_comment, only: [:create, :destroy, :upvote, :downvote]
  before_action :authenticate_user!

  #Garantindo que somente o dono de um Post ou do Comentário pode pode executar a ação destroy
  before_filter :require_permission, only: [:destroy]

  def create
    #Construção de um comentário dentro do post.
    @comment = @post.comments.build(comment_params)
    #associando o usuário ao comentário
    @comment.user_id = current_user.id
    @comment.save
    redirect_to @post
  end
  def destroy
    #Encontrando um comentário dentro do post.
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post
  end

  def upvote
    @comment.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @comment.downvote_by current_user
    redirect_to :back
  end

  private
    def require_permission
      set_comment
      if (current_user != @post.user) and (current_user != @comment.user)
        flash[:notice] = 'Permissões insuficientes!'
        redirect_to @post
      end
    end
    #precisamos encontrar o post para manipular o comentário dentro dele
    def set_post
      @post = Post.find(params[:post_id])
    end

    #precisamos encontrar o post para manipular o comentário dentro dele
    def set_comment
      set_post
      @comment = @post.comments.find(params[:id])
    end

    #agora não precisamos mais do post_id. Ele é preenchido automaticamente.
    def comment_params
      params.require(:comment).permit(:message)
    end
end
