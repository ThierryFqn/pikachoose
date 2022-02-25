import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    onChange: updatePrice
  });
}

const updatePrice = (evt) => {
  // querySelector les 2 inputs et le prix => 2 string
  const begin_date = document.getElementById("booking_begin_date").value;
  const end_date = document.getElementById("booking_end_date").value;
  const day_price = document.getElementById("day-price-value").innerHTML;
  const parse_begin_date =  Date.parse(begin_date) / (1000 * 60 * 60 * 24);
  const parse_end_date =  Date.parse(end_date) / (1000 * 60 * 60 * 24);
  const final_price_object = document.getElementById("total-price-value");
  const days_difference = (parse_end_date - parse_begin_date) + 1;
  const final_price = days_difference * day_price;
  if (isNaN(final_price)) {
    return  final_price_object.innerText = "";
  } else {
    final_price_object.innerText = `= ${final_price}€`;
  }
}

export { initFlatpickr };
