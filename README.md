# wEthereum : 이더리움 존버 가즈아ㅏ
<img src="https://github.com/kbs4674/blockchain_hackathon_public/blob/master/public/project/hackathon_poster.jpg?raw=true" width="250px">


## 1. 팀 소개
한도경, 송현수, 구건모, 김철민


## 2. 루비/루비온 레일즈 정보
* Ruby : 2.4.0
* Rails : 5.1.6


## 3. 프로젝트 개요
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/_V-6H27A6Dc/0.jpg)](https://www.youtube.com/watch?v=_V-6H27A6Dc)<br/>
▲ 간략적인 홈페이지 소개 영상(클릭 시 Youtube영상 사이트로 이동)

### 1) 서론
"춘천, 시민이 주인입니다."
1. 시민들의 의견이 반영될 수 있는 플랫폼 제공
2. 참여에 따른 보상 지급을 통해 참여율 증대

### 2) 홈페이지 이용 방식
1. 사람들은 정책 혹은 안건에 투표를 통해 정치참여, 투표 시 리워드인 '토큰' 증정
2. 시민들이 정책참여를 하면 주어지는 토큰으로 토큰 상점에서 실물상품을 구매할 수 있게 한다.
    * 단, 실물 상품은 강원도에서 쓸 수 있는 물건을 중심으로
3. 사람들이 토큰을 통해 상품을 구입을 하고, 강원도에서 사용을 함으로서, 부수적으로 내수경제 활성 기대

### 3) 기획안 PPT 자료 [<a href="https://github.com/kbs4674/blockchain_hackathon_public/blob/master/public/project/hackathon_project.pptx?raw=true" target="_blank">클릭</a>]
<img src="https://github.com/kbs4674/blockchain_hackathon_public/blob/master/public/project/ppt_display.png?raw=true" width="500px">


## 4. 핵심 코드파일
1. ```app/views/event_trigger/_post_write.html.erb``` [<a href="/app/views/event_trigger/_post_write.html.erb">이동</a>] ABI 및 contract 주소 설정, javascript를 통한 web3 IPC 통신 (게시글 생성, 투표 시 트랜잭션 발생, 블록이 쓰여짐.)
2. ```app/controllers/users/registrations_controller.rb``` [<a href="/app/controllers/users/registrations_controller.rb">이동</a>] Ruby를 통한 RPC 통신 (웹페이지에서 계정 생성 시 geth에 새로운 계정블록 생성)
3. ```app/controllers/posts_controller.rb``` [<a href="/app/controllers/posts_controller.rb">이동</a>] 게시글(Post) 내에 쓰여진 안건에 대한 Controller 처리 (좋아요, 글쓰기 등 이벤트 처리)
4. ```app/views/posts/index/_index_main.html.erb``` [<a href="/app/views/posts/index/_index_main.html.erb">이동</a>] 시민 청원/정책 투표 게시글에 대한 목록 디자인
5. ```app/views/posts/show/_show_card.html.erb``` [<a href="/app/views/posts/show/_show_card.html.erb">이동</a>] 시민 청원/정책 투표 게시글 열람(상세 페이지) 디자인
6. ```app/views/posts/vote_render/_disagree_issue.html.erb``` [<a href="/app/views/posts/vote_render/_disagree_issue.html.erb">이동</a>] 안건에 대한 투표 (투표 전 view)
7. ```app/views/posts/vote_render/_agree_issue.html.erb``` [<a href="/app/views/posts/vote_render/_disagree_issue.html.erb">이동</a>] 안건에 대한 투표 (투표 후 view)
8. ```app/views/posts/upvote.js.erb``` [<a href="/app/views/posts/upvote.js.erb">이동</a>] 투표에 대한 비동기(ajax) 처리


## 5. geth 설치를 위한 AWS EC2 셋팅
<img src="https://github.com/kbs4674/blockchain_hackathon_public/blob/master/public/project/AWS_server1.png?raw=true" width="500px">

1) AWS EC2 한국서버 DashBoard로 이동한다.
2) 새로운 EC2 인스턴스를 생성한다.
3) EC2 인스턴스 설정 (단계 1) : Ubuntu OS를 선택한다.
    * 참고로 최신버전보다 하위단계로 선택하는 것이 좋다. (안정성 고려)
