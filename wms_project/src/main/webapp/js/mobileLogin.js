      document.getElementById('login_btn').addEventListener('click', function() {
          var deliverId = document.getElementById('deliver_id').value;
          var deliverPw = document.getElementById('deliver_pw').value;
          var deliverCheck = document.getElementsByName('deliver_check')[0].checked;

          if (deliverCheck) {
              localStorage.setItem('deliver_id', deliverId);
              localStorage.setItem('deliver_pw', deliverPw);
          } else {
              localStorage.removeItem('deliver_id');
              localStorage.removeItem('deliver_pw');
          }   
      });

      window.onload = function() {
          var savedId = localStorage.getItem('deliver_id');
          var savedPw = localStorage.getItem('deliver_pw');

          if (savedId && savedPw) {
              document.getElementById('deliver_id').value = savedId;
              document.getElementById('deliver_pw').value = savedPw;
              document.getElementsByName('deliver_check')[0].checked = true; // 체크박스 선택
          }
      };


      function logout() {
          localStorage.removeItem('deliver_id');
          localStorage.removeItem('deliver_pw');
          window.location.href = '/deliveryMobile/mobileLogin.jsp'; // 예시로 로그인 페이지로 이동
      }
	  
	  
  
  var login_btn = document.querySelector("#login_btn");
  login_btn.addEventListener("click",function(){
      if(fm.deliver_id.value==""){
          alert("기사님의 사원번호를 입력하세요");
          fm.deliver_id.focus();
      }
      else if(fm.deliver_pw.value==""){
          alert("기사님의 패스워드를 입력하세요");
          fm.deliver_pw.focus();
      }
      else{
          fm.method = "POST";
          fm.action = "/deliveryMobile/mobileLoginOk.do";
          fm.enctype = "application/x-www-form-urlencoded";
          fm.submit();
      }
  });
