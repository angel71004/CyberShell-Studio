const tools = [
  {
    name: "Port Scanner",
    file: "scripts/portscanner.sh",
    description: "Scans ports on a target IP to find open ports.",
    hasInput: true,
    inputFields: [
      { label: "Target IP", placeholder: "e.g., 127.0.0.1" },
      { label: "Start Port", placeholder: "e.g., 1" },
      { label: "End Port", placeholder: "e.g., 100" }
    ]
  },
  {
    name: "Subnet Scanner",
    file: "scripts/subnetscanner.sh",
    description: "Scans a subnet to find live hosts.",
    hasInput: true,
    inputFields: [
      { label: "Subnet (e.g., 127.0.0.1/32)", placeholder: "127.0.0.1/32" }
    ]
  },
  {
    name: "Password Strength Checker",
    file: "scripts/password_strength_checker.sh",
    description: "Checks the strength of passwords.",
    hasInput: true,
    inputFields: [
      { label: "Password", placeholder: "Enter password" }
    ]
  }
];

const container = document.getElementById("tool-container");

tools.forEach((tool, index) => {
  const card = document.createElement("div");
  card.className = "tool-card";

  card.innerHTML = `
    <h2>${tool.name}</h2>
    <p>${tool.description}</p>
    ${generateInputFields(tool.inputFields, index)}
    <button onclick="runDemo(${index})">Run Demo</button>
    <a href="${tool.file}" download>Download Script</a>
    <div class="output" id="output-${index}"></div>
  `;

  container.appendChild(card);
});

function generateInputFields(fields, index) {
  return fields.map((field, i) => `
    <label>${field.label}</label>
    <input type="text" class="input-field" id="input-${index}-${i}" placeholder="${field.placeholder}">
  `).join('');
}

function runDemo(index) {
  const tool = tools[index];
  const inputs = tool.inputFields.map((_, i) => document.getElementById(`input-${index}-${i}`).value);
  const outputDiv = document.getElementById(`output-${index}`);

  let output = `(kali㉿kali)-[~/CyberShell]\n$ ./script.sh ${inputs.join(" ")}\n`;

  if (tool.name === "Port Scanner") {
    output += "Port 22 is OPEN\nPort 80 is OPEN\nScan Complete!";
  } else if (tool.name === "Subnet Scanner") {
    output += "Host 127.0.0.1 is UP\nScan Complete!";
  } else if (tool.name === "Password Strength Checker") {
    const password = inputs[0];
    let score = 0;

    if (password.length >= 8) score++;
    if (/[A-Z]/.test(password)) score++;
    if (/[a-z]/.test(password)) score++;
    if (/[0-9]/.test(password)) score++;
    if (/[^a-zA-Z0-9]/.test(password)) score++;

    let strength = "";

    if (score === 5) {
        strength = "VERY STRONG";
    } else if (score >= 3) {
        strength = "MODERATE";
    } else {
        strength = "WEAK";
    }

    output += `Password Strength: ${strength}`;
}


  outputDiv.textContent = output;
}
