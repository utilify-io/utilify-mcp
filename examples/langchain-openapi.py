"""
Load Utilify's OpenAPI spec as a LangChain toolkit.
Requires: pip install langchain langchain-openai requests
"""

import json
import requests
from langchain.agents import AgentType, initialize_agent
from langchain_community.agent_toolkits.openapi import planner
from langchain_community.agent_toolkits.openapi.spec import reduce_openapi_spec
from langchain_openai import ChatOpenAI

# Fetch the spec
spec = requests.get("https://utilify.io/openapi.json").json()
reduced = reduce_openapi_spec(spec)

# Plug into an agent
llm = ChatOpenAI(model="gpt-4o", temperature=0)
agent = planner.create_openapi_agent(reduced, requests_wrapper=None, llm=llm)

# Use it
print(agent.run("What is the cheapest electricity plan at ZIP 77002?"))
