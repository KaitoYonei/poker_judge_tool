class HandsController < ApplicationController
  #require "judge_service"
  include JudgeService

  def top
    @result = nil
    @error_message = nil
  end

  def result
    @card = params[:hand]
    target = JudgeHands.new(@card)
    @error_message = target.valid

    if @error_message
      render:action => 'top', :status => 400
    else
      @result = target.judge
      render("top")
    end
  end
end