from django.urls import path
from api.views import StartTaskView, ProgressView

urlpatterns = [
    path("start/", StartTaskView.as_view()),
    path("progress/<str:task_id>/", ProgressView.as_view()),
]