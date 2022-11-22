describe("add_to_cart tests", () => {
  it("goes to jungle homePage", () => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("cart should be 0 after adding should be 1", () => {
    cy.contains("My Cart (0)");
    cy.get("[alt=Add]").first().click({ force: true });
    cy.contains("My Cart (1)");
  });
});