4) EC2 인스턴스 설정 (단계 2) : 인스턴스 유형은 최소 t2.medium 이상으로 선택.
5) 단계3 ~ 단계5는 그냥 건너뛰어도 된다. (개인취향 차)
6) EC2 인스턴스 설정 (단계 6) : 보안 그룹 구성, 즉 허용 포트를 열어주는 곳이다.
```규칙 추가``` 버튼을 클릭해서 ```사용자 지정 TCP 규칙```을 선택한 후,  포트범위는 ```50796```, 소스는 ```위치 무관```
    * 참고로 포트번호는 뭘 해도 상관없으나, 기존 이더리움의 ```8545``` 포트는 피하자. 8545 포트는 안될 수도 있다는 얘기가 있다.
7) AWS EC2(OS : Ubuntu) 초기 계정 ID는 ```ubuntu``` 이다.
8) AWS EC2 계정인증 SSH 접속법은 설명에서 생략하겠다, 혹시 궁금하다면 <a href="http://hyeonstorage.tistory.com/271" target="_blank">여기</a>를 클릭해서 참고.


## 6. AWS EC2:Ubuntu 서버 내 Geth 설치 및 설정
<img src="https://github.com/kbs4674/blockchain_hackathon_public/blob/master/public/project/geth2.png?raw=true" width="500px">

1) 아래 명령어 입력을 통해 go-ethereum 설치
```
git clone https://github.com/ethereum/go-ethereum
sudo apt-get update
```
해당 코드 입력 후 중간에 여러 선택지 중 "keep the local version currently installed" 선택 :
```
sudo apt-get -y upgrade
```
이어서 계속 코드 입력(go-lang 설치) :
```
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
sudo tar -xvf go1.10.3.linux-amd64.tar.gz
sudo mv go /usr/local
```

2) ```vi .bashrc``` 명령어를 입력 후 .bashrc 파일 내 아래 코드 추가 (go-lang에 대한 환경정의)
```
export GOROOT=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH\
```

3) ```.bashrc``` 내용이 변경되었으니 SSH bash(putty)를 껏다 키자.

4) make geth를 설치하고자 이어서 순차적으로 명령어 입력
```
sudo apt-get install -y build-essential
cd go-ethereum
make geth
```
이어서 geth가 제대로 설치되었는지 확인 :
```
./build/bin/geth version
```
이 때 잠시 ```geth```를 입력해보자.<br/>
일단 명령어는 작동이 안 될 것이다.

5) geth 명령어 환경 설정
```
sudo cp build/bin/geth /usr/local/bin/
which geth
```
이제 ```geth``` 명령어를 입력하면 이전과 달리 명령어가 제대로 작동됨이 확인.

6) ethereum 계정 생성 (참고로 명령어를 입력하는 현재 위치는 go-ethereum 폴더 이어야 함. / ```pwd``` 로 확인할 것.)
```
mkdir sotolab
geth --datadir sotolab account new
```
```geth --datadir sotolab account new``` 명령어를 입력함으로서 새로운 이더리움 계정을 생성을 할 수 있게 되는데,
현재 bash창에서는 계정을 생성하면서 설정할 암호를 묻고 있다. 이번 예습 때에는 간단하게 ```eth``` 로 통일하자.

이어서 한번 더 계정 생성을 하자 :
```geth --datadir sotolab account new```

7) 터미널에 ```geth --datadir sotolab account list```를 입력하면 생성된 계정 목록/정보를 열람할 수 있다.

8) 터미널에서 ```vi Genesis.json``` 을 입력해주고, vi 편집기에 다음 코드를 입력해주자.
```
{
    "config": {
        "chainId": 15,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
    "nonce": "0x0000000000000042",
    "timestamp": "0x00",
    "parentHash":
    "0x0000000000000000000000000000000000000000000000000000000000000000",
    "extraData": "0x00",
    "gasLimit": "0x800000",
    "difficulty": "1",
    "mixhash": 
    "0x0000000000000000000000000000000000000000000000000000000000000000",
    "coinbase": "0x3333333333333333333333333333333333333333",
    "alloc": {
            "423d5552b8334430ad6e5ec862e700f139782d60": {
            "balance": "10000000000000000000"
        },
		"c3675b08cdc3c3236daec2fedf378697fff4f01c": {
            "balance": "10000000000000000000"
        }
    }
}
```
그리고 ```:wq``` 로 저장 후, ```Genesis.json``` 파일을 생성.

해당 ```Genesis.json``` 을 실행시키면 지금까지 생성된 계정들에 대해 이더리움 코인을 alloc.balance에 입력된 만큼 지급을 해준다.
참고로 지금 입력된 코인 값은 '1코인' 이다.<br/>
그리고 해당 예제에서는 난이도(difficulty)를 가장 쉬운 1 로 지정했다. (본래 예제 파일에서는 ```0x400``` 였다.)
```Genesis.json``` 실행은 딱 한번만 가능하니 이 점 유의하자.

