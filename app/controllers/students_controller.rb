class StudentsController < ApplicationController
  before_action :set_student

  # GET /students/:id
  def show
    render json: student_json(@student)
  end

  # GET /students/:id/courses
  def courses
    class_sessions = @student.class_sessions_as_student
                              .includes(:course, :semester, :teacher, :enrollments)

    render json: class_sessions.map { |cs|
      enrollment = cs.enrollments.find { |e| e.student_id == @student.id }
      class_session_json(cs, enrollment)
    }
  end

  private

  def set_student
    @student = User.find(params[:id])
    unless @student.student?
      render json: { error: "User is not a student" }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Student not found" }, status: :not_found
  end

  def student_json(user)
    {
      id:         user.id,
      name:       user.name,
      email:      user.email,
      role:       user.role,
      created_at: user.created_at
    }
  end

  def class_session_json(cs, enrollment)
    {
      class_session_id: cs.id,
      course: {
        id:          cs.course.id,
        name:        cs.course.name,
        code:        cs.course.code,
        description: cs.course.description
      },
      semester: {
        id:   cs.semester.id,
        name: cs.semester.name
      },
      teacher: {
        id:   cs.teacher.id,
        name: cs.teacher.name
      },
      room:     cs.room,
      schedule: cs.schedule,
      grade:    enrollment&.grade
    }
  end
end
