import perfil from './img/perfil.png';
import github from './img/github.png';
import linkedin from './img/linkedin.png';
import instagram from './img/instagram.png';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={perfil} className="App-perfil" alt="Vinícius Trainotti" />
        <p>
          Hello! I'm Vinícius Trainotti
        </p>
        <div >
          <a
            href="https://github.com/viniciustrainotti"
            target="_blank"
            rel="noopener noreferrer">
            <img src={ github } className="Logos" alt="Github"/>
          </a>
          <a
            href="https://www.linkedin.com/in/vinicius-trainotti/"
            target="_blank"
            rel="noopener noreferrer">
            <img src={ linkedin } className="Logos" alt="LinkedIn"/>
          </a>
          <a
            href="https://www.instagram.com/trainotti_"
            target="_blank"
            rel="noopener noreferrer">
            <img src={ instagram } className="Logos" alt="Instagram"/>
          </a>
        </div>
      </header>
    </div>
  );
}

export default App;
