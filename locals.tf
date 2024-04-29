locals {
  default_function_association = length(var.default_cache_behavior) == 0 ? {
    function_association = {
      viewer-request = {
        function_arn = aws_cloudfront_function.viewer_request.arn
      }
    }
  } : {}
}
