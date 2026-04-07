# 서론
텐서는 PyTorch의 핵심 데이터 구조이다. NumPy의 다차원 배열과 유사한 형태를 가진다. GPU 위에서 연산 가능하다는 것만 빼면 거의 비슷. 또, 행렬과 바슷함.
# 텐서 선언하기
## 0-D Tensor (Scalar)
하나의 숫자(상수)를 담는 0차원 텐서입니다.

``` python
import torch

# 스칼라 선언
a = torch.tensor(36.5)
```
## 1-D Tensor (Vector)
숫자들이 일렬로 나열된 1차원 구조이다.

```python
# 벡터 선언 (리스트 전달)
b = torch.tensor([175, 60, 81, 0.8, 0.9])
```
## 2-D Tensor (Matrix)
행(Row)과 열(Column)로 구성된 2차원 격자 구조이다.
```python
# 행렬 선언 (이중 리스트 전달)
c = torch.tensor([[77, 114, 140], 
                  [39, 56, 46]])
```

## 3-D Tensor (Rank 3 Tensor)
2차원 행렬을 여러 장 쌓아 올린 입체 구조이다. (예: RGB 이미지)
```python
# 3차원 텐서 선언 (세 채널을 결합하거나 리스트의 리스트의 리스트 전달)
d = torch.tensor([
    [[255, 0], [0, 255]], # Red 채널
    [[0, 255], [0, 255]], # Green 채널
    [[0, 0], [255, 0]]    # Blue 채널
])
```
## N-D Tensor
동일한 크기의 하위 차원 텐서들을 계속해서 쌓아 나가면 고차원 텐서가 된다.
```python
# N차원 텐서 (차원 확장)
nd_tensor = torch.randn(2, 3, 4, 5) # 4차원 텐서 예시
```

**요약하자면:** 결국 텐서 선언은 `torch.tensor()` 안에 데이터를 리스트 형태로 중첩해서 넣어주기만 하면 된다. 괄호 `[]`의 중첩 개수가 곧 차원의 수가 된다고 이해하면 편하다.
## 특정한 값으로 초기화된 Tensor 생성

| **코드 예시 (3x2 크기)**         | **설명**               |
| -------------------------- | -------------------- |
| `torch.zeros(3, 2)`        | 모든 요소를 **0**으로 채움    |
| `torch.ones(3, 2)`         | 모든 요소를 **1**으로 채움    |
| `torch.full((3, 2), 3.14)` | **사용자가 지정한 값**으로 채움  |
| `torch.eye(3)`             | **단위 행렬**(대각선만 1) 생성 |

| **코드 예시 (참조 텐서 c 기준)**    | **설명**                                   |
| ------------------------- | ---------------------------------------- |
| `torch.zeros_like(c)`     | 특정 텐서와 같은 크기, 자료형으로 모든 요소를 **0**으로 채움    |
| `torch.ones_like(c)`      | 특정 텐서와 같은 크기, 자료형으로 모든 요소를 **1**로 채움     |
| `torch.full_like(c, 7.5)` | 특정 텐서와 같은 크기, 자료형으로  **사용자가 지정한 값**으로 채움 |
## 난수로 초기화된 Tensor 생성
| 코드 예시 (3x2 크기)        | 설명                                                               |
| --------------------- | ---------------------------------------------------------------- |
| `torch.rand([3,2])`   | 0~1 사이의 연속균등분포에서 추출한 난수로 채워진 특정 크기의 Tensor를 생성                   |
| `torch.randn([3,2])`  | 표준정규분포에서 추출한 난수로 채워진 특정 크기의 Tensor를 생성                           |
| `torch.rand_like(c)`  | 특정 Tensor와 같은 크기, 자료형으로 0~1 사이의 연속 균등분포에서 추출한 난수로 채워진 Tensor를 생성 |
| `torch.randn_like(c)` | 특정 Tensor와 같은 크기, 자료형으로 표준정규분포에서 추출한 난수로 채워진 Tensor를 생성          |
## 지정된 범위 내에서 초기화된 Tensor 생성
- **`torch.arange(start, end, step)`**: `start`부터 `end-1`까지 `step` 간격으로 생성
    ```python
    x = torch.arange(0, 10, 2) # [0, 2, 4, 6, 8]
    ```
