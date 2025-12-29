import ast
from rest_framework.views import APIView
from rest_framework.response import Response
from tasks.workers import stock_scraper
import redis
import uuid

r = redis.Redis()

class StartTaskView(APIView):
    def get(self, request, ticket):
        task_id = str(uuid.uuid4())
        stock_scraper.send(task_id, ticket)
        return Response({"task_id": task_id})

class ProgressView(APIView):
    def get(self, request, task_id):
        progress = r.get(f"progress:{task_id}")
        result = r.get(f"result:{task_id}")

        return Response({
            "progress": int(progress) if progress else 0,
            "result": ast.literal_eval(result.decode()) if result else None
        })
