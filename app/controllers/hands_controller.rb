class HandsController < ApplicationController
  require "judge.rb"
  include Judge_Service

  def top
    @result = nil
    @result_error = nil
  end

  def result
    @card = params[:hand]
    text = Text.new(@card)
    @result_error = text.valid
    @result = text.judge
    render("top")
  end


end