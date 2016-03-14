class DocumentsController < ApplicationController
  # This controller is not active, in this moment.
  # Controller that handles everything about the documents.
  # Creates & reads.

  DOCUMENT_SAVED_FLASH       = "Dokument sparades!"
  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.create(document_params)

    if @document.save
      flash[:success] = DOCUMENT_SAVED_FLASH
      redirect_to @document
    else
      render 'new'
    end
  end

  private
    # Strong parameters that whitelists params that is used in this controller.
    def document_params
      params.require(:document).permit(:title, :file, :category)
    end
end
