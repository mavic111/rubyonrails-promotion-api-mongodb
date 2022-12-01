class HomeController < ApplicationController
    def index
        redirect_back_or_to '/api/docs/v1'
    end
end