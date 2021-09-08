Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4004033C9
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbhIHFaX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 01:30:23 -0400
Received: from mail-eopbgr1400041.outbound.protection.outlook.com ([40.107.140.41]:2272
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237726AbhIHFaW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Sep 2021 01:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDQPfXYCM7ff9ixMos3wj/RYTIyIG2mpG0JVz4Hd+soLOUr12vDh4K7utT0g1t3t5Vp5BdoCAFVUyFQ4gtiLY0+mUXuvstLo2x1S07k4BHPfQPU7nP9a69NaiToZ2qvWcpg6Uh39Iof/GiMbcSqyrfwrsdR93VA4aR8kHcItR0xLlezuBGp21Vz8012GT91piw9sFisNGEAf5itKP2HZp2ePq8WG0XUz1VNJLBxjd189S8KqPCwE+BwDot2WjrlYosndL4jx8G9GDJr55ocyqe2+utPmxehdvvXxQCAQU6ZPppGjBmcB5uEXEOYIh/jyOlQjK4vmcnvps7wOJ8dQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ME8Znc6SAYhydXRQKZomTJ9po/6UIPJQl0sEpKKR6Q4=;
 b=fmYlYClP31uY/Q1TbbbI12uOGR+YPnw4OEEnOAMJsF0TXkbkDW6bN6qvC33p1z8TaKlH7OHmu5IXJ4ZmeB2lczlHkFLR+pPwJSNZr7cP2iMc0Y4EhFynwsmFr+rXtOnzy7PQL9PCf3oZGrBQSvCSEpr15WymSIw4C3AS8fMjT2pR+xmIKOGCw2UWy/LGof+VuCX1KTUAA29Mtj62eeXz/yTOiBndRizt384CagI1AIUjarPsT26sQn+M2eigCaMK1pV1vE2yN85zFZdqpHvIic0Lzu8PQvXLYISaePYp+2NAJRSCC0ikhh0JJebq8aL0d2e7W53xr+VtW6isGj/aQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME8Znc6SAYhydXRQKZomTJ9po/6UIPJQl0sEpKKR6Q4=;
 b=TDIwjc3X58z1xkW3SK8Q3mAVLyFOKfPHk8uBAnPTcBjjMdpeL/33cVrqwcGgMOUBz0VxFhTccoqUGaTC8cyGb44XZQmGvna/bySb/7cCFbx37GCpa7nDxufEzuYIrL7f5g37IEZjDSWbeb9vx/qOcKg2/YpC8zZA7hCfCyoSQAo=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSBPR01MB4629.jpnprd01.prod.outlook.com (2603:1096:604:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 05:29:13 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::1502:1fa4:2cab:1975]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::1502:1fa4:2cab:1975%5]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 05:29:12 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH] spi: Fixed division by zero warning
