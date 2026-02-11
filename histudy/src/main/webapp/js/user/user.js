    // 2. 로그인 함수 
	function loginCheck(){
		return fetch("userSignIn.do", 
		{method: "POST",
		 headers: {
		 	"Content-Type":"application/json"	
		 },
		 body:JSON.stringify({
		 	user_id: document.login.user_id.value,
		 	user_pwd: document.login.user_pwd.value,
		 	remember_id: document.login.rememberId.checked ? "on" : null
		 })
		})
		.then(function(res){
			return res.text();
		})
		.then(function(data){
			alert(data);
			location.reload();
		})
	
	}	

    // [2] 로그인 모달 열기 및 쿠키 처리 통합

function getCookie(name){

    const cookies = document.cookie.split(";");

    for(let i=0; i<cookies.length; i++){

        const cookie = cookies[i].trim();

        if(cookie.indexOf(name + "=") === 0){
            return cookie.substring(name.length + 1);
        }
    }
    return null;
}
=======
/* === 전역 변수 (상태 관리) === */
var isIdChecked = false;
var isEmailChecked = false;

/** 1. 로그인 처리 함수 (Promise 방식) */
function loginCheck() {
    var userId = document.login.user_id.value;
    var userPwd = document.login.user_pwd.value;
    var rememberId = document.login.rememberId.checked ? "on" : null;

    return fetch("userSignIn.do", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            user_id: userId,
            user_pwd: userPwd,
            remember_id: rememberId
        })
    })
    .then(function(res) { return res.text(); })
    .then(function(data) {
        alert(data);
        location.reload();
    })
    .catch(function(err) { console.error("로그인 중 오류 발생:", err); });
}

/** 2. 쿠키 읽기 함수 */
function getCookie(name) {
    var cookies = document.cookie.split(";");
    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i].trim();
        if (cookie.indexOf(name + "=") === 0) return cookie.substring(name.length + 1);
	
function getCookie(name) {
    return document.cookie
        .split(";")
        .find(row => row.startsWith(name + "="))
        ?.split("=")[1];
}


    // [2] 로그인 모달 열기 및 쿠키 처리 통합
    }
    return null;
}

/** 3. 로그인 모달 열기 함수 */
>>>>>>> develop2
function openSignInModal() {
    fetch("userSignIn.do")
        .then(function(response) {
            if (!response.ok) throw new Error("서버 응답 오류");
            return response.text();
        })
        .then(function(html) {
            var parser = new DOMParser();
            var doc = parser.parseFromString(html, 'text/html');
            var fragment = doc.querySelector('#signInFragment');
            var modalContent = document.getElementById('modalContent');
            if (!modalContent) return;

            modalContent.innerHTML = fragment ? fragment.innerHTML : html;
            var overlay = document.getElementById('modalOverlay');
            if (overlay) overlay.style.display = 'flex';

            var id = getCookie("id");
            if (id) {
                var idInput = modalContent.querySelector('input[name="user_id"]');
                var rememberCheck = modalContent.querySelector('input[name="rememberId"]');
                if (idInput) idInput.value = id;
                if (rememberCheck) rememberCheck.checked = true;
            }

            if (!modalContent.querySelector('.close-btn')) {
                var closeBtn = document.createElement('div');
                closeBtn.className = 'close-btn';
                closeBtn.innerHTML = '&times;';
                closeBtn.onclick = closeSignInModal;
                Object.assign(closeBtn.style, {
                    position: 'absolute', right: '25px', top: '20px',
                    cursor: 'pointer', fontSize: '20px', fontWeight: 'bold', color: '#666'
                });
                modalContent.appendChild(closeBtn);
            }
        })
        .catch(function(error) { console.error("모달 로드 실패:", error); });
}

/** 4. 모달 닫기 함수 */
function closeSignInModal() {
    var overlay = document.getElementById('modalOverlay');
    if (overlay) overlay.style.display = 'none';
}

/** 5. 아이디 중복 확인 */
function checkId() {
    var userIdEl = document.getElementById('user_id');
    if (!userIdEl) return;
    
    var userId = userIdEl.value.trim();
    if (!userId) { alert("아이디를 입력해주세요."); return; }

    var idRegExp = /^[a-zA-Z0-9]+$/;
    if (!idRegExp.test(userId)) { alert("아이디는 영문과 숫자만 가능합니다."); return; }

    fetch("userCheckId.do?user_id=" + userId)
        .then(function(res) { return res.text(); })
        .then(function(data) {
            if (data.trim() === "0") {
                alert("사용 가능한 아이디입니다.");
                isIdChecked = true;
                userIdEl.onchange = function() { isIdChecked = false; };
            } else {
                alert("이미 존재하는 아이디입니다.");
                isIdChecked = false;
            }
        });
}

