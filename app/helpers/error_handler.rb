class ErrorHandler
  def self.call(error_text: "An error has occurred, exiting program.", error_occurred: true)
    puts error_text

    if error_occurred
      exit 1
    else
      exit 0
    end
  end
end
