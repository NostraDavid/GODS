// Run this to enable the 'yes' button to actually remove it
let ys = Array.from(document.getElementsByClassName("score likes")).filter(e => parseInt(e.title) < 3).map(e => e.parentElement.parentElement.parentElement).map(el => el.querySelector(`[data-event-action*="delete"]`));
ys = ys.slice(77, ys.length - 1);
ys.map(e => e.click());

// Then run this to actually remove the comments
let xs = Array.from(document.getElementsByClassName("score likes")).filter(e => parseInt(e.title) < 3).map(e => e.parentElement.parentElement.parentElement).map(el => el.querySelector(".yes"));
xs = xs.slice(77, xs.length - 1);
let i = 0;
let id = setInterval(() => { xs[i].click(); console.log(i); i++; }, 1100);
