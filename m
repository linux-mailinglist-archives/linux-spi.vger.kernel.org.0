Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B83580A5
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhDHKdi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 06:33:38 -0400
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:18746
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229751AbhDHKdg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 06:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BK98dBKr8UHF3y3a77i00RglbvXHF0pKe5PP3214ZOePtrnARJXNoZKGCE4uyGMkXUVdntVXivOHr+wFS/cmDBZ8EAjI/jOH9FVrmdQs/vYdxNpbhQgNV7HOMETvoNOhH2JozHcEujju6KzASOmLyoC4EwhluTDwUfKyfaFcki9Lq2iHgIhb95u5UnFxBZMmauatpJk0xo2v1KUbePanT4lic/kGXry/KAvaPUjuBSAQo5u+pynGz5i+diq+Fe9ClBhFxWZoASkUy5PYWyNIXBnjWDPD5QKiA9J8Mx2jaRvAMPyLoiN4u3AOZ27QYzZgg/GESoa8TjpjlLPP/mGUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BJrWZj1WJEGe6X2pToaizf35MLNkfa70ccZjnk8EoQ=;
 b=KQPppJxQ1yUKnQ9+UW4cZBIYVq14nI0iqB0Oy7utXTx71ynXt3bpdIJZYF8BIVpUMfMmS2KJWtAVWhQT212Ys49BOdrKz686S8r9Z1KrpwGJ5bsvhaESrOgvMczEavyiBJt2bIiwsFuCzoZLwPhp5tfpZWOuD93wIljTti4AENZPVeYxH66JidSzuJAyCz+pSfCyuMgBK2aDzqF27LVUJ6WXiLDBMcvYb//kkZgRNKXfpD6aEiSBm4VtNH8wgMAiDFGQ3pRd9yh/R1hKNVOqW7zkVMA4Ap4IogPRo2KiV8wcPMmV2KjIMx0jjGsVZNV3hm2KiUmzggsuiKPCwyyCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BJrWZj1WJEGe6X2pToaizf35MLNkfa70ccZjnk8EoQ=;
 b=Z3pqwx1AvLYEzvr7p11LpjM5XQff7fd7PC7cClgRj24nTKqBgam1eXBDu41IyRe9IjfoxGDyQ7jmFVUrhXIEJSg98bGAx5XNpJ3mHWj1XA1JOHjrLVPJLMccJMmcjd4ZmLlu1b0/epjjaIn4f5f9z6xUzJ4MXfbOAmv3eNa+5MQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4982.eurprd04.prod.outlook.com (2603:10a6:20b:5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 10:32:53 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::5cd9:3da7:144f:36f9]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::5cd9:3da7:144f:36f9%3]) with mapi id 15.20.3999.035; Thu, 8 Apr 2021
 10:32:53 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: add a check for speed_hz before calculating the clock
