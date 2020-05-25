Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742531E0C0E
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 12:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbgEYKoI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 06:44:08 -0400
Received: from mail-eopbgr20132.outbound.protection.outlook.com ([40.107.2.132]:24965
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389484AbgEYKoI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 06:44:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBr5yatC6JBs6/N/tDWdwBcB6sqwfBwQkQDAROGnzoZ1iQ4LBYAl5PNt7QIiD92uF5NFMVjkrxwsWCKKKJWAu9n9Zt6NTzfiMzYNGT5vbP9XIYVyqvC7X2iYkE6OCEKr6rr/V/eUEDTLBIovny+/GMOGtZmwakg0MqCw5rxt55ekfy2o2Bsj//L10TRAG1lkMFCf1l4GLiqCxjuQcAc5C7HOTeWm/epXR8qdZJmJI35eIU1dZ85TMImllWzh4xCjD4nnEsvPVUrVKupNxAu3+7TmHpulFIkB0NlMANY7dAIVR3jdiskZOLm1j55jk2zMkQrmc8mbuKV1WKbBIhwnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot6w2xQIhbjd277hYYAhRakjQIUnRHohWAcb43MtOJI=;
 b=HffoP5Fn8Lj4RUEpEmxDwPitm1UaW4EYFZtf4WvHThRrEhE38P5eBeLikJvLx7lM9O7cAdQjUNVOypnYVvIQJILtkSCTiflNg4RkOYM11CWPXxmZqaMelp50vWy+VGL++LRemkt6bH42lWiEKZLr64h7f4dqNbYLTxc97YHpZDvuS0tj3Pd/yRZtzqKscwuwMxVTYe3HxzkNl4Y+DRqOAnUnWaRRW6HutIV2HAr3HRaU09oWO4uTIl6jIR8oPpcggsnvxn87KfxUWoi3ZiunwMFhduyIqCjbVQ/6XL4i/K5vJoH0rnOqHk/bagoegWJn4EqpglkEIjK6HKs6RFvidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot6w2xQIhbjd277hYYAhRakjQIUnRHohWAcb43MtOJI=;
 b=oxgQx9H9X7IVE7cIlt4GnbS+NoK40J62ej3OoGvhlkcS57TKo2CABoKIaGjFKncFi5LNLgDTHOImdITeQvLrrHbjACqHtITXSh4/BD1PUahKjF37sqOjRi5UGOU3lCdZSkdN6DIYCNTVb8YT/TCdl8TcwcHyksn3+TRHH3jgyo8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5498.eurprd02.prod.outlook.com (2603:10a6:10:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 10:44:04 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::ccd1:96b3:48dc:c5d1]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::ccd1:96b3:48dc:c5d1%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 10:44:04 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Mark Brown <broonie@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] spi: mux: repair mux usage
Date:   Mon, 25 May 2020 12:43:52 +0200
Message-Id: <20200525104352.26807-1-peda@axentia.se>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR09CA0057.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::25) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orc.pedanet (213.112.138.116) by HE1PR09CA0057.eurprd09.prod.outlook.com (2603:10a6:7:3c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 10:44:03 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [213.112.138.116]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f6301c1-97b2-4674-7c69-08d800988b41
X-MS-TrafficTypeDiagnostic: DB8PR02MB5498:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR02MB5498EF6B4C7452E53FFC3BD5BCB30@DB8PR02MB5498.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7BfIcn5wGLnhMymTdpzv9Q+dM8er0rwjP2jQ7T5JJEnaV4l9ksNgWfr0ihKbAnFTln9VWGnGyNK5FU6FnVz2vy3FIwVHg/8T7huc1u6OVwJiE1ll0N765NhsELCOBVkqFICUChEru7uKCBRGT3v0VqOYOgzPu3xIuP9u5CgjU5rveinKALdRVku+kKTloR4vUARGL96EDMp3udVVZ63s1uqDT4GUkcc7LLRSlweHtpXJwivwn2ibK2+GLrP4Pb8Ent82JlJu1tN2nRTjuNZ40af6iWi3172PWVPGt5QuWXM1BKzfA7AFLWF0WkQmHQGSZZRqileRQnVKfM6fkNsHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(39830400003)(396003)(366004)(346002)(66946007)(52116002)(186003)(4326008)(1076003)(26005)(6506007)(316002)(508600001)(36756003)(66556008)(16526019)(2906002)(6666004)(66476007)(8676002)(6916009)(956004)(2616005)(6486002)(5660300002)(86362001)(8936002)(6512007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: chAp2z4ccFyza8OMK1uoBrY4JISCd084tEB8Lpn9bbnITmLjjdbyHEmw5Y64mMVrhGicLh8L8MLxtZk1MPBZwlle1ZHmUPYII55p9juqf+Exe16RLDArui+qtQjU/x7dq1lU6QiAHjuIJJCZrgpTCcEtYOx+PsITxY6KQABr3yX3RovvSUZgi6M4aMhUkhpm5RyRvzYqqY2bsvAz7CbgpmaMusA/HRgQhaGwB5hqMe3i95upBQOU+n6H1cvcWNKPiaWnwiosrHSakwSYAi8er9xvCzlhTmw5fPmwGLglQBjc1eZJirqS2EHFpMGJSqhDu5wpW3ATYVRH1HT/BFVVY4ARMgAXkFIJW8OGNFqHSC84X5YD6SZbuzOvIr8LZSv6V0CAwBlLGC28/oRZm92ZLM96m6QljVl9mplvIPZCV+zi1hZoAuB9G2bjrARlp7Bf/eCMeF3gtEDl684WEvmaZ89z5HvUvO2QNSURT6TIOuk=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6301c1-97b2-4674-7c69-08d800988b41
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 10:44:04.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOveGtqF2nUHa50Q0dkdjllJrQ5jXAJoY2WwBybTmw7adDWRmetaJ5JN8/DyTBMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5498
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It is not valid to cache/short out selection of the mux.

mux_control_select() only locks the mux until mux_control_deselect()
is called. mux_control_deselect() may put the mux in some low power
state or some other user of the mux might select it for other purposes.
These things are probably not happening in the original setting where
this driver was developed, but it is said to be a generic SPI mux.

Also, the mux framework will short out the actual low level muxing
operation when/if that is possible.

Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/spi/spi-mux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 4f94c9127fc1..cc9ef371db14 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -51,6 +51,10 @@ static int spi_mux_select(struct spi_device *spi)
 	struct spi_mux_priv *priv = spi_controller_get_devdata(spi->controller);
 	int ret;
 
+	ret = mux_control_select(priv->mux, spi->chip_select);
+	if (ret)
+		return ret;
+
 	if (priv->current_cs == spi->chip_select)
 		return 0;
 
@@ -62,10 +66,6 @@ static int spi_mux_select(struct spi_device *spi)
 	priv->spi->mode = spi->mode;
 	priv->spi->bits_per_word = spi->bits_per_word;
 
-	ret = mux_control_select(priv->mux, spi->chip_select);
-	if (ret)
-		return ret;
-
 	priv->current_cs = spi->chip_select;
 
 	return 0;
-- 
2.20.1

