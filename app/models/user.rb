class User < ApplicationRecord
  has_many :reported_incidents, class_name: 'Incident', foreign_key: 'reporter_id'
  has_many :resolved_incidents, class_name: 'Incident', foreign_key: 'resolver_id'
end
