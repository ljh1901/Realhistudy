const stars = document.querySelectorAll(".star");
const ratingInput = document.getElementById("ratingValue");

function paintStars(score) {
  stars.forEach((star, index) => {
    star.classList.remove("full", "half");

    const starNumber = index + 1;

    if (score >= starNumber) {
      star.classList.add("full");
    } 
    else if (score >= starNumber - 0.5) {
      star.classList.add("half");
    }
  });
}

stars.forEach((star, index) => {

  star.addEventListener("mousemove", (e) => {

    const rect = star.getBoundingClientRect();
    const isHalf = (e.clientX - rect.left) < rect.width / 2;
    const score = isHalf ? index + 0.5 : index + 1;

    paintStars(score);
  });

  star.addEventListener("click", (e) => {

    const rect = star.getBoundingClientRect();
    const isHalf = (e.clientX - rect.left) < rect.width / 2;
    const score = isHalf ? index + 0.5 : index + 1;

    ratingInput.value = score;
    paintStars(score);
    document.querySelector('.rating_value').innerText = "평점: " + score;
  });

});