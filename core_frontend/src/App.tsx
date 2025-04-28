import { useState } from 'react';
import './styles/App.css';
import { Route, Routes } from 'react-router';
import { Home } from './pages/Home';
import ProtectedRoute from './routes/ProtectedRoute';
import Registration from './pages/Registration';
import Login from './pages/Login';

function App() {
  const [count, setCount] = useState(0);

  return (
    <>
      <Routes>
        <Route
          path="/"
          element={
            <ProtectedRoute>
              <Home />
            </ProtectedRoute>
          }
        />
        <Route path="/login/" element={<Login />} />
        <Route path="/register/" element={<Registration />} />
      </Routes>
    </>
  );
}

export default App;
