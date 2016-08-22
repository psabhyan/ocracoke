class ConcatenateOcrJob < ApplicationJob
  queue_as :concatenate

  def perform(resource, images)
    puts "ConcatenateOcrJob: #{resource}"
    concatenator = OcrConcatenator.new(resource, images)
    if concatenator.ocr_exists?
      puts "Concatenated OCR already exists for #{resource}"
    else
      concatenator.concatenate
      # TODO: Ping another service to let it know it is complete
    end
  end
end