- **`torch.linspace(start, end, steps)`**: `start`부터 `end`까지 **동일한 간격**으로 `steps`개의 숫자를 생성
    ```python
    x = torch.linspace(0, 10, 5) # [0, 2.5, 5, 7.5, 10]
    ```
## 초기화 되지 않은 Tensor의 생성
| **코드 예시 (2x3 크기)**                    | **설명**            |
| ------------------------------------- | ----------------- |
| `torch.empty(2, 3)`                   | 메모리만 할당 (초기화 안 함) |
| `torch.empty_like(c)`                 | 기존 텐서와 같은 크기로 할당  |
| `torch.empty_strided((2, 3), (3, 1))` | 특정 스트라이드(보폭)로 할당  |
## Tensor 복제
`y = x.clone() #x는 이미 선언 및 초기화된 Tensor`

# Tensor의 Indexing, Slicing
## 1. 인덱싱(Indexing)과 슬라이싱(Slicing)의 개념
- Indexing: 데이터에서 특정 위치의 값 하나를 콕 집어 가져오는 것이다.
- Slicing: 특정 구간을 지정해 연속된 여러 값을 잘라내어 가져오는 것이다.
파이썬의 기본 문법과 동일하게 텐서의 인덱스는 0부터 시작하며, 뒤에서부터 접근할 때는 -1부터 시작한다.

## 2. 1차원 텐서 다루기
1차원 텐서는 일반적인 파이썬 리스트와 다루는 방법이 거의 동일하다. 슬라이싱의 기본 형태는 `[start : stop : step]`이다.
- `start`: 포함됨 (기본값: 처음)
- `stop`: 포함되지 않음 (기본값: 끝)
- `step`: 건너뛰는 간격 (기본값: 1)
```python
import torch

t1 = torch.tensor([10, 20, 30, 40, 50])

# 인덱싱
print(t1[0])   # 10 (첫 번째 요소)
print(t1[-1])  # 50 (마지막 요소)

# 슬라이싱
print(t1[1:4]) # [20, 30, 40] (인덱스 1부터 3까지)
print(t1[:3])  # [10, 20, 30] (처음부터 인덱스 2까지)
print(t1[2:])  # [30, 40, 50] (인덱스 2부터 끝까지)
print(t1[::2]) # [10, 30, 50] (처음부터 끝까지 2칸씩 건너뛰며)
```
## 2차원 텐서 다루기 (파이썬 리스트와의 결정적 차이)
파이썬 기본 리스트는 `list[행][열]`처럼 대괄호를 두 번 써야 하지만, 텐서는 **대괄호 하나 안에서 콤마(`,`)를 사용해 차원을 구분**한다.
형태: `tensor[행 슬라이싱, 열 슬라이싱]`

```python
t2 = torch.tensor([
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12]
])

# 1. 인덱싱: 특정 행, 특정 열의 값
print(t2[1, 2]) # 7 (인덱스 1번 행의 2번 열)

# 2. 행 또는 열 전체 선택 (콜론 ':' 단독 사용)
print(t2[0, :]) # [1, 2, 3, 4] (0번 행의 모든 열)
print(t2[:, 1]) # [2, 6, 10] (모든 행의 1번 열만 추출)

# 3. 다차원 슬라이싱
print(t2[0:2, 1:3]) 
# [[2, 3],
#  [6, 7]] 
# (0~1번 행에서 1~2번 열만 교차하는 부분 잘라내기)
```
콜론(`:`)만 단독으로 쓰면 해당 차원(행 또는 열)의 **모든 데이터**를 가져오겠다는 의미이다.
## Ellipsis (...)
차원이 3차원, 4차원으로 깊어지면 슬라이싱을 할 때 `:`를 여러 번 써야 해서 코드가 지저분해진다. 이때 점 3개로 이루어진 `...` (Ellipsis)를 사용하면 매우 편리하다. `...`은 "나머지 모든 차원"을 의미한다.

