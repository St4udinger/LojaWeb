function openDeleteModal(tipo, id, nome) {
    const modal = document.getElementById('deleteModal');
    const deleteId = document.getElementById('deleteId');
    const modalMessage = document.getElementById('modalMessage');

    if (!modal || !deleteId || !modalMessage) return;

    deleteId.value = id;
    modalMessage.textContent = `Deseja realmente excluir ${tipo === 'categoria' ? 'a categoria' : 'o produto'} "${nome}"?`;
    modal.classList.remove('hidden');
}

function closeDeleteModal() {
    const modal = document.getElementById('deleteModal');
    if (modal) {
        modal.classList.add('hidden');
    }
}

document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
        closeDeleteModal();
    }
});
