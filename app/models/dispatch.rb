class Dispatch < ActiveRecord::Base
  # RELATIONS #
  belongs_to :report
  belongs_to :responder

  # VALIDATIONS #
  validates_presence_of :report
  validates_presence_of :responder

  # SCOPE #
  default_scope { order(:created_at) }
  scope :accepted,     -> { where(status: %w(accepted completed)) }

  scope :not_rejected, -> do
    where.not(status: 'rejected')
      .joins(:responder).order('dispatches.status', 'dispatches.updated_at')
  end

  scope :pending,      -> { where(status: 'pending') }

  # CALLBACKS #
  after_create :messanger
  after_update :messanger, if: :status_changed?

  # CLASS METHODS #
  def self.latest
    order('created_at desc').first
  end

  # INSTANCE METHODS #
  def accepted?
    status == "accepted"
  end

  def completed?
    status == "completed"
  end

  def pending?
    status == "pending"
  end

  def rejected?
    status == "rejected"
  end

private

  def messanger
    dispatch_messanger = DispatchMessanger.new(responder)
    case status
    when 'accepted'
      dispatch_messanger.accept!
    when 'completed'
      dispatch_messanger.complete!
    when 'pending'
      dispatch_messanger.pending!
    when 'rejected'
      dispatch_messanger.reject!
    end
  end

end
