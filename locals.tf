locals {
  function_association = (var.associate_function && length(var.default_cache_behavior) == 0) ? {
    viewer-request = {
      function_arn = aws_cloudfront_function.viewer_request[0].arn
    }
  } : {}
}

