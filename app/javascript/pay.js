const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  if (form.dataset.payjpInitialized === "true") return;
  form.dataset.payjpInitialized = "true";

  const publicKey = gon.public_key;
  if (!publicKey) return;

  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber", { placeholder: "カード番号" });
  const expiryElement = elements.create("cardExpiry", { placeholder: "月/年" });
  const cvcElement = elements.create("cardCvc", { placeholder: "CVC" });

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        alert(response.error.message);
        return;
      }

      const tokenInput = document.getElementById("token");
      if (!tokenInput) {
        alert("token field not found");
        return;
      }

      tokenInput.value = response.id;
      form.submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);