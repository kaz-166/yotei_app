class PagesController < ApplicationController
  before_action :sign_in_required, only: [:show]
  def index
    if user_signed_in?
      redirect_to '/pages/show'
    else
      redirect_to '/users/sign_in'
    end
  end

  def show
  end


end
