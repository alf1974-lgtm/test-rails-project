# db/seeds.rb
# Clears existing data and seeds fresh records.

puts "Clearing existing data..."
Enrollment.destroy_all
ClassSession.destroy_all
Semester.destroy_all
Course.destroy_all
Department.destroy_all
User.destroy_all

# ── Departments ──────────────────────────────────────────────────────────────
puts "Creating departments..."
english  = Department.create!(name: "English",  description: "Literature, writing, and language studies")
math     = Department.create!(name: "Math",     description: "Mathematics and applied mathematics")
science  = Department.create!(name: "Science",  description: "Natural and physical sciences")
history  = Department.create!(name: "History",  description: "World and American history")
cs       = Department.create!(name: "Computer Science", description: "Computing, algorithms, and software")

# ── Courses ───────────────────────────────────────────────────────────────────
puts "Creating courses..."
eng101  = Course.create!(name: "Composition I",          code: "ENG101", department: english,  description: "Fundamentals of academic writing")
eng201  = Course.create!(name: "American Literature",    code: "ENG201", department: english,  description: "Survey of American literary works")
mat101  = Course.create!(name: "Calculus I",             code: "MAT101", department: math,     description: "Limits, derivatives, and integrals")
mat201  = Course.create!(name: "Linear Algebra",         code: "MAT201", department: math,     description: "Vectors, matrices, and linear transformations")
sci101  = Course.create!(name: "Introduction to Biology",code: "SCI101", department: science,  description: "Foundations of biological science")
sci201  = Course.create!(name: "Chemistry I",            code: "SCI201", department: science,  description: "Atomic structure and chemical reactions")
his101  = Course.create!(name: "World History",          code: "HIS101", department: history,  description: "Survey of world history from antiquity to present")
cs101   = Course.create!(name: "Intro to Programming",  code: "CS101",  department: cs,       description: "Programming fundamentals using Python")
cs201   = Course.create!(name: "Data Structures",       code: "CS201",  department: cs,       description: "Arrays, linked lists, trees, and graphs")

# ── Semesters ─────────────────────────────────────────────────────────────────
puts "Creating semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-09-01", end_date: "2026-12-20")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-15", end_date: "2027-05-10")

# ── Teachers ──────────────────────────────────────────────────────────────────
puts "Creating teachers..."
teachers = [
  { name: "Dr. Alice Hartman",  email: "a.hartman@university.edu",  role: "teacher" },
  { name: "Prof. Bob Nguyen",   email: "b.nguyen@university.edu",   role: "teacher" },
  { name: "Dr. Carol Osei",     email: "c.osei@university.edu",     role: "teacher" },
  { name: "Prof. David Reyes",  email: "d.reyes@university.edu",    role: "teacher" },
  { name: "Dr. Eva Kowalski",   email: "e.kowalski@university.edu", role: "teacher" }
].map { |attrs| User.create!(attrs) }

t1, t2, t3, t4, t5 = teachers

# ── Students ──────────────────────────────────────────────────────────────────
puts "Creating students..."
students = [
  { name: "Jamie Torres",    email: "j.torres@student.edu",    role: "student" },
  { name: "Morgan Lee",      email: "m.lee@student.edu",       role: "student" },
  { name: "Riley Patel",     email: "r.patel@student.edu",     role: "student" },
  { name: "Casey Kim",       email: "c.kim@student.edu",       role: "student" },
  { name: "Jordan Smith",    email: "j.smith@student.edu",     role: "student" },
  { name: "Avery Johnson",   email: "a.johnson@student.edu",   role: "student" },
  { name: "Quinn Williams",  email: "q.williams@student.edu",  role: "student" },
  { name: "Skyler Brown",    email: "s.brown@student.edu",     role: "student" },
  { name: "Dakota Martinez", email: "d.martinez@student.edu",  role: "student" },
  { name: "Reese Davis",     email: "r.davis@student.edu",     role: "student" }
].map { |attrs| User.create!(attrs) }

s1, s2, s3, s4, s5, s6, s7, s8, s9, s10 = students

# ── Class Sessions ────────────────────────────────────────────────────────────
puts "Creating class sessions..."

# Fall 2026
cs_eng101_f26  = ClassSession.create!(course: eng101, semester: fall2026,   teacher: t1, room: "Humanities 101", schedule: "MWF 9:00-9:50")
cs_mat101_f26  = ClassSession.create!(course: mat101, semester: fall2026,   teacher: t2, room: "Math 204",       schedule: "TTh 10:00-11:15")
cs_sci101_f26  = ClassSession.create!(course: sci101, semester: fall2026,   teacher: t3, room: "Science 310",    schedule: "MWF 11:00-11:50")
cs_his101_f26  = ClassSession.create!(course: his101, semester: fall2026,   teacher: t4, room: "Social 102",     schedule: "TTh 13:00-14:15")
cs_cs101_f26   = ClassSession.create!(course: cs101,  semester: fall2026,   teacher: t5, room: "Tech 201",       schedule: "MWF 14:00-14:50")

# Spring 2027
cs_eng201_s27  = ClassSession.create!(course: eng201, semester: spring2027, teacher: t1, room: "Humanities 103", schedule: "TTh 9:00-10:15")
cs_mat201_s27  = ClassSession.create!(course: mat201, semester: spring2027, teacher: t2, room: "Math 206",       schedule: "MWF 10:00-10:50")
cs_sci201_s27  = ClassSession.create!(course: sci201, semester: spring2027, teacher: t3, room: "Science 312",    schedule: "TTh 11:00-12:15")
cs_cs201_s27   = ClassSession.create!(course: cs201,  semester: spring2027, teacher: t5, room: "Tech 203",       schedule: "MWF 13:00-13:50")

# ── Enrollments ───────────────────────────────────────────────────────────────
puts "Creating enrollments..."

grades = %w[A A- B+ B B- C+ C]

# Fall 2026 enrollments (with grades — semester is over)
[
  [cs_eng101_f26, [s1, s2, s3, s4, s5, s6]],
  [cs_mat101_f26, [s1, s3, s5, s7, s8, s9]],
  [cs_sci101_f26, [s2, s4, s6, s7, s10]],
  [cs_his101_f26, [s1, s2, s8, s9, s10]],
  [cs_cs101_f26,  [s3, s4, s5, s6, s7, s8]]
].each do |session, enrolled_students|
  enrolled_students.each_with_index do |student, i|
    Enrollment.create!(class_session: session, student: student, grade: grades[i % grades.length])
  end
end

# Spring 2027 enrollments (no grades yet — semester in progress)
[
  [cs_eng201_s27, [s1, s2, s3, s5, s9]],
  [cs_mat201_s27, [s1, s4, s7, s8, s10]],
  [cs_sci201_s27, [s2, s3, s6, s9, s10]],
  [cs_cs201_s27,  [s3, s4, s5, s6, s7]]
].each do |session, enrolled_students|
  enrolled_students.each do |student|
    Enrollment.create!(class_session: session, student: student, grade: nil)
  end
end

puts ""
puts "✅ Seed complete!"
puts "   #{Department.count} departments"
puts "   #{Course.count} courses"
puts "   #{Semester.count} semesters"
puts "   #{User.teachers.count} teachers"
puts "   #{User.students.count} students"
puts "   #{ClassSession.count} class sessions"
puts "   #{Enrollment.count} enrollments"
puts ""
puts "Sample student IDs: #{User.students.limit(3).pluck(:id, :name).map { |id, n| "#{id} (#{n})" }.join(', ')}"
