from rest_framework.views import APIView
from rest_framework.response import Response
from tasks.workers import long_task
import redis
import uuid

r = redis.Redis()

class StartTaskView(APIView):
    def get(self, request):
        task_id = str(uuid.uuid4())
        long_task.send(task_id)
        return Response({"task_id": task_id})

class ProgressView(APIView):
    def get(self, request, task_id):
        progress = r.get(f"progress:{task_id}")
        return Response({"progress": int(progress) if progress else 0})