Thread-Topic: [PATCH] spi: Fixed division by zero warning
Thread-Index: AQHXpGzgpRfkzD6gr0adyzLhTJ/gQg==
Date:   Wed, 8 Sep 2021 05:29:12 +0000
Message-ID: <OSZPR01MB70049C8F56ED8902852DF97B8BD49@OSZPR01MB7004.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f501d6c-3a9d-4809-92e0-08d972899777
x-ms-traffictypediagnostic: OSBPR01MB4629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB4629A062C59D8003B684B7348BD49@OSBPR01MB4629.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gmgXM4DIMJv0A97rT/uLuohmGjVlljACl+NEorm4JwfQ/Grut72vk+A2Hmkv8ljxt9u838kNwn+NOZIy3hzONNduqOzxNWeCJ1POby/ONG2/5FxlNHtC212N7kAmuuF9M4lOyU59aq2rh2XKD130r//YSnWkZKbuX7FMNQmyAym1qvKmk3TrCYc4UCibz4ust2VhHbuiGFS9mzGFpJXJgd3pFRWOEyfAAKvG5r3FowTY3HS+k/UyMWwZgIy2YY64yD9TrJDmMYNxbrt0P6d4ycMas17td8PaPjyDvNChlkeWJTp4KHlP/7HQkbiU7Mrvq11SZqoY57/L1NHaUUh8+HiPykNGi9BfUD/oitZlOeNjptAzTq6Q1gZMf+bC7ECFQ9ijrVQYNp/dFiQ/pIDpYEl/6k0n/g33RFUiUNKi/7wRnI9QDvvoko1TaPBPKrzpeu/ap6V1RNpdTpMHStpbArsQBbzwSfyW1JEio6NgAVJLnySCx+/NozvY4OmwIleeOJfPCGlXtNwEn2FlFrjhickY+Ky0rUhnOSfGvDyag/SzzJ3xUAb/kUrbOtycGN7L8tVOmUo5wfWP4CxznDFEKoc4NrgcKLEI50k3fNpFIcpRob1Gv25ZOee/S+Ypph/7k5bUnFwhm8nq6IoewpBwl0XDRywT88pW91u4GBujLwkRXXDeMk85r+gyZ7kmiICRMeZRUE2vCm7yVHy/ygFk8d8AY2uCGab+spWqVEqhsM1/xUsn21ApU/9LXSwvcDP97e6/mGjqkGqbDEcm/siqKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(376002)(366004)(346002)(396003)(38070700005)(54906003)(55016002)(478600001)(316002)(186003)(8676002)(6506007)(64756008)(76116006)(86362001)(66946007)(5660300002)(66556008)(66446008)(71200400001)(8936002)(66476007)(2906002)(52536014)(9686003)(6916009)(83380400001)(38100700002)(122000001)(107886003)(4326008)(26005)(33656002)(7696005)(65966003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w/tHePExRxx8HlilAUay5xbdeIOhi27Hj8rBCo7uH6U0w0QyjJ23ayD3JHTC?=
 =?us-ascii?Q?u2s8zzqYpwDqJYsuhCSJHAeKRJ9q7J9iZ+YGlCYpjAODqTN9MOf1tsfZYZQJ?=
 =?us-ascii?Q?5nZVk3cOcTV9Z4X0qLVTMC+lyqlUD0kW1jZUyHIWnH2HuMuQatqWNMvcHUY9?=
 =?us-ascii?Q?BkUGiHbcE2DqMRtqtOPvu5Nmmhg8l+vQSbh36ldd2l3wgzoozQV29zvdqx/4?=
 =?us-ascii?Q?D7R4YEYDcOuN5fPIdZEx3R7jtX6NH0PjmujoZUnuRSBKn8EAXAiWu712fjKC?=
 =?us-ascii?Q?oi8EERUjxYYhQz25Da/57aXjhM4/IpS9WD6F95jvbMqxolOxC1hVgBvmeenc?=
 =?us-ascii?Q?RP2v6PTs2cnvQtHOeOhkdgDqMn8g5sU/5WEhtqJawtYmNnwtiPrFPS4WiOl0?=
 =?us-ascii?Q?LrF+IMUfntcbyW2qcdOMkR/5OyJJicCto5sv8N7b6vQkG642fQCVHuSvTYY1?=
 =?us-ascii?Q?sTH2QI38W7WeBmo4NUq6FgJ+Kk3O2riF+XNppIRgybTV4zgFLJlCghcFm/Ym?=
 =?us-ascii?Q?5iLON8Lq2Yq6901s8/9Z25pzBKxf1exZUbQKBy2QdvIuLZssfP57XxamD2OA?=
 =?us-ascii?Q?1vNtvSa+l1mYM2Z9EUaDNapQ/Wk9+gcFg41TH7h9SXLna/A7lPt1LAWVGUh4?=
 =?us-ascii?Q?QQR9lpwhMK3YGOpewzY0b5vHGuuaMpuU6pXrsOJ513ST182IoHz8cKKk6M4w?=
 =?us-ascii?Q?znU9UX0gHFCpjsX6Pay1vQ3qLq9EjGHlSiY2YzAYE7hK9gyLrrRFObaKg6Iv?=
 =?us-ascii?Q?GnNxgG393inziTtMqC9rreTiyR10TOgUGw7SfwdxIJJ57UKBHHVy/VyhOiDw?=
 =?us-ascii?Q?zSgi797K3AjzryJHm30HUqpEzjHYAYuRoVunaupbpMW7pwNXKTu+WWCojttJ?=
 =?us-ascii?Q?fm+6l9loZstTg9kzDR4542dHtPn8vPIvip6j7iktCeiI4XNdOAdFO5jFO0Me?=
 =?us-ascii?Q?dRCVC6qox4MO9WEALlKW4ziyt3RG+WlL+wwP95MVzgOujA3IH4nkSyf3DivR?=
 =?us-ascii?Q?yX+bfbamzKzfrkm83N1YmqWyfDheM3+BVe3TptD3SkT2h4Rf9gQOqFXKvOJC?=
 =?us-ascii?Q?4fW+rpaMfLZa0uzoT0fes8PXrJziY4wHmEEYPE1VFHhI15tgB8kLOcM7ysrO?=
 =?us-ascii?Q?nA1kOOKj3NzzFjC2rPNqAf5U+Q2ZThKTFibqcoTiMFxKmKkA0hr0vIIZv8Ay?=
 =?us-ascii?Q?ir65N8L+wcpe7HGaVOFmGNf9JEPqelxrEha++izT6hgfKw5vcEEqYI7QZPMo?=
 =?us-ascii?Q?uJl0/ADxGbPilXY8nI0BI1MymFgAYC7qOSip1w7MEMsjZtCh5WNTcs35meqZ?=
 =?us-ascii?Q?ZXVqbVk5+ajOD9jOcO3uncHC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09F168E73405CB4A9CE40C5AB6D4F915@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f501d6c-3a9d-4809-92e0-08d972899777
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 05:29:12.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZ0LWu43h+MvHI3STxeDBSudXNy+ngUVOPKjzX5wya4TrTzMfarCgyRt7jDWeco1/2zcQWnBNNmLhsgnzoUCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4629
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The reason for dividing by zero is because the dummy bus width is zero,
but if the dummy n bytes is zero, it indicates that there is no data transf=
er,
so there is no need for calculation.

