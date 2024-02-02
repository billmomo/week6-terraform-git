
resource "aws_iam_user" "example_user" {
  name = "ansible"

}



resource "aws_iam_group" "example_group" {
  name = "ansiblegroup"

}