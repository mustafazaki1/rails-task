namespace :batch do
  desc "TODO"
  task update_counter: :environment do
    applications= Application.all
    applications.each { |application|
      chat_count = Chat.where(applications_id: application.id).count
      application.chat_count=chat_count
      application.save
    }
    chats= Chat.all
    chats.each { |chat|
      message_count = Message.where(chats_id: chat.id).count
      chat.message_count=message_count
      chat.save
    }
  end

end
