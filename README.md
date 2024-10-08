## 쌍용강북교육센터 개인 프로젝트 (withSports)

## 


## 프로젝트 소개

<p align="left">
   <a> 쌍용강북교육센터에서 SpringMVC 수업 진행 후 개인 프로젝트를 진행 하는 과정을 통해 제작하게 되었습니다. </a>
   <a>단, java code는 개인, 주제선정 및 ERD, CSS는 팀원을 갖추어 같은 주제 및 데이터로 진행했습니다. </a>
</p>
<p align="left">
  <h4>어떤 홈페이지이고, 이 주제를 선정하게 된 이유는?</h4> 
  <a>
    
  </a>
</p>  
<p align="left">
   <a>교육센터 이수 후 추후 코드 리뷰 시 부족한 점 및 오류부분을 발견하여
     코드 추가 및 개선을 위해 2차 수정을 진행 하였습니다.  </a>
</p>

## 개발기간

   <p align="left">
      <a>2024.02.28 ~ 2024.03.15 (1차)</a>
   </p>
   <p align="left">
      <a>2024.07.23 ~ 2024.08.02 (2차)</a>
   </p>
  
## ERD
   <p align="center">
      <img alt="withSportsERD" src="https://github.com/user-attachments/assets/62cc16fa-2cb1-483b-8de9-5e0f312fe6db" />
      https://www.erdcloud.com/d/TJ68m4z9nZHTcBp25
   </p>


## 홈페이지 소개
   
   * 2계층
      + 기업/개인 사용자     

   * 페이지별 공통 기능
      + 상/하단 네비게이션
        - 홍보게시판
        - 후기게시판
        - 기업/개인 마이페이지
        - 로그인 / 로그아웃
     + 최상단 이동
        
   * 메인페이지 
      * 홍보 목록 (슬라이드3 / 조회순3)
       
   * 로그인    
      * 회원가입
         - 기업/개인 회원가입
         - 아이디/비밀번호 찾기 (개인)
   
   * 홍보게시판
      * 홍보 글 목록
      * 홍보 글 작성 (기업)
      * 홍보 글 상세정보 
         + 홍보 글 수정 (기업)
       
   * 후기게시판 
      * 후기 글 목록
      * 후기 글 작성 (개인)
      * 후기 글 상세정보
         + 후기 글 수정(개인) 

   * 마이페이지
      * 개인
         + 회원정보 
            - 회원정보 수정 / 회원 탈퇴
         + 대회 참여기록 
         + 작성 글/작성 댓글
         + 관심 글
 
      * 기업
         * 작성 글 목록
            + 참여인원 목록 
           