```python
# 3차원 텐서 (채널, 높이, 너비 형태의 이미지 데이터라고 가정)
t3 = torch.rand(3, 224, 224) 

# 첫 번째 채널의 모든 높이, 너비 데이터 가져오기
# t3[0, :, :] 와 동일한 코드이다.
print(t3[0, ...].shape) # torch.Size([224, 224])

# 마지막 너비(width) 데이터만 가져오기
# t3[:, :, -1] 과 동일한 코드이다.
print(t3[..., -1].shape) # torch.Size([3, 224])
```

# 데이터 타입
PyTorch에서 데이터 타입이란 Tensor가 저장하는 값의 데이터 유형을 의미한다.
## 1. 주요 데이터 타입
가장 자주 사용되는 타입들은 크게 **실수형(Floating Point)**, **정수형(Integer)**, 그리고 **논리형(Boolean)** 으로 나뉜다.

| **데이터 유형** | **PyTorch dtype (torch.)** | **설명**           | **비고**                |
| ---------- | -------------------------- | ---------------- | --------------------- |
| **실수형**    | `float32` 또는 `float`       | 32비트 부동소수점       | **기본값**, 가장 많이 사용     |
|            | `float64` 또는 `double`      | 64비트 부동소수점       | 높은 정밀도 필요 시 사용        |
|            | `float16` 또는 `half`        | 16비트 부동소수점       | 메모리 절약, 학습 가속         |
|            | `bfloat16`                 | 16비트 Brain Float | TPU/최신 GPU에서 효율적      |
| **정수형**    | `int64` 또는 `long`          | 64비트 부호 있는 정수    | 인덱싱, 라벨(Label)용       |
|            | `int32` 또는 `int`           | 32비트 부호 있는 정수    | 일반적인 정수 연산            |
|            | `int8`                     | 8비트 부호 있는 정수     | 양자화(Quantization)에 사용 |
|            | `uint8`                    | 8비트 부호 없는 정수     | 이미지 픽셀 데이터(0~255)     |
| **기타**     | `bool`                     | True / False     | 마스킹(Masking) 연산용      |
|            | `complex64`                | 복소수 (32비트 실수 2개) | 신호 처리 등 특수 목적         |
## 2. 데이터 타입 확인 및 변경 방법

### 데이터 타입 확인
```python
import torch

x = torch.tensor([1, 2, 3])
print(x.dtype)  # 기본적으로 torch.int64 (정수 입력 시)

y = torch.tensor([1.0, 2.0])
print(y.dtype)  # 기본적으로 torch.float32 (실수 입력 시)
```

### 데이터 타입 변경 (Casting)
가장 권장되는 방법은 `.to()` 메서드를 사용하는 것이다. .to() 이외에도 `.float()`, `.long()`, `.double()` 과 같은 메서드들도 있다.
```python
# 1. .to() 사용 (가장 유연함)
x = x.to(torch.float32)

# 2. 특정 타입 메서드 사용
x = x.float()   # float32로 변경
x = x.long()    # int64로 변경
x = x.half()    # float16으로 변경

# 3. 생성 시 지정
z = torch.ones((2, 2), dtype=torch.int8)
```


# CUDA Tensor
GPU(Graphics Processing Unit) 메모리에 올라가 있는 텐서
GPU에 옮겨서 굉장히 빠르게 연산이 가능함.
## CUDA 텐서 사용법
### 장치 확인 및 설정
```python
import torch

# CUDA(GPU) 사용 가능 여부 확인
is_cuda = torch.cuda.is_available()
print(f"CUDA Available: {is_cuda}")

# 사용할 장치 지정
device = torch..device("cuda" if torch.cuda.is_available() else "cpu")
```

### 텐서를 GPU로 보내기
```python
# 1. 생성 후 이동 (.to 메서드 - 가장 권장됨) 
x = torch.FloatTensor([1, 2, 3]).to(device) 

# 2. 생성 후 이동 (.cuda 메서드) 
y = torch.FloatTensor([1, 2, 3]).cuda() 

# 3. 처음부터 GPU에 생성 
z = torch.ones((2, 2), device="cuda")
```

