Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F32F3C953E
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 02:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGOAtZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 20:49:25 -0400
Received: from mail-eopbgr1400075.outbound.protection.outlook.com ([40.107.140.75]:35596
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229666AbhGOAtZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 20:49:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm4W5xjYUTLgnpoZpCwCVJdYnnwoHZaMTSETeqUcP42WZfYlo5IM8uwb1AtFeYegQ0yiieOOhVDFf7pI7bGAioZW0xNADeoWd6T5y2K3ktQZAN8AbW3Ev34pYhnafOd9UWgfAwMdtUXqhkjvf64PjDFaYVjNOP9A6TxCyu16/R7c9+uxhZ7gA4KoKZZVtK2YCn18cwW5N5X5TL8AJYTZYRQqli9VmOZPNDjCQ0cbKoJIOpb4/r5F3A5+O+EqjdtHcK1JVrRQQ+Pr1BRoJPthaKuC0VutnEKwY16r4gzjpj5xIr7S/wd5UmgwURwpCDFEKQegOFVNhqE5kjEYI39DOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS3Abz0VDH1Oti6gop/Q/AOux+UxUi0zOi9Bn7VYz8k=;
 b=oeJSO+DifmOJHnIeeDS2sElqgaJyglQnhEMAZb6bYyP59olD/Dn2cbP9D9PNZGkYZuq4tI6E/mE8dGHelTIAKjvYf5evqCdj8hf7eABgsb8yMO6dD2NOxj4JLrt2J4AN5j6gTrlUWyXzUNzmIgnzRwzlktQ9ssgIGzp39Sjwl55FHiiEsHt/RwNW2ppYBfe7TqBfCUKBo1oNUryxFRIJG9PHY9wp0/TNPDLW48hX8waiXzAe/g3IS3CoFL7Gv1wXDsfBvA/z9C03RHA26x5UHdaRVmqkZZ7Zb/Ul8cSkJQoHRLp13Z3hLfaWoL3fqCCr8mKheTIK6l1IDWzXUClmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS3Abz0VDH1Oti6gop/Q/AOux+UxUi0zOi9Bn7VYz8k=;
 b=EDbTp76OXWP5QrKBKyH10mwl2+ylsdRpYH1B6AJVYpsuf/jEUtyT11lbok/th1Bxf0yxUT0VNDpCVqt/pNy/mtMXbZRjePtJIktG1MWBR9HV5gKgNeKrprYJu/2LdpbvYaYkKZjkGSZ/FhwRYjOi04WM0phwD17NSQ3lpNHY9YA=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OS3PR01MB5941.jpnprd01.prod.outlook.com (2603:1096:604:b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Thu, 15 Jul
 2021 00:46:31 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 00:46:31 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: [PATCH v2] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH v2] spi: spi-cadence-quadspi: Fix division by zero
 warning
Thread-Index: AQHXeRLRq9j2aM/2WUWyoM0xh6yPGw==
Date:   Thu, 15 Jul 2021 00:46:30 +0000
Message-ID: <362e0cbc-ed82-bf7d-025c-d586d11eaac2@nskint.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6b1b313-a268-4561-96f8-08d94729fcd0
x-ms-traffictypediagnostic: OS3PR01MB5941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB59411C414F15F1DBBD6F91B08B129@OS3PR01MB5941.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:337;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lezb0Xdh6Su/efH5t+kfKzBDovkEUn8AY0xTQCMbInbH/bNjSCtrTX/o6/9T3Uzw8d5WXe3v4NzkWV7tQLg/jh/5fHf2B7B9hTy61FbFxvxekyHxxT5mVZJrG5frjAgbyo1WrwD7cNKxz2Fp2tMYbWzcoJMm2ah2pggodtemFSYD+MiyYsu9zcBUKgBny1MpY+NHTtvn9q89LbWJiEeWR23VY/H+suHbZsDLd3LTUieH4tDOVDGG3U6NGHxVNrrxhvRDGuhj1parDHW7PIWLxSyH5BuSGckYccsfiYB62C9DbKU1mu6FhSPQ0S532dCD0bYxUxzl6B32JE5hZfJLOX96we9g7yNz4dgb7mK7HW3aydS50C4gDWJVdqp9/2/lJpXxgVxmQ5E6sZQkX0671VlJUicxvmWX3rwE1z+XzbQM1Q5LMXGnrKZKQqVHWhRMYYgTdK0yxBCV0wOu9gdYEEuyrnnDHXrsNQ/l33av9VfJvEWe0cRM7GAItsoBBTJj8qOPLMr9XTmKK6d20o18nDaEZVV1Ny3XJemY4ESnM4R3Z5kisQRCWL/z8Wsc2kfFDXn9/X6fxO0mGZxjyhrse5P0cHcX2hu2ku44KYM4P6YPOROig+ZDinQlfKpkTCFwSpfTCHqhAs6UpO0QFjGZEx7dyIYfNsW/WJ7NIZloT6YSpCXmisV7tCei3BNS+hiQm+zPx7WRXro6QdQXRx/wQKDDvfcbpXZzLaWZRkubMEDRQTh0ohEP18Vcpi+ncGbVkZn/+fzt4pmuM3VlWkXLIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(71200400001)(8936002)(86362001)(36756003)(66446008)(31696002)(316002)(64756008)(5660300002)(54906003)(66556008)(66476007)(122000001)(83380400001)(8676002)(6512007)(107886003)(2616005)(478600001)(6916009)(38100700002)(6506007)(76116006)(66946007)(4326008)(26005)(31686004)(186003)(6486002)(43740500002)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MktxZGk5bmU0VnhaY0xyNjlqTzFobnRMVks2R1g1M2g1QysvYjNtTkhD?=
 =?iso-2022-jp?B?N0NSbmpxSGZrMUVOZFFzLzc5U2F0bXVVamlqZWFwUG9KNEJLeHZNTkw2?=
 =?iso-2022-jp?B?REZ4ZXpmM044czIyczZlRm54VHpMS0tzNlZjbCsvQ3VPU1hFNk5jNmFJ?=
 =?iso-2022-jp?B?T0lxUmd3UVllTUg3V1FXNEVSSTJ3ZDUwaS9KZ1Y2U2xCdmZKMVhla0Jy?=
 =?iso-2022-jp?B?UzdIQUczTkVIb0c4MWRqdVErOVB3emtMZWJwWXRRc2J6RFUvVEtNOER1?=
 =?iso-2022-jp?B?K015bk9UUWlRY1c3MUtYRVVKMThoejduTlc2eHJ4UmNrT2NUbVEvM3V1?=
 =?iso-2022-jp?B?dWdSZlNLMmtUQjI5ZllOVnh4N29jUGx4S0ZwQmdZYllqNXkwN000ZFQ0?=
 =?iso-2022-jp?B?Y1RlRXc5U3dIZU5nSHk3dTZvU0lzNWVTWlV2QnR6WTVMWURiR1ZDZGV5?=
 =?iso-2022-jp?B?MkJjSnRGZnFKS3FhT01BUHNTLzFYWFBVVnFuaTk0Q1JmQVhMNHZKejBi?=
 =?iso-2022-jp?B?Mmw0RXlKcmZ2R3VPdnNGU2ZaaG1WMGF5c1ZjakpoUFQ0bXJ4RUtaQUJT?=
 =?iso-2022-jp?B?aXBZUkhXN1krbk5UWUpmMEY1dkZhSWlWUGI4ZnQrM3Fkc2x4cWdaK0sy?=
 =?iso-2022-jp?B?Vmg0WWdSaEQ4SWI4SU9JckpGbWFrV0RYYitTa0JvNHUvYzFscHpvNkZF?=
 =?iso-2022-jp?B?bmgweFJuUFYzQWpaYktPbWRyWEFxUzRVdWR6azNMbWg1c1EwU2s1RHFG?=
 =?iso-2022-jp?B?TTltVk9KL0NmN1k1TGQzOHVMcTJXUFYyK29qaURUV3VSOS9Jd09CQUJQ?=
 =?iso-2022-jp?B?SW96K3ljSmdiQUpBMG0xYnMyWmU3ZW5OUFdSVGU4VHNKNUZLUC9HTE52?=
 =?iso-2022-jp?B?QVpMMzBEVEtLYzFSR0VQWk9vQTcrQUo2UzMxa3pSMUExZHZRZ1ljSHdD?=
 =?iso-2022-jp?B?Umg1WVhwUjlmWGZva2lHeEUzTExMeXQ4WTRzUHhNR1FrKytjUkRFVUE2?=
 =?iso-2022-jp?B?NjVHak5YL3h0NEtDczM4aEc2M2d0alRhZ3YrZitWVWh4KzZaeGE2RGhr?=
 =?iso-2022-jp?B?NFFqZXdUcTNlK2dJMUhMVGVOdnhlSFRqWUJMMnFVdWl4NU4xREQ5cTNW?=
 =?iso-2022-jp?B?ZnFneERzWFUrY1VRMXpWanVFaC9VaXM3NWpsZFM5NmgwM21UbUFMSVBm?=
 =?iso-2022-jp?B?VFhSTlFibVY4RXNJcmpMdGpnWEVTekNLaUczRVU4UE05Z1pmck1wbHRW?=
 =?iso-2022-jp?B?NWJxWUxpVVZCV3JidTNaUm8xQ0xjNmEwWmRiLzNia3RNOWxPMm5tdFB1?=
 =?iso-2022-jp?B?VXhtSjRzcm1CdDRiQWkxKzBWK1hnaXMyUitYQ2VFRXRDUmQ2N2pqZVZK?=
 =?iso-2022-jp?B?WWRsUGRTaG16MmQ4NVplRWRoUXF4UlR0UHc2NUZPRytNOHZaeTJicGFI?=
 =?iso-2022-jp?B?dmZkZTk0dFhpdEhJbEZXVXdpVFgyZ0pOZlphc2U1emVGL2hIUFFUbGZB?=
 =?iso-2022-jp?B?NUZXbSs5TGdUSkIxMEJJdVVBQU5LL1BrMVpWSjZncm5zMFBRd01nYXli?=
 =?iso-2022-jp?B?ZE4vb05JdUU0K0NhTzVxcEthRTNKbHhLVUhadzV6RFlHSHRwMGxmWVlm?=
 =?iso-2022-jp?B?OFNIRzlzdXVNT2Q5Tm1DTVBBOWlkNFhyMEdJc1o2UkZnMng1RnA2bFds?=
 =?iso-2022-jp?B?b0h5NzZDNUdqR3RzU3A0bHJWM0p6QkRLNGFKYzNIK3N2RDBwMERSMER3?=
 =?iso-2022-jp?B?YllTb1pzOGd0SVJtTzJoWE1YaFJmd3k2QnBMVU1nckgveWcvWmZpWUtK?=
 =?iso-2022-jp?B?ajBWd1MvOFY3dkJTUU1CallTWmhNSjVWaXI3Tmt0SWZNK0FkenptUzBq?=
 =?iso-2022-jp?B?bmhDclBlOG9paDlOMVZtOFdYZnZqSnJnVVVPMGJtSlNXd1Jvbmhqa0dl?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <429F4CF7D8542E45B5075D9A45B811B5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b1b313-a268-4561-96f8-08d94729fcd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 00:46:30.9390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXQFVnG5ZDUr+3l61RZ4UJ/ltqIHSKNGbOjxEFUmHw1TlFFT8japSBLYeE20vIjCf6oLVZKGU3kfn5xx88HlKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5941
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix below division by zero warning:
- Added an if statement because buswidth can be zero, resulting in division=
 by zero.
- The modified code was based on another driver (atmel-quadspi).

[    0.795337] Division by zero in kernel.
   :
[    0.834051] [<807fd40c>] (__div0) from [<804e1acc>] (Ldiv0+0x8/0x10)
[    0.839097] [<805f0710>] (cqspi_exec_mem_op) from [<805edb4c>] (spi_mem_=
exec_op+0x3b0/0x3f8)

Signed-off-by: Yoshitaka Ikeda <ikeda@nskint.co.jp>
---
v2:
- Fix commit message.
---
   drivers/spi/spi-cadence-quadspi.c | 10 ++++++----
   1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index 7a00346ff9b9..13d1f0ce618e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -307,11 +307,13 @@ static unsigned int cqspi_calc_rdreg(struct cqspi_fla=
sh_pdata *f_pdata)
  =20
   static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool d=
tr)
   {
-	unsigned int dummy_clk;
+	unsigned int dummy_clk =3D 0;
  =20
-	dummy_clk =3D op->dummy.nbytes * (8 / op->dummy.buswidth);
-	if (dtr)
-		dummy_clk /=3D 2;
+	if (op->dummy.buswidth && op->dummy.nbytes) {
+		dummy_clk =3D op->dummy.nbytes * (8 / op->dummy.buswidth);
+		if (dtr)
+			dummy_clk /=3D 2;
+	}
  =20
   	return dummy_clk;
   }
--=20
2.32.0
