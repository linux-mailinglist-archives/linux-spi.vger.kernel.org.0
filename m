Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250A13CB0E5
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 04:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhGPCx5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 22:53:57 -0400
Received: from mail-eopbgr1400073.outbound.protection.outlook.com ([40.107.140.73]:50030
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231230AbhGPCx4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 22:53:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3pQ97ef8rdZ/hqRmXDWpe+gwFxFZA1Qn+mWA2lH91yV7OO0+fFyKEKqbrGJqDRTsNFUjMj6MiAsRqWoeBIAszqBrXgQxkxRfzEn+6RjNqam9o/XDSZu4bfQg/Hzx6vF8tzWNk/EhcNpeHxvBJJTGn5PiXSck5zh6BtUzoOSn0YLX6dB+U9lDjIIBENVhJPiTsPXMAjeBgI+jaIPIhDtPv2PDzAek310savCFFdF0knUNgOJ3a8YUX9yiGvgY53RINw+jpGUtYMM2pO6oElD2VPCYY/bDg5jNJITYUMaawgUrKUQGM7sXRTWauyZhYKbt/4db9dXH+dD8/560m5t5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Asrbn/frmQ0Tx59EFzQYkftZrxd0Lbjs94EJWL0Tsx4=;
 b=NObe95ntetNc1yLMIliIXE5nACEUvDR3E7OzP4Jd33WYvqv/DqfGSrJaWS26kXTooNE6c41bZxjPu/QxWRxur1s3hmUra7XnFD1RLBliWabukvsuCSjf23WLpQJTiVbYqYPrPVOIFKUqNEV/6HqzWoqBUiPU+WRx8iESj08wRp6VhQHNWoi2zpIk68utnC0Yxtt4rXSpVTHlTl3TU3/5rS6j62ogZ21PXFYjif2IlSYYepcggy5nI/xV+0t0WPhezFTqtqF8OGI8a76ZaAQCRCDYbjvAs2XxeOB9W+0vj+6vlnC7N/OEi9qXSJt+OJokjELM5mSdsCiBTIxIStktcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Asrbn/frmQ0Tx59EFzQYkftZrxd0Lbjs94EJWL0Tsx4=;
 b=iYVZjr85qlpx4YshjsaBLG28NZeF58JHdoyWvGnajcI9GkA2V1aVH1fEdbKL7hVpmyC0WC2O+2Ampk8CE3nLWzBpDum7tGqvhlMcQtEQ3h7sycGCks6tMRlSyuzgdU3jfJ7/smrFatZNKaxeZAMquEtI4R/4V6jYmXyzQ1bjVps=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSBPR01MB5157.jpnprd01.prod.outlook.com (2603:1096:604:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Fri, 16 Jul
 2021 02:51:01 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 02:51:00 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH v3] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH v3] spi: spi-cadence-quadspi: Fix division by zero
 warning
Thread-Index: AQHXeZV5q18FbZMuSU6W5e8ubdQqtqtEYgoAgACFnAA=
Date:   Fri, 16 Jul 2021 02:51:00 +0000
Message-ID: <833995d9-4511-2712-e8fb-6e0bbb57c0c2@nskint.co.jp>
References: <ed989af6-da88-4e0b-9ed8-126db6cad2e4@nskint.co.jp>
 <20210715185248.2ms4yjx24n5v4nef@ti.com>
In-Reply-To: <20210715185248.2ms4yjx24n5v4nef@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: nskint.co.jp; dkim=none (message not signed)
 header.d=none;nskint.co.jp; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d813a5f7-3ad0-4ca5-fdd8-08d948048ba7
