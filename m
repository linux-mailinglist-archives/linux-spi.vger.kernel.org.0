Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551CC3CB0F6
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 05:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGPDLb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 23:11:31 -0400
Received: from mail-eopbgr1410040.outbound.protection.outlook.com ([40.107.141.40]:30771
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231230AbhGPDLb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 23:11:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk4SgrdA8LdpHgoVh8b02eP09hC6kzyioeqCIE8dEfszgHeApqTQ1i+bbPcBFWW3q1HsFbkBWC7xfSJl6qHIOXLC4KtPMRaF7MmZX8sL7j8FV0Kon9UJ3Evl8NXnIfKB98A+2jgr7tSW/ZC7DaNY0zF4hf7aasSwY3MctxnOKzqJQdZpgAvqYvrLetFPIG4nuRJ3hvg00N2Wa26Cs+UWwlwrooeJWNNBFb5GbjXNbC40RIg2GqQEC0yb5vtlGdiL9GQ080Kri+ii9AW2LS95sUJB5rmO1U2PILZWepUHwuQvtvKCjC+BnYps6KFF0ssmembVUFHjjX4rsX/qA/k9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/HJGWIUnTml9o2T3rc/505IDPDjyT02LFJKolGRB1A=;
 b=lnEAPmE6nE4WJYFKWoL0FD1oy55zFs0kfs3wjnLG2N3TbXaqNfxl9Hz/R5GOqQUIpAb0M548M1lk5LSimZz7/Y9BRMix0NdXZ9DAhs7Soc2Z+eEGxDlVxbBqQXnj0m8g6Upe8+5wiVlKkiDhN1E/TPM9xr+mn/L3Y1coeTqMa2OYqcKS7rBqOraVs2TSOeUwz05n7U8L/QPXmSDw2a2Y/rjyqEAORgcFIN8DomG7o0XttC27FzSfrXajy7iC2A5/j29jjgKzJnOTu15fzpwsO1pZETU5fpLtmYlB9frMTG7+agUp8Qgfaw1emzadeEayCv+9/xS9CDdHl9V2uCGjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/HJGWIUnTml9o2T3rc/505IDPDjyT02LFJKolGRB1A=;
 b=ThQqoa5ehuaPB2vv8DdPDiUr1JI83GzYMFxCK6maYSvDnJFci9uL4bykmGXbaYqxdoRqYRF5nC3AVZj+Tqvzx6NBWXOjyWhmsnK1q7Tzd+tXHmqullxlXJZ/7hWdiIR3CDz4W4T7wfaYpRk+diOx/ZoHNb8FMlwy0BeGkuwu6GY=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSBPR01MB3397.jpnprd01.prod.outlook.com (2603:1096:604:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 03:08:35 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 03:08:35 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH v4 2/2] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH v4 2/2] spi: spi-cadence-quadspi: Fix division by zero
 warning
Thread-Index: AQHXee/dj3Pe0gvgLUKcPSxBtVG6Cg==
Date:   Fri, 16 Jul 2021 03:08:35 +0000
Message-ID: <958bb93b-db83-b685-5fa1-8e5dc40a5975@nskint.co.jp>
References: <d3deb78b-fb30-ff37-bc9c-2ba7b8b40c36@nskint.co.jp>
In-Reply-To: <d3deb78b-fb30-ff37-bc9c-2ba7b8b40c36@nskint.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: nskint.co.jp; dkim=none (message not signed)
 header.d=none;nskint.co.jp; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c1947bf-34af-4ff1-6c44-08d94807004b
