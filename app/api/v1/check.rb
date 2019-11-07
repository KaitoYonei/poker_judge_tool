module Check
  class V1 < Grape::API

    include JudgeService
    format :json

    resource :cards do
      post "/check" do

        params do
          requires :cards, type: Array
        end

        cards = params[:cards]
        @api_result = []
        @api_error = []
        @api_strong_score = []

        cards.each do |card|
          target = JudgeHands.new(card)
          @error_message = target.valid
          @result = target.judge
          @strong_score = JUDGE_STRONG_SCORE[@result]
          @error_message.each {|err| @api_error.push({"card"=>card,"msg"=>err})} if @error_message
          if @result
            @api_result.push({"card"=>card,"hand"=>"#{@result}"})
            @api_strong_score.push(@strong_score)
          end
        end

        best_number = @api_strong_score.max
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
