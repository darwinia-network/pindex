module MessagesHelper
  def status_style(status)
    if status == 'accepted'
      'bg-blue-100 text-blue-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-full dark:bg-blue-900 dark:text-blue-300'
    elsif status == 'root_ready'
      'bg-yellow-100 text-yellow-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-full dark:bg-yellow-900 dark:text-yellow-300'
    elsif status == 'dispatch_failed'
      'bg-red-100 text-red-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-full dark:bg-red-900 dark:text-red-300'
    elsif status == 'dispatch_success'
      'bg-green-100 text-green-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-full dark:bg-green-900 dark:text-green-300'
    end
  end

  def time_consumption(message)
    return unless message.status == 'dispatch_success' || message.status == 'dispatch_failed'

    # to human readable
    distance_of_time_in_words(
      Time.at(message.block_timestamp),
      Time.at(message.dispatch_block_timestamp)
    )
  end
end
