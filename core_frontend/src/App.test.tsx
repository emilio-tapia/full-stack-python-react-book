import { describe, it, expect } from 'vitest';
import { render, screen } from './utils/test.utils';
import App from './App';

describe('App', () => {
  it('renders the App component', () => {
    render(<App />);
    const linkElement = screen.getByText(/Welcome to Postagram!/i);
    expect(linkElement).toBeInTheDocument();
    // screen.debug(); // prints out the jsx in the App component unto the command line
  });
});
