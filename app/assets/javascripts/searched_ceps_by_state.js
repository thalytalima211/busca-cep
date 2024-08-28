document.addEventListener('DOMContentLoaded', function() {
    const state = document.getElementById('state').value;
    
    fetchCeps(state);
    
    document.getElementById('state').addEventListener('change', function() {
      fetchCeps(this.value);
    });
  });
  
function fetchCeps(state){
    fetch(`${window.origin}/cep_stats/ceps_by_state?state=${state}`)
        .then(response => response.json())
        .then(data =>{
            displayCeps(data);
        })
        .catch(error => {
            console.error('Erro ao buscar CEPs', error);
        })
}

function displayCeps(ceps){
    const tbody = document.querySelector('#state-ceps tbody')
    const message = document.getElementById('message')
    const table = document.getElementById('state-ceps')

    if(ceps.length === 0){
        message.textContent = 'Não há CEPs para o estado selecionado'
        message.style.removeProperty('display')
        table.style.display = 'none';
    } else {
        message.style.display = 'none'
        table.style.removeProperty('display')
        tbody.innerHTML = ''

        ceps.forEach(cep => {
            const row = document.createElement('tr')
            row.classList.add("bg-gray-50", "hover:bg-slate-200")

            const stateCell = document.createElement('td')
            stateCell.classList.add('border-x', 'border-slate-300', 'pl-3')
            stateCell.textContent = cep.state
            row.appendChild(stateCell)

            const cepCell = document.createElement('td')
            cepCell.classList.add('border-x', 'border-slate-300', 'pl-3')
            cepCell.textContent = cep.cep
            row.appendChild(cepCell)

            const cityCell = document.createElement('td')
            cityCell.classList.add('border-x', 'border-slate-300', 'pl-3')
            cityCell.textContent = cep.city
            row.appendChild(cityCell)

            const detailsCell = document.createElement('td')
            detailsCell.classList.add('border-x', 'border-slate-300', 'text-center', 'pb-0.5')

            const link = document.createElement('a')
            link.classList.add('hover:border-b', 'hover:border-black', 'font-semibold')
            link.setAttribute('href', `${window.origin}/cep_stats/${cep.id}`)
            link.textContent = 'Visualizar'

            detailsCell.appendChild(link)
            row.appendChild(detailsCell)

            tbody.appendChild(row)
        });
    }
}