
describe('product details page', () => {
  it('visits homepage', () => {
    cy.visit('http://localhost:3000');
  });

  it("There are products on the page", () => {
    cy.debug();
    cy.get(".products article").should("be.visible");
  });  

  it("Lets you visit product page", () => {
    cy.visit('/')
    cy.get('.products article').first().click()
    cy.url().should("include", "/products/2")
    cy.visit('/products/2')
  })

  it("Lets you visit product page", () => {
    cy.visit('/')
    cy.get('.products article').last().click()
    cy.url().should("include", "/products/1")
    cy.visit('/products/1')
  })

});