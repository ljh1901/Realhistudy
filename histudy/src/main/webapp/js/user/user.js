var isIdChecked = false;
var isEmailChecked = false;

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
    .catch(function(err) { console.error(err); });
}

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

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
        .catch(function(error) { console.error(error); });
}

function closeSignInModal() {
    var overlay = document.getElementById('modalOverlay');
    if (overlay) overlay.style.display = 'none';
}

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
                isEmailChecked = true; 
                emailEl.onchange = function() { isEmailChecked = false; };
            }
        })
        .catch(function(err) { console.error(err); });
}

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

document.addEventListener('DOMContentLoaded', function() {
    initPasswordCheck();
    
    document.addEventListener('click', function(e) {
       
    });

    document.addEventListener('click', function(e) {
        var menu = document.getElementById('userMenu');
        var dropdown = e.target.closest('.user-dropdown');
        if (menu && !dropdown) menu.style.display = 'none';
    });

    var signupForm = document.getElementById('signupForm');
    if (signupForm) {
        signupForm.onsubmit = function() { return validateSignUp(); };
    }
});

function toggleUserMenu(event) {
    if (event) event.stopPropagation();
    var menu = document.getElementById('userMenu');
    if (menu) {
        var isVisible = (menu.style.display === 'block');
        menu.style.display = isVisible ? 'none' : 'block';
    }
}

function toggleEditMode(isEdit) {
    var viewElements = document.querySelectorAll('.view-mode');
    var editElements = document.querySelectorAll('.edit-mode');
    var viewButtons = document.getElementById('view-buttons');
    var editButtons = document.getElementById('edit-buttons');

    if (isEdit) {
        viewElements.forEach(el => el.style.display = 'none');
        editElements.forEach(el => el.style.display = ''); 
        viewButtons.style.display = 'none';
        editButtons.style.display = 'block';
    } else {
        viewElements.forEach(el => el.style.display = '');
        editElements.forEach(el => el.style.display = 'none');
        viewButtons.style.display = 'block';
        editButtons.style.display = 'none';
    }
}

function submitProfileUpdate() {
    var formData = new FormData();
    
    formData.append('user_idx', document.getElementById('user_idx').value);
    formData.append('user_name', document.getElementById('name-input').value);
    formData.append('user_birthdate', document.getElementById('birthdate-input').value);
    formData.append('user_email', document.getElementById('email-input').value);
    formData.append('user_tel', document.getElementById('tel-input').value);
    formData.append('user_intro', document.getElementById('intro-input').value);

    var fileInput = document.getElementById('fileInput');
    if (fileInput.files.length > 0) {
        formData.append('uploadFile', fileInput.files[0]);
    }
    fetch(contextPath + '/updateProfile.do', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("서버 응답 에러 (상태 코드: " + response.status + ")");
        }
        return response.text();
    })
    .then(result => {
        var realResult = result.trim();
        if (realResult === 'success') {
            alert('프로필이 성공적으로 수정되었습니다.');
            location.reload();
        } else {
            alert('서버에서 수정을 거절했습니다.' + realResult);
        }
    })
    .catch(error => {
        console.error(error);
        alert('통신 오류가 발생했습니다! 내용: ' + error.message);
    });
}