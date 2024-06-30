const style = document.createElement('style');
style.innerHTML = `
 body {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 50vh;
  margin: 0;
  font-family: Arial, sans-serif;
  background-color: #faf2ff;
}


#card-container {
background-color: #f1d7ff;
  background-size: cover;
  background-position: center;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  padding: 20px;
  max-width: 300px;
  text-align: center;
  color: #46394e; 
  transition: transform 0.3s ease-in-out;
}
`;
document.head.appendChild(style);

var firebaseConfig = {
    apiKey: "AIzaSyBMXWPTuQUygeTM3Q91fsiMrybjcDzVYdU",
    authDomain: "socialqr-d2f3e.firebaseapp.com",
    projectId: "socialqr-d2f3e",
    storageBucket: "socialqr-d2f3e.appspot.com",
    messagingSenderId: "753103954376",
    appId: "1:753103954376:web:a65d303a1bf5c27ea120fd"
};


firebase.initializeApp(firebaseConfig);
var db = firebase.firestore();




const urlParams = new URLSearchParams(window.location.search);
const userId = urlParams.get('userId');
const labelId = urlParams.get('labelId');


db.collection('users').doc(userId).collection('labels').doc(labelId).get()
    .then((doc) => {
        if (doc.exists) {
            const data = doc.data();
            displayCard(data);
        } else {
            console.log("Belirtilen döküman bulunamadı.");
        }
    })
    .catch((error) => {
        console.error("Hata: ", error);
    });

function displayCard(data) {
    const cardContainer = document.getElementById('card-container');

    const card = document.createElement('div');
    card.style.border = '1px solid #ccc';
    card.style.padding = '16px';
    card.style.margin = '16px';
    card.style.borderRadius = '8px';

    const title = document.createElement('h2');
    title.textContent = data.Baslik;
    card.appendChild(title);

    const name = document.createElement('p');
    name.textContent = `Ad: ${data.Ad}`;
    card.appendChild(name);

    const surname = document.createElement('p');
    surname.textContent = `Soyad: ${data.Soyad}`;
    card.appendChild(surname);

    const number = document.createElement('p');
    number.textContent = `Numara: ${data.Numara}`;
    card.appendChild(number);

    const note = document.createElement('p');
    note.textContent = `Not: ${data.Not}`;
    card.appendChild(note);

    const address = document.createElement('p');
    address.textContent = `Adres: ${data.Adres}`;
    card.appendChild(address);

    cardContainer.appendChild(card);
}
