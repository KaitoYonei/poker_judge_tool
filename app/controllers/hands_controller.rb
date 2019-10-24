class HandsController < ApplicationController
  require "judge"
  include JudgeService

  def top
    @result = nil
    @error_message = nil
  end

  def result
    @card = params[:hand]
    target = JudgeHands.new(@card)
    @error_message = target.valid
    @result = target.judge
    render("top")
  end


end