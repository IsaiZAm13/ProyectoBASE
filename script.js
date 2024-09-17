











// Simular una base de datos de usuarios
let users = JSON.parse(localStorage.getItem('users')) || [
    { username: 'admin1', password: 'admin1', role: 'admin1' },
    { username: 'cliente', password: 'cliente', role: 'cliente' }
];

// Registro de inicios de sesión
let loginHistory = JSON.parse(localStorage.getItem('loginHistory')) || [];

// Función para guardar usuarios en el almacenamiento local
function saveUsers() {
    localStorage.setItem('users', JSON.stringify(users));
}

// Función para guardar el historial de inicios de sesión
function saveLoginHistory() {
    localStorage.setItem('loginHistory', JSON.stringify(loginHistory));
}

//










// Manejar el registro de usuarios
if (document.getElementById('registroForm')) {
    document.getElementById('registroForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const email = document.getElementById('email').value;
        const username = document.getElementById('newUsername').value;
        const password = document.getElementById('newPassword').value;

        if (users.some(user => user.username === username)) {
            alert('Este nombre de usuario ya está en uso.');
            return;
        }

        users.push({ email, username, password, role: '' });
        saveUsers();
        alert('Registro exitoso. Por favor, inicia sesión.');
        window.location.href = 'Logging.html';
    });
}

// Manejar el inicio de sesión
if (document.getElementById('loginForm')) {
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        const user = users.find(user => user.username === username && user.password === password);
        if (user) {
            loginHistory.push({ username, password, timestamp: new Date().toISOString() });
            saveLoginHistory();
            localStorage.setItem('currentUser', JSON.stringify(user));
            
            switch(user.role) {
                case 'admin1':
                    window.location.href = 'admin.html';
                    break;
                case 'cliente':
                    window.location.href = 'cliente.html';
                    break;
                default:
                    window.location.href = 'producto.html';
            }
        } else {
            alert('Usuario o contraseña incorrectos.');
        }
    });
}

// Manejar el cierre de sesión
function logout() {
    localStorage.removeItem('currentUser');
    window.location.href = 'Logging.html';
  }

// Verificar si el usuario está autenticado
function checkAuth() {
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    if (!currentUser) {
        alert('Por favor, inicia sesión para ver esta página.');
        window.location.href = 'Logging.html';
    }
    return currentUser;
}

// Funciones específicas para la página de admin
if (window.location.pathname.includes('admin.html')) {
    const currentUser = checkAuth();
    if (currentUser.role !== 'admin1') {
        alert('No tienes permiso para acceder a esta página.');
        window.location.href = 'Logging.html';
    }

    // Mostrar historial de inicios de sesión
    const historyList = document.getElementById('loginHistory');
    loginHistory.forEach(login => {
        const li = document.createElement('li');
        li.textContent = `Usuario: ${login.username}, Contraseña: ${login.password}, Fecha: ${new Date(login.timestamp).toLocaleString()}`;
        historyList.appendChild(li);
    });

    // Manejar la adición de nuevos usuarios
    document.getElementById('addUserForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const username = document.getElementById('newUsername').value;
        const password = document.getElementById('newPassword').value;
        const role = document.getElementById('newRole').value;

        if (users.some(user => user.username === username)) {
            alert('Este nombre de usuario ya está en uso.');
            return;
        }

        users.push({ username, password, role });
        saveUsers();
        alert('Usuario agregado exitosamente.');
        location.reload();
    });
}

// Funciones específicas para la página de cliente (calculadora)
if (window.location.pathname.includes('cliente.html')) {
    checkAuth();
    
    const display = document.getElementById('display');
    let currentValue = '';

    function updateDisplay() {
        display.value = currentValue;
    }

    document.querySelectorAll('.calc-btn').forEach(button => {
        button.addEventListener('click', function() {
            const value = this.textContent;
            if (value === '=') {
                try {
                    currentValue = eval(currentValue).toString();
                } catch (error) {
                    currentValue = 'Error';
                }
            } else if (value === 'C') {
                currentValue = '';
            } else {
                currentValue += value;
            }
            updateDisplay();
        });
    });
}
// Objeto para almacenar los puntos de los usuarios
let userPoints = {};

