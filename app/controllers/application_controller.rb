class ApplicationController < ActionController::API
  def index
    applications = Application.order("created_at DESC")
    return_data=[]
    applications.each{|app| return_data.push(app)}
    render json: {status: 'SUCCESS', message: 'get applications', data: return_data}, status: 200
  end

  def get_by_uuid
    application = Application.find_by_token(params[:app_token])
    if application==nil
      render json: {status: 'NOT FOUND', message: ('cant find application by token= '+ token)}, status: 404
    else
      render json: {status: 'SUCCESS', message: 'get application', data: model_to_dto(application)}, status: 200
    end
  end

  def create
    application = tdo_to_model

    if application.save
      render json: {status: 'SUCCESS', message: 'application saved successfully', data: model_to_dto(application)}, status: :ok
    else
      render json: {status: 'ERROR', message: 'failure at saving application', data: application.errors}, status: :unprocessable_entity
    end
  end

  def update_by_uuid
    application = Application.find_by_token(params[:app_token])
    if application==nil
      render json: {status: 'NOT FOUND', message: ('cant update application by token= '+ token)}, status: 404
    else
      application.app_name=params[:app_name]
      application.save
      render json: {status: 'SUCCESS', message: 'get application', data: model_to_dto(application)}, status: 200
    end
  end

  private

  def tdo_to_model
    application = Application.new
    application.token = SecureRandom.uuid
    application.app_name = params[:app_name]
    application
  end

  def model_to_dto(application)
    {:app_name => application.app_name.to_s, :token => application.token}
  end
end
