class MailboxesController < ApplicationController
  before_action :authenticate_user!

  def index
    @mailboxes = mailbox.conversations.paginate(page: params[:page], per_page: 10)
  end

  def inbox
    @inbox = mailbox.inbox.paginate(page: params[:page], per_page: 10)
    @active = :inbox
  end

  def sent
    @sent = mailbox.sentbox.paginate(page: params[:page], per_page: 10)
    @active = :sent
  end

  def trash
    @trash = mailbox.trash.paginate(page: params[:page], per_page: 10)
    @active = :trash
  end
  
end
