class Enrollment < ApplicationRecord
  belongs_to :class_session
  belongs_to :student, class_name: "User"

  GRADES = %w[A A- B+ B B- C+ C C- D+ D D- F].freeze

  validates :class_session, presence: true
  validates :student,       presence: true
  validates :student_id, uniqueness: { scope: :class_session_id,
                                       message: "is already enrolled in this class session" }
  validates :grade, inclusion: { in: GRADES, allow_nil: true }
end
