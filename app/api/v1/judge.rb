module Judge
  class V1 < Grape::API

    include JudgeService
    format :json
    resource :judge do

    rescue_from Grape::Exceptions::Base do
      @api_error = []
      @api_error.push({"msg"=>"不正なリクエストです。"})
      error!({"error": @api_error},400)
    end
    rescue_from :all do |e|
      error!({error: e.message, backtrace: e.backtrace[0]}, 500)
    end

    params do
      requires :cards, type: Array
    end

    post do
      cards = params[:cards]
      @api_result = []
      @api_error = []
      @api_best = []

      cards.each do |var|
        target = JudgeHands.new(var)
        @error_message = target.valid
        @result = target.judge
        @best = target.best
        if @error_message
          @error_message.each do |err|
            @api_error.push({"card"=>var,"msg"=>err})
          end
        end
        if @result
          @api_result.push({"card"=>var,"hand"=>"#{@result}"})
          @api_best.push(@best)
        end
      end

      best_number = @api_best.sort.reverse[0]
      x = 0

      @api_best.each do |bst|
        @api_result[x].store("best",bst == best_number)
        x += 1
      end

      if @api_result == []
        {"error": @api_error}
      elsif @api_error == []
        {"result":@api_result}
      else
        {"result": @api_result,
        "error":@api_error}
      end
    end
  end
  end
end