# Tensor의 기초 함수 및 메서드
## 1. 대표적인 산술 및 통계 함수

| **함수**         | **설명**                           | **비고**              |
| -------------- | -------------------------------- | ------------------- |
| `torch.sum()`  | 모든 원소의 **합**을 구함                 | -                   |
| `torch.prod()` | 모든 원소의 **곱**을 구함                 | -                   |
| `torch.mean()` | 원소들의 **평균**을 구함                  | 실수형(float) 텐서에서만 작동 |
| `torch.min()`  | **최솟값**을 반환                      | -                   |
| `torch.max()`  | **최고값**을 반환                      | -                   |
| `torch.var()`  | **분산(Variance)**을 구함             | -                   |
| `torch.std()`  | **표준편차(Standard Deviation)**를 구함 | -                   |
## 2. 차원(Dimension) 연산
딥러닝에서는 전체 원소의 합보다 **특정 축(axis)** 을 기준으로 연산하는 경우가 훨씬 많다. 이때 `dim` 파라미터를 사용한다.
- **`dim=0`**: 행(Row)을 따라 연산 (결과적으로 열별로 계산됨)
- **`dim=1`**: 열(Column)을 따라 연산 (결과적으로 행별로 계산됨)
### 예시 코드

```python
import torch

x = torch.FloatTensor([[1, 2, 3], 
                       [4, 5, 6]])

print(x.sum())          # 전체 합: 21.0
print(x.sum(dim=0))     # 행 방향 합 (결과: [5., 7., 9.])
print(x.sum(dim=1))     # 열 방향 합 (결과: [6., 15.])
```


## 3.`keepdim`
연산을 수행하면 해당 차원이 사라지게 된다. 하지만 연산 후에도 원래 텐서의 차원을 유지하고 싶을 때 `keepdim=True`를 사용한다. 이는 브로드캐스팅(Broadcasting) 연산을 할 때 매우 유용하다.

```python
x = torch.FloatTensor([[1, 2], [3, 4]])

# keepdim=False (기본값)
out1 = x.mean(dim=1) 
# 결과: tensor([1.5, 3.5]), 크기: (2,)

# keepdim=True
out2 = x.mean(dim=1, keepdim=True) 
# 결과: tensor([[1.5], [3.5]]), 크기: (2, 1) -> 원본과 차원 수 동일
```

## 4. 주의사항

1. **데이터 타입 제한:** `mean()`, `var()`, `std()` 같은 통계 함수는 정수형(`int64` 등) 텐서에서 바로 사용할 수 없다. 반드시 **실수형(`float32` 등)** 으로 변환 후 사용해야 한다.
    - 잘못된 예: `torch.tensor([1, 2]).mean()`
    - 올바른 예: `torch.tensor([1.0, 2.0]).mean()`
2. **`min()`과 `max()`의 추가 기능:** 이 함수들에 `dim`을 지정하면 최솟값/최댓값뿐만 아니라 그 값이 위치한 **인덱스(indices)** 도 함께 한다.
	``` python
	print('torch.max(l) =', torch.max(l, dim = 0))
	values, indices = torch.max(l, dim = 0)
	print('')
	print('values =', values)
	print('indices =', indices)
	```
	결과	
	```
	torch.max(l) = torch.return_types.max(
	values=tensor([3., 4., 5.]), 
	indices=tensor([1, 1, 1]))
	
	values = tensor([3., 4., 5.])
	indices = tensor([1, 1, 1])
	```
