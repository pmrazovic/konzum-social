class OrdersController < ApplicationController
  before_filter :authenticate_user!
end