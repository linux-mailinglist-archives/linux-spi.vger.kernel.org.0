Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF28F3CA22E
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhGOQY1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 12:24:27 -0400
Received: from mail-eopbgr1400084.outbound.protection.outlook.com ([40.107.140.84]:6976
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229518AbhGOQY0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 12:24:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQoV5rcTniXlG/bXKIKhqIIOhdlbP4JnVbCcLtp09DB6mvqK/c2xeiLznjjf0rbffqGyobDp1GnC2F32+w3WDYGwUoCSAGVfY1lnimlOS7oDxkHMt0rhhdeNPHSLBGu69ssuPyADFAl3nnW/qqtUIAlF3HdwediZ6RcC1cYuWF4sm+Id4vGqH06DzmXSiY5KFp2tXF3OqnoWsDBziNG2CpEaSIL1Xxet+2pv/zJDy5jUbqcvOKwwBejRPTOruHPAc0sVJM3HFIz7JNawK0s4Dpi+w7sEmLQXv0UHoCw14Uo37keXXf0NXiBijFBw8IJM2WHVW8ht0XzLeFtqBhGPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9NIP1owCmu4yF+rLq+e74Z2+Al3IPxGEAUGiSF9eQ8=;
 b=HWVBZiNiJL9D82qusXv4PSWll7GBxp0h/UlDIzf6ozx4cOvDOKQXgtA8FOf/7hF30J/aaAk8XunYMEA4TLjBdWiQgIipHgYU6KT7gPUNR6XcjR/S6tgZ4ZZXjp/keE1UHMKv9ojUaES0JyWvwJcR0QZxdKMmOWyAtq0WBzQEtcKkyFiDHsx1VVqs14cHh4eLORzYF1pMGP9ZrVysg0cUhGyJm9DPqsyPcCjDZFeZbZ+JHX1A8R1WWnc5WE0wk7DA2hhGjVNO2hWzVA1FUFlRlpui1u941Fx/QBp073v61a5rE0AKZUzbNyEtg3faVTk5BMWNCXCTRGbG6ovF0QVNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9NIP1owCmu4yF+rLq+e74Z2+Al3IPxGEAUGiSF9eQ8=;
 b=e8fhNXaltDkQ88tFHUUhcugfo3nIk5jPy0k36oldXw6SoqKo5qY8RhZ5SB3Ann1z4RaatGxoHZTBNHst4fZbTPnWYbNcjuicVHpz4orGLXmorFDD+BBcIy/hnvEuhd27rN32e9ayxB6KqDT7IWm4fupMbLR/wFLyw4isii9YB1A=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSZPR01MB6566.jpnprd01.prod.outlook.com (2603:1096:604:fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Thu, 15 Jul
 2021 16:21:32 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 16:21:32 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH v3] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH v3] spi: spi-cadence-quadspi: Fix division by zero
 warning
