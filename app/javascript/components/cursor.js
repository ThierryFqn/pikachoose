const cursorRound = () => {
  console.log("coucou")
  let clientX = -10;
  let clientY = -10;
  const innerCursor = document.querySelector(".custom-cursor");
  const initCursor = () => {
    // add listener to track the current mouse position
    document.addEventListener("mousemove", e => {
      clientX = e.clientX;
      clientY = e.clientY;
    });

    // transform the innerCursor to the current mouse position
    // use requestAnimationFrame() for smooth performance
    const render = () => {
      innerCursor.style.transform = `translate(${clientX+10}px, ${clientY-30}px)`;
      // if you are already using TweenMax in your project, you might as well
      // use TweenMax.set() instead
      // TweenMax.set(innerCursor, {
      //   x: clientX,
      //   y: clientY
      // });

      requestAnimationFrame(render);
    };
    requestAnimationFrame(render);
  };
  initCursor();

}
export { cursorRound }
