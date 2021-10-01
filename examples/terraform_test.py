import pytest
import os
import time
import boto3
from subprocess import call, Popen, PIPE, STDOUT
from distutils.util import strtobool
from json import loads
pytest.dir = None
@pytest.fixture(scope="session")
def terraform_deploy():
    pytest.dir = os.path.dirname( os.getenv('PYTEST_CURRENT_TEST').split(sep=":")[0] )
    try:
        tfvars = os.environ['TF_VARS']
    except KeyError:
        tfvars = "variables.pytest.tfvars"
    try:
        skip = strtobool(os.environ['CREATE_skip'])
    except KeyError:
        skip = False
    print("\nCREATE_skip: {}".format(skip))
    if not skip:
        return_code = call("terraform init", shell=True, cwd=pytest.dir)
        assert not return_code
        return_code = call("terraform plan -var-file={} -out=terraform.plan".format(tfvars), shell=True, cwd=pytest.dir)
        assert not return_code
        return_code = call("terraform apply terraform.plan", shell=True, cwd=pytest.dir)
        yield return_code
    else:
        yield False
    try:
        skip = strtobool(os.environ['DESTROY_skip'])
    except KeyError:
        skip = False
        
    print("\nDESTROY_skip: {}".format(skip))
    if not skip:
        call("terraform destroy -var-file={} -auto-approve".format(tfvars), shell=True, cwd=pytest.dir)
@pytest.fixture(scope="session")
def terraform_deployed(terraform_deploy):
    assert not terraform_deploy
@pytest.fixture(scope="session")
def terraform_output(terraform_deployed):
    output = Popen(
        [
            "terraform",
            "output",
            "-json",
        ],
        stdout=PIPE,
        stderr=STDOUT,
        cwd=pytest.dir,
    )
    return loads( output.stdout.read().decode("utf-8") )
@pytest.fixture(scope="session")
def boto3_session(terraform_output):
    aws_region = terraform_output["aws_region"]["value"]
    aws_account_name = terraform_output["aws_account_name"]["value"]
    return boto3.session.Session(profile_name=aws_account_name, region_name=aws_region)
@pytest.fixture(scope="session")
def get_asg_id(terraform_output):
    return terraform_output["autoscaling_group_id"]["value"]
@pytest.mark.parametrize("desired_capacity", [
    pytest.param(1, id="desired capacity=1 "),
    pytest.param(2, id="desired capacity=2 "),
    pytest.param(1, id="desired capacity=1 "),
])
def test_asg_change_desired_capacity(desired_capacity, get_asg_id, boto3_session):
    client = boto3_session.client('autoscaling')
    response = client.set_desired_capacity(
        AutoScalingGroupName=get_asg_id,
        DesiredCapacity=desired_capacity,
    )
    timeout = time.time() + 60*10   # 10 minutes from now
    while True:
        response = client.describe_auto_scaling_groups(
            AutoScalingGroupNames=[get_asg_id],
        )
        instances = response["AutoScalingGroups"][0]["Instances"]
        if len(instances) == desired_capacity or time.time() > timeout:
            break
        time.sleep(10)
    assert len(instances) == desired_capacity
    
# @pytest.fixture(scope="session")
# def ec2_session(terraform_output, boto3_session):
#     return boto3_session.resource('ec2')
# @pytest.fixture
# def get_instance_id(terraform_output, autoscaling_session, get_asg_id):
#     response = autoscaling_session.describe_auto_scaling_groups(
#         AutoScalingGroupNames=[get_asg_id],
#     )
#     return response["AutoScalingGroups"][0]["Instances"][0]["InstanceId"]
# @pytest.fixture
# def get_instance_ip_address(ec2_session, get_instance_id):
#     instance = ec2_session.Instance(id=get_instance_id)
#     return instance.private_ip_address
# @pytest.fixture
# def get_instance_state(ec2_session, get_instance_id):
#     instance = ec2_session.Instance(id=get_instance_id)
#     return instance.state
# def test_instance_is_running(get_instance_state):
#     timeout = time.time() + 60*5   # 5 minutes from now
#     while True:
#         state = get_instance_state["Name"]
#         if state == "running" or time.time() > timeout:
#             break
#         time.sleep(10)
#     assert state == "running"