Date:   Thu,  8 Apr 2021 18:33:47 +0800
Message-Id: <20210408103347.244313-2-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408103347.244313-1-xiaoning.wang@nxp.com>
References: <20210408103347.244313-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by HK2PR0401CA0017.apcprd04.prod.outlook.com (2603:1096:202:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:32:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e243e604-6060-4bef-ad51-08d8fa79aa53
X-MS-TrafficTypeDiagnostic: AM6PR04MB4982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4982D6E108677787639C85CFF3749@AM6PR04MB4982.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hww1p55nvlO+9MMtg0CLYXQkLRQE/ajTeGEz/vkFCnrqKtGzwiQoUU++joaGiuApymNI9kJo2clfDYksHOuHR40/xGOpwhND2Bod765fEcUXejsvybd6B/h/OUkD/qLZTvNYW9+JcIpnQk5Y336GW0RuY1PPAMZOY1R1SaEoz0vc+3inswKlLNOeApGixCYR9ZKVJHGuTEkRVlCs4CNkc+yso376KhT0BoIwH2f5269FPYohCSVN+iPTSzKkCGyliUvX3cEw1GH9W+E8CEFNX4E5f9G8/0J9Nio5m0+wtnD+rZtqfinvx7pZejt5MpryyCKTi3Zq7tdR3YTdKpM5zM4rSpQD9gDiWeAQvYrP99AR8b8mRVqzjivqYPh164h0y9EdtkDf9HYrhksw2NNUwQNhR3462L43tRduNrf3w72I3/M+tDTXX2svPWiyZeHLeXLPvPAl4xXM5MduG8/zgVAqQ8maS9iIyTu9tLcYwIm02sS9AsagG46lUL15w681JRy93kIjUzSdvez+JARBFHz5LMdVMsVe6ldR4gsgTtA5yU84wmuslP2sZQTA1ftsd2lGc8zxKg5XZQndYQiiZc/iNLWoDyjtj1sJD3s2zr3UR+S0gESWCnQN/w9eWFRobBJD/okVSJ7u/Eb/vQxt7knQUzcl3IENWiOqypmryAPwQ82pb8FMNJLtsmHHrKqHZY/pDLoL3RCTEaHvHQmN+ZShNGYUkPo/UGoNUkTe0Zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(6486002)(66556008)(38350700001)(66476007)(16526019)(86362001)(956004)(2616005)(66946007)(4326008)(8676002)(36756003)(5660300002)(6506007)(38100700001)(52116002)(26005)(69590400012)(2906002)(8936002)(83380400001)(6512007)(316002)(6666004)(478600001)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9e31Z7QbjlSHA+AB3XgqQjmUmO1+1pO423e4YjQrxLY9MMs0Hd6xZzVNFBG8?=
 =?us-ascii?Q?WYYBxzMQiI2happ3Xsl9Cq0arL1q2pGigII0GBil3HhIa9XEpU/JqEhi2g/2?=
 =?us-ascii?Q?kQfVlH0TQ/USl2h886P9zEYWs5oN/M6ywuTKU3Fyh3WuRRWIhaaev/gauZnn?=
 =?us-ascii?Q?PAMzsgrzK8PXvN4vQV/xDJCTYEfO3T50TBVICOalORPqGyalpbkb+TFLSdDj?=
 =?us-ascii?Q?CpyhPONcrRuFRJ4v1qqniYXeJeukIen8f3SlwzwxTk9WhlQ9yeM2THCzvAUd?=
 =?us-ascii?Q?6P3XMv1eycsb4XBPVY4YB4yqqX+1dbROn9hU3buD6G7uDZQio7KcQ9HxSfRI?=
 =?us-ascii?Q?QLeFH1TYD81y/Q5Y1JM3nHIeIijhOLbCpMn+/ppFFRZnvuOa4q8LH17lV3pW?=
 =?us-ascii?Q?zy5hMsp6yGxwThmeAiuEsJTeEVAkIN5aoFUxLvU97JyrmrVCyIvQ02xQVEdi?=
 =?us-ascii?Q?f6IADbNrqHpPwHyjfJ/yg0/mO4zegD3IVlCYBvV3N1yv81WzaD9EBhchEJ19?=
 =?us-ascii?Q?Q9DO3ftlrdAI02H+0drCtPAeAQ8k9JQaZLzeUa8nS9q3AZ3do6dyjgwXhSrM?=
 =?us-ascii?Q?s7FB8dU+3Q2ISnVul21gZ8KNfqOLso86cXH3c/t+56uF/+UFf381iK0bPW5T?=
 =?us-ascii?Q?q6nnivQJ5nwtgFHSar48PTShpBj0T/PHMYMobNQi2Sg8EKn8asCMk/1HhUHO?=
 =?us-ascii?Q?eO43XK+SxY23xbJVMEdJP4Lo3cHXw9XQEOM6NyUGNmiEoA/mvKjHrQhC037T?=
 =?us-ascii?Q?+EQ1yNIFX70ja3fxNCeHqNoU5GyKtBhyfrKEG3/CphkCeq88Opt0JNcbXdF3?=
 =?us-ascii?Q?WzgH5dHqaWdhxSc3Kg4XrOqy8Tv6a5Qhl4IVh7BNJTjKM2uELUKie4UeKaRZ?=
 =?us-ascii?Q?/5EYcDvGlie6xiwBViQhWaypIe9p1UvSYisrnhIwM4T+WEo7qOGfG/nbWTU+?=
 =?us-ascii?Q?NxxqMRcx7cCxYlNSgNCGfUnY9Pbkf/RYeqIn6bD0xssG5wziVoVZDsUzEZ/F?=
 =?us-ascii?Q?izcT19W92wNwgAYOjAKxvItLi+ewgkh8TdquQy/8VjzCZcwfmwsVsr0spbDj?=
 =?us-ascii?Q?fZAi5FNNh+R+mM+m6ThktrelbIkSkWxsJcJKHiL7/oJvFUGrOYdxtoUVFLM3?=
 =?us-ascii?Q?hbWOtHijaq3L8+LYavi6fyYW+y5VB5onDLiiKfghaeTtUKrQ80moqJIcT5tW?=
 =?us-ascii?Q?z2Bug0/S2TxP75UDqMMFXjsnCJrbghUh9tZxbERgQ8BK/Jio+DQ1qjEy2+C4?=
 =?us-ascii?Q?o+W7zPQd217vOBJ/81vfCeuTnrPML7nQ/FNHiBs2V/wlMGuze+rVD4NEPvHg?=
 =?us-ascii?Q?Hmx8yeckpNenxXXipWp8iTWl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e243e604-6060-4bef-ad51-08d8fa79aa53
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:32:53.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm4/KG4WalniptNq4x8pKhVJF7vQRpbtGdJwAGRyTT+VXgPmqKVFjDMzhhDxXfdDtIpYt8Z9AwAA84+1w7m2rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4982
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When some drivers use spi to send data, spi_transfer->speed_hz is
not assigned. If spidev->max_speed_hz is not assigned as well, it
will cause an error in configuring the clock.
Add a check for these two values before configuring the clock. An
error will be returned when they are not assigned.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-imx.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 24ba7ab1b05d..01f27b4d7384 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -66,8 +66,7 @@ struct spi_imx_data;
 struct spi_imx_devtype_data {
 	void (*intctrl)(struct spi_imx_data *, int);
 	int (*prepare_message)(struct spi_imx_data *, struct spi_message *);
-	int (*prepare_transfer)(struct spi_imx_data *, struct spi_device *,
-				struct spi_transfer *);
+	int (*prepare_transfer)(struct spi_imx_data *, struct spi_device *);
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
@@ -581,11 +580,10 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 }
 
 static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
-				       struct spi_device *spi,
-				       struct spi_transfer *t)
+				       struct spi_device *spi)
 {
 	u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
-	u32 clk = t->speed_hz, delay;
+	u32 clk, delay;
 
 	/* Clear BL field and set the right value */
 	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
@@ -599,7 +597,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	/* set clock speed */
 	ctrl &= ~(0xf << MX51_ECSPI_CTRL_POSTDIV_OFFSET |
 		  0xf << MX51_ECSPI_CTRL_PREDIV_OFFSET);
-	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
+	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
 	spi_imx->spi_bus_clk = clk;
 
 	if (spi_imx->usedma)
@@ -711,13 +709,12 @@ static int mx31_prepare_message(struct spi_imx_data *spi_imx,
 }
 
 static int mx31_prepare_transfer(struct spi_imx_data *spi_imx,
-				 struct spi_device *spi,
-				 struct spi_transfer *t)
+				 struct spi_device *spi)
 {
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
 	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, t->speed_hz, &clk) <<
