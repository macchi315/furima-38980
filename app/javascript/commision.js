
function commision (){
  const itemPrice  = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
  const addTaxPrice  = document.getElementById("add-tax-price");
  addTaxPrice.innerHTML = Math.floor(itemPrice.value * 0.1);
  const Profit  = document.getElementById("profit");
  Profit.innerHTML = itemPrice.value-addTaxPrice.innerHTML;
  });
};  

window.addEventListener('load', commision);