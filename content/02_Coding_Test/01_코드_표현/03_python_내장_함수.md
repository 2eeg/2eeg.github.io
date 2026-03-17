
파이썬의 내장 함수
# 수학 및 계산 관련
- `max(iter)`, `min(iter)`: 최댓값, 최솟값
- `sum(iter)`: 합계
- `abs(x)`: 절댓값
- `pow(x, y)`: $x$의 $y$승 ( `x ** y`와 같음)
- `divmod(a, b)`: 몫과 나머지를 튜플 `(몫, 나머지)`로 한 번에 반환 (이거 은근 꿀입니다)
- `round(x, n)`: 반올림, 쓸 때 주의해야 함, .5를 무조건 올리지 않고 앞자리를 짝수 쪽으로 가게 함.
- 버림은 `math.floor()`, 올림은 `math.ceil()`
## 예: 2차원 리스트에서 최대 값 찾기
`max(map(max, board))`
# 시퀀스(리스트/문자열) 처리 관련
- `len(s)`: 길이 반환
- `sorted(iter)`: 정렬된 **새로운 리스트**를 반환 (원본 변경 X)
- `range(start, stop, step)`: 숫자 범위 생성
- `enumerate(iter)`: 인덱스와 값을 같이 꺼내줌 (반복문에서 필수!)
- `zip(iter1, iter2)`: 두 리스트를 지퍼처럼 묶어서 짝지어줌
- `reversed(iter)`: 거꾸로 뒤집기 (반환값이 이터레이터라 보통 `list(reversed(x))`로 씀)

# 형 변환 (Type Conversion)
- `int()`, `str()`, `float()`, `bool()`
- `list()`, `tuple()`, `set()`, `dict()`
- `ord(char)`: 문자를 아스키코드(숫자)로
- `chr(int)`: 숫자를 문자(아스키코드)로

# 논리 확인
- `all(iter)`: 안에 있는 게 **모두** 참(True)이면 True 반환 (AND 연산 비슷)
- `any(iter)`: 안에 있는 게 **하나라도** 참(True)이면 True 반환 (OR 연산 비슷)
## 예: 2차원 리스트의 원소 중 0이 있는 지 판단
`any(0 in row for row in board)`
# 입출력 및 기타
- `print()`: 출력
- `input()`: 입력
- `id()`: 객체의 고유 주소값 확인
- `type()`: 자료형 확인
# 고차 함수 및 익명 함수
- `lambda`: 한 줄짜리 익명 함수 (예: `lambda x, y: x + y`)
- `map(f, iter)`: 모든 원소에 함수 f를 적용한 결과 반환
- `filter(f, iter)`: 함수 f의 결과가 True인 원소만 추출
## 사용 예
- 코딩 테스트 입력: `list(map(int, input().split()))`
- 조건에 맞는 원소 삭제 대신 추출: `list(filter(lambda x: x != "삭제대상", my_list))`
- 정렬 기준 설정: `sorted(players, key=lambda x: x['score'])` (점수 기준 정렬)