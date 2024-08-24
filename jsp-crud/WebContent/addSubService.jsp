<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Main Service</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="mb-4">Add New Main Service</h1>
        <form method="post" action="saveMainService.jsp">
            <div class="form-group">
                <label for="serviceName">Service Name</label>
                <input type="text" class="form-control" id="serviceName" name="serviceName" required>
            </div>
            <div class="form-group">
                <label for="serviceCategory">Category</label>
                <select class="form-control" id="serviceCategory" name="serviceCategory" required>
                    <option value="" disabled selected>Select Category</option>
                    <option value="Hair">Hair</option>
                    <option value="Nails">Nails</option>
                    <option value="Skin">Skin</option>
                    <option value="Makeup">Makeup</option>
                    <option value="Massage">Massage</option>
                    <option value="Men">Men</option>
                    <option value="Bridal">Bridal</option>
                    <option value="Kids">Kids</option>
                    <option value="Wellness">Wellness</option>
                    <option value="Additional">Additional</option>
                </select>
            </div>
            <div class="form-group">
                <label for="serviceDescription">Description</label>
                <textarea class="form-control" id="serviceDescription" name="serviceDescription" rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label for="servicePrice">Price (in INR)</label>
                <input type="number" class="form-control" id="servicePrice" name="servicePrice" required>
            </div>
            <div class="form-group">
                <label for="serviceDuration">Duration (in minutes)</label>
                <input type="number" class="form-control" id="serviceDuration" name="serviceDuration" required>
            </div>
            <button type="submit" class="btn btn-primary">Save Service</button>
        </form>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
