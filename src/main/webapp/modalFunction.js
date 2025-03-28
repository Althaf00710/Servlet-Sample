function openModal() {
    document.getElementById('Modal').classList.remove('hidden');
}

function closeModal() {
    document.getElementById('Modal').classList.add('hidden');
}

// Close when clicking outside
window.onclick = function(event) {
    const modal = document.getElementById('Modal');
    if (event.target === modal) {
        closeModal();
    }
}

function openEditStudentModal(studentId) {
    fetch(`${window.location.origin}/Student_war_exploded/students/get?id=${studentId}`)
        .then(response => response.json())
        .then(student => {
            if (student.error) {
                console.error('Error:', student.error);
                return;
            }
            document.querySelector('#EditStudentModal input[name=id]').value = student.id;
            document.querySelector('#EditStudentModal input[name=name]').value = student.name;
            document.querySelector('#EditStudentModal input[name=age]').value = student.age;
            document.querySelector('#EditStudentModal input[name=address]').value = student.address;
            document.querySelector('#EditStudentModal input[name=phone]').value = student.phone;
            document.querySelector('#EditStudentModal select[name=gender]').value = student.gender;

            document.getElementById('EditStudentModal').classList.remove('hidden');
        })
        .catch(error => console.error('Error fetching student data:', error));
}
