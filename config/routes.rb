Rails.application.routes.draw do
  # Student routes
  get  "students/:id",         to: "students#show",    as: :student
  get  "students/:id/courses", to: "students#courses", as: :student_courses

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
