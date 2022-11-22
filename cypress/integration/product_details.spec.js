describe("product_detail tests", () => {
  it("selects first product on homePage", () => {
    cy.visit("/");
    cy.get(".products article").first().click();
    cy.url().should("include", "/products/2");
  });
});
