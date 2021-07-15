Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F583C952E
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 02:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhGOAcf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 20:32:35 -0400
Received: from mail-eopbgr1400088.outbound.protection.outlook.com ([40.107.140.88]:37970
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229928AbhGOAcf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 20:32:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+Ue47L1F8wGr5fnlHAyJJVG5ascEAdCgIu0IG6e9NRhGwS4Q3c87cFaaxcql0K6Nt3bkUdppj2s6cwo1C0ya3+2NWfrpBenQkz2jsq59ZQowv/NjvzGYTXjqk1g6lYK4vmUAZJh33lA4h9NgPXY5hbklmkCEwGRPxxQbUsxv3oe9HSY/9HxxoObzecrB9ESKNVsWYhBPJ4kjgHguLO9dFmGYwkXtoxpC42qUKYPhWocciThit9gJdeFGpd32QnQfHp3SIpgYgtu7dj8unoQ8KHUMC5PP+80aJIqYxcEXhVNEtsdi5DtWEHQlwNV8hmS1uFkAya6rqqlkxXlFwlDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw9cR9Dtr/dsoc4fJmyAoO7053ubBSuR+PMFKt7hvIM=;
 b=NTdkDQ7MSM24RnM7Y7E1faBb8JPKQgakRPSXxJrAAPBzA7EHHKcN9SL5qZo4KexCyrYRQ8ZClzqR0f6p7ytQiT+Apl+TSItV2QpT4vyc+I9Hmmgpzd+pBmwBDX0AkHHrxzsMbHU4ezBPsF7z+Kz8NTBE64RUqYboXhokzJUr6gz9Ur6E2Oh6/2I44nlUks3pc9L0+5+aDl9P05lp6RqBB17MQqPyCkmR0LwYPwroyp1ey7UuSc/MwlmthpH8wQPuQn8zhFAbCJ7mdDZMGctVS5IuRt2urwOjuttjqFw/0Vv3L8/AYz7M70b8H40MZJrztXa8ChuKFCsNdnSyAMBDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw9cR9Dtr/dsoc4fJmyAoO7053ubBSuR+PMFKt7hvIM=;
 b=U71CHTooSGcHOEvSN5XnnE+On1OLe2Djo4XW89QsSgiswNLbhnVWexfyBB2lR3c9yLrWkbRGYE+ZDhVpcIGn21QevpatoNzSHIRM6du54JNtGiB+oXQPJwlrai/Md5tiX6uOnWO/kGWzcL2laxEBIpQ0arSj9g8P2XryXOzR9qg=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OS3PR01MB6548.jpnprd01.prod.outlook.com (2603:1096:604:10a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Thu, 15 Jul
 2021 00:29:39 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 00:29:39 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Index: AQHXd7fwKzEQWTvWzEqH2Qm18vEKNatA1OMAgADmmQCAAK0qgIAAyOcA
Date:   Thu, 15 Jul 2021 00:29:39 +0000
Message-ID: <d63a34c1-94bc-9f06-e041-680311f99ad6@nskint.co.jp>
References: <1406d756-1edb-6294-116b-91c7a9d29b71@nskint.co.jp>
 <20210713122528.GB4098@sirena.org.uk>
 <3b9745c1-ec32-793f-41c2-98c9f60057cc@nskint.co.jp>
 <20210714123034.GB4719@sirena.org.uk>
In-Reply-To: <20210714123034.GB4719@sirena.org.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0ca91d1-81f9-4923-adda-08d94727a1c9
x-ms-traffictypediagnostic: OS3PR01MB6548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB6548D40199469080F7E00F2D8B129@OS3PR01MB6548.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7hQO7jBoDOcMclmzVo89F91HV9oirY21u/88F4c+G7tQuXyOzDsAA6fJH4YCoJH4X4+5HuJEtG5kvigxdgOkHAq1M8fWvUoE5k+zvthMmiLMhsVS9fy0mzV3mFIxBHisYxK9LOnzEvyd/sZIm2roEZCBJyyOU/VtuvS+r3w1w4ValUbWBWfGvmnmO0cDSczabOkKfQdfvUtayuoNhqwIsn9o973CFhzN+VkyNVQ7vrBxFF9pniCmUgE4TlqPnn6kvL7wI/+Lukqp68/5yv5Ls1gMd5UcnXI3hIVIaVCk8dT0wlb05+LoJMcjuvjnPsoyVFDz1eVUl2TTIAXP4bmKKVZly/UcpttBXSa6/dOuy/iuN1V2W3SiuZTSePOuC35NygA7N8iThj7/J8AE4zOQPpXAoxnNsHiNnGkSk5Rkd8OUsuqGg3wj8PPApCIeLcoF0+PULxzWmDPf/UJtXu1wBfhvwnsEh5H0uh3AH/O3pe0L4228260OQfQbdk7bTE9PAvgOmtzlZFjz7bN0b650HqdbY8bCz/WrnTN1pqi25AEJYR2xoFpaoJxpKsWTTNikLxbqezco9fvgTAY1aTJ47nC/ze/57EQz8yIf6PzVAQr+SAQe+wFtQzdUKvp4+law7HlHyuiKO05ycMTtRvGBrsoMqkJttxNsJUPjEjCvCTtncbxptXsgZKS2eJ+soNS2VIDx2GtazjzjuesNhoV5B5y54TiHkL1II6gUoZLhzJ1xeBW7JZc4KflZMrz8Qs7+siBmgoQnZD1QFTITGrKFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(346002)(39830400003)(136003)(38100700002)(2616005)(478600001)(6916009)(6512007)(8676002)(107886003)(26005)(66946007)(4326008)(186003)(6486002)(31686004)(53546011)(76116006)(6506007)(66446008)(316002)(64756008)(31696002)(2906002)(71200400001)(8936002)(86362001)(36756003)(66556008)(66476007)(122000001)(5660300002)(54906003)(558084003)(45980500001)(38070700004)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZktDYjNkeVRoZXlzcC8zdUJ3UU1BcC9NWE1iU2xFNnJwcXd3aTMvRjEr?=
 =?iso-2022-jp?B?THNIMUg3Um9xY0ZYNmN4NGFUM0hUUHg5Tmt0a3N3aTFzc3oyN0xSS2dK?=
 =?iso-2022-jp?B?Myt3bjdIRzJaMkVScS9LbFdlR0FYeFRMRGZrdlJYK1BFWVJCeEFUblhY?=
 =?iso-2022-jp?B?QWsyMjJqREJDVTFvMEZ5aEsxTlI5Y3h1bFdwai9vaTJQa0pGUG10QWU4?=
 =?iso-2022-jp?B?cSt1NWZFWG8rdFJQTGVJQlFWMTc4Y1RuT25Cb0VGeE5TYk02cWsxQnZW?=
 =?iso-2022-jp?B?bTRZcTloOHljRlQ3VVVEUjFJSXBlaDQ5M0M5RFVHZWxySVkrNk5yaVlQ?=
 =?iso-2022-jp?B?bkMvb3Qvdmc5MWdBRXFDdHMrcmJGQ2hLMG9pUW1NdVhEczFKOTJNWmZz?=
 =?iso-2022-jp?B?VDNvaWNlOWxXMW9rbFB2dzNPUXZlYlpiQlB0UE9Ud08vTW5sUkFlRGdh?=
 =?iso-2022-jp?B?Z2gxWXJpRzJlTUFxV1NtWXZOMVF6QjdhbHQ4ZWlRb2k3ckJhSGpMODUr?=
 =?iso-2022-jp?B?ajlRMUhtelExRHZHd0JhZkJrUS9Rc0hkZUQ2dUFSY3RnZnJmaytpR1Ix?=
 =?iso-2022-jp?B?REIxN0RLdlZ5YS9NZWprYVEwbjBxVHdJM2tNSGJKeDhGR0VVR0FPeERt?=
 =?iso-2022-jp?B?SDFydVQvdXpxNWprV05PRllwOCtsOGxXR1haRStxYUNqOHhxV0crZzFL?=
 =?iso-2022-jp?B?ZHMyK014dXg4Vlp4QmNNbFAvZk1QL01DbmRKSDY4cVVhdmZDN0NhV2lz?=
 =?iso-2022-jp?B?WHBYbDNaeUJVWlgzWWxZWkFPV09VQUErS0FCaWxKK2RWaVJxMVlDbTN5?=
 =?iso-2022-jp?B?ZDJqaU1sUHBpaE85RFJCTTFnK3hFZnhYRU5kV3VxaWUwN2h6cUY0UGNv?=
 =?iso-2022-jp?B?ZW5XZ0NTQ0tTSm1NQ3UzOHdRVzBDUk5ieGIyeGdTdER4Ty9lclZ5aUQr?=
 =?iso-2022-jp?B?S0tWS1dTS1hSV2Jvdjh1L0xEWEZWMGZjRFdiK3E5dzBsZ1VnZzlTKzZi?=
 =?iso-2022-jp?B?NzVTNStQbzRyOEdkQm5iWXVMMzNrczVkSVEwdFV0M3Z6RmtDaWRXSE55?=
 =?iso-2022-jp?B?bVphNlNXZno5cGU0TXdyc0p2ckc2aXAvNkppS1pSWUVZbW84ZnpKcytP?=
 =?iso-2022-jp?B?REh3OUN5aVlDQkdUS1VDblk2b2pEVVNkNVJGUGlYdWc0OXdkUEtzZWNM?=
 =?iso-2022-jp?B?SVlMb1BMRG91T0VIS3VKS1JmVVlpZ0NqNGhtcHhDY0pyQ3BXUitMcjBq?=
 =?iso-2022-jp?B?UFNobjhieGxORm1BbHlyNXVDQmtWQkJQMXZBRG9naloyTGJDcVRQUGQ4?=
 =?iso-2022-jp?B?THduSVZUMjhab2ZDUWpiRlVvcTdtZVhuVVNpd0pHelkvT0JSdmZWWmdN?=
 =?iso-2022-jp?B?MUI5SXNpbmlHVm5Ld2FnVVFDenRvSmdxSEFLczN4TUtKWHVJaS9qYVho?=
 =?iso-2022-jp?B?ZUs2cU1BN29qK3gxUzNQN25GYjNQSHlrcnEzR1JuNE1uR3V4Y3dQa0lQ?=
 =?iso-2022-jp?B?QUNaWE1WZC9mTDY1Ykt2SFBES2x3NVpVUGRBeDdDNzRHNWNPWk4rZEFt?=
 =?iso-2022-jp?B?ZEZSbXlHalVhSFJmd2lNZFpFdTM3bEdNM000TG1pUHRZMjJrdm8xclg0?=
 =?iso-2022-jp?B?cmNjUzlGSGVkVTNQdWx5WUlTNFRyclFYY29MK3ZGRjJtd3BJUS9BYVpL?=
 =?iso-2022-jp?B?UG9mMGFScFFXNDV4ekxLZVdDQWFSOEtxNmd0N3pEb2Ntc0VyRWtXTVBM?=
 =?iso-2022-jp?B?MTFpTDJYR2N6Z21RV2VyRXpKNjlBUVdRakhCRWd1MWVGVmZFN0xmd0VG?=
 =?iso-2022-jp?B?N2JwYW1lRk1hZUYzMXhHVHQ1dzFPdzlPTEpkVUlpRmFjWFh4K1BiMVRt?=
 =?iso-2022-jp?B?MDFDME9aTkg5ZERqSDFIOUh1aUlidHNnYlkzZzVYSm5INy81alc2bmNx?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <DBA43EF0C9D65940858D02C7A0ED24D4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ca91d1-81f9-4923-adda-08d94727a1c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 00:29:39.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0UNXTjVofluO7QbGdJ/RVfqeCxj4n3hTPKmraI4suTxeIF88X15LCvN8Op9T04QRvsCw0SNYlRwrg32kZVQgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6548
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/07/14 21:30, Mark Brown wrote:

> That looks good to me.

Thanks for your review.
I will repost it later.
