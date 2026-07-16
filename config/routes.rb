Rails.application.routes.draw do
  # Student-facing routes
  get  "students/:id",         to: "students#show",    as: :student
  get  "students/:id/courses", to: "students#courses", as: :student_courses

  # Health check (built-in Rails 8)
  get "up" => "rails/health#show", as: :rails_health_check
end