1. **Bessel's Correction:** PyTorch의 `var()`와 `std()`는 기본적으로 **불편 분산(Unbiased variance)** 을 계산한다 ($n-1$로 나눔). 인구 통계학적 분산($n$으로 나눔)이 필요하다면 `correction=0` 옵션을 줄 수 있다.
## 5. Tensor의 특성을 확인하는 메서드
| **구분**    | **코드 (예시 l)**                         | **의미**                 | **직관적인 비유**          | **예시 결과 (2x3 텐서 기준)** |
| --------- | ------------------------------------- | ---------------------- | -------------------- | --------------------- |
| **차원 수**  | `l.dim()`                             | **Rank** (차원 개수)       | 대괄호(`[`)가 몇 겹인가?     | `2`                   |
| **모양**    | `l.size()`<br><br>  <br><br>`l.shape` | **Shape** (각 차원의 크기)   | 가로, 세로에 몇 개씩 있는가?    | `torch.Size([2, 3])`  |
| **원소 개수** | `l.numel()`                           | **Number of Elements** | 안에 든 숫자 총 개수가 몇 개인가? | `6`                   |
# Tensor 조작(Manipulation)
PyTorch에서 Tensor Manipulation은 Tensor의 모양(Shape)을 바꾸거나, 특정 부분을 추출하고, 여러 텐서를 합치는 등의 변형 과정을 의미한다.
## Tensor의 형태 변경: view()와 reshape()

텐서의 원소 개수(데이터)는 그대로 유지하면서 차원과 크기(Shape)만 바꿀 때 사용하는 대표적인 두 함수이다.

```python
import torch

x = torch.arange(12) # [0, 1, 2, ..., 11] 크기가 12인 1차원 텐서

# 1차원 텐서를 3행 4열의 2차원 텐서로 변경
v_tensor = x.view(3, 4)
r_tensor = x.reshape(3, 4)
```
두 함수는 결과적으로 같은 형태의 텐서를 반환하지만, **메모리 작동 방식**에서 결정적인 차이가 있다.
### view()
- 기존 텐서와 **동일한 메모리 공간을 공유**한다. (즉, `view`로 만든 텐서의 값을 바꾸면 원본 텐서의 값도 바뀐다.)
- **조건:** 텐서의 데이터가 메모리상에 연속적으로(Contiguous) 배치되어 있을 때만 정상적으로 작동한다.
### reshape()
- `view()`와 동일한 기능을 수행하지만, 조건이 더 유연하다.
- 텐서가 연속적이라면 `view()`처럼 기존 메모리를 공유하지만, **연속적이지 않다면 데이터를 새로 복사(Copy)** 하여 연속적인 텐서를 새로 만든 뒤 형태를 변경한다.

---

## 메모리 연속성과 is_contiguous()

그렇다면 `view()`의 작동 조건인 **'연속적(Contiguous)'**이라는 것은 무슨 의미일까?

PyTorch에서 텐서를 처음 생성하면, 그 데이터는 메모리상에 순서대로 빈틈없이 나란히 저장된다. 이를 '연속적인 상태'라고 한다. 하지만 텐서에 `transpose()` (축 변경)나 슬라이싱 같은 연산을 적용하면, 텐서의 형태나 접근 순서는 바뀌지만 실제 메모리에 저장된 물리적 데이터 순서는 그대로 유지된다. 결과적으로 논리적인 순서와 물리적인 메모리 주소 순서가 일치하지 않는 **비연속적(Non-contiguous) 상태**가 된다.

`is_contiguous()` 메서드는 현재 텐서가 메모리상에 연속적으로 배치되어 있는지를 `True` 또는 `False`로 반환하여 알려준다.

```python
x = torch.tensor([[1, 2, 3], [4, 5, 6]])
print(x.is_contiguous()) # True (처음 생성했으므로 연속적임)

# 전치(Transpose) 연산을 통해 행과 열을 바꿈
y = x.transpose(0, 1) 
print(y.is_contiguous()) # False (축이 뒤틀려 메모리 연속성이 깨짐)
```

### 에러 상황과 해결 방법
비연속적인 텐서에 `view()`를 적용하면 에러가 발생한다.
```python
# RuntimeError: view size is not compatible with input tensor's size and stride...
z = y.view(-1) 
```

**해결 방법 1: contiguous() 사용 후 view() 적용**
강제로 메모리에 연속적으로 데이터를 재배치(복사)한 후 `view()`를 적용한다.

```python
z = y.contiguous().view(-1) # 정상 작동
```

**해결 방법 2: reshape() 사용 (가장 권장됨)**
`reshape()`는 내부적으로 텐서가 비연속적일 경우 알아서 `contiguous()`를 호출하여 복사한 뒤 형태를 바꾸므로 매우 안전하다.