x-ms-traffictypediagnostic: OSBPR01MB5157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB51576FBD3CE1CFF85E17AE778B119@OSBPR01MB5157.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNKiTOPx5y8P7FQpiKEHc73ulpzypCTl/eT2nBQAk5HG/JoLbqwKIMnONBUgr7+Pr6QAgxpY7AQL3L7Qu4NgIgUUsa1+IQe758q1NtA15Z/QthvCo8NdMsotuNxJGbvv3QUif+giDCnrcCVHNfd6sqeMVEXrl/W+M8WpboMBm2yukQvdGXTy2ZlVZ840k0+R5fK2deuS2cKkmf/9yDTEWuJlPfYh+aq0IM5e83UMAZnTr0s0obDVij4rButBN5Xj1zc1UqwDDjsaBA6S3rGDoR0xdFO7khwRTXoY59GKp6EDZ7EYAcUitprnhmxPTuyVOZkqQX+BdaDUtmtjvKU1/paRkLLiV8eLwzjCIVV8qUvdjNEprq+4OJ2Sz30CCFb54/QTSaKFqUf/X3odJO3JiTZuqHMJjWRrdziiLXfVR+lbcLyPYS0RWus5WlZuT00iN5JUFfIXyIGHKMYIyWuYaPbu0lQLQbuZ1NRXlPvcqYqR9CPvJTA8vDcwBVKLcqzdKtM3K5RRmlg0n2D6OSfLasEdOiI/fDFZ90bf7EO6f8gHfQJsYd5sI4inpBYvkfIc7UqHp9CkiabJ2FToph99/6JpikqI+urOXUJ4qUVRou8FjL/BhxVlDwcd7jFO5uUVvvCHp1S7G32o3FfSfIqplmznyx0oflBZ9Fsh66x6a/01hnIcckLXI5rWnmKy8zlwVkO5jwqURAVdNhK2eGYoZtiAjMoUSJFjPbZJje5+I4pcnjfydLf/4uoUhz7hLPUsWGdrgVWTsHQ+wC/NWluGrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(376002)(136003)(396003)(366004)(53546011)(122000001)(6916009)(6506007)(71200400001)(38100700002)(31686004)(478600001)(8676002)(54906003)(83380400001)(8936002)(6512007)(5660300002)(107886003)(26005)(36756003)(86362001)(4326008)(316002)(76116006)(66556008)(6486002)(31696002)(64756008)(186003)(66446008)(2616005)(66946007)(2906002)(66476007)(43740500002)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MXd1eklnRHZYVWRlSkxZWlZ6R056dnlvandRSFBDVHY0bkRycWFUeEs5?=
 =?iso-2022-jp?B?TXNKMVFwZHFkN2JqbjJJcUNlTVdoT1BBaU9kTm1tRW9iT3FUelNtVG9s?=
 =?iso-2022-jp?B?ZzNEV0tZUDhNWUdrUVpNNzkxekNHTWdycjR0MGFTVGxlclY4R3N0ZEpL?=
 =?iso-2022-jp?B?c1lzTmRlRUdVUng2S21DMmZRQXFJMEZtRzFQRi80NGR6bndZY1Ftd3hz?=
 =?iso-2022-jp?B?bUlhdnE1eWpLajVTcHFGWTY0djh5eHVYQXgvekN6NkFVSllUMDlxNm1K?=
 =?iso-2022-jp?B?UFdDR0MyS1M2elhMSXFXZm90YlpSZXMrRldNeXhGZzREL2h0aFVaQXZG?=
 =?iso-2022-jp?B?QUFWQmpwNFVzS2piM3V1NkVia1d3eWZRMkMvZkpNR2FSbEt2ZVB2ODRp?=
 =?iso-2022-jp?B?MFA0Rkt6UEJmOGJVOUNwb29zaUJjNzBZcTRDRTZlR3FINTg0OFdPSXJj?=
 =?iso-2022-jp?B?K3QrVXN1bytoSnN3MnJ2bjQzSUVqLzk3L1lVbi81NWpNYUdiTEdFYTFJ?=
 =?iso-2022-jp?B?a2p4RWNLOHl3T2dIaGNoLzY1NS9lL284a1BCbTJmSHVmdndKVTdCQjR3?=
 =?iso-2022-jp?B?dEprUVFKUzRMVVFLaElPSTB0UlB3ZjVUemJkOHA1ald5ME5odWJmLzVM?=
 =?iso-2022-jp?B?K29wbW5WZTRia0VJaGxVS1ZXRVpwWXB5V0xrNm1OWGltSUZxemdwM3V2?=
 =?iso-2022-jp?B?dzMrT3FJc0tZWU5oclJ0REtWY3hObk5kRDNLbXB6N1JjZHB3Rm1sWkkz?=
 =?iso-2022-jp?B?RGNDYlRJQVlwL1VwSWVBRFlxZVBncW5JZEVPOXhUeFdqaytzWlN5RENS?=
 =?iso-2022-jp?B?QVdLeEZGNDVHYzkvVlRsNExoSHp6RnYybVdLNys5anB4MnR0TitoV2Ix?=
 =?iso-2022-jp?B?U0FlNWp4Mys5K3VSTXF1SmR6TFNNOXE2OEs1eE9PL3c5aWlIMnBtRWp1?=
 =?iso-2022-jp?B?dVNMU0JVVExOZGhXR3I2SWRaOGozYzhsYTFKTTJmNFB1NnNHdXd5U2M3?=
 =?iso-2022-jp?B?WURKVlBTM3h1ak93MCtJQzdLVDl2Q2tDMyt1cFh1U2tNS3NmUmovOEpW?=
 =?iso-2022-jp?B?blNwNWRFTkE2Y3dURDV1WEVLT2JuTEN0ZmxmUFNvTXI5cmMwVDl0aVUz?=
 =?iso-2022-jp?B?ZUZmdVlUMDY1SDBvWVNoTjhyaTRBWlU5clBGQUFsenBON09JM2FmR2tr?=
 =?iso-2022-jp?B?T3N2VXZZZVFLa2pob1R5WjEwM0JZQkFMdUNuaEFOUWNHNHoycTM5Umpp?=
 =?iso-2022-jp?B?c2k3OEUvWEFickR6L2ZHVUc2RnYvWE0zaE5qc3Y3czV4Q2YxSE8vOStK?=
 =?iso-2022-jp?B?R0J0SEV0QmZVMlB2d29ZQkJCZTFRNERQNm1iQTl2NTNHN2FldmFPMGNO?=
 =?iso-2022-jp?B?cndRSXoyZ2hMYXpieXNUUFdVaDRuNmo5SkZGVE9Uai94QVo1anpFeVRS?=
 =?iso-2022-jp?B?Qmo4ZVNyRVEzaDRDb0FKYXczVUJJcHFXWU1jeUF0Qmg0ZkxyYUtrcGo0?=
 =?iso-2022-jp?B?STdmVG9EejR1disrSXljWHJqdUNjTEpOMFFiakdIOVlrOEdhV1hkOWl0?=
 =?iso-2022-jp?B?TUJrUzBncjZTR3NDeW5qNnZwc1JpMlFaQnhaU1Y2Tjd5N1EwNFhidWJx?=
 =?iso-2022-jp?B?VURONmRSYjdpYjZmRnBKdTE1TjF1aWdZeCt1NkpTVCtGVnVyR1drZkZT?=
 =?iso-2022-jp?B?c2MwNlAyRU9IUXcvYk4zNXJkZnZ6TnBVWjNlbkxseS9Kd1pLNmNTQVc0?=
 =?iso-2022-jp?B?cFJXNVZySnArNkxQUTJsN0hnMnMzcmYrekJJaUdtZDRXbEVCbWRPd2ps?=
 =?iso-2022-jp?B?WHdoamdYTzBQNlJiZjEweGRLTS9pTDcrTGlqLzF5VnNDZGI3d1dra3E4?=
 =?iso-2022-jp?B?M0RFR2NrZW9PL2JjSGpqaEt4R3AwUG4wZi9ublpzRXpqR1JjUE1EbE9s?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B8AEE5F9A384D94DAC33267279943F07@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d813a5f7-3ad0-4ca5-fdd8-08d948048ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 02:51:00.9249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1q1bxJJ90A/A6vjrlXrO0MNsGqfKQzM54aulQ2uFrryuNqtrjk8+isA7RYxBJbtB/ZHdqBf1YDe7RTGIYBdNdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5157
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/07/16 3:52, Pratyush Yadav wrote:
> On 15/07/21 04:21PM, Yoshitaka Ikeda wrote:
>> Fix below division by zero warning:
>> - Added an if statement because buswidth can be zero, resulting in divis=
ion by zero.
>> - The modified code was based on another driver (atmel-quadspi).
>>
>> [    0.795337] Division by zero in kernel.
>>    :
>> [    0.834051] [<807fd40c>] (__div0) from [<804e1acc>] (Ldiv0+0x8/0x10)
>> [    0.839097] [<805f0710>] (cqspi_exec_mem_op) from [<805edb4c>] (spi_m=
em_exec_op+0x3b0/0x3f8)
>=20
> Please add a fixes tag.
>=20
> Fixes: 7512eaf54190 ("spi: cadence-quadspi: Fix dummy cycle calculation w=
hen buswidth > 1")
>=20
>>
>> Signed-off-by: Yoshitaka Ikeda <ikeda@nskint.co.jp>
>> ---
>> v2:
>> - Fix commit message.
>> v3:
>> - repost.
>>
>>  drivers/spi/spi-cadence-quadspi.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence=
-quadspi.c
>> index 7a00346ff9b9..13d1f0ce618e 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -307,11 +307,13 @@ static unsigned int cqspi_calc_rdreg(struct cqspi_=
flash_pdata *f_pdata)
>> =20
>>  static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool =
dtr)
>>  {
>> -	unsigned int dummy_clk;
>> +	unsigned int dummy_clk =3D 0;
>=20
> I think you can just do:
>=20
>   if (!op->dummy.nbytes)
> 	return 0;
>=20
> and leave the rest same.
>=20
> I don't think we should have to check for buswidth here, even though it=20
> is the one causing divide-by-zero. Any op with positive dummy nbytes but=
=20
> with 0 buswidth is invalid. That should be rejected by the SPI MEM core=20
> or the supports_op(), so it should never even get here.

Thanks for the detailed explanation. I understand now.
I will fix it as you suggested.

>> =20
>> -	dummy_clk =3D op->dummy.nbytes * (8 / op->dummy.buswidth);
>> -	if (dtr)
>> -		dummy_clk /=3D 2;
>> +	if (op->dummy.buswidth && op->dummy.nbytes) {
>> +		dummy_clk =3D op->dummy.nbytes * (8 / op->dummy.buswidth);
>> +		if (dtr)
>> +			dummy_clk /=3D 2;
>> +	}
>> =20
>>  	return dummy_clk;
>>  }
>> --=20
>> 2.32.0
>=20
