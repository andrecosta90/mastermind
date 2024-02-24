# frozen_string_literal: true

# Module responsible for creating secret codes.
module CodeMaker
  # Creates a secret code.
  #
  # This method should be implemented by classes including this module.
  def create_secret_code
    raise 'Not implemented'
  end
end

# Module responsible for making guesses to crack secret codes.
module CodeBreaker
  # Makes a guess to crack the secret code.
  #
  # This method should be implemented by classes including this module.
  def make_guess
    raise 'Not implemented'
  end
end
