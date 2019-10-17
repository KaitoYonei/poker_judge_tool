class HandsController < ApplicationController
  require "judge"
  include JudgeService

  def top
    @result = nil
    @result_error = nil
  end

  def result
    @card = params[:hand]
    target = Target.new(@card)
    @result_error = target.valid
    @result = target.judge
    render("top")
  end


end