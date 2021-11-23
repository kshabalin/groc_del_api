class ApplicationController < ActionController::API
        include RenderMethods
        include DeviseTokenAuth::Concerns::SetUserByToken
end
