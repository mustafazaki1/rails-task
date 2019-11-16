class MessageController < ActionController::API

  def create
    result = save_message(params[:app_token], params[:chat_number])

    if result == nil
      render json: {status: 'NOT FOUND', message: ('cant find chat by token= ' + params[:app_token] + 'and chat_id= ' + params[:chat_number])}, status: 404
    elsif result != 0
      return_data = []
      result.each { |message| return_data.push(model_to_dto(message)) }
      render json: {status: 'SUCCESS', message: 'ok', data: return_data}, status: :ok
    end
  end

  def search_message_by_body_api
    result = search_message_by_body(params[:app_token], params[:chat_number], params[:body])

    return_data = []
    if result != nil && result.size != 0
      result.each { |message| return_data.push(model_to_dto(message)) }
    end
    render json: {status: 'SUCCESS', message: ',message saved successfully', data: return_data}, status: :ok
  end

  def get_all_messages_by_chat_api
    messages = get_all_messages_for_chat(params[:app_token], params[:chat_number])
    if messages == nil
      render json: {status: 'NOT FOUND', message: ('cant find application by token= ' + params[:app_token])}, status: 404
    else
      render json: {status: 'SUCCESS', message: 'chat saved successfully', data: model_to_dto(messages)}, status: :ok
    end
  end

  def get_all_messages_for_application_api
    messages = get_all_messages_for_application(params[:app_token])
    if messages == nil
      render json: {status: 'NOT FOUND', message: ('cant find application by token= ' + params[:app_token])}, status: 404
    else
      render json: {status: 'SUCCESS', message: 'chat saved successfully', data: model_to_dto(messages)}, status: :ok
    end
  end

  # ----------------------------------------------------------
  def get_all_messages_for_application(app_token)
    application = Application.find_by_token(app_token)
    if application == nil
      return nil
    end
    chats = Chat.where(applications_id: application.id)
    if chats.size == 0
      return nil
    end
    message_to_return = []
    chats.each { |chat|
      Message.find_by_chats_id(chat.id).each { |message|
        message_to_return.push(message);
      }
    }
    message_to_return
  end


  def get_all_messages_for_chat(app_token, chat_number)
    application = Application.find_by_token(app_token)
    if application == nil
      return nil
    end
    chats = Chat.where(chat_number: chat_number, applications_id: application.id)
    if chats.size == 0
      return nil
    end
    message_to_return = []
    chats.each { |chat|
      Message.find_by_chats_id(chat.id).each { |message|
        message_to_return.push(message);
      }
    }
    message_to_return
  end

  def search_message_by_body(app_token, chat_number, body)
    application = Application.find_by_token(app_token)
    if application == nil
      return nil
    end
    chats = Chat.where(chat_number: chat_number, applications_id: application.id)
    if chats.size == 0
      return nil
    end
    message_to_return = []
    chats.each { |chat|
      Message.search_published(body, chat.id).each { |message|
        message_to_return.push(message);
      }
    }
    message_to_return
  end

  def save_message(app_token, chat_number)
    application = Application.find_by_token(app_token)
    if application == nil
      return nil
    end
    chats = Chat.where(chat_number: chat_number, applications_id: application.id)
    if chats.size == 0
      return nil
    end
    sql = 'select * from messages INNER JOIN chats on chats.id = chats_id INNER JOIN applications on applications.id = chats.applications_id where chats.chat_number=' + chat_number + ' and applications.token="' + app_token + '"'
    message_number = Message.find_by_sql(sql).count + 1
    message_to_return = []
    chats.each { |chat|
      message = Message.new
      message.body = params[:body]
      message.chats_id = chat.id
      message.message_number = message_number
      message_number = message_number +1
      unless message.save
        render json: {status: 'ERROR', message: 'failure at saving message', data: message.errors}, status: :unprocessable_entity
        return 0
      end
      message_to_return.push(message);
    }
    message_to_return
  end

  def model_to_dto(message)
    {:body => message.body, :message_number => message.message_number}
  end
end