Thread-Index: AQHXeZV5q18FbZMuSU6W5e8ubdQqtg==
Date:   Thu, 15 Jul 2021 16:21:32 +0000
Message-ID: <ed989af6-da88-4e0b-9ed8-126db6cad2e4@nskint.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f0720ae-c6ae-4e8a-cf91-08d947ac9bcc
x-ms-traffictypediagnostic: OSZPR01MB6566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB656607E24030541055C8CFE28B129@OSZPR01MB6566.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:337;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: an57FWZ2OCKVXAVAaqjM1AzTALUNdD9AxnkTjsj66lkKGfdWzbqx4x2l9JeL2+cK1tbVnq9IQVvfYrWdNdqeaBxV0DT8HsPeCZSEhp1yKy6eJa+cy47q8IbOlU2GwC/qUUnWs5bjbMnH/JDjYSkGoy54mEVzkAMCHugJlYa9OIy0WlTkSL4HHuHPvxhil8hRPZaW3PzmUwzI3tj9t8uZIYIXlpWsSQoi3VG6hkSajCtAA2u0ZhGqpJr/UGpEsrijt4KGeS/jy1jo3HwiCdHh8/mZ1EXAN9SxmlCNaVzDFbBRSBaiXnjpjlbklVavZIcu3R4LIVJbCQh0nwLM/8RzTXXRW8ykyoa/mSKCTsZzZHqjpEmpeoG076D6kibZQ/Ve8iSXP4ew/NyTCs0BQLKg+9/FyBlgt5ylyoEztqG+sa6GFv/fKBWgWoXufG9BAUWoq6eq4sjVzTSkLHu5ot/Zz3ReIbT/yvUkShsd/y7NsyXnwUD8W3KISMoVS3DP3/mWM0yJHd3ty8i9cu2kNRNZc8IHL4k7H4vsS0QPmciFsXbVYmhwp3SFtu2zScHMYv+tFuXNnQyYaj2TQyOD4V8ju7i3nCBV3v3x9ekFENz1W8YqBU18XBBz12xD8elqLcZIHW/oN5WIF6ucXm/qDcnh2zEJjrh1vqqzW3g+efjgsBiWxb/2Ag2tw6rQ/IpBgLayltiLi70q8YDXEAQ+jWj8A6k2hEbWSptCA2VdCMe37l/Hdj9j0nFW7BrvpUnRje2++mkWj2LWKqZyq+dWXvwHig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39830400003)(366004)(346002)(396003)(38100700002)(122000001)(71200400001)(186003)(54906003)(6506007)(64756008)(76116006)(66946007)(26005)(31686004)(478600001)(316002)(66446008)(66556008)(6916009)(2906002)(31696002)(2616005)(86362001)(66476007)(8676002)(6512007)(4326008)(5660300002)(36756003)(83380400001)(107886003)(6486002)(8936002)(43740500002)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?R0FXcUFPMHNSQWM4KzNkSktpUHZtcVBvT3JFWEgwTytCUktGaWt6UFp0?=
 =?iso-2022-jp?B?Wm5OOWl0SW9QVUtwUDVHREtwQnhaZ2hSY3Axak52T3pVWlBiNkVtQmUx?=
 =?iso-2022-jp?B?L1N2ZmQ0V29tbDkyM2Vud2x4RU1zSE1aTHhHRmpBUHd3dFo5TnZETXhP?=
 =?iso-2022-jp?B?K3Y1Ti94aThUQ3paQkFuemZBQXcybzk1S2czdlhseC94VlkwNDd5T1J3?=
 =?iso-2022-jp?B?YUZ6bkpmaHdZbGg4ekw2Sm81MWtTNWtvT1R3SGEwUGx6azRtem9jOVhy?=
 =?iso-2022-jp?B?eHNpZTgyWFdYMjNjbHZXZlZNeC9qOHhiZ0JBNnZWMzhPUHRIZzN3eE1K?=
 =?iso-2022-jp?B?YlRIRkJGS1UwUFVqRVBCeFo0SFU5Uk1VekVqTnZGU0hPM3V5Zmx6Wllh?=
 =?iso-2022-jp?B?MExnQTNzSWF3QWpTMUVLVWF4UTFTMWcreHM5YzI2MlJ5dXJNRlZGeEhR?=
 =?iso-2022-jp?B?QjZXYmRGT0FkR01DL0oyUUM4Q2RaOU5RYzA3WTVwUjBWM1hud0Q5Vm1M?=
 =?iso-2022-jp?B?Zk5OejY0bkFTcEFsNlkxdmpNQW1UMEpHc2Y3b0xzM3lTYXpaMllCVEJq?=
 =?iso-2022-jp?B?U1hUclE1Q2dzWUNsSXhVdWQvUnRQRjFMLzE1UTFBUnFFYWljM0pNNDNk?=
 =?iso-2022-jp?B?RUE0UXdLbHFZZ2cyOHJkOXU3VC91UmtvaG90amJ5Q05URXRXbDM4cmsw?=
 =?iso-2022-jp?B?SmRsdGJkdzA5dXI2aE1rd2tzVTEzelNVb2ZKd0ZpL0ZRNVRvZmNwRjh0?=
 =?iso-2022-jp?B?NmtmSXdwZmtKTUtQMGU3ZkFJWkZaN281ZnB2SWt4dHNsQlltQ09xR3Bj?=
 =?iso-2022-jp?B?a0Y1UzlNazJscFBlVWxQNVUwak1mRys0bEVDWjFGNnF3bC9Cb0l1Ym8x?=
 =?iso-2022-jp?B?WDVVRktUaHlxUThiNlRYSGIwVmo5Slk3Sys1T3J2WHIxak9aRmpKVUR1?=
 =?iso-2022-jp?B?blRDakxPdTV2aUp0Tm0yQjBHWjA0VWVPaDNoTmwxUFVSMEVmNFJmTExP?=
 =?iso-2022-jp?B?NmxMTFBBNGI3SUVLWURmWEtDZndLVnFNWDNnYTBjdFNYRGFNbkVFZG16?=
 =?iso-2022-jp?B?MnkrTUoxL1EwdFlhbXkrOEw5TUxvbWVuRDNGcXBNMFdPTTRKRWJDbmov?=
 =?iso-2022-jp?B?VXlERis1TXAxY1dIQ05oUEtZMVg3a2hBMjFodFlodnZsbkxXd2ZPLzEw?=
 =?iso-2022-jp?B?YUw3NmlmLys3T3NOdFRZcmtpUTBtRlJkNUpaRTNkMGJlT2lHN0FqOEU2?=
 =?iso-2022-jp?B?U3hhRVEzaDR5d0lDVjI5aWZIQ3NyWnEzZThBSFVqNkg0WUZlaVR5c01H?=
 =?iso-2022-jp?B?aDQxbjFaMnVsR0Z4U1dteXV5ekNhS2luVVdTLzVad0ZpR1lKeStYSlVq?=
 =?iso-2022-jp?B?N3haNWZmUUNXMnovNEdkUXdpNTBqRExRMmp3d0prUFg4akZYaGVhdzY2?=
 =?iso-2022-jp?B?UG1VVm93cXdMVEphbTFxbStNOHBwTnRVM2NoNEVaUTlrVHpiNlJ4cVo3?=
 =?iso-2022-jp?B?dUVMUE5oaUdOUmM4L2pjMS9xSldQbzRDdGJTMkxQb1hpZXdZYVc0SlBU?=
 =?iso-2022-jp?B?cnkrbWgvWDBzazRvbmZCazk0OXkxc3UrSGJRR0x3SXZUVU9tZCtaaEtu?=
 =?iso-2022-jp?B?R2dabkxJRmg1Y0V5aHA3Wkl4VlEwLzNRQlQzMWhpcVBhTnZua3hXM1Rj?=
 =?iso-2022-jp?B?V2Q1cmRGdzhULzU4Wml6L3dzeW50VFdWdEhnR25IcTdQOUltbW1sVUY4?=
 =?iso-2022-jp?B?OGtKMmdzWHgxbU5yMnQ0bXNKUy81dlFvdFhQTHZNZWtvUHFOeW1RVHF4?=
 =?iso-2022-jp?B?Mzk0cUtPSkxGMlQrTEFXWnRsR1J6NEp3ZkFSOTdPQzJOcnFzUythQVJQ?=
 =?iso-2022-jp?B?RjRqQkVWTUNhRk9OQ0tTQmRFYTcrSDg4cEx4UG50ZkxVSzRmM1NyN1NG?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <CB217A795779024E99F74CAB5E02A006@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0720ae-c6ae-4e8a-cf91-08d947ac9bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 16:21:32.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkffQu34+yg6U+cNzT8C0pgXnXzS7149LXdPusTHkOpTK2YwSXnsc0YbRybCqxVpgGO9JvUBTxz3TlybDLZrRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6566
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
v3:
- repost.

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
 static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr=
)
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
