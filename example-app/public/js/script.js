document.addEventListener("DOMContentLoaded", function () {
    // Xử lý tìm kiếm
    document.getElementById("search").addEventListener("keyup", function () {
        let keyword = this.value.toLowerCase();
        let rows = document.querySelectorAll("#userTable tr");

        rows.forEach(row => {
            let text = row.textContent.toLowerCase();
            row.style.display = text.includes(keyword) ? "" : "none";
        });
    });

    document.querySelectorAll(".delete-btn").forEach(button => {
        button.addEventListener("click", function () {
            if (confirm("Bạn có chắc muốn xóa người dùng này?")) {
                this.closest("tr").remove();
            }
        });
    });
});


//view
document.addEventListener("DOMContentLoaded", function () {
    // Lấy ID từ URL
    const params = new URLSearchParams(window.location.search);
    const userId = params.get("id");

    // Dữ liệu mẫu (có thể thay thế bằng dữ liệu từ server)
    const users = [
        { id: "1", username: "nguyenvanA", email: "nguyenA@gmail.com", role: "Admin" },
        { id: "2", username: "tranvanB", email: "tranB@gmail.com", role: "User" }
    ];

    // Tìm user theo ID
    const user = users.find(u => u.id === userId);

    if (user) {
        document.getElementById("userId").textContent = user.id;
        document.getElementById("username").textContent = user.username;
        document.getElementById("email").textContent = user.email;
        document.getElementById("role").textContent = user.role;
    } else {
        document.querySelector(".card-body").innerHTML = "<p class='text-danger'>Không tìm thấy người dùng!</p>";
    }
});

