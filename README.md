
# Combine 테스트

![testCombine1](https://github.com/leojini/TestCombine/assets/17540345/dc90f97d-6afc-4377-92ae-e469d1c06e80)

![image](https://github.com/leojini/TestCombine/assets/17540345/f608bfd5-b6fb-4fcb-ae7f-938b70a576d8)


1. 비동기(프로세스를 중단시키지 않고 처리. 사용자 입력 혹은 네트워크 데이터 전달 완료 시점 예측이 불가능한 작업등에 주로 쓰임) 처리를 위한 ios native 프레임워크
2. 시간 경과에 따라 퍼블리셔(발행자)가 발생시키는 이벤트를 서브스크라이버(구독자)가 처리할 수 있는 구조.
3. operator를 combine하여 사용한다.
4. 코드 가독성을 높이고 유지 보수가 용이하다.

- TextField 2개의 입력값 Published 어노테이션으로 구독이 가능하도록 설정한다.
- TextField 2개 매치 여부 퍼블리셔로 반환 후 버튼 설정 변경한다.
- SearchBarTextField 값 변경시 공백 필터 및 라벨에 설정한다.