Fixes: 7512eaf54190 ("spi: cadence-quadspi: Fix dummy cycle calculation whe=
n buswidth > 1")
Signed-off-by: Yoshitaka Ikeda <ikeda@nskint.co.jp>
---
 drivers/spi/atmel-quadspi.c  | 2 +-
 drivers/spi/spi-bcm-qspi.c   | 3 ++-
 drivers/spi/spi-mtk-nor.c    | 2 +-
 drivers/spi/spi-stm32-qspi.c | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 95d4fa32c299..92d9610df1fd 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -310,7 +310,7 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 		return mode;
 	ifr |=3D atmel_qspi_modes[mode].config;
=20
-	if (op->dummy.buswidth && op->dummy.nbytes)
+	if (op->dummy.nbytes)
 		dummy_cycles =3D op->dummy.nbytes * 8 / op->dummy.buswidth;
=20
 	/*
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index a78e56f566dd..0d95fe54b3c0 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -395,7 +395,8 @@ static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi =
*qspi,
 	if (addrlen =3D=3D BSPI_ADDRLEN_4BYTES)
 		bpp =3D BSPI_BPP_ADDR_SELECT_MASK;
=20
-	bpp |=3D (op->dummy.nbytes * 8) / op->dummy.buswidth;
+	if (op->dummy.nbytes)
+		bpp |=3D (op->dummy.nbytes * 8) / op->dummy.buswidth;
=20
 	switch (width) {
 	case SPI_NBITS_SINGLE:
diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 41e7b341d261..5c93730615f8 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -160,7 +160,7 @@ static bool mtk_nor_match_read(const struct spi_mem_op =
*op)
 {
 	int dummy =3D 0;
=20
-	if (op->dummy.buswidth)
+	if (op->dummy.nbytes)
 		dummy =3D op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth;
=20
 	if ((op->data.buswidth =3D=3D 2) || (op->data.buswidth =3D=3D 4)) {
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 27f35aa2d746..514337c86d2c 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -397,7 +397,7 @@ static int stm32_qspi_send(struct spi_mem *mem, const s=
truct spi_mem_op *op)
 		ccr |=3D FIELD_PREP(CCR_ADSIZE_MASK, op->addr.nbytes - 1);
 	}
=20
-	if (op->dummy.buswidth && op->dummy.nbytes)
+	if (op->dummy.nbytes)
 		ccr |=3D FIELD_PREP(CCR_DCYC_MASK,
 				  op->dummy.nbytes * 8 / op->dummy.buswidth);
=20
--=20
2.33.0