```python
z = y.reshape(-1) # 정상 작동
```

## Tensor의 평탄화: `flatten()`
아무 인자도 주지 않으면 텐서의 모든 요소를 1차원 배열로 쭉 나열한다.
```python
import torch

# 2x2x2 크기의 3차원 텐서 생성
t = torch.tensor([
    [[1, 2], [3, 4]],
    [[5, 6], [7, 8]]
])
print("원본 형태:", t.shape) # torch.Size([2, 2, 2])

# 전체 평탄화
flat_t = torch.flatten(t)
print("평탄화 형태:", flat_t.shape) # torch.Size([8])
print(flat_t) # tensor([1, 2, 3, 4, 5, 6, 7, 8])
```
`torch.flatten()`의 기본 형태는 `torch.flatten(input, start_dim=0, end_dim=-1)`이다.
- `start_dim`: 평탄화를 시작할 차원을 지정한다. 기본 겂은 0 (시작 차원)이다.
- end_dim: 평탄화를 끝낼 차원을 지정한다. 기본값은 `-1`(마지막 차원)이다.
- `start_dim`과 `end_dim`을 함께 사용하면 텐서의 특정 중간 구간만 선택하여 평탄화할 수 있다.
```python
import torch

# (배치, 채널, 깊이, 높이, 너비) 크기가 (2, 3, 4, 5, 5)인 5차원 텐서
t = torch.rand(2, 3, 4, 5, 5)

# 채널(dim=1)부터 깊이(dim=2)까지만 평탄화 (나머지는 유지)
result = torch.flatten(t, start_dim=1, end_dim=2)

# (2, 3 * 4, 5, 5) -> (2, 12, 5, 5) 형태로 변환됨
print(result.shape) # torch.Size([2, 12, 5, 5])
```
## 차원의 축소와 확장: squeeze() & unsqueeze()
텐서의 특정 차원 크기가 1일 때, 이를 제거하거나 반대로 크기가 1인 차원을 새로 만들어야 할 때 사용하는 함수이다.
- **squeeze()**: 인자를 넣지 않으면 텐서에서 크기가 1인 차원을 모두 제거하여 차원을 축소한다. 또는 지정한 인덱스(`dim`) 위치의 크기가 1일 때만 제거한다. 만약 해당 차원의 크기가 1이 아니면 아무런 변화가 일어나지 않는다.
- **unsqueeze(dim)**: 지정한 인덱스(`dim`) 위치에 크기가 1인 차원을 추가하여 차원을 확장한다.
**unsqueeze() 적용 예시**
크기가 `(3, 4)`인 2차원 텐서 `y`가 있다고 가정할 때, `dim` 값에 따라 차원이 어떻게 확장되는지 코드로 확인해 볼 수 있다.

```python
import torch

y = torch.randn(3, 4)

# 0차원(가장 앞)에 차원 추가 -> 모양: (1, 3, 4)
z_dim0 = torch.unsqueeze(y, dim=0)

# 1차원(중간)에 차원 추가 -> 모양: (3, 1, 4)
z_dim1 = torch.unsqueeze(y, dim=1)

# 2차원(가장 뒤)에 차원 추가 -> 모양: (3, 4, 1)
z_dim2 = torch.unsqueeze(y, dim=2)
```
## 새로운 축을 기준으로 텐서 결합: stack()
`stack()` 함수는 말 그대로 여러 텐서를 '쌓아서' 결합하는 역할을 한다. 이때 기존 텐서들의 차원이 유지된 채로 결합되는 것이 아니라, 지정한 `dim`을 기준으로 **새로운 차원(축)이 생성**되며 결합된다는 점이 특징이다.
예를 들어, 각각 `(2, 2)` 크기를 가지는 3개의 이미지 채널(Red, Green, Blue) 텐서가 있다고 가정해 보자.

```python
red_channel = torch.tensor([[255, 0], [0, 255]])
green_channel = torch.tensor([[0, 255], [0, 255]])
blue_channel = torch.tensor([[0, 0], [255, 0]])
```

