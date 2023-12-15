## Check Redirect Results

curl -L http://mindmazelab.com.s3-website.ca-central-1.amazonaws.com

## Create Static Website

```js
npx create-react-app app
cd app
npm install react-router-dom@6
```

```js
import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import HomePage from './HomePage';
import AboutPage from './AboutPage';
import ContactPage from './ContactPage';

function App() {
  return (
    <Router>
      <nav>
        <Link to="/">Home</Link> | 
        <Link to="/about">About</Link> | 
        <Link to="/contact">Contact</Link>
      </nav>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/about" element={<AboutPage />} />
        <Route path="/contact" element={<ContactPage />} />
      </Routes>
    </Router>
  );
}

export default App;
```

```js
import React from 'react';

function HomePage() {
  return (
    <div>
      <h1>Home Page</h1>
      <p>Welcome to our home page!</p>
    </div>
  );
}

export default HomePage;
```

```js
import React from 'react';

function AboutPage() {
  return (
    <div>
      <h1>About Page</h1>
      <p>Welcome to our about page!</p>
    </div>
  );
}

export default AboutPage;
```

```js
import React from 'react';

function ContactPage() {
  return (
    <div>
      <h1>Contact Page</h1>
      <p>Welcome to our contact page!</p>
    </div>
  );
}

export default ContactPage;
```