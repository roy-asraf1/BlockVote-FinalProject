import React from 'react';
import './MainContainer.css';
import Header from './Header';
import Footer from './Footer';
import VotingComponent from './VotingComponent';

function MainContainer() {
  return (
    <div className="MainContainer">
      <Header />
      <VotingComponent />
      <Footer />
    </div>
  );
}

export default MainContainer;
