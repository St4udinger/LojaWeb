function openDeleteModal(button) {
    const modal = document.getElementById('deleteModal');
    const message = document.getElementById('deleteMessage');
    const confirmBtn = document.getElementById('confirmDeleteBtn');

    const itemName = button.getAttribute('data-name');
    const url = button.getAttribute('data-url');

    message.textContent = 'Deseja realmente excluir o registro "' + itemName + '"?';
    confirmBtn.setAttribute('href', url);
    modal.classList.add('open');
}

function closeDeleteModal() {
    const modal = document.getElementById('deleteModal');
    modal.classList.remove('open');
}

window.addEventListener('click', function (event) {
    const modal = document.getElementById('deleteModal');
    if (modal && event.target === modal) {
        closeDeleteModal();
    }
});
