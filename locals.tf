locals {

  azs = {
    # 아시아 태평양
    "ap-northeast-1" = ["a", "b", "c", "d"] # 도쿄
    "ap-northeast-2" = ["a", "b", "c", "d"] # 서울
    "ap-northeast-3" = ["a", "b", "c"]      # 오사카
    "ap-southeast-1" = ["a", "b", "c"]      # 싱가포르
    "ap-southeast-2" = ["a", "b", "c"]      # 시드니
    "ap-southeast-3" = ["a", "b", "c"]      # 자카르타
    "ap-southeast-4" = ["a", "b", "c"]      # 멜버른
    "ap-south-1"     = ["a", "b", "c"]      # 뭄바이
    "ap-south-2"     = ["a", "b", "c"]      # 하이데라바드

    # 유럽
    "eu-central-1" = ["a", "b", "c"] # 프랑크푸르트
    "eu-central-2" = ["a", "b", "c"] # 취리히
    "eu-west-1"    = ["a", "b", "c"] # 아일랜드
    "eu-west-2"    = ["a", "b", "c"] # 런던
    "eu-west-3"    = ["a", "b", "c"] # 파리
    "eu-north-1"   = ["a", "b", "c"] # 스톡홀름
    "eu-south-1"   = ["a", "b", "c"] # 밀라노
    "eu-south-2"   = ["a", "b", "c"] # 스페인

    # 미국
    "us-east-1" = ["a", "b", "c", "d", "e", "f"] # 버지니아 북부
    "us-east-2" = ["a", "b", "c"]                # 오하이오
    "us-west-1" = ["a", "b", "c"]                # 캘리포니아 북부
    "us-west-2" = ["a", "b", "c", "d"]           # 오레곤

    # 캐나다
    "ca-central-1" = ["a", "b", "d"] # 중부 캐나다
    "ca-west-1"    = ["a", "b"]      # 서부 캐나다

    # 남미
    "sa-east-1" = ["a", "b", "c"] # 상파울루

    # 중동
    "me-south-1"   = ["a", "b", "c"] # 바레인
    "me-central-1" = ["a", "b", "c"] # UAE

    # 아프리카
    "af-south-1" = ["a", "b", "c"] # 케이프타운
  }

  subnet_region_cidrs = {
    for name, cidrs in var.vpc_attr.subnet_cidrs : name => {
      for i, cidr in cidrs : local.azs[var.common_attr.region][i] => cidr
    }
  }
}
