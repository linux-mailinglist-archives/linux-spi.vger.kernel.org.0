Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD563625AC
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 18:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhDPQcV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 12:32:21 -0400
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:37217
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235575AbhDPQcU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 12:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbp8XZDBBF7Fkgl+08b/Q5uz8zRu2gwewjNioPZ8thiul2cpNquiAaClxsZAjK1PzdEEzCCvoux48QqLqBc20QR2lKAcpPW+1YDnV5ETLQFT0/qRxYMFWgYpUDLTkJrdvF9ZvOmST7E+v8GW1K82wYzrLC5l7WRbJhY2XNQ/Wt3lF6537HdI6kGNm78sYwK/Dq2FYBVrq59BXh0PB3zm9YNKfTIok8VaasdBc4oqS5/t5rVmVTSODi9Vr9Prk+csdu8R10M/QUgYFKESOWf9srgby+RtEU3TUSdmcS5adLKHJVAA7/vs818u2xpKqQX0Bp5tHHhlkvXrMrJzK/NjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0cunF9DSgqkUrxKxAk8uwQIUeUQw/fZs4EgfeLK4yM=;
 b=dgTvL/ziCH1BxFgqSDS7Zs49oQYO/IaurOhIlMd8IJwGskDn50T6iLdqgYsCDMd3c2r2egcyORDkSlRMOl53zJEKJiHYiDlgqh6OtEvYTR3VV+8c9A7jwEh2EXQ+dNi67yYkILXvHrAQ8rtxLqc2NCmN28MiV27Vnf+J0MPa4zctCJUqPdBbVDu/ifXNNgjm6mD8KQ5wA5XhqNNWQeOJkE0UeQdyjsMD5WXv9aPC+UdWykehuQWci6Cwtz7up95oOKU+G+ji0xRIaChpLN9aFB5wA7cNwSI1ETlxpSqIn5T3qMo1IMwZjh0h50lqm9lV6RZSQkNpkavmzzjLDvgWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0cunF9DSgqkUrxKxAk8uwQIUeUQw/fZs4EgfeLK4yM=;
 b=ajAUMREcbBidkpJCJb58IXi+8TSbyTtl7m39v0jAjHI/BOaS7WVPY7ju3Uv6mnAuGlH94SzZwKIFVaoVukdjXG6xpr0CbpMGeQgzd9mnLSZ7jyn3dgFMDypS6UZe2+k/E1FLYn6X0OLHLy8/FlgvLBFs6Sh4n2eYY9+V2nUNgYI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1544.namprd11.prod.outlook.com (2603:10b6:910:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 16:31:54 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 16:31:54 +0000
Subject: Re: [PATCH 0/5] spi: spi-zynqmp-gqspi: fix spi issues
To:     Mark Brown <broonie@kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
References: <20210416142047.6349-1-quanyang.wang@windriver.com>
 <161858883110.29027.5432599534762847384.b4-ty@kernel.org>
From:   Quanyang Wang <quanyang.wang@windriver.com>
Message-ID: <fb308dee-6ca4-e2de-964a-f67684f15e54@windriver.com>
Date:   Sat, 17 Apr 2021 00:31:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <161858883110.29027.5432599534762847384.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [111.196.167.14]
X-ClientProxiedBy: HKAPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:203:c9::6) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.109] (111.196.167.14) by HKAPR03CA0019.apcprd03.prod.outlook.com (2603:1096:203:c9::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Fri, 16 Apr 2021 16:31:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66affeb5-0f25-4aec-6ad4-08d900f52509
X-MS-TrafficTypeDiagnostic: CY4PR11MB1544:
X-Microsoft-Antispam-PRVS: <CY4PR11MB15442E9030675011882A74FEF04C9@CY4PR11MB1544.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZgZm//mZ9+nN+ErC0fF6/cUYOhboQ5L1bq42vdNRcDMqsdrgx+awri7OuZnIGnW/Lc4bhIT8K3kpPVjDAdRHZcTORzTP1OCLz+Q9B50kiCwoZHO+j5EEeUa7M7m8oCVvS2ow/yHyjnOA1zdi+3nyQQNxQjgP+/rt1+U5NX2AS7C7xrP68eYY3gWnnYbbd8uMUzT85ZMhmUYjOeSUXAomRKBLMjGMUlKIKmBssxbAYvDntyf6zvkXr8mKSASY6NfrtZz9qQn2S97pDawwBDcLEK1QgkRpXmEKJb8hxnhHWz5OKf9aZv9IddCSOMgp0WEwi0CsBOThz6jFh75WYldpzyQFLwzgC0JNN15Z4ykf0VeLw655Zhg4RjimrbKTJ/P+CCraW8LbXN1do8ae4rstxo9lRhzmxq2/fJAOgWrQj9lQ3RHXsnxiF/+iFgj1FzlMXDSlODNkKn4OTfH8RLleGXyDSG34pOZQnK1lsw0utmLUsljiRMruyRYIF1p5jH57O76aTqpGnzDFFmZn6iCIrJeqKnabC9pUv/zRWaeds84aZ0Kg0rX9GmZXIcY1xDUOMzI6Qx2JYEZMAv3LBTAri6rUj/UDPMSbtCuMMv+f7arNIkEr26raVARy/DU7pt+cE/q+4oy52mx1qHWzdTAeOTrkNkUuKLGdjRjj1Yc6/DSGtxqsp2LXwF/RRIf2q5NSv1IKQE9f53jsi1N0seCn5PAeEZIuSPC+4bZvuwvwJEHpApBqDxkEpuzq8+Xh4/Ljdu1cqIkAwBEgNP3W097plds58Yix9K4+nxro4xGpT8cBtbHFYo6rKv2grqGa9xx2rlRl9jb3o6LiCkeH/iRJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(346002)(366004)(376002)(8936002)(36756003)(966005)(186003)(16526019)(83380400001)(4326008)(478600001)(31686004)(6486002)(2616005)(5660300002)(956004)(8676002)(26005)(44832011)(31696002)(53546011)(66556008)(66946007)(2906002)(38100700002)(38350700002)(110136005)(16576012)(316002)(6666004)(66476007)(86362001)(52116002)(13296009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NjJYQjBXSWFpZlVsUXdLZzRGUHlzeVI0SWVyTUdKRXF0MHBlTjBRQWFsRFJJ?=
 =?utf-8?B?cmk4QnUxcVRkMDFWcEpkeWE3am1JZVFleC95bHFZMUoxN0ZqSkhtM1NraXNi?=
 =?utf-8?B?Q2VLRVBrcm82SlR2YzlCbGd3UnMrTG1QUXIva3prVFQzdmZvRXdYSFkxQ0JO?=
 =?utf-8?B?bVlJTXlaVWZTOThSM0NWOFNpTkRuVXI5VzBPWWRnU1lGZy9MSWJpQjlIdDIw?=
 =?utf-8?B?KzY1VDJVTDVFWThVU3BaMHJNanluNCtpUVJQbTU3Y2VzR3N0Rnl0bGJLdk1y?=
 =?utf-8?B?VmxyWU95RmY4bVk4TWJGZlh3VlpZQUUwVGQ1SXNJbWd0WXU1Q1VyeDk2T1FF?=
 =?utf-8?B?MzlON0ZZUEhHa0czYUxQclRSaTQ1M2w3eGpPUWp6Nm1TMW0vUXU3bEhTWDk5?=
 =?utf-8?B?Y2VNcVJicC9CcWc2dEFlbjYxUnVpcVlwVVVUdXVHbmRlYUlFUGNLK0dmZ0xV?=
 =?utf-8?B?SFUwMDVmWGFpODUrbEIvT1R6MGN3UGpyTTFuQzVQVUx4akIxeGFDMUxrbHMx?=
 =?utf-8?B?dzh1MVNaU1ljOVpJMFdCRUtHN3AvNFlrTVJkSWRrM3BYUkEvYUZRajdIOG92?=
 =?utf-8?B?b0JqYmRWcVhXMzlyUmlFaldvUW1WbW9GSzFEVnNhQUNHN01Dem9CTVU4V2p1?=
 =?utf-8?B?NitOaVRBTkJPZGZFdWllbEJqTDlIK2ZYcmlUWmZZWVNWK3grZXFFL0twWW9s?=
 =?utf-8?B?MVJnUUN0ZUlubnNPT2pWaVJkaDBOTXA5UU96ckdxaHpPdXpIZDg3QlB1MFBk?=
 =?utf-8?B?dGY5U1V2RkZWVllmdkoycm1HcmpXUnFOOXFwNGFLOGYzSkhPazRXbS96Sjhz?=
 =?utf-8?B?RFlWcHNNZnlaWksvOERJUzJBendlazdQU0swN3pVVUxOdjVmcTU5ZDdxcEVH?=
 =?utf-8?B?SW9uZFNQL1dsczJ6ejdPbXNRTVBCT21Gc2hHQXpEa2NwSlBJcnV4UVk3cVVP?=
 =?utf-8?B?WVFJcVZuOEVMRXZleExZUi9CU2IxemZiZUk3bzlIT3JaRlh1Y0ZFa0taRzFl?=
 =?utf-8?B?V2tyUEh4UVFtLzJDYnpScUR3di80dXUwQ3d3TDc5U3VoSllQdEdKdmtrNmxY?=
 =?utf-8?B?S080Q1hvbVZzOVRubDRaWXhMSHk1QVdVd0h0aXRFZG1LY25MZUJrNjZRTEly?=
 =?utf-8?B?VklRVTlBMGp0czBLOTFDWEgxbWhNMDdHZ1dTSTRSaWVKT0hLVFFJVEpVc0R2?=
 =?utf-8?B?MjVZMUJlVW1tWTJtSGI1NEtrMitCRlBMZmJwY1ovSWhrSHZXYmlubTR5WHRk?=
 =?utf-8?B?VjNQQlVPbm9NSGphZEZmUEhwQTRWV0wwZWxkdURKVGhNeUtiNDN1eTQzZVBr?=
 =?utf-8?B?c2VPc0NTazQxMXBtL0czT2NIeUpGbk52UUFYZ2lxaXFmZ2hpci9OWnZUaS9p?=
 =?utf-8?B?VWRyUE9JOURjVjdXb0xRYzhaeHpyMkliWVJHWnVBdzJhbEFjTXhlRGVQSEhm?=
 =?utf-8?B?TjY1Vys3dDh0ZUJIcEtKSkViYyt6YVZnZVRpVFNIdi9aQndMN05ld05ndmZL?=
 =?utf-8?B?VDIvNHRqcVJ1NVA1a2VLZnVmbjNUM0w4bFEzdVdMdVRwekhBaFlNL2xjT20y?=
 =?utf-8?B?dUZYRGN5QkUyQmdBK1QxVmMxMnpGS1ZmQ0VLeUh4WlRHdFVnbEFTeTlxV01s?=
 =?utf-8?B?TTRNQXZ0UWRRRjdWRWZaWEZ2VERoc3VidVd1cnBBQXVrRnI4emlvQlVJQWd6?=
 =?utf-8?B?NjJHMU9HM1pZTGZXVU4vNFdyR0hEY0ZSTGhEL1VvRDE2WXdvSkVkdmdWblRI?=
 =?utf-8?Q?M9S0TqC5ornBqRP0eVU8Suiex0XAmlaZWmjU0+f?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66affeb5-0f25-4aec-6ad4-08d900f52509
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 16:31:54.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ4O10gchX00fosTH3YynKS9/sTJiA8ZtN+V6UTf8p9cb168GRr8t/Gk/sE7dduwTJpzl2H3brqrCOxZUukvJToEpKFCQdOitb9n47OCUWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1544
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Sorry for any confusion caused.

Thanks,

Quanyang

On 4/17/21 12:01 AM, Mark Brown wrote:
> On Fri, 16 Apr 2021 22:20:42 +0800, quanyang.wang@windriver.com wrote:
>> V2:
>> Remove all "Fixes:" tags since they base on some patches are not
>> with "Fixes:".
>>
>> V1:
>> This series fix some issues that occurs in spi-zynqmp-gqspi.c.
>>
>> [...]
> Applied to
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>
> Thanks!
>
> [1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable imbalance issue
>        commit: c6bdae08012b2ca3e94f3a41ef4ca8cfe7c9ab6f
> [2/5] spi: spi-zynqmp-gqspi: fix hang issue when suspend/resume
>        commit: 799f923f0a66a9c99f0a3eaa078b306db7a8b33a
> [3/5] spi: spi-zynqmp-gqspi: Resolved slab-out-of-bounds bug
>        commit: 2530b3df4326023a171977ab46fdfeac0340f5b2
> [4/5] spi: spi-zynqmp-gqspi: fix use-after-free in zynqmp_qspi_exec_op
>        commit: a2c5bedb2d55dd27c642c7b9fb6886d7ad7bdb58
> [5/5] spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails
>        commit: 126bdb606fd2802454e6048caef1be3e25dd121e
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
