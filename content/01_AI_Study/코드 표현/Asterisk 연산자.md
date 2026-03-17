# 서론
파이썬에서 가끔 파이썬 코드를 보다 보면 함수 인자에 `*args`나 `**kwargs` 같은 별표가 붙은 변수들을 자주 마주하게 됩니다.
* **`*` (Asterisk)**: 리스트나 튜플 같은 **순서가 있는(Iterable)** 객체를 다룹니다.
* **`**` (Double Asterisk)**: 딕셔너리 같은 **키-값(Key-Value)** 객체를 다룹니다.

파이썬에서 보통 Astrisk(\*, \*\*)는 Packing, 또는 Unpacking의 2가지 역할을 합니다.

---

# 1. Unpacking (풀기)
여러 개의 값이 담긴 리스트, 튜플, 딕셔너리의 껍질을 벗겨서 **안에 있는 알맹이들을 하나씩 꺼내 놓는 것**을 의미합니다.

## A. 함수 호출 시 인자 전달
함수가 요구하는 인자의 개수와 리스트의 요소 개수가 같을 때 유용합니다.

``` python
def login(id, pw):
    print(f"ID: {id}, PW: {pw}")

user_list = ["my_id", "1234"]
user_dict = {"id": "my_id", "pw": "1234"}

# 1. 리스트 풀기 (*): 순서대로(Positional) 들어감
login(*user_list)  
# 결과 -> login("my_id", "1234")와 동일

# 2. 딕셔너리 풀기 (**): 키(Key) 이름에 맞춰(Keyword) 들어감
login(**user_dict) 
# 결과 -> login(id="my_id", pw="1234")와 동일
```

## B. 데이터 병합 (합치기)
기존의 데이터를 합쳐서 새로운 리스트나 딕셔너리를 만들 때 사용할 수 있습니다.

```python
list_a = [1, 2]
list_b = [3, 4]

# 리스트 합치기
merged_list = [*list_a, *list_b] 
# 결과: [1, 2, 3, 4]

dict_a = {"name": "Park"}
dict_b = {"age": 25}

# 딕셔너리 합치기
merged_dict = {**dict_a, **dict_b} 
# 결과: {'name': 'Park', 'age': 25}
```

---

# 2. Packing (묶기)

반대로 흩어져 있는 여러 개의 인자들을 **하나의 변수로 묶어서 받는 것**을 의미합니다. 주로 함수를 **정의**할 때 사용합니다.

## A. `*args` (위치 인자 묶기)

몇 개의 인자가 들어올지 모를 때, 들어오는 값들을 **튜플(Tuple)**로 묶어줍니다.
_(args는 관례적인 이름이며, `*numbers`처럼 바꿔 써도 무방합니다.)_

```python
def save_numbers(*args):
    print(args)      # 튜플로 묶여서 출력
    print(type(args))

save_numbers(10, 20, 30, 40)
# 출력: (10, 20, 30, 40) 
# 타입: <class 'tuple'>
```

### B. `**kwargs` (키워드 인자 묶기)

`key=value` 형태로 들어오는 값들을 **딕셔너리(Dictionary)**로 묶어줍니다.
_(kwargs = Keyword Arguments)_

``` python
def save_profile(**kwargs):
    print(kwargs)     # 딕셔너리로 묶여서 출력
    print(type(kwargs))

save_profile(name="Park", job="AI Student", level=1)
# 출력: {'name': 'Park', 'job': 'AI Student', 'level': 1}
# 타입: <class 'dict'>
```

> [!tip]  함수 밖에서도 `*`를 써서 남은 요소를 한꺼번에 담을 수 있습니다.
> 
> 
> ```python
> first, *middle, last = [1, 2, 3, 4, 5]
> # first = 1 / middle = [2, 3, 4] / last = 5
> ```

---

## ⚡ 요약표 (Cheatsheet)

| **구분**        | **기호** | **대상**       | **역할**              | **주요 상황**              |
| ------------- | ------ | ------------ | ------------------- | ---------------------- |
| **Unpacking** | `*`    | 리스트/튜플       | 껍질 벗겨서 **나열**       | 함수 호출, 리스트 병합          |
| (풀기)          | `**`   | 딕셔너리         | `Key=Value`로 **나열** | 함수 호출, 딕셔너리 병합         |
| **Packing**   | `*`    | 여러 값들        | **튜플**로 묶기          | 함수 정의 (`*args`), 변수 할당 |
| (묶기)          | `**`   | `Key=Value`들 | **딕셔너리**로 묶기        | 함수 정의 (`**kwargs`)     |
