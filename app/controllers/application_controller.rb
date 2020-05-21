# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authenticate_application!

  private

  def authenticate_application!
    decoded_token = Base64.decode64(request.headers['Authorization'])

    app_name, token = decoded_token.split(':')
    if configuration(app_name).fetch('token') != token
      json_response({ error: 'Invalid token or application' }, :unauthorized)
    end
  end

  def configuration(app_name)
    applications_tokens_path = Rails.root.join('config', 'applications.yml')

    YAML.load_file(applications_tokens_path)[Rails.env][app_name]
  end
end
