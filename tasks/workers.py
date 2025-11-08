# tasks/workers.py
import time
import redis
import dramatiq
from company_scan import broker

r = redis.Redis()

@dramatiq.actor(store_results=True)
def long_task(task_id):
    total_steps = 10
    for step in range(1, total_steps + 1):
        time.sleep(60)
        progress = int(step / total_steps * 100)
        r.set(f"progress:{task_id}", progress)
    return "done"
