# elasticsearch with python

- https://www.elastic.co/kr/
- https://marcobonzanini.com/2015/02/02/how-to-query-elasticsearch-with-python/
- https://tryolabs.com/blog/2015/02/17/python-elasticsearch-first-steps/

## Installation

```bash
pip install elasticsearch
```

## Getting started

```python
from elasticsearch import Elasticsearch

es_client = Elasticsearch()  # default localhost:9200
```

### 검색

#### match

그 자료의 KEY의 값이 VALUE와 정확하게 일치하는 자료만 가져온다.

```python
query = {
	"query": {
		"match": {
			KEY: VALUE
		}
	}
}
res = es_client.search(index=INDEX, doc_type=TYPE, body=query)

print("%s개가 검색됨" % res['hits']['total'])
for doc in res['hits']['hits']:
	# ID - content
	print("%s - %s" % (doc['_id'], doc['_source']['content']))
```

#### prefix

그 자료의 KEY의 값이 VALUE로 시작하는 자료만 가져온다.

```python
query = {
	"query": {
		"prefix": {
			KEY: VALUE
		}
	}
}
res = es_client.search(index=INDEX, doc_type=TYPE, body=query)

# 생략
```

#### 등등

elasticsearch api를 참조하자

### 자료 추가

```python
es_client.create(index=INDEX, doc_type=TYPE, body=DATA)
```

### 특정 id의 자료 가져오기

```python
res = es_client.get(index=INDEX, doc_type=TYPE, id=DOC_ID)
print(res['_source'])
```

### 특정 id의 자료 지우기

```python
res = es_client.delete(index=INDEX, doc_type=TYPE, id=DOC_ID)
if res['result'] = 'deleted':
	print("success!")
```

### query로 자료 지우기

QUERY는 자료 검색과 같다

```python
res = es_client.delete_by_query(index=INDEX, body=QUERY)
print("%s개가 삭제됨" % res['deleted'])
```
