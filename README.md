# School API — Rails 8

A Rails 8 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Models

| Model | Description |
|---|---|
| `User` | Both students and teachers. `role` is `"student"` or `"teacher"` |
| `Department` | e.g. English, Mathematics, Science, History, Computer Science |
| `Course` | Belongs to a department. Has a `name` and short `code` (e.g. `CS101`) |
| `Semester` | e.g. *Fall 2026*, *Spring 2027* |
| `ClassSession` | A course offered in a semester, taught by one teacher |
| `Enrollment` | Join between a student and a class session; holds the student's `grade` |

## Endpoints

### `GET /students/:id`
Returns a student's profile.

```json
{
  "id": 6,
  "name": "Sam Torres",
  "email": "sam.torres@students.edu",
  "role": "student",
  "created_at": "2026-07-16T18:24:48.212Z"
}
```

### `GET /students/:id/courses`
Returns all class sessions the student is enrolled in, with course, semester, teacher, and grade info.

```json
[
  {
    "class_session_id": 1,
    "course":   { "id": 1, "name": "Introduction to Literature", "code": "ENG101" },
    "semester": { "id": 1, "name": "Fall 2026", "start_date": "2026-09-01", "end_date": "2026-12-20" },
    "teacher":  { "id": 1, "name": "Dr. Alice Monroe" },
    "grade": "B"
  }
]
```

Returns `404` if the ID doesn't exist or belongs to a teacher.

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Seed Data

Running `db:seed` creates:
- **5** departments (English, Mathematics, Science, History, Computer Science)
- **10** courses (2 per department)
- **2** semesters (Fall 2026, Spring 2027)
- **5** teachers
- **8** students (IDs 6–13 after a fresh seed)
- **10** class sessions (5 per semester)
- **40** enrollments (Fall 2026 sessions have grades; Spring 2027 sessions do not)
