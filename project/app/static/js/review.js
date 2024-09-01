// Dummy reviews data
const dummyReviews = [
    {
        name: 'Amit Sharma',
        location: 'Barot Valley',
        rating: 5,
        review: 'Barot Valley is an absolute gem! The serene environment, the lush greenery, and the clear river make it a perfect escape from city life. Highly recommended for nature lovers.',
        icon: 'fas fa-mountain'
    },
    {
        name: 'Priya Gupta',
        location: 'Jatayu\'s Fort',
        rating: 4,
        review: 'The Jatayu’s Fort is a remarkable place to visit, especially for history enthusiasts. The statue is massive and awe-inspiring, and the cable car ride adds an adventurous touch.',
        icon: 'fas fa-archway'
    },
    {
        name: 'Rahul Desai',
        location: 'Polo Forest',
        rating: 4,
        review: 'Polo Forest is a peaceful retreat with a rich history. The ruins are fascinating to explore, and the surrounding forest provides a calm and refreshing atmosphere.',
        icon: 'fas fa-tree'
    }
];

// Function to load dummy reviews
function loadDummyReviews() {
    const dummyReviewsContainer = document.getElementById('dummy-reviews-container');

    dummyReviews.forEach(review => {
        const reviewDiv = document.createElement('div');
        reviewDiv.className = 'review-card';

        const reviewHTML = `
            <i class="${review.icon}"></i>
            <h3>${review.name}</h3>
            <div class="location">${review.location}</div>
            <div class="rating">${getRatingStars(review.rating)}</div>
            <p>${review.review}</p>
        `;

        reviewDiv.innerHTML = reviewHTML;
        dummyReviewsContainer.appendChild(reviewDiv);
    });
}

// Function to generate star ratings
function getRatingStars(rating) {
    let stars = '';
    for (let i = 0; i < 5; i++) {
        if (i < rating) {
            stars += '<i class="fas fa-star"></i>';
        } else {
            stars += '<i class="far fa-star"></i>';
        }
    }
    return stars;
}

// Load dummy reviews on page load
window.onload = loadDummyReviews;

// Handling new reviews submission
// document.getElementById('review-form').addEventListener('submit', function(e) {
//     e.preventDefault();

//     // Get form values
//     const name = document.getElementById('name').value;
//     const location = document.getElementById('location').value;
//     const rating = document.getElementById('rating').value;
//     const review = document.getElementById('review').value;

//     // Create a review element
//     const reviewDiv = document.createElement('div');
//     reviewDiv.className = 'review-card';

//     const reviewHTML = `
//         <i class="fas fa-map-marker-alt"></i>
//         <h3>${name}</h3>
//         <div class="location">${location}</div>
//         <div class="rating">${getRatingStars(rating)}</div>
//         <p>${review}</p>
//     `;

//     reviewDiv.innerHTML = reviewHTML;

//     // Append the review to the container
//     document.getElementById('reviews-container').appendChild(reviewDiv);

//     // Clear the form
//     document.getElementById('review-form').reset();
// });
