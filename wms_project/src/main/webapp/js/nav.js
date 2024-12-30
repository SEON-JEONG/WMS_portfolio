document.body.addEventListener('click', function(event) {
    if (event.target && event.target.id === 'sss') {
        event.preventDefault();
        document.getElementById('iii').style.display = 'block'; // 이미지 보여주기
    }

    if (event.target && event.target.id === 'ccc') {
        event.preventDefault();
        document.getElementById('iii').style.display = 'none'; // 이미지 닫기
    }
});

document.getElementById("views").src = "/deliveryMobile/img/mobileQR.png";