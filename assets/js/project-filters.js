document.addEventListener("DOMContentLoaded", () => {
    const filterButtons = document.querySelectorAll(".filter-btn");
    const projects = Array.from(document.querySelectorAll(".project-card"));

    projects.forEach(p => p.classList.add("animated"));

    function showProjects(filter) {
        let visibleIndex = 0;

        projects.forEach(project => {
            const filters = project.dataset.filters?.split(" ") || [];
            const show = filter === "all" || filters.includes(filter);

            project.classList.remove("visible", "hidden-card");

            if (show) {
                setTimeout(() => {
                    project.classList.add("visible");
                }, visibleIndex * 80);
                visibleIndex++;
            } else {
                project.classList.add("hidden-card");
            }
        });
    }

    showProjects("all");

    filterButtons.forEach(button => {
        button.addEventListener("click", () => {
            const filter = button.dataset.filter;

            filterButtons.forEach(b => b.classList.remove("active"));
            button.classList.add("active");

            showProjects(filter);
        });
    });
});