9) ```Genesis.json``` 실행 : ```geth --datadir sotolab init Genesis.json```

10) 이어서 Geth 초기 설정을 시행해주자.
```
geth --datadir sotolab --networkid 15 console
```
참고로 여기서 networkid가 15로 지정된게 확인되는데, 이는 ```Genesis.json``` 파일 내에서 config.chainId 값을 따른 것이다.

11) 현재 우리는 Geth 콘솔에 접근을 했다.<br/>
간단한 명령어 몇 선을 소개하겠다.
```
eth.accounts
eth.accounts[0]
eth.getBalance(eth.accounts[1])
eth.blockNumber
personal.unlockAccount(eth.accounts[0], "eth")
```

12) 이제 최초 채굴 작업을 진행해보자 : ``` miner.start() ```<br/>
해당 채굴 작업은 percentage의 100% 수치가 2회 순환되어야 한다.

13) 채굴이 끝났다면(2회 이상 순환) 채굴을 이만 멈추자 : ``` miner.stop() ```
    * 작업중인 터미널에 그냥 그대로 입력해주면 된다.

14) 채굴 이후 계정들의 잔액을 확인해보자.
```
eth.getBalance(eth.accounts[0])
```

15) 이어서 ```Ctrl+D```로 Geth Console을 나가주고, 새로운 Console을 열어주자.<br/>
참고로 지금 콘솔은 이전 콘솔과는 다르게 이제 외부에서 Geth 서버에 접근이 가능한 Console이다
```
geth --networkid 15 --nodiscover --maxpeers 0 --datadir sotolab --rpc --rpcaddr "0.0.0.0" --rpcport 50796 --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" console 2>> geth.log
```
명령어 중간에 보면 --rpcport가 50796으로 되어있는게 보이는데, 이는 AWS 허용 포트를 넣어준 것이다.

16) [Option] Ruby에서 간단히 통신을 해보자.<br/>
일단, ```Gemfile```에는 ```gem 'ethereum.rb'```가 깔려 있어야 한다.<br/>
Gem 설치 후, ```rails c``` 콘솔창을 통해 다음 명령어를 입력해보자.
```
web3 = Ethereum::HttpClient.new('http://(아마존 서버 IP):50796')
web3.eth_accounts
web3.eth_accounts.values[2]
web3.eth_accounts.values[2][0]
web3.personal_new_account("eth")
```
> 1. Gem 깃허브 사이트 : https://github.com/EthWorks/ethereum.rb<br/>
> 2. Gem에는 이상하게 Geth에서 지원하는 모든 메소드가 지원되지 않는다. (대표적으로 ethereum.rb Gem에서는 transaction이 미지원)


## 7. remix ABI 및 주소 연동
1) <a href="http://remix.ethereum.org" target="_blank">http://remix.ethereum.org</a>로 이동.
    * 반드시 http 여야 한다, https로 접속 시 SSL 때문인지 Remix 서버와 AWS 서버와 RPC 통신이 안됨.

2) solidiy 프로그래밍 컴파일

3) remix Run 메뉴 - web3 Provider에서 나의 서버와 연동

4) AWS EC2 Geth 서버에 ```personal.unlockAccount(eth.accounts[0], "eth")``` 명령어 입력을 해서 한시적으로 계정 접근 허용을 해준다.

5) remix Run - Deploy를 통해 Contract 주소값을 얻어낸다.
    * 이 때 서버가 마이닝 상태(```miner.start()```)여야 한다.

6) 이어서 remix Compile 메뉴로 돌아가 ABI 코드(Json 방식 코드)도 얻어내어, web3 통신 javascript에 활용한다.
    * web3 활용 자바스크립트는 ```해당 프로젝트 파일에서 app/views/event_triger``` 내에 있다.


## 8. geth 설치 및 연동 주의사항 (종합)
1. 서버(AWS)-클라이언트(홈페이지) 및 remix 전부 https 환경에서 하지 말 것. (RPC 통신 문제생김.)
2. AWS EC2는 t2.medium 이상급으로 돌릴 것. (t2.medium 미만으로 돌릴 시 마이닝 때 퍼포먼스가 안 나옴.)
3. 이더리움에 관련하여 AWS EC2 포트를 열어줄 때, 8545 포트는 피할 것. (이더리움 서버 작업이 안될 수 있다는 이슈가 있음.)
