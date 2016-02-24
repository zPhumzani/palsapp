class MailboxerConversationsController < ApplicationController
  before_action :authenticate_user!

  layout 'mailboxes'

  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end

  def create
    receipeint = User.find(mailbox_params[:user])
    conversation = current_user.send_message(receipeint, mailbox_params[:body], mailbox_params[:subject]).conversation
    flash[:success] = "Your message was successfully sent!"
    redirect_to conversation
  end

  def show
    @receipts = conversation.receipts_for current_user

    conversation.mark_as_read(current_user)
  end  

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = "Your reply message was successfully sent!"
    redirect_to conversation
  end

  def destroy
    conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to mailbox_trash_path
  end

  def restore
    conversation.untrash(current_user)
    flash[:success] = "The conversation was restored."
    redirect_to conversation
  end

  def empty_trash
    mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = "Your trash was cleaned!"
    redirect_to mailboxes_url
  end

  private

    def mailbox_params
      params.require(:message).permit(:user, :subject, :body)
    end

    def message_params
      params.require(:message).permit(:body, :subject)
    end
end
