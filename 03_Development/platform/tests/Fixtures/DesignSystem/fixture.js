const opener = document.querySelector('#open-dialog');
const dialog = document.querySelector('#demo-dialog');

if (opener instanceof HTMLButtonElement && dialog instanceof HTMLDialogElement) {
  opener.addEventListener('click', () => dialog.showModal());
  dialog.addEventListener('keydown', (event) => {
    if (event.key === 'Escape') {
      event.preventDefault();
      dialog.close();
    }
  });
  dialog.addEventListener('close', () => opener.focus());
}
