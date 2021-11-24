module ControllerHelper
  def response_json
    JSON.parse(response.body, object_class: HashWithIndifferentAccess)
  rescue JSON::ParserError
    {}
  end

  def response_data
    return {} if response_json[:data].nil?

    response_json[:data]
  end

  def authenticate(user)
    sign_in user
    request.headers.merge!(user.create_new_auth_token)
  end
end