+	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, spi_imx->spi_bus_clk, &clk) <<
 		MX31_CSPICTRL_DR_SHIFT;
 	spi_imx->spi_bus_clk = clk;
 
@@ -816,14 +813,13 @@ static int mx21_prepare_message(struct spi_imx_data *spi_imx,
 }
 
 static int mx21_prepare_transfer(struct spi_imx_data *spi_imx,
-				 struct spi_device *spi,
-				 struct spi_transfer *t)
+				 struct spi_device *spi)
 {
 	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
 	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
 	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, t->speed_hz, max, &clk)
+	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, spi_imx->spi_bus_clk, max, &clk)
 		<< MX21_CSPICTRL_DR_SHIFT;
 	spi_imx->spi_bus_clk = clk;
 
@@ -892,13 +888,12 @@ static int mx1_prepare_message(struct spi_imx_data *spi_imx,
 }
 
 static int mx1_prepare_transfer(struct spi_imx_data *spi_imx,
-				struct spi_device *spi,
-				struct spi_transfer *t)
+				struct spi_device *spi)
 {
 	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
 	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, t->speed_hz, &clk) <<
+	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, spi_imx->spi_bus_clk, &clk) <<
 		MX1_CSPICTRL_DR_SHIFT;
 	spi_imx->spi_bus_clk = clk;
 
@@ -1177,6 +1172,16 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	if (!t)
 		return 0;
 
+	if (!t->speed_hz) {
+		if (!spi->max_speed_hz) {
+			dev_err(&spi->dev, "no speed_hz provided!\n");
+			return -EINVAL;
+		}
+		dev_dbg(&spi->dev, "using spi->max_speed_hz!\n");
+		spi_imx->spi_bus_clk = spi->max_speed_hz;
+	} else
+		spi_imx->spi_bus_clk = t->speed_hz;
+
 	spi_imx->bits_per_word = t->bits_per_word;
 
 	/*
@@ -1218,7 +1223,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->slave_burst = t->len;
 	}
 
-	spi_imx->devtype_data->prepare_transfer(spi_imx, spi, t);
+	spi_imx->devtype_data->prepare_transfer(spi_imx, spi);
 
 	return 0;
 }
-- 
2.25.1

