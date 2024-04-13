
const btn_send = document.querySelector('.btn-enviar')
const clean_button = document.querySelector('.btn-limpiar')


let nombre = document.querySelector('.inp-nombre')
let email = document.querySelector('.inp-email')
let telefono = document.querySelector('.inp-telefono')


btn_send.addEventListener('click', (e) => {
    e.preventDefault()
   
    if(nombre.value == ""){
        alert("debes de llenar el nombre, desaweonizate!")
        return false
    }


    console.log(nombre.value)
    console.log(email.value)
    console.log(telefono.value)
})
addEventListener('click', (e) => {
    e.preventDefault()
    nombre.value = ""
    email.value = ""
    telefono.value = ""
})
clean_button.addEventListener('click', (e) => {
    e.preventDefault()
    nombre.value = ""
    email.value = ""
    telefono.value = ""
})