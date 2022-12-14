describe("product_detail tests", () => {
  it("goes to jungle homePage", () => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("selects first product on homePage", () => {
    cy.visit("/");
    cy.get(".products article").first().click();
    cy.url().should("include", "/products/2");
  });
});