x-ms-traffictypediagnostic: OSBPR01MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB3397E7412E4B225B847E953C8B119@OSBPR01MB3397.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9oh3A/ivA3ZmRQARYrwOlj9ZgzOoQJUmMmr4hwrX6YPxomqL/JNpQfRJn8qrAD7ivvMuFM09LAEaPe/UBc0eYcUachyQ5xoQA2yFBvgdjiBgKXWPks5dbRJZmoxJ2KecyoHCzFuGy/Fs3CZYflWST0RJN3YUWakG18u9M+yTkjLbbSPfzQXSHhGV8PELS2oIWqo9TY4aZ9u9v9sBKUFq61RZGaBPEp5fovqDHLHFCCA/oqUPPetCjB+a18kXKkHxledpuFKyR2FI/9pI0b6uoTgGX6D69A6vxC2q+s/GeIeBwGyeBrdKTC1eotXCyjUeCmj/VZSPNx10nB7BjU1IeoDxGGckcTePPzKUZyahMzYhtOOstR+hEjr2f8lxmfRy1GBZcyaiOdVdy2+7a8Jl4+qR0f0pmgkk760hC72467qojrz8nAcD9q3aT/vMnu6njtJ2FYYdLQRiazULlW+cYXQv3EICIkuZOvsciEpbhV3IXcnwwE7t6aUXcxbTH53mpR4jvX14S8GEMF1dTVrdVnvRMlZg0yjj8T69ZWryw12arZ417YQbi8rhhFPxvlpfs/sF7AtlCK5Wd47u+Zzgleb3jmuQKuBoiF/ZxtjDSmMmcSKgcCr2YEGf5kbZ9G2ZSWpnaDTVfcP5jXxVibnEQ4+uvoOp9+8jNH1WuxoJyyOS9/JTGcEh7dOdpBER2Kl4UguKdfeOttIojSj223iLFbWRLefz2EZ217PNAoApG1JaYgje8xVWd+uz1M8vCh+f9kBXlsFX0u0kJNbrMAXrTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39830400003)(346002)(376002)(31696002)(86362001)(26005)(83380400001)(54906003)(6916009)(107886003)(76116006)(6486002)(64756008)(4326008)(6506007)(6512007)(66556008)(66446008)(36756003)(8676002)(316002)(66476007)(2906002)(31686004)(186003)(2616005)(8936002)(478600001)(66946007)(71200400001)(122000001)(38100700002)(5660300002)(45980500001)(43740500002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MkxGeDZ1Z2x1a1RjM2pGUU9SS2FoSWpLdGJpcHhubXdSSURuVEVROE1s?=
 =?iso-2022-jp?B?ejZuelNvOHVMbEFIc09XalUvVnRWYzIvazZoN29NNnVnc1kzL3NQbnVp?=
 =?iso-2022-jp?B?ZTZmcnk3NmIwRGtZUW1GNThHNXFQd1NnZTZzeUZndUFYY2lwNGxTSkZ4?=
 =?iso-2022-jp?B?MlM4VkovTVBWMFhvK2psUkluUGRQUEdib1JvQmRsdHJ6dm5qN0NlRnBn?=
 =?iso-2022-jp?B?QXdCOWxSWEpydFRLdW5IVDN1U3ZiWThtbEtHcXB1UzlUK3d3ZVFYbEpR?=
 =?iso-2022-jp?B?bStpNWM5THVma2lPa1Vzc1BJZDFrMDY3M25UVk1yMXEzVk5QOWJqL1lM?=
 =?iso-2022-jp?B?WWNuSlFsek1ydW0xSlZQZUZJSnI0YnAvbEs0S1ZkK3RWWU5FcHNmWE04?=
 =?iso-2022-jp?B?aEdFVFdkQjF0SG1WNUhGdEdyTU5WQ3BuVzVMZmZUSFpEbUVzdElnQVRG?=
 =?iso-2022-jp?B?TDIyakxvQ3UwUURYMFVQUjhtUXF3eFA4YWtqY0h4Q3l3TTMwUmZmN2hr?=
 =?iso-2022-jp?B?UjB1dlBpWWdFbGV1NE5OYTliZGVvYXBQVkxMNWI0ejZSVVVya2xUTko0?=
 =?iso-2022-jp?B?Z0wySGlTZmVYT0hyL0QzdnBUV09oWUt4RWZtdytNa0dGamlhV0k4TnQv?=
 =?iso-2022-jp?B?TEtKeHZiYmVOSUVmYVFiRVNiSDZHaHEwM3lXUkp4VTVncVc1S2pEN1ZR?=
 =?iso-2022-jp?B?WUo0RjhveXRTWHpJcE1wYUpIREJXQnMrbisvSnFLS3ozNmgxSmhUM1di?=
 =?iso-2022-jp?B?eE1PVW9uMXhjdE1seXJPSzF2NDVoMDdCdHdUTS9qaFdXRTdtRFpOeG0v?=
 =?iso-2022-jp?B?SlI3L3U4OG5kV2thWkRNM3FEOUtyRHdsYVlVcyt1cmVKL1NhL0VZT29Z?=
 =?iso-2022-jp?B?K1VtTlBCd1doNGhXUG10aFZyOHZzYkwraTU0Q3FSRlpnd2JVVlZEL2Er?=
 =?iso-2022-jp?B?SUtmZHFWK1Z4cHp4WWlXT0p3R0JCbnAyRFJpdU4wNVdNMnZpOXRKN2lB?=
 =?iso-2022-jp?B?MXkvdzMzUmVlYW1PNVdVa0pva25mMWdOd2NiTytGVTFRaWhvVkl2REpo?=
 =?iso-2022-jp?B?THFNanV3L1k0L1kyT01YY1o4QXBxUktnOEFka3M5Ym5TU0tySGdNOUQ5?=
 =?iso-2022-jp?B?alR2d2FzbFh5WTIvSVNEd0FDSWhydnY1azF4SVB1WE93Y3RscDUvMll1?=
 =?iso-2022-jp?B?K2MvV2pJS3ViNFhsMkptd2hFQzgwd2lWR256NlRSeXhiaitFRUdTcmd4?=
 =?iso-2022-jp?B?cnA2UFVDM0FVaDNPWnBLN0JlUzZYOHFORktjODloMDIvNVFDK2NsRlQ3?=
 =?iso-2022-jp?B?ZDhDcUFha0x5eG9zSXNWT3FWZ2hYejhjMzBsT2pwMkhWU3lQdS9BV0Nu?=
 =?iso-2022-jp?B?RVh0enpaUVAyV0NXM0s2dFBxTDM0amwzK2RsaDZ2NmhSMWo5WFk5YjdG?=
 =?iso-2022-jp?B?eGVhZjZWcC9OOEJiZERHWTZtRGM1eDNzTFpyQUFxQ2svSXF2UFQwdTJ5?=
 =?iso-2022-jp?B?KzdWK3JRZUJpczVJc3ZETUVDZzA1bElVOWFXbzFZSFZaWkRRV1JlWkZa?=
 =?iso-2022-jp?B?NkRuVzBibUR5S0lTcVBFQmljSEpaQUZYYjVvcmhVSFU5TXJSS0w3THRj?=
 =?iso-2022-jp?B?OUZmL0I5QnhTZGdTV0g5eWFYYkF6WlRZQnJwWExrTXB3VnlQeUpTZmRO?=
 =?iso-2022-jp?B?ZTFtMWtMclRNa1AzNG5xOU9xQS9kMHJrN1lLYmJQYUZIMlUrSTZmUXN3?=
 =?iso-2022-jp?B?djI5T2w1a21oY2Z6djRjT2tBdE03Ymk2TWFwOWxhK0c3NGc0RG1tZ2hH?=
 =?iso-2022-jp?B?bWFyUjRXelZsNjhVQmxJWnV2dkJXd0p3elRGR3hKY2JkR05vY3BySFhE?=
 =?iso-2022-jp?B?SXJlZE0rM0MwQ2Z3MXU1QkczdkpIVy9tOVdzd0RtZXBwRXJrOCtjSStt?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <1BB8864EDF195B4EADE99CDAAE482F92@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1947bf-34af-4ff1-6c44-08d94807004b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 03:08:35.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXlPMaR9oEH7tSlP29L2/fLMbd2C9vZU70g1XoKeqj/jIupm8FAgw89OD+BQM90PVsZ8BefgIsEu227KuEs4BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3397
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix below division by zero warning:
- The reason for dividing by zero is because the dummy bus width is zero,
  but if the dummy n bytes is zero, it indicates that there is no data tran=
sfer,
  so we can just return zero without doing any calculations.

[    0.795337] Division by zero in kernel.
   :
[    0.834051] [<807fd40c>] (__div0) from [<804e1acc>] (Ldiv0+0x8/0x10)
[    0.839097] [<805f0710>] (cqspi_exec_mem_op) from [<805edb4c>] (spi_mem_=
exec_op+0x3b0/0x3f8)

Fixes: 7512eaf54190 ("spi: cadence-quadspi: Fix dummy cycle calculation whe=
n buswidth > 1")
Signed-off-by: Yoshitaka Ikeda <ikeda@nskint.co.jp>
---
 drivers/spi/spi-cadence-quadspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index 7a00346ff9b9..d62d69dd72b9 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -309,6 +309,9 @@ static unsigned int cqspi_calc_dummy(const struct spi_m=
em_op *op, bool dtr)
 {
 	unsigned int dummy_clk;
=20
+	if (!op->dummy.nbytes)
+		return 0;
+
 	dummy_clk =3D op->dummy.nbytes * (8 / op->dummy.buswidth);
 	if (dtr)
 		dummy_clk /=3D 2;
--=20
2.32.0
