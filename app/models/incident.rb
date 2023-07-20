class Incident < ApplicationRecord
  enum status: { open: 0, resolved: 1 }
  enum severity: { sev0: 0, sev1: 1, sev2: 2 }

  validates :title, presence: true
  has_one :channel
  belongs_to :reporter, class_name: 'User', foreign_key: "reporter_id", optional: true
  belongs_to :resolver, class_name: 'User', foreign_key: "resolver_id", optional: true
  belongs_to :app

  after_create_commit :publish_new_incident
  after_update_commit :publish_updated_incident

  def resolution_time
    ((Time.zone.now - created_at) / 1.minute).ceil
  end

  private

  def publish_new_incident
    broadcast_after_to(
      :incidents,
      target: "all_incidents",
      partial: "incidents/incident"
    )
  end

  def publish_updated_incident
    broadcast_replace_to(
      :incidents,
      target: "incident_#{id}",
      partial: "incidents/incident"
    )
  end
end
