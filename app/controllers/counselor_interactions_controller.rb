class CounselorInteractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counselor_interaction, only: [:show, :edit, :update, :destroy]

  def index
    @counselor_interactions = current_user.counselor_interactions
  end

  def show
    @response = @counselor_interaction.response
  end

  def new
    @counselor_interaction = CounselorInteraction.new
  end

  def create
    input_text = counselor_interaction_params[:input]
    response_text = get_ai_response(input_text)

    interaction = current_user.counselor_interactions.build(
      input: input_text,
      response: response_text
    )

    if interaction.save
      redirect_to interaction, notice: 'Counselor interaction was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @counselor_interaction.update(counselor_interaction_params)
      redirect_to @counselor_interaction, notice: 'Counselor interaction was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @counselor_interaction.destroy
    redirect_to counselor_interactions_url, notice: 'Counselor interaction was successfully destroyed.'
  end

  private

  def set_counselor_interaction
    @counselor_interaction = current_user.counselor_interactions.find(params[:id])
  end

  def counselor_interaction_params
    params.require(:counselor_interaction).permit(:input, :response)
  end

  def get_ai_response(prompt)
    client = OpenAI::Client.new(api_key: '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')
    response = client.completions(
      engine: "text-davinci-003",
      prompt: prompt,
      max_tokens: 000,
      temperature: 1.0
    )
    puts response.inspect
    response.choices[0].text.strip
  end
end
