describe('Home Page', () => {
  it('should load the home page', () => {
    cy.visit("/")
    cy.contains('Welcome')
  })

  it("There is products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
  });
})
