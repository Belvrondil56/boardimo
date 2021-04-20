document.getElementById("submit-url").addEventListener("click", function (){
    let url = document.getElementById("url").value;

    fetch('http://localhost:7373/', {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'plain/text;charset=UTF-8'
        },
        body: JSON.stringify({url: url})
    })
    .then(response => response.json())
    .then(data => console.log(data))
});
