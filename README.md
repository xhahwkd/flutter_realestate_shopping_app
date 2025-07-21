<h1 align="center">
임박세일 홈즈 🏠
<br/>
</h1>
<p align="center">
</p>
</p>

<br/>

## 프로젝트 개요
### "임박세일 홈즈"는 부동산 급매 매물을 실시간으로 연결하는 매물 중심 쇼핑 플랫폼입니다.
### ✨ 이런 분들을 위해 설계되었습니다.

> 매물을 신속하게 판매하고 싶은 집주인
> 

> 좋은 조건의 급매를 찾는 실수요자
> 

> 타이밍을 중시하는 전략적 투자자
> 

<br/>

## 팀 소개 / 역할 분담
### 팀명: 성공임박

**박혜진** : 홈화면 I / II, 찜목록페이지, 테마, 페이지연결  
  
**임혜진** : 상품등록페이지, 상품상세페이지, 상품목록페이지, 상품필터기능

<br/>

## 프로젝트 일정
25/07/17 ~ 25/07/23

<br/>

## 앱 UI Flow

<img alt="UIFlow1" src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2F9igUJ%2FbtsPs2NL772%2FAAAAAAAAAAAAAAAAAAAAAC-IwTrQ79MgjS82FzKWIva_zqUM0t8FrLDi3I_e6lRu%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1753973999%26allow_ip%3D%26allow_referer%3D%26signature%3DlU0zmtetHhibgWu9p9%252FDGLGwr%252Bs%253D"/>

<img alt="UIFlow2" src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2FcUu37e%2FbtsPqPilKTO%2FAAAAAAAAAAAAAAAAAAAAAGq1kjY_9v96EHTZf_4TeH7v7oNxY02QINz28b3S2nuU%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1753973999%26allow_ip%3D%26allow_referer%3D%26signature%3DzAMsEfV2a6GKOGIQtAa00QwWvxk%253D"/>

<img alt="UIFlow3" src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2FoaQg9%2FbtsPthYgVRt%2FAAAAAAAAAAAAAAAAAAAAAKmYkScRuACqjeSSA-THLtc0NC0OC6foTG2-tsyjONWY%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1753973999%26allow_ip%3D%26allow_referer%3D%26signature%3DRJTkQUjC6hn4ROKFg0izhwjS2C8%253D"/>

<img alt="UIFlow4" src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2Fbh3qNs%2FbtsPtiCQzF2%2FAAAAAAAAAAAAAAAAAAAAAPMYVQZ3t3cQ8BE0kYZeV-ysFISHwCrrSeDRobK2h5yt%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1753973999%26allow_ip%3D%26allow_referer%3D%26signature%3DlT%252FufMULkjijeZ9KJeDM0x6bYPA%253D"/>

<br/>

## 앱 주요기능
**홈화면I** : 로그인 유형 선택 - 구매자 / 판매자  

**홈화면II** :  구매자 홈 화면 / 찾고있는 매물 가격, 유형 필터링 검색  

**상품등록페이지** :  판매자 페이지 / 매물 이미지, 이름, 종류, 가격, 상품 설명 입력  

**매물목록(상품목록)페이지** :  매물 목록 확인 / 매물 이미지, 이름, 종류, 가격, 상품 설명  

**상품상세페이지** :  매물 상세 내용 확인 / 찜하기 / 구매하기  

**찜목록페이지** :  찜한 매물 확인 / 삭제 / 구매하기  

<br/>

## Trouble Shooting
### 1. floatingActionButton 중복 선언 에러
[상황]
- branch를 merge하는 과정에서 FAB(floatingActionButton) conflict 발생

[원인]
- Scaffold는 floatingActionButton을 하나만 가질 수 있음
- 두 개의 FAB가 동시에 존재해 빌드 에러 발생

[해결]
- 두 개의 버튼을 Column으로 묶어 하나의 위젯처럼 구성
- 그 Column을 floatingActionButton에 통째로 전달하여 해결.

### 2. Get X Obx 오류 (런타임 에러)
[상황]
- GetX 기반의 찜 목록 화면에서 Obx 사용 후 에러 박스(red screen) 발생

[원인]
- Obx로 UI 감쌌지만, 내부에서 .obs로 선언된 반응형 변수를 실제로 사용하지 않음
- 따라서 GetX가 반응형 상태 추적을 할 수 없어 런타임 에러 발생

[해결]
- Obx 내부에서 반드시 .obs로 선언된 변수를 직접 사용  
예시: likeController.isProductSelected.value 값을 사용해 UI 요소 제어