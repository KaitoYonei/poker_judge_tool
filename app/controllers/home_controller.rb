class HomeController < ApplicationController
  require "judge.rb"
  include Judge_System

  def top
    @result = nil
    @result_error = nil
  end

  def result
    @card = params[:hand]
    text = Text.new(@card)
    @result_error = text.valid
    @result = text.judge
    @input_array = @card.split
    render("top")
  end


end