/** 6. 이메일 중복 확인 */
function emailCheck() {
    var emailEl = document.getElementById('user_email');
    if (!emailEl) return;

    var userEmail = emailEl.value.trim();
    if (userEmail === "") { alert("이메일을 입력해주세요."); emailEl.focus(); return; }

    var emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if (!emailPattern.test(userEmail)) { alert("유효한 이메일 형식이 아닙니다."); return; }

    fetch("userCheckEmail.do?user_email=" + encodeURIComponent(userEmail))
        .then(function(res) { return res.text(); })
        .then(function(data) {
            if (data.trim() === "1") {
                alert("이미 사용 중인 이메일입니다.");
                isEmailChecked = false;
            } else {
                alert("사용 가능한 이메일입니다.");
                isEmailChecked = true; // 중요: 중복 확인 성공 시 상태 업데이트
                emailEl.onchange = function() { isEmailChecked = false; };
            }
        })
        .catch(function(err) { console.error("이메일 중복 체크 오류:", err); });
}

/** 7. 비밀번호 실시간 일치 확인 초기화 */
function initPasswordCheck() {
    var pwConfirmEl = document.getElementById('user_pw_confirm');
    if (!pwConfirmEl) return;

    pwConfirmEl.onkeyup = function() {
        var pw = document.getElementById('user_pw').value;
        var pwConfirm = this.value;
        var msg = document.getElementById('pw_msg');
        var icon = document.getElementById('pw_icon');
        var unlockImg = "/histudy/user-img/pw2-icon.png";
        var lockImg = "/histudy/user-img/pw-icon.png";

        if (pwConfirm === "") { msg.innerHTML = ""; if(icon) icon.src = unlockImg; return; }
        if (pw.length < 7) {
            msg.innerHTML = "비밀번호는 7자리 이상이어야 합니다.";
            msg.style.color = "orange";
            if(icon) icon.src = unlockImg;
            return;
        }
        if (pw === pwConfirm) {
            msg.innerHTML = "비밀번호가 일치합니다.";
            msg.style.color = "green";
            if(icon) icon.src = lockImg;
        } else {
            msg.innerHTML = "비밀번호가 일치하지 않습니다.";
            msg.style.color = "red";
            if(icon) icon.src = unlockImg;
        }
    };
}

/** 8. 회원가입 전체 유효성 검사 */
function validateSignUp() {
    if (!isIdChecked) { alert("아이디 중복 검사를 진행해주세요."); return false; }
    if (!isEmailChecked) { alert("이메일 중복 검사를 진행해주세요."); return false; }

    var pw = document.getElementById('user_pw').value;
    var pwConfirm = document.getElementById('user_pw_confirm').value;
    if (pw.length < 7) { alert("비밀번호는 7자리 이상이어야 합니다."); return false; }
    if (pw !== pwConfirm) { alert("비밀번호가 일치하지 않습니다."); return false; }

    var year = document.getElementById('birth_year').value;
    var month = document.getElementById('birth_month').value;
    var day = document.getElementById('birth_day').value;
    if (!year || !month || !day) { alert("생년월일을 모두 선택해주세요."); return false; }

    var birthdateEl = document.getElementById('user_birthdate');
    if (birthdateEl) birthdateEl.value = year + "-" + month + "-" + day;

    return true;
}

/** 9. 공통 이벤트 리스너 등록 */
document.addEventListener('DOMContentLoaded', function() {
    initPasswordCheck(); // 비밀번호 실시간 체크 활성화
    
    // [A] 로그인 버튼 클릭 위임
    document.addEventListener('click', function(e) {
        if (e.target && e.target.classList.contains('header__login')) {
            var dropdown = e.target.closest('.user-dropdown');
            if (!dropdown) { e.preventDefault(); openSignInModal(); }
        }
    });

    // [B] 메뉴 바깥쪽 클릭 시 닫기
    document.addEventListener('click', function(e) {
        var menu = document.getElementById('userMenu');
        var dropdown = e.target.closest('.user-dropdown');
        if (menu && !dropdown) menu.style.display = 'none';
    });

    // [C] 회원가입 폼 전송 이벤트 연결
    var signupForm = document.getElementById('signupForm');
    if (signupForm) {
        signupForm.onsubmit = function() { return validateSignUp(); };
    }
});

/** 10. 메뉴 토글 함수 */
function toggleUserMenu(event) {
    if (event) event.stopPropagation();
    var menu = document.getElementById('userMenu');
    if (menu) {
        var isVisible = (menu.style.display === 'block');
        menu.style.display = isVisible ? 'none' : 'block';
    }
}
