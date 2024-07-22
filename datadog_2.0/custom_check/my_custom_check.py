from datadog_checks.base import AgentCheck

class MyCustomCheck(AgentCheck):
    def check(self, instance):
        self.gauge('my_metric', 1, tags=['tag1:value1'])
