const price = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    const itemPrice = Number(inputValue);
    if (!Number.isInteger(itemPrice)) {
      addTaxDom.innerHTML = "";
      profitDom.innerHTML = "";
      return;
    }

    const tax = Math.floor(itemPrice * 0.1); // 小数点以下切り捨て
    const profit = itemPrice - tax;

    addTaxDom.innerHTML = tax.toLocaleString();
    profitDom.innerHTML = profit.toLocaleString();
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);