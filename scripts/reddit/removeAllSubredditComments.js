// Go to your own account and load as many comments as you can via RES unending thingy.
Array.from(document.getElementsByClassName("subreddit hover"))
  .filter(el => el.innerHTML == "TheLastOfUs2")
  .map(el => el.parentElement)
  .map(el => el.parentElement)
  .map(el => Array.from(el.childNodes).filter(el => el.className == "entry likes")[0])
  .filter(el => el.className == "flat-list buttons")[0]

Array.from(document.getElementsByClassName("yes")).map(el => el.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement)

let xs = Array.from(document.getElementsByClassName("subreddit hover")).filter(el => el.innerHTML == "TheLastOfUs2").map(el => el.parentElement.parentElement).map(el => el.querySelector(".toggleButton"))
let ys = Array.from(document.getElementsByClassName("subreddit hover")).filter(el => el.innerHTML == "TheLastOfUs2").map(el => el.parentElement.parentElement).map(el => el.querySelector(".yes"))
let i = 0;
let id = setInterval(() => {xs[i].click(); console.log(i); i++;},1100);

// open all 'delete' options
Array.from(document.getElementsByClassName("subreddit hover")).filter(el => el.innerHTML == "TheLastOfUs2").map(el => el.parentElement.parentElement).map(el => el.querySelector(`[data-event-action*="delete"]`)).map(el => el.click());
