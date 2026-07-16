class StudentsController < ApplicationController
  before_action :set_student

  # GET /students/:id
  def show
    render json: student_json(@student)
  end

  # GET /students/:id/courses
  def courses
    sessions = @student.class_sessions
                       .includes(:course, :semester, :teacher, :enrollments)
                       .order("semesters.name, courses.name")

    render json: sessions.map { |cs| course_session_json(cs, @student) }
  end

  private

  def set_student
    @student = User.find_by(id: params[:id], role: "student")
    render_not_found("Student") unless @student
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

  def course_session_json(cs, student)
    enrollment = cs.enrollments.find { |e| e.student_id == student.id }
    {
      class_session_id: cs.id,
      course: {
        id:   cs.course.id,
        name: cs.course.name,
        code: cs.course.code
      },
      semester: {
        id:         cs.semester.id,
        name:       cs.semester.name,
        start_date: cs.semester.start_date,
        end_date:   cs.semester.end_date
      },
      teacher: {
        id:   cs.teacher.id,
        name: cs.teacher.name
      },
      grade: enrollment&.grade
    }
  end
end
