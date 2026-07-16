# University School API

A Rails 8 API-only application modelling a university school system. Built as a test project.

## Models

| Model | Description |
|---|---|
| `User` | Students and teachers (`role: "student"` or `"teacher"`) |
| `Department` | Academic departments (English, Math, Science, History, Computer Science) |
| `Course` | A course belonging to a department (e.g. ENG101 Composition I) |
| `Semester` | A semester (Fall 2026, Spring 2027) |
| `ClassSession` | A specific offering of a course in a semester, with one teacher |
| `Enrollment` | Join between a student and a class session; holds the student's grade |

### Relationships

```
Department ──< Course ──< ClassSession >── Semester
                               │
                          Enrollment
                         /          \
                    Student        (grade)
                    (User)
```

## API Endpoints

| Method | Path | Description |
|---|---|---|
| `GET` | `/students/:id` | Get a student's profile |
| `GET` | `/students/:id/courses` | Get all class sessions a student is enrolled in (with grades) |

### Example responses

**`GET /students/6`**
```json
{
  "id": 6,
  "name": "Jamie Torres",
  "email": "j.torres@student.edu",
  "role": "student",
  "created_at": "2024-01-01T00:00:00.000Z"
}
```

**`GET /students/6/courses`**
```json
[
  {
    "class_session_id": 1,
    "course": { "id": 1, "name": "Composition I", "code": "ENG101", "description": "..." },
    "semester": { "id": 1, "name": "Fall 2026" },
    "teacher": { "id": 1, "name": "Dr. Alice Hartman" },
    "room": "Humanities 101",
    "schedule": "MWF 9:00-9:50",
    "grade": "A"
  }
]
```

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

## Seed Data

The seed file creates:
- **5 departments**: English, Math, Science, History, Computer Science
- **9 courses** spread across departments
- **2 semesters**: Fall 2026 (graded) and Spring 2027 (in progress)
- **5 teachers** and **10 students**
- **9 class sessions** across both semesters
- **48 enrollments** (Fall 2026 enrollments have grades; Spring 2027 do not yet)
