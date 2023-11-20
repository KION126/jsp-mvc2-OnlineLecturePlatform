function lectureInfo(userID, classID) {
    // 동적으로 form 생성
    var form = document.createElement('form');
    form.method = 'post';
    form.action = 'lectureInfo.do';

    // userID를 전달하는 hidden input 추가
    var userIDInput = document.createElement('input');
    userIDInput.type = 'hidden';
    userIDInput.name = 'userID';
    userIDInput.value = userID;
    form.appendChild(userIDInput);

    // classID를 전달하는 hidden input 추가
    var classIDInput = document.createElement('input');
    classIDInput.type = 'hidden';
    classIDInput.name = 'classID';
    classIDInput.value = classID;
    form.appendChild(classIDInput);

    // form을 문서에 추가하고 submit
    document.body.appendChild(form);
    form.submit();

    // 필요하면 form을 제거
    document.body.removeChild(form);
}