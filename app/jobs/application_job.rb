class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  private

  def split_long_sentences(text, max_length)
    sentences = text.gsub("\n", ' ').split(/(?<=[。．！？])/)
    sentences.each_with_object([]) do |sentence, mem|
      last_sentence = mem.last || ''
      if max_length >= (last_sentence.length + sentence.length)
        mem[-1] = last_sentence + sentence
      else
        mem << sentence
      end
      mem
    end
  end
end
