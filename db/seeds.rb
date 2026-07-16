# db/seeds.rb
# Clears existing data and repopulates with realistic school data.

puts "Clearing existing data..."
Enrollment.delete_all
ClassSession.delete_all
Semester.delete_all
Course.delete_all
Department.delete_all
User.delete_all

# ── Departments ──────────────────────────────────────────────────────────────
puts "Seeding departments..."
departments = Department.create!([
  { name: "English" },
  { name: "Mathematics" },
  { name: "Science" },
  { name: "History" },
  { name: "Computer Science" }
])

english, math, science, history, cs = departments

# ── Courses ───────────────────────────────────────────────────────────────────
puts "Seeding courses..."
courses = Course.create!([
  { name: "Introduction to Literature",   code: "ENG101", department: english },
  { name: "Creative Writing",             code: "ENG201", department: english },
  { name: "Calculus I",                   code: "MAT101", department: math },
  { name: "Linear Algebra",               code: "MAT201", department: math },
  { name: "Biology 101",                  code: "SCI101", department: science },
  { name: "Chemistry Fundamentals",       code: "SCI201", department: science },
  { name: "World History",                code: "HIS101", department: history },
  { name: "Modern American History",      code: "HIS201", department: history },
  { name: "Intro to Programming",         code: "CS101",  department: cs },
  { name: "Data Structures & Algorithms", code: "CS201",  department: cs }
])

eng101, eng201, mat101, mat201, sci101, sci201, his101, his201, cs101, cs201 = courses

# ── Semesters ─────────────────────────────────────────────────────────────────
puts "Seeding semesters..."
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-09-01", end_date: "2026-12-20")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-15", end_date: "2027-05-10")

# ── Teachers ──────────────────────────────────────────────────────────────────
puts "Seeding teachers..."
teachers = User.create!([
  { name: "Dr. Alice Monroe",   email: "alice.monroe@school.edu",   role: "teacher" },
  { name: "Prof. Bob Nguyen",   email: "bob.nguyen@school.edu",     role: "teacher" },
  { name: "Dr. Carol Patel",    email: "carol.patel@school.edu",    role: "teacher" },
  { name: "Prof. David Kim",    email: "david.kim@school.edu",      role: "teacher" },
  { name: "Dr. Eva Rosenberg",  email: "eva.rosenberg@school.edu",  role: "teacher" }
])

alice, bob, carol, david, eva = teachers

# ── Students ──────────────────────────────────────────────────────────────────
puts "Seeding students..."
students = User.create!([
  { name: "Sam Torres",     email: "sam.torres@students.edu",     role: "student" },
  { name: "Jamie Lee",      email: "jamie.lee@students.edu",      role: "student" },
  { name: "Morgan Davis",   email: "morgan.davis@students.edu",   role: "student" },
  { name: "Riley Chen",     email: "riley.chen@students.edu",     role: "student" },
  { name: "Jordan Smith",   email: "jordan.smith@students.edu",   role: "student" },
  { name: "Casey Brown",    email: "casey.brown@students.edu",    role: "student" },
  { name: "Taylor Wilson",  email: "taylor.wilson@students.edu",  role: "student" },
  { name: "Alex Johnson",   email: "alex.johnson@students.edu",   role: "student" }
])

sam, jamie, morgan, riley, jordan, casey, taylor, alex = students

# ── Class Sessions ────────────────────────────────────────────────────────────
puts "Seeding class sessions..."

# Fall 2026
cs_eng101_f26  = ClassSession.create!(course: eng101, semester: fall2026,   teacher: alice)
cs_mat101_f26  = ClassSession.create!(course: mat101, semester: fall2026,   teacher: bob)
cs_sci101_f26  = ClassSession.create!(course: sci101, semester: fall2026,   teacher: carol)
cs_his101_f26  = ClassSession.create!(course: his101, semester: fall2026,   teacher: david)
cs_cs101_f26   = ClassSession.create!(course: cs101,  semester: fall2026,   teacher: eva)

# Spring 2027
cs_eng201_s27  = ClassSession.create!(course: eng201, semester: spring2027, teacher: alice)
cs_mat201_s27  = ClassSession.create!(course: mat201, semester: spring2027, teacher: bob)
cs_sci201_s27  = ClassSession.create!(course: sci201, semester: spring2027, teacher: carol)
cs_his201_s27  = ClassSession.create!(course: his201, semester: spring2027, teacher: david)
cs_cs201_s27   = ClassSession.create!(course: cs201,  semester: spring2027, teacher: eva)

# ── Enrollments (with grades for Fall 2026, pending for Spring 2027) ──────────
puts "Seeding enrollments..."

GRADES = %w[A A- B+ B B- C+ C].freeze

def random_grade = GRADES.sample

# Fall 2026 enrollments — all graded
[
  [cs_eng101_f26, [sam, jamie, morgan, riley, jordan]],
  [cs_mat101_f26, [sam, riley, casey, taylor, alex]],
  [cs_sci101_f26, [jamie, morgan, jordan, casey, alex]],
  [cs_his101_f26, [sam, jamie, taylor, alex, riley]],
  [cs_cs101_f26,  [morgan, riley, jordan, casey, taylor]]
].each do |session, enrolled_students|
  enrolled_students.each do |student|
    Enrollment.create!(class_session: session, student: student, grade: random_grade)
  end
end

# Spring 2027 enrollments — no grades yet
[
  [cs_eng201_s27, [sam, jamie, morgan]],
  [cs_mat201_s27, [riley, casey, taylor]],
  [cs_sci201_s27, [jordan, alex, sam]],
  [cs_his201_s27, [jamie, morgan, riley]],
  [cs_cs201_s27,  [casey, taylor, alex]]
].each do |session, enrolled_students|
  enrolled_students.each do |student|
    Enrollment.create!(class_session: session, student: student, grade: nil)
  end
end

puts ""
puts "Done! Seeded:"
puts "  #{Department.count}   departments"
puts "  #{Course.count}      courses"
puts "  #{Semester.count}    semesters"
puts "  #{User.where(role: 'teacher').count}    teachers"
puts "  #{User.where(role: 'student').count}    students"
puts "  #{ClassSession.count}   class sessions"
puts "  #{Enrollment.count}   enrollments"
puts ""
puts "Sample student IDs: #{User.where(role: 'student').pluck(:id, :name).map { |id, n| "#{id} (#{n})" }.join(', ')}"
