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
      @api_strong_score = []

      cards.each do |card|
        target = JudgeHands.new(card)
        @error_message = target.valid
        @result = target.judge
        @strong_score = JUDGE_STRONG_SCORE[@result]
        if @error_message
          @error_message.each do |err|
            @api_error.push({"card"=>card,"msg"=>err})
          end
        end
        if @result
          @api_result.push({"card"=>card,"hand"=>"#{@result}"})
          @api_strong_score.push(@strong_score)
        end
      end

      best_number = @api_strong_score.sort.reverse[0]
      x = 0

      @api_strong_score.each do |stg|
        @api_result[x].store("best",stg == best_number)
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
