
describe('home page', () => {
  it('visits homepage', () => {
    cy.visit('http://localhost:3000');
  });

  it("There are products on the page", () => {
    cy.debug();
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.debug();
    cy.get(".products article").should("have.length", 2);
  });

   it("starts with an empty cart", () => {
    cy.visit('/')
    cy.get('#cart-size').contains("(0)")
  })

  it("adds an item to the cart", () => {
    cy.visit('/')
    cy.get(".products div button").first().click({force: true})
    cy.get('#cart-size').contains("(1)")
  })

});