## 주요 기능

   * 메인페이지 
      * 홍보 목록을 출력 (슬라이드 / 조회순 3개씩)

   * 로그인 
      - 개인 / 기업 로그인 가능
      - 아이디와 패스워드가 DB의 값과 일치하면 로그인, 일치하지 않으면 팝업창을 띄움  
   
   * 회원가입  
      + 개인, 기업 공통부분 제약사항
         - 아이디 : 4-20자 영문 대/소문자 + 숫자
         - 비밀번호 : 8~32자 영문 대/소문자 + 숫자 + 특수문자
         - 이메일 : xyz@xyz.com 형식
 
      + 개인 
         - 기존 존재하는 아이디, 이메일, 닉네임, 전화번호는 입력 할 수 없도록 중복검사 하도록 구현
            - 전화번호 : 010-1234-5678 형식 
      + 기업
         - 기존 존재하는 아이디, 이메일, 사업자번호, 주소, 연락처는 입력 할 수 없도록 중복검사 하도록 구현
            - 전화번호 : 031-123-5678 형식 
            - 사업자번호 : 001-12-34567 형식
            - 기업 회원가입은 관리자 승인을 받아야 정상 이용 가능하도록 구현
            
   * 아이디 찾기 
      + 이름, 이메일 값이 DB의 값과 일치하면 아이디 확인을 할 수 있음

   * 비밀번호 찾기 JavaMail API (SMTP) 
      + 아이디, 이름, 이메일 값이 DB의 값과 일치하면 이메일 주소로 인증코드를 발송
      + 인증코드 발송 후 기재 시 값이 일치하면 비밀번호 재설정 가능

   * 홍보 글 작성 (기업)  
      + 제목/기간/종목/장소/참가비용/인원/내용 필수입력
         - 대회 장소는 카카오지도 API를 통해 우편번호 찾기 가능, 상세주소만 추가입력
         - 모집기간 > 대회일자 인 경우 글 작성 불가
            - ex) 모집기간(2024-08-22) > 대회일자(2024-08-19)
            - 모집 시작, 마감 및 대회 시작, 마감 전부 동일하게 적용  
      + 이미지 업로드 가능

   * 홍보 글 목록 
      + 검색
         - 검색 키워드는 작성자, 행사명, 행사내용
      + 모집전/중/후
        - 모집기간 전의 경우 - 모집 전으로 출력
        - 모집기간 중이고, 모집인원 미달인 경우 - 모집 중으로 출력    
        - 모집기간 후의 경우 또는 모집인원이 초과의 경우 - 모집 마감으로 출력
      + 게시글 제목/이미지/기간/장소/인원/주최자/게시일/좋아요 수/종목 출력  
         - 첨부 이미지가 없는경우 대체 이미지 출력 
         
   * 홍보 글 상세정보        
      + 게시글 클릭 시 마다 조회수 + 1 
      + 해당 게시글의 상세정보 및 이미지, 내용, 조회수 및 좋아요 수를 출력
         - 첨부 이미지 없는경우 미 출력  
      + 카카오 지도 API 제공
         - 카카오 지도 API를 통해 약도를 확인 할 수 있음
      + 홍보 글 추천(좋아요) (개인)  
         - 버튼 클릭 시 기능 작동, 마이페이지에서 확인가능
         - 취소가능, 마이페이지에서도 취소가능
      + 카카오페이 결제(개인)
         - 카카오 페이 API를 통해 결제 시스템 추가
         - 결제 후 마이페이지에서 확인가능
         - 모집기간 전/모집기간 후 또는 모집인원 초과 시 결제불가
      + 작성 기업자는 해당 글을 수정 할 수 있음
      
   *  홍보 글 목록/ 글 상세정보  
      + 우측에 추천순, 조회순으로 게시글 3개씩 출력해줌
         - 클릭하여 해당 게시글로 이동 가능  
         
   * 후기 글 작성 (개인)       
      + 제목/내용 필수입력
      + 이미지 업로드 가능
   
   * 후기 글 목록     
      + 검색
         - 검색 키워드는 작성자, 제목, 내용 
      + 정렬
         - 최신순, 조회수로 정렬가능  
         
   * 후기 글 상세정보  
      + 댓글 / 대댓글
         - 댓글, 대댓글 작성가능 (개인)
            - 작성된 댓글, 대댓글 삭제가능, 마이페이지에서도 삭제가능  
            - 삭제시 DB에서 상태값 변경해서 삭제된 댓/대댓글로 출력
      + 후기 글 수정/삭제 (개인) 
         - 글 삭제시 작성된 댓/대댓글 전부 삭제
         
   * 마이페이지           
      + 개인 
         + 회원정보
            - 아이디, 이름, 이메일 등 회원정보 조회가능
               - 회원정보 수정 버튼을 통해 비밀번호, 닉네임, 이메일, 전화번호 수정가능
                  - 수정은 회원가입과 마찬가지로 형식에 맞춰서 수정 
               - 회원탈퇴 버튼을 통해 팝업창 출력, 확인 시 회원탈퇴 가능
               
         + 결제 성공/취소 목록
            - 후기 상세페이지에서 결제 목록/결제 취소목록 출력
               - 카카오페이 결제취소 가능
               - 결제일자로부터 3일 내 취소 가능, 단 대회시작일자 당일엔 취소불가  
         
         + 작성 글/댓글 목록
            - 작성된 후기글, 댓글 목록 출력
            - 삭제된 글/댓글은 미출력
         + 관심글 목록
            - 관심 홍보 글 목록 출력
            - 관심 홍보 글 취소가능
             
      + 기업
         + 홍보 글 목록
            - 작성한 홍보 글 목록 출력
               - 글 클릭시 해당 상세정보로 이동 
            - 검색
               - 검색 키워드는 행사명, 행사내용
         
         + 참가인원 목록 확인가능
            - 참가인원 버튼을 통해 참여자 목록 확인가능
               - 참가인원이 존재하는경우 10개씩 출력
               - 참가인원이 없는경우 참가인원이 없다고 출력             

## 사용언어 및 툴

<p align="left">
   <img alt="java" src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white"/>
   <img alt="html5" src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white"/>
   <img alt="css3" src="https://img.shields.io/badge/css3-1572B6?style=for-the-badge&logo=css3&logoColor=white" />
   <img alt="javaScript" src="https://img.shields.io/badge/Java%20Script-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white"/>
   <img alt="jquery" src="https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white"/>
   <img alt="jsp" src="https://img.shields.io/badge/jsp-000000?style=for-the-badge&logo=jsp&logoColor=white"/>
   <img alt="jstl" src="https://img.shields.io/badge/jstl-000000?style=for-the-badge&logo=jstl&logoColor=white" />
   <img alt="mybatis" src="https://img.shields.io/badge/mybatis-000000?style=for-the-badge&logo=mybatis&logoColor=white"/>
</p>

<p align="left">
   <img alt="spring" src="https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white"/>
   <img alt="tomcat" src="https://img.shields.io/badge/apache%20tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white"/>
   <img alt="oracle" src="https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=black"/>
   <img alt="kakaoPay" src="https://img.shields.io/badge/kakaoPay-FFCD00?style=for-the-badge&logo=kakao&logoColor=black"/>
</p>

## 
<p align="left">
   <a>   </a>
</p>
