describe('Add to Cart', () => {
  it('should increase the cart count when a product is added', () => {
    // Visit the home page
    cy.visit('/');

    // Confirm initial cart count is (0)
    cy.get('.navbar').contains('My Cart (0)');

    // Click "Add to Cart" on the first product
    cy.get('.products article').first().contains('Add').click({ force: true });

    // Confirm cart count is now (1)
    cy.get('.navbar').contains('My Cart (1)');
  });
});
