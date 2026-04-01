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
| **정수형**    | `int64` 또는 `long`          | 64비트 부호 있는 정수    | **인덱싱, 라벨(Label)**용   |
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

---

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
