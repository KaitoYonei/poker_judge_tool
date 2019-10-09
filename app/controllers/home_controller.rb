class HomeController < ApplicationController
  require "judge.rb"
  include Judge_System

  def top
    @result = nil
    @result_error = nil
  end

  def result
    @card = params[:input]
    text = Text.new(@card)
    @result_error = text.valid
    @result = text.judge
    render("top")
  end


end