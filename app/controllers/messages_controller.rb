class MessagesController < ApplicationController
  before_action :set_message, only: %i[show]

  # GET /messages or /messages.json
  def index
    from_network = Network.find(params[:from_network]) if params[:from_network].present?
    to_network = Network.find(params[:to_network]) if params[:to_network].present?

    @messages = Message.all

    @messages = @messages.where(from_chain_id: from_network.chain_id) if from_network.present?
    @messages = @messages.where(to_chain_id: to_network.chain_id) if to_network.present?
    @messages = @messages.where(status: params[:status]) if params[:status].present?
    @messages_count = @messages.count

    @messages = @messages.order(block_timestamp: :desc).page(params[:page]).per(25)
  end

  # GET /messages/1 or /messages/1.json
  def show
    @messages_count = Message.count
  end

  def message
    if params[:tx_or_hash].start_with?('0x')
      # query from form
      redirect_to message_by_tx_or_hash_path(params[:tx_or_hash])
    else
      redirect_to messages_path
    end
  end

  # GET /messages/timespent/gt/30/minutes?status=accepted,root_ready
  # GET /messages/timespent/lt/30/minutes.json?status=accepted,root_ready
  def timespent
    unit = params[:unit].singularize
    if unit == 'second'
      distance = params[:number].to_i
    elsif unit == 'minute'
      distance = params[:number].to_i * 60
    elsif unit == 'hour'
      distance = params[:number].to_i * 60 * 60
    elsif unit == 'day'
      distance = params[:number].to_i * 60 * 60 * 24
    else
      raise 'Invalid unit'
    end

    @messages = if params[:op] == 'gt'
                  Message.where(
                    '(dispatch_block_timestamp IS NULL AND round(extract(epoch from(current_timestamp - block_timestamp)))::int > ?) OR (dispatch_block_timestamp IS NOT NULL AND round(extract(epoch from(dispatch_block_timestamp - block_timestamp)))::int > ?)', distance, distance
                  )
                elsif params[:op] == 'lt'
                  Message.where(
                    'dispatch_block_timestamp IS NOT NULL AND round(extract(epoch from(dispatch_block_timestamp - block_timestamp)))::int < ?', distance
                  )
                else
                  raise 'Invalid operator'
                end
    @messages_count = @messages.count

    @messages = @messages.order(block_timestamp: :desc).page(params[:page]).per(25)

    status = params[:status] || 'accepted,root_ready,dispatch_success,dispatch_failed'
    @messages = @messages.where(status: status.split(','))
    respond_to do |format|
      format.html { render :index }
      format.json { render json: { messages: @messages, messages_count: @messages_count } }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message =
      if params[:id].present?
        Message.find(params[:id])
      elsif params[:from_network] && params[:to_network] && params[:index]
        from_network = Network.find(params[:from_network])
        to_network = Network.find(params[:to_network])
        Message.find_by(from_chain_id: from_network.chain_id, to_chain_id: to_network.chain_id, index: params[:index])
      elsif params[:tx_or_hash].present?
        Message.find_by(transaction_hash: params[:tx_or_hash]) || Message.find_by(msg_hash: params[:tx_or_hash])
      end

    return unless @message.nil?

    # 404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html" }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
    end
  end
end
