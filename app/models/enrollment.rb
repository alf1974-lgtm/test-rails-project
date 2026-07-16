class Enrollment < ApplicationRecord
  belongs_to :class_session
  belongs_to :student, class_name: "User"

  validates :class_session_id, presence: true
  validates :student_id, presence: true,
            uniqueness: { scope: :class_session_id, message: "already enrolled in this class session" }
  validate  :student_must_be_a_student

  private

  def student_must_be_a_student
    errors.add(:student, "must have role 'student'") if student && !student.student?
  end
end
