Python에서 `or`, `and` 는 단순히 `True/False`를 뱉는게 아니라 논리를 결정 짓는 그 값(객체)를 선택해서 반환한다.
파이썬에서는 모든 값이 참 또는 거짓으로 평가된다.
- **Falsy (거짓 취급):** `False`, `None`, `0`, `0.0`, 비어있는 컬렉션(`[]`, `{}`, `()`, `""`)
- **Truthy (참 취급):** 위의 Falsy를 제외한 모든 값 (예: `1`, `"hello"`, `[1, 2]`)
# or 연산자
A or B
A가 참이면 A를 반환하고 거짓이라면 B를 반환함.
값이 없을 때 기본값을 설정하는 패턴으로 가장 많이 쓰인다.
```python
name = input_name or "익명 사용자"
# input_name이 빈 문자열 "" 이면 "익명 사용자"가 들어감
```
# and 연산자
`A and B`
앞에서 부터 보다가 처음으로 발견된 '거짓(Falsly)'값을 반환한다.
끝까지 모두 참이면 맨 마지막 값을 반환한다.
```python
# user가 존재(True)할 때만 user.name에 접근
current_user_name = user and user.name 

# 만약 user가 None이면? -> None이 반환됨 (에러 발생 안 함!)
# 만약 user가 객체면? -> user.name이 반환됨
```