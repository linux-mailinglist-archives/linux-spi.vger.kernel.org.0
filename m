Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E633CB8C4
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhGPOiK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 10:38:10 -0400
Received: from mail-eopbgr1410089.outbound.protection.outlook.com ([40.107.141.89]:46018
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232988AbhGPOiK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 10:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fal5tWAMS0lY/iRy2t3gZT4GKnF92kV9Aqu0Xmx8cyOvSwIWQ39p3cyrF6nKKeoUkLuaRk+fQfg7rcvbfoXSq62QHLy3ezzJCJ8E3ZeYMKsZdklTrCvqYnkuUxj1U+cpNwc0Kn54GsyDegiyLRSChYDQyMhO/6tmce2jU3uFowGQdPUc+OCd/tucKMUc72zzT2nnwd6Y2sbUvkZJ59Bn5oq/vohEpNSICpepcJ9X0UlY9smpRozXBLm4sF+mO1J/V1kpayxVVQLEb2cUEHTNktXo4WXavKVCx6DP/4+Fp5lR0TmtxMmRhWaykYtNgQmZbJZMnDlgQAAtCDpKBX32fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOoX0RERd88j38vnZ45RHCQXZXrL7etzrOmDg0pIZug=;
 b=YH0Npxaok0FcF436q4meN3anPAWwXZU+1ab80Jj7TayO6MYV8AdWWrzmWgk1SEcns7bCEBbnKo3VdyO4Ym4603ChsyAfqvl1pBds4Npfa6OjY+5wowTc3SvnnhmCWHCNamS4C4RPjiBHq/TmKDg5JSItbC3mRsruowZssmDWJitS8laGs6ULzec8/g9ROImAfPnv1sIo5jvuRt7AKDYWhu26vruyZq57IV4wWL2Mq6WTpUpYz27LS0s/g8q1UADmxHY1JYRLq1tmJN9uP66s8sYUMdq0ziJk7pKzbNsNmsGR5zUZZcChZmrL33EO1IOUGXI4NpNl7m1aEUake2BLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOoX0RERd88j38vnZ45RHCQXZXrL7etzrOmDg0pIZug=;
 b=PqGNkAGmZRRqaCKNjS1tNt7hDWaN4tcjnbNCBEqfuwRBFtmzRmvd87xdyLvxxDaIejeOI9EAuZMZgLHQrq2a56ag6ow9ZtvVs7XqHvFdxrk5aDuJjy9TNRPNQaB25a3qKhgKvOqtHB9wTlG8pQNmCxZxfLgotcJSSjRIleJ1lGE=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSBPR01MB4278.jpnprd01.prod.outlook.com (2603:1096:604:76::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 14:35:13 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 14:35:13 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH v5 2/2] spi: spi-cadence-quadspi: Fix division by zero warning
Thread-Topic: [PATCH v5 2/2] spi: spi-cadence-quadspi: Fix division by zero
 warning
Thread-Index: AQHXek/JTWLD5iZQsU64LL3ZCMDkDQ==
Date:   Fri, 16 Jul 2021 14:35:13 +0000
Message-ID: <92eea403-9b21-2488-9cc1-664bee760c5e@nskint.co.jp>
References: <bd921311-5896-b228-ea6c-20e11dfe62e3@nskint.co.jp>
In-Reply-To: <bd921311-5896-b228-ea6c-20e11dfe62e3@nskint.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: nskint.co.jp; dkim=none (message not signed)
 header.d=none;nskint.co.jp; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7de8799a-ddb3-47f5-6bf7-08d94866ec2b
x-ms-traffictypediagnostic: OSBPR01MB4278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB4278EDA1BFE4BBC8C431ABEC8B119@OSBPR01MB4278.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3EtXWmNq+66GCG2++RS930YqhJA0DPQxH9nHzn3n/8OUAB17ZRUuzcBwGw4Q7M1f5Zuy7LAp16CcoSvp7+luu68MVaet3fxl0G97pVAxnPf6YSqMwE2ElFSnTrTEbRZKql7YNMrQBzT+0LC7I99443HuzmICF2x/ssvEsvpaSUNy3zAeL1lSAQRlW2pqxyNQaG2IYB4lnk/Cc7L3/YtuR9DxRFBP2dt+PomMPmy5qDIm9MFk4GVsBAXxe5apsKETGMyA0zgifLpCkWL15/chGFMpjFrfr8izOsnUTrCvDuoXjBVqp9DXFK2libT/5tZ3zVOZ5JLxjnqehizEzBNe+UJ8lia1O2KV9VoKgKOSOYCHoTmFEcl4/4mjL3aqM4lU5ew1x+gFs4kIyyM5NC4ThWBbkOx1orRDNafJCtelYk9nZ7/sPRNSTmj76zxqzNIWe94QoD8e/NwHyU2qTsOrymknXEsFHjJw+RVax8DM+LetyfJhWHH48oZE+cwqOhsx3+OtTTDF8wMEEpXLdYTZcUbcr+7b4wKBzan6lXBf4FSEnVzmnnPRC9DXXmuv5Rt06khbHsDT7aFmzMjwnGNXpK0TetJWXKB2r4x6z1dCStTHkXzdboErMrEi58QMvxSvVJxjulpZSyU7xTqFQvdRfc1O6ObEJrpcWgLK+4IgTVzpkBOrbt1QQz07NGeAoeYoeCnbw1FSd5Hgw4gNo/GlxAVNjg1qH257UG0JU2YhjA62vJ1zZpFWTAL+nxUyWZLVgYMiIJiRTPW9cDVusxfNKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39840400004)(136003)(366004)(376002)(122000001)(38100700002)(6512007)(83380400001)(6506007)(6916009)(54906003)(31686004)(36756003)(31696002)(107886003)(8676002)(86362001)(8936002)(2616005)(26005)(2906002)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(6486002)(316002)(4326008)(186003)(478600001)(71200400001)(5660300002)(43740500002)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QVliZ1l1UExRTlVuV0NrbkdwZG14N3JvL3JXbXZHcXE0YTkyNnRMMlcr?=
 =?iso-2022-jp?B?MWJsOVdqaTcyNmFGa21EbjE5WE1yN3VCS00vYVk2VDdKN1RrY0tGbXQ1?=
 =?iso-2022-jp?B?OFJkSWFobU0zSTF5WXdQb0pBS1VFeks3N2lnaldMcldSTVdKVyttdXdh?=
 =?iso-2022-jp?B?VFZmN0ZqZmxnNGRkMmNtL3NRZmtnc2pVNHhxeDZpQitrK3lDMnFIOUow?=
 =?iso-2022-jp?B?UHFoZWgrT3NRbDRIbERmUjkzZ1BDTG40QmZLL2YyRWV4ZENBdEhJRGtC?=
 =?iso-2022-jp?B?R1lNM1BVZ1Z2MWE2Q3lSVlpMV0hJdGdncnQxMkRoOFgrbGNBd0NtbEkr?=
 =?iso-2022-jp?B?eDZKWDNLTFNzV2trSFpLOTdoNmxGZmx6bmhoWkN6TVlHQmpRNlNsUU5U?=
 =?iso-2022-jp?B?eURiYUNYMkR4My9wa2pvMTA2WjdEYThJWTNPQ1FDT1BHVHFyWmg3am8r?=
 =?iso-2022-jp?B?VzZiQ1B2YnNZYTFzSDdOSkpmQWZzcEtLeTdvc0tiVEo4OUpLc1Nra1Vh?=
 =?iso-2022-jp?B?aWFvOW1OWmlNaS9IQkRmRm5xTHE1QmF0MStDTFNtV1U4eE9SeE9mZXdG?=
 =?iso-2022-jp?B?TFh3WFJKdWE0ZnpuY2xFN1YyZ0swejZzV0Y1aUlLS1haaENReHl1cTMw?=
 =?iso-2022-jp?B?cmtkTUFWM0xQT3BvU2FCMmFIT3p4NnQwMk1odEdHT2NobWNaaUJVRkMv?=
 =?iso-2022-jp?B?Z01QQ2lERFcrU0Fwd3h1Z09EeTdOQkVuMFAwdUFmNnBIenFaN01RUUVN?=
 =?iso-2022-jp?B?YTVhZmxRdVc0Mk9jdUVzWW9PcC9FNUVDRUU5VmxnRFJQcEZYRXZPWnVF?=
 =?iso-2022-jp?B?THo5UFZMLzhJcy9vMm9iaVEvMUkzTEtEblgyd1NKelNLTmd5WEg5c3Fz?=
 =?iso-2022-jp?B?TE5sNWxUWFdqVkFFdjRqK01tSTBnKzRYQmY3dHRKNHlBUUJ0bnUzUk9V?=
 =?iso-2022-jp?B?M2JZT1NLMm1DY1h4WXUzdnlTLzl1MnkzUENNczFubkp0d2hHMmpNcURh?=
 =?iso-2022-jp?B?empIV3FOaXlzVmZhdm56QVVwZk82MEs0RnBjVHVCeVFYbTgzL3l2UVo4?=
 =?iso-2022-jp?B?ejZvcU5PZVhXeWpKUDhENWtzdXdiaWVCOGMwVHhOSVk0cWVnWmFaUTRP?=
 =?iso-2022-jp?B?bng1aDNJVVZjQ011TmRLM1VrY1VjOERmZXNyQTR0cHJBaEw1UWtBbVlG?=
 =?iso-2022-jp?B?NFJWNUZZMWpKN0o4d21Wb3ZzZkh4U0hqd2ZSOWtXb0ExYzUzKzN2UjNv?=
 =?iso-2022-jp?B?bXFzbXN5M2pUMy9lUHVKSm5sbDBlMVh5NUtRZXVmcnl5eUxsUnJNbUtM?=
 =?iso-2022-jp?B?VnZVTmEwb2VBRk5yejg0TEMyNTBITzNzWFJKOU9XMitrczg1cXFJUWM2?=
 =?iso-2022-jp?B?Y0s4OU83Y09jWWFEVjA5ZnAya1dSYWNPSU0zczh6UTQ3UWo3MCtHVEpK?=
 =?iso-2022-jp?B?Nml0NlJNbFg0T0t4QjZCLytkeXRrcE5QMXpuZklvWUk0czc0QUJZL1k2?=
 =?iso-2022-jp?B?QjZXTHZXUFFFUER3WlVETFpXcW5kQWI5Qno1Z3pramlqZVJVVUVMV2Vv?=
 =?iso-2022-jp?B?eUV5RGpDck1MZ1RBN3VtWDNCZHh5WDFMbUZKOEdOWkV2QldwL2ZPbUlT?=
 =?iso-2022-jp?B?WFRTeUZld3ZUOXAwekRTZWNGaWJOeDVqSzIzaVVCaHlPMmxaM0w2Uzh1?=
 =?iso-2022-jp?B?L0tYNjdOVHc0ZmVLejRxYXg2ZmZZc01qVTRCRmFmaktJNTdwQmxGQkd3?=
 =?iso-2022-jp?B?SjhHS2p2YWpUV0FYbi9jSFpQbmR0NHhtUUhXWkNLSUpsYjVsa2RqMDU4?=
 =?iso-2022-jp?B?QUcxNXltOHdvbWdJY2Z6aXRXZlIwYmZIRjM2VXpjYUlrSnlaNnlGeFl1?=
 =?iso-2022-jp?B?MkswVFc5ZXByN1VvamlXMk9LUS9Bb1EwWk1pRHNlQk1QZU5EcWVSMU9J?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <1563C88FFEACCF4BBEF972AD0151C488@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de8799a-ddb3-47f5-6bf7-08d94866ec2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 14:35:13.4902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkVbphohn+y7FJ2GUa6IqDrUKJFquBtsvwGPLtU1+A1/QlLQegVZDpcq64km2wWa7Uc4C9e/fjL5Ajqt4YYkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4278
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
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
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
