const starWrap = document.querySelector(".star_wrap");
const stars = document.querySelectorAll(".star");
const ratingInput = document.getElementById("ratingValue");
const ratingText = document.querySelector(".rating_value");

let fixedScore = 0; // 클릭으로 확정된 점수

function drawStars(score){
    stars.forEach((star, idx)=>{
        const starIndex = idx + 1;

        if(score >= starIndex){
            star.innerText = "★";
        }
        else if(score >= starIndex - 0.5){
            star.innerText = "⯨"; // 반별
        }
        else{
            star.innerText = "☆";
        }
    });
}

function calculateScore(e){
    const rect = starWrap.getBoundingClientRect();
    let x = e.clientX - rect.left;

    if(x < 0) x = 0;
    if(x > rect.width) x = rect.width;

    let percent = x / rect.width;
    let score = percent * 5;

    score = Math.round(score * 2) / 2;

    if(score === 0) score = 0.5;

    return score;
}

// hover 미리보기
starWrap.addEventListener("mousemove", (e)=>{
    const score = calculateScore(e);
    drawStars(score);
    ratingText.innerText = "평점: " + score;
});


starWrap.addEventListener("mouseleave", ()=>{
    drawStars(fixedScore);
    ratingText.innerText = "평점: " + fixedScore;
});

// 클릭 시 확정
starWrap.addEventListener("click", (e)=>{
    fixedScore = calculateScore(e);
    ratingInput.value = fixedScore;
    drawStars(fixedScore);
    ratingText.innerText = "평점: " + fixedScore;
});