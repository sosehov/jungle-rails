describe('Product Navigation', () => {
  it('should navigate to the product details page when a product is clicked', () => {
    cy.visit("/")

    // Find the first product link and click it
    cy.get('.products article').first().find('a').click();

    // Check for product description
    cy.get('.product-detail').should('exist');
  })
})