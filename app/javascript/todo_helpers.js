  let auth_token = document.querySelector('meta[name="csrf-token"]').content;
  var TodoHelpers = {};
  
  TodoHelpers.categoryFetch = function(path, method, body = {}) {
    return fetch(path, {
      method,
      headers: {
        "X-CSRF-Token": auth_token,
        "Content-Type": "application/json",
        "Accept": "text/vnd.turbo-stream.html"
      },
      body: JSON.stringify(body)
    })
  };

  TodoHelpers.fetchWithTurbo = function(path, method, body) {
    return categoryFetch(path, method, body).then(response => response.text()).then(html => {
      Turbo.renderStreamMessage(html);
      setTimeout(() => {
        lucide.createIcons();
      }, 100);
    });
  }

  TodoHelpers.updateItem = function(categoryId, itemId, completed) {
    categoryFetch(
      `categories/${categoryId}/items/${itemId}`,
      "PUT",
      { item: { completed } }
    ).then(response => response.json()).then(data => {
      if (data.completed) {
        document.getElementById(`task-${itemId}`).innerHTML = `<input type="checkbox" checked onclick="updateItem(${categoryId}, ${itemId}, ${!data.completed})"> <span class="line-through">${data.name}</span>`;
      } else {
        document.getElementById(`task-${itemId}`).innerHTML = `<input type="checkbox" onclick="updateItem(${categoryId}, ${itemId}, ${!data.completed})"> <span>${data.name}</span>`;
      }
    })
  }

  TodoHelpers.updateCategoryColor = function(categoryId, colorIndex) {
    fetchWithTurbo(
      `categories/${categoryId}`,
      "PUT",
      { category: { color: colorIndex } }
    )
  }

  TodoHelpers.removeCategory = function(categoryId) {
    fetchWithTurbo(`categories/${categoryId}`, "DELETE")
  }
  
  TodoHelpers.clearChecked = function(categoryId) {
    fetchWithTurbo(`categories/${categoryId}/clear_checked`, "POST")
  }


  export default TodoHelpers;
