# Load Testing
- [Load Testing](#load-testing)
- [Load Testing Simulation](#load-testing-simulation)
  - [How It Works](#how-it-works)
  - [Why It’s Important](#why-its-important)
    - [How Load Testing Helped Us](#how-load-testing-helped-us)
    - [Creating an Unhealthy Instance (for Testing)](#creating-an-unhealthy-instance-for-testing)

# Load Testing Simulation
> Load testing simulation is a way to test how a system (like a website or application) performs under a specific amount of traffic or load.

* Aim: we want to trigger the CPU to cause an alert. 
* Work out what the threshold is for it to work. 

## How It Works
* **Simulate Users**: You use a tool to *simulate many users visiting your website at once*. For example, you might simulate 1,000 users all trying to access your site at the same time.
* **Measure Performance**: While the simulated users are accessing your site, you measure how well your site performs. You look at things like:
  * **Response Time**: How long does it take for your *site to respond* to a user’s request?
  * **Throughput**: How many *requests can your site handle* per second?
  * **Error Rate**: Are there *any errors* when users try to access your site?
* **Analyse Results**: After the test, you analyse the results to see if your site can handle the load. If there are problems, you can identify what needs to be fixed.

## Why It’s Important
* **Prevent Crashes**: By knowing how your site performs under heavy load, you can *prevent it from crashing during peak times* (like a big sale or event).
* **Improve User Experience**: Ensuring your *site is fast and reliable* even under heavy traffic keeps *users happy*.
* **Plan for Growth**: As your site grows, load testing helps you *plan for future traffic increases*.

### How Load Testing Helped Us

- **Load Testing**: Simulated high traffic to identify performance bottlenecks and ensure the system can handle peak loads.

---

### Creating an Unhealthy Instance (for Testing)

You can simulate an unhealthy instance by manually overloading the CPU or stopping a critical service like your web application or database.

1. **Overload the CPU**:
   - Install Apache Bench (AB) if not already done:
     ```bash
     sudo apt-get install apache2-utils
     ```
   - Run a load test to create CPU spikes:
     ```bash
     ab -n 100000 -c 1000 http://localhost/
     ```
2. **Stop a Critical Service** (e.g., your web app):
   ```bash
   pm2 stop app.js
   ```
3. The load balancer's health probe will detect this instance as **unhealthy** because it is no longer serving traffic or has high CPU usage. Traffic will stop being routed to this instance.

---