class ChatController < ActionController::API

  def create
    chat = save_message
    if chat == nil
      render json: {status: 'NOT FOUND', message: ('cant find application by token= '+ params[:app_token])}, status: 404
    elsif chat.save
      render json: {status: 'SUCCESS', message: 'chat saved successfully', data: model_to_dto(chat)}, status: :ok
    else
      render json: {status: 'ERROR', message: 'failure at saving chat', data: chat.errors}, status: :unprocessable_entity
    end
  end

  private




  def save_message
    chat = Chat.new
    chat.chat_number= Chat.count+1
    application = Application.find_by_token(params[:app_token])
    if application == nil
      return nil
    end
    chat.applications_id = application.id
    chat
  end

  def model_to_dto(chat)
    {:chat_number => chat.chat_number}
  end
end
