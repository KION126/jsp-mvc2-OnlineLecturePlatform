function myPage(userID) {
    // 동적으로 form 생성
    var form = document.createElement('form');
    form.method = 'post';
    form.action = 'myPage.do';

    // userID를 전달하는 hidden input 추가
    var userIDInput = document.createElement('input');
    userIDInput.type = 'hidden';
    userIDInput.name = 'userID';
    userIDInput.value = userID;
    form.appendChild(userIDInput);

    // form을 문서에 추가하고 submit
    document.body.appendChild(form);
    form.submit();

    // 필요하면 form을 제거
    document.body.removeChild(form);
}