// Función para actualizar los puntos mostrados
function updatePointsDisplay() {
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    if (currentUser) {
        const points = userPoints[currentUser.username] || 0;
        document.getElementById('userPoints').textContent = `Puntos: ${points}`;
    }
}

// Función para agregar puntos
function addPoints() {
    const selectedUser = document.getElementById('userSelect').value;
    const points = parseInt(document.getElementById('pointsInput').value);
    userPoints[selectedUser] = (userPoints[selectedUser] || 0) + points;
    localStorage.setItem('userPoints', JSON.stringify(userPoints));
    updatePointsDisplay();
}

// Función para restar puntos
function subtractPoints() {
    const selectedUser = document.getElementById('userSelect').value;
    const points = parseInt(document.getElementById('pointsInput').value);
    userPoints[selectedUser] = Math.max((userPoints[selectedUser] || 0) - points, 0);
    localStorage.setItem('userPoints', JSON.stringify(userPoints));
    updatePointsDisplay();
}

// Función para cargar los usuarios en el selector
function loadUserSelect() {
    const userSelect = document.getElementById('userSelect');
    if (userSelect) {
        userSelect.innerHTML = '';
        users.forEach(user => {
            const option = document.createElement('option');
            option.value = user.username;
            option.textContent = user.username;
            userSelect.appendChild(option);
        });
    }
}

// Modificar la función de inicio de sesión existente
if (document.getElementById('loginForm')) {
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        const user = users.find(user => user.username === username && user.password === password);
        if (user) {
            localStorage.setItem('currentUser', JSON.stringify(user));
            userPoints = JSON.parse(localStorage.getItem('userPoints')) || {};
            updatePointsDisplay();
            
            switch(user.role) {
                case 'admin':
                    window.location.href = 'admin.html';
                    break;
                case 'cliente':
                    window.location.href = 'cliente.html';
                    break;
                default:
                    window.location.href = 'producto.html';
            }
        } else {
            alert('Usuario o contraseña incorrectos.');
        }
    });
}

// Cargar los puntos al iniciar la página
window.addEventListener('DOMContentLoaded', () => {
    userPoints = JSON.parse(localStorage.getItem('userPoints')) || {};
    updatePointsDisplay();
    loadUserSelect();
});

// Datos de los productos
const products = [
    { title: "Producto 1", availability: 7, cost: 500 },
    { title: "Producto 2", availability: 5, cost: 750 },
    { title: "Producto 3", availability: 3, cost: 1000 },
    { title: "Producto 4", availability: 10, cost: 250 },
    { title: "Producto 5", availability: 2, cost: 9999 }
];

// Función para manejar el carrusel
function setupCarousel() {
    const carousel = document.querySelector('.carousel-container');
    const prevBtn = document.querySelector('.prev-btn');
    const nextBtn = document.querySelector('.next-btn');
    const productTitle = document.getElementById('productTitle');
    const productAvailability = document.getElementById('productAvailability');
    const productCost = document.getElementById('productCost');

    let currentIndex = 0;

    function updateProductInfo() {
        const product = products[currentIndex];
        productTitle.textContent = product.title;
        productAvailability.textContent = `${product.availability} unidades disponibles`;
        productCost.textContent = `Costo: ${product.cost} pts`;
    }

    function showImage(index) {
        carousel.style.transform = `translateX(-${index * 100}%)`;
        currentIndex = index;
        updateProductInfo();
    }

    prevBtn.addEventListener('click', () => {
        currentIndex = (currentIndex - 1 + products.length) % products.length;
        showImage(currentIndex);
    });

    nextBtn.addEventListener('click', () => {
        currentIndex = (currentIndex + 1) % products.length;
        showImage(currentIndex);
    });

    // Inicializar con la primera imagen
    updateProductInfo();
}

// Ejecutar la función de configuración del carrusel cuando se carga la página
window.addEventListener('DOMContentLoaded', () => {
    userPoints = JSON.parse(localStorage.getItem('userPoints')) || {};
    updatePointsDisplay();
    loadUserSelect();
    
    // Configurar el carrusel si estamos en la página de producto
    if (window.location.pathname.includes('producto.html')) {
        setupCarousel();
    }
});
