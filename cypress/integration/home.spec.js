describe("first tests", () => {
  it("goes to jungle homePage", () => {
    cy.visit("http://localhost:3000/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
});
