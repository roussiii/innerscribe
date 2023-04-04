class CounselorInteraction < ApplicationRecord
  require 'openai'
  belongs_to :user

  def self.get_ai_response(prompt)
    response = Openai::Completion.create(
      engine: "text-davinci-002",
      prompt: prompt,
      max_tokens: 100,
      n: 1,
      stop: nil,
      temperature: 0.7
    )

    response.choices.first.text.strip
  end
end