이 3개의 2D 텐서를 `stack()`을 활용해 결합할 때, `dim` 값에 따라 결과 텐서의 형태가 달라진다.
- **dim=0으로 결합**: 가장 바깥쪽에 새로운 축을 생성하여 쌓는다. 결과 텐서의 모양은 `(3, 2, 2)`가 된다.
- **dim=1으로 결합**: 행(row)을 기준으로 새로운 축을 생성하여 결합한다. 결과 텐서의 모양은 `(2, 3, 2)`가 된다.
- **dim=2로 결합**: 열(column)을 기준으로, 즉 가장 안쪽 차원 요소들끼리 묶어서 결합한다. 결과 텐서의 모양은 `(2, 2, 3)`이 된다.
```python
# dim=0 기준 결합
a_dim0 = torch.stack((red_channel, green_channel, blue_channel))

# dim=1 기준 결합
a_dim1 = torch.stack((red_channel, green_channel, blue_channel), dim=1)

# dim=2 기준 결합
a_dim2 = torch.stack((red_channel, green_channel, blue_channel), dim=2)
```
## 기존 축을 기준으로 텐서 결합: `cat()`
`stack()` 함수는 새로운 차원을 생서앟여 Tensor를 결합하지만 `cat()` 함수는 **기존의 차원** 을 유지하면서 Tensor 들을 연결함.
```python
b = torch.tensor([[0,1],[2,3]])
c = torch.tensor([[4,5], [6,7]])

# dim = 0을 기준으로 Tensor b와 c를 연결하는 코드 표현
d = torch.cat((b,c))

# dim = 1을 기준으로 Tensor b와 c를 연결하는 코드 표현
e = torch.cat((b,c),1)
```

## 텐서의 크기 늘리기: `expand()` vs `repeat()`
특정 차원의 크기가 1인 텐서를 더 큰 크기로 늘리고 싶을 때 사용하는 함수들이다. 예를 들어 `(1, 3)` 형태의 행벡터를 `(4, 3)` 형태의 행렬로 복제하고 싶을 때 유용하다.
### **expand(): 메모리 효율적인 참조**
`expand()`는 실제로 데이터를 새로 복사해서 메모리에 할당하지 않는다. 기존 데이터를 **참조**만 하여 마치 늘어난 것처럼 보여주는 방식이다.
- **장점:** 메모리를 거의 추가로 사용하지 않아 매우 효율적이다.
- **제약:** 크기가 **1인 차원**에 대해서만 늘릴 수 있다.
- **특이사항:** `expand`로 만든 텐서의 값을 변경하면 원본 텐서의 값도 함께 바뀔 수 있으며, 메모리가 연속적이지 않은 상태가 되기 쉽다.

```python
import torch

x = torch.tensor([[1, 2, 3]]) # 모양: (1, 3)

# (1, 3) -> (4, 3)으로 확장
x_expanded = x.expand(4, 3)

print(x_expanded.shape) # torch.Size([4, 3])
print(x_expanded)
# [[1, 2, 3],
#  [1, 2, 3],
#  [1, 2, 3],
#  [1, 2, 3]]
```
### **repeat(): 실제 데이터 복사**
`repeat()`은 데이터를 실제로 원하는 횟수만큼 **복사**하여 새로운 텐서를 생성한다.
- **장점:** 원본과의 연결이 끊어지며, 메모리상에 연속적인 새로운 텐서를 얻을 수 있다. 크기가 1이 아닌 차원도 반복할 수 있다.
- **단점:** 실제 복사가 일어나기 때문에 데이터가 클수록 메모리 사용량이 급증한다.
- **인자:** `expand`가 '최종 모양'을 인자로 받는다면, `repeat`은 **'각 차원을 몇 번 반복할지'**를 인자로 받는다.

```python
x = torch.tensor([[1, 2, 3]]) # 모양: (1, 3)

# 0번 차원을 4번, 1번 차원을 1번 반복 -> 모양: (4, 3)
x_repeated = x.repeat(4, 1)

print(x_repeated.shape) # torch.Size([4, 3])
```
