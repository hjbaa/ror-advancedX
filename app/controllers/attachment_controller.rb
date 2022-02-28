class AttachmentController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @attached_file = ActiveStorage::Attachment.find(params[:id])

    return head(:forbidden) unless current_user&.author_of?(@attached_file.record)

    @attached_file.purge
  end
end
