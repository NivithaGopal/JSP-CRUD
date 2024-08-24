<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Salon Service</title>
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
        <h1 class="mb-4">Add New Salon Service</h1>
        <form method="post" action="saveService.jsp">
            <div class="form-group">
                <label for="serviceName">Service Name</label>
                <input type="text" class="form-control" id="serviceName" name="serviceName" required>
            </div>
           
            <div class="form-group">
                <label for="serviceDescription">Description</label>
                <textarea class="form-control" id="serviceDescription" name="serviceDescription" rows="3" required></textarea>
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
