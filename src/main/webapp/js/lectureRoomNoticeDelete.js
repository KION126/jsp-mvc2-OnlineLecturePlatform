function lectureRoomNoticeDeleteAction(classID, boardID, boardType) {
        // confirm으로 확인 메시지 표시
        var result = confirm("정말로 삭제하시겠습니까?");

        // 확인을 눌렀을 때만 삭제 진행
        if (result) {
            // 동적으로 form 생성
            var form = document.createElement('form');
            form.method = 'post';
            form.action = 'lectureRoomNoticeDeleteAction.do';

            // classID를 전달하는 hidden input 추가
            var classIDInput = document.createElement('input');
            classIDInput.type = 'hidden';
            classIDInput.name = 'classID';
            classIDInput.value = classID;
            form.appendChild(classIDInput);

            // boardID를 전달하는 hidden input 추가
            var boardIDInput = document.createElement('input');
            boardIDInput.type = 'hidden';
            boardIDInput.name = 'boardID';
            boardIDInput.value = boardID;
            form.appendChild(boardIDInput);
            
            // boardID를 전달하는 hidden input 추가
		    var boardTypeInput = document.createElement('input');
		    boardTypeInput.type = 'hidden';
		    boardTypeInput.name = 'boardType';
		    boardTypeInput.value = boardType;
		    form.appendChild(boardTypeInput);

            // form을 문서에 추가하고 submit
            document.body.appendChild(form);
            form.submit();

            // 필요하면 form을 제거
            document.body.removeChild(form);
        }
    }