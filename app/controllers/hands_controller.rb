class HandsController < ApplicationController
  require "judge"
  include JudgeService

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