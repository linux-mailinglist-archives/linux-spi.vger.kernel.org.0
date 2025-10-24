Return-Path: <linux-spi+bounces-10814-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF2C046DF
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 07:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 814F24E18EF
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 05:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD88239E9A;
	Fri, 24 Oct 2025 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FTvxOi7R"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D823A9AE;
	Fri, 24 Oct 2025 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285225; cv=fail; b=fmROIzWn2pYVEq54x5/G7cAJ5yzODXlpFSr/Ggd4BmhMy+nmieJOaGRsRaBVBdWZIseIdVnkcQ1xbmSKaaOqzaCcJ/7X43i4kNHyWwtTf0WvUcdfJdsqnkNWnc9+5FnAY4msQVzImPL7gqSPEvAjy6wSne3xL8ox8K7bB63VDfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285225; c=relaxed/simple;
	bh=YUsLBd4i/BFDZzUtBSy0WXp5Mr/Ub7urXVfongJvGAA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=vDZVrFb11JMjDc2H2YsBsPxyiSMGDy9U/tnwww5ukeAvjDX6BYNexAykiFtGaW6ze+mKDEq2CQ2WwBUdYYtmKsjgUaFbPZgkQyf5DnzcVka4NRpbbackpiiQkwgDB9WX4GNxBGQscCrxaPpYiTH+xsXpiMRiKL5UBzlMsLcXTEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FTvxOi7R; arc=fail smtp.client-ip=40.107.162.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuoAO3l6QjqxnOh0e0iuowgx3+JOnv9hpYQjp10RPWm0ctsZJArZmXZadxrrnE3XmnefcSqe5ZKZMrNPJr0U7bKcR8p609U7EObI4zcgyKnJ4Jmbpl2Q5p2tPJsmGDGLEXFt+Up6Lcixt8UZyo9kfurLz9fLhibwfqLfScbPHDOMvW1jCpMvvH3AMZlTZuzza6LJvboa8AgI2y/ULP5nsrVbRt4GFzJedgLxBxPOk2/fpq6TLiI58o1n4yOsxQDkt1UZA+qjipZocNTpVDRdPQbIaft5nFQxBkccbHRhRu+C8P8/UnewDdN1397eJcMhVOj6nej0GbqKpr9CCyhnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/Fwo1WuMUMmF3MnrYOSW7PjfQmGS/j4jUA24sJTmhM=;
 b=wMr9KX4Tx73JizOHHxHfkgOmSYyOuMHLHYHTQI20Ackqby09Gr1wKsehxoqm7QIKpYld2Opv3oBaul08GiNkhKsvDNVEx7wZvqACmEUBZSXhYHnw3Okw+Uy4yT0Psm+w2BTB3Oala6j9XwuSNLXGFoakK9zpE2DNFR2tIcifW2zYlZI8wlyGBMAIRqm4wrvdG+Yr1Lid4LSekwUfgL290EBeXjf9jEjyoKUDSUsoiMWVupDcjl85W2tZcTJxzy3fEfOII8FrL61a6xQdkyEiofkTRpUdrMdq+0MjaK4oo3WuFvhgCIXAjJdO418AAlIGnhhO5cM5ONot+W5/Cwv43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/Fwo1WuMUMmF3MnrYOSW7PjfQmGS/j4jUA24sJTmhM=;
 b=FTvxOi7RdufNhzXdMPEpyuhOVOuJghuytWp1b/c4UZ2W/+IzAn/v2nQ9rnMDrz4TfY7MCPk34zoCCAHjxnZwmJA9Sza9bOqQkVvwPHav6xUL8Vnm3yoF0+NnoVpIHbNhAK5V4JgYUjWqCMQKfXL3Lc3Pzz/BYcFlsCzIhbUKG+tn5n50nh0/kyKaPi42FOmRND3cFGKQOeeyQKUgHbv+RmxEx8uw8ZI7tpJwFRB7BETbhN++FzjWKh6GFfTr1Rs9DKBry/AIJC49jHUHe1UM8Nf1J6lviiHdlWtlGlRX6hV9/ZPI1g14NC7BCklanK1ru+0HW3chM4Hcu4/1/qh8Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by GVXPR04MB9758.eurprd04.prod.outlook.com
 (2603:10a6:150:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 05:53:41 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 05:53:40 +0000
From: carlos.song@nxp.com
To: frank.li@nxp.com,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: keep dma request disabled before dma transfer setup
Date: Fri, 24 Oct 2025 13:53:20 +0800
Message-Id: <20251024055320.408482-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0061.eurprd03.prod.outlook.com (2603:10a6:208::38)
 To VI2PR04MB11147.eurprd04.prod.outlook.com (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|GVXPR04MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd340da-abc5-4304-6913-08de12c1aebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m/GVqbjojJQPkSOho2fCZCJoY72jbGryWuSJAFFyZyRXN6bMGOyCJvOL6lNe?=
 =?us-ascii?Q?5MIRvBy2bpnJcmhwThA3/pDvGqlMQOANGf87pUWiDUXZvMNB14JYaxu99Enz?=
 =?us-ascii?Q?5FkMQiMyZRWZGsQRyK/e6/X8aQ01niv5K5YriCYBDrD9WZ7xJVWScEuHos5a?=
 =?us-ascii?Q?qJ2ec5VDLzYHzQKA0hmAHbv4g+H5dj2oqpc+WKGZUr3v8ApIkZTMVXP533EQ?=
 =?us-ascii?Q?Sub0FTXwgra+RYUuBypc0EnSSNNohK+T1leoDlR7e8gt7Im0NlQUgAx6WxbH?=
 =?us-ascii?Q?WY/4pDXIPZ/DQEDtVzVXjlkflntHuSRFEWpfGO9kby8p3bAT7hqFCcFf3kkl?=
 =?us-ascii?Q?bU5ecB/H8G1BbkPPmY01KYK18LVhNsFzGXRDktuQPdgm7Ij+Q/00EedC9T8+?=
 =?us-ascii?Q?LRvivG6jmhMri9U/E7cWAGzwIyzolW3ndzR4fIIT4P6fnhWNFcpTJNXm2FVO?=
 =?us-ascii?Q?LCGY1M41qbh4cgbk7Sk4WKEdY2/cBlIRtFBNN1glAUCW/DyAXBa7emd29c2L?=
 =?us-ascii?Q?8eVkQRLu1Ue6etmWAWrHTGyL3lwzVwu87B1Qdz9rZJZdz3fyBo8U098kiy7n?=
 =?us-ascii?Q?RdQVwaG7ewxjfLEtbr+K/SbAfhIReWnZrQLx09n6dxSnyShnMCceWP8+Hb6n?=
 =?us-ascii?Q?TCDKzlzddBbQ/+gxViqfHGClGjOCgxCHV8nOimvC9SGQJJzfiPGukeoh/nHn?=
 =?us-ascii?Q?uJNY+J48jIrCUAx8n/hT/52Cs3jVf2hPEE8AqvDJFkNjIPKUUYi1TTlb2l30?=
 =?us-ascii?Q?FSM7Z7znUmW64wHx4WuxOVir9rNn08m8jMvgGhFR6wxkZ+mZAhXQ5g6fhaQX?=
 =?us-ascii?Q?UMu1/Zlhhm8w/uiaYJkKyfKnW37OnfUeQMTqlkK/a1ZaUACjCPqLe4fdIKiL?=
 =?us-ascii?Q?4CeQ2WIwjDNFm347iRv+NRVo4LqX3F/y49LVt3L6Nmh8oiHR4TRYmEpEVsZi?=
 =?us-ascii?Q?5LGZEn5ovrTzLVv/oIeu4P/CDf3icVldWQl3qPjzA8VBNI/qYEUpNxMmr0cT?=
 =?us-ascii?Q?8gJBF/T0G/GR8r5sxU1Efie9qMI4sXWoAdou4wUPQjKpzqx7glTeH5pFJ6/4?=
 =?us-ascii?Q?Tzd2R0TQS5WK71jD94TxxjYF/wpTB4knjUw9UvVEGcZhEChDDunJk6V2C2HL?=
 =?us-ascii?Q?kHTufWvJlrpjsY2lKw4UazJFrt7JV3mDX53WvYq8vC7vtah2DCkUHPlzmh3k?=
 =?us-ascii?Q?iiWyRrHXtGeHCIuQsw/VWwB+nr5QdDG4zmqf5HZWp/lPAave7kjvjcp6SqyS?=
 =?us-ascii?Q?6ro1dLijGy25DLrLKVDFm8QT1+/WUIYgrRBxi3yJ39PtBpXs43h1FodR3hbj?=
 =?us-ascii?Q?d7VgEFBQbCiIpU7KYtj7ShPTf57gQux/zaifBcbBkMeIyG4RKssDD2Yd5hL0?=
 =?us-ascii?Q?bAyjkYIRz0WQM5tzfYZ0BvCBF9qQvr2/sqreMAtJHUFONPaY/Jk0l2B5CNUc?=
 =?us-ascii?Q?pFvA2bgEg9sAzVMDkQmRu9MhTN3GNZ+woOnvzNTup7W5ZYtLBT6D2FV3oX5R?=
 =?us-ascii?Q?EQ64Cvam8FG0IIYHYooB0gHJ9/t1fhqu5zyc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FvQWOiKSU8VFCmKScxtyqgkCqxDyw2lFE/bOQtdYBgdr86FH3TOjZKYODuoN?=
 =?us-ascii?Q?TMEigmOG2H9eINhjOBtBN+vOIaVbZtzBfGbrL0xfOcWk++jjUXXzVFzMfn4a?=
 =?us-ascii?Q?XjEjuxUWpQwOxjk4oCty4Ld0W9SC0/wa06u/t+tNRs5fD8wA9JOecQ7EDTOd?=
 =?us-ascii?Q?9YZK+L9XKNG+sXSQZymMkZr7Ddz+9p3mmlngqc+PqaeUsbRf0LqHsp9VVO8U?=
 =?us-ascii?Q?WWWqQeeDU05KJ4OaPIGZ6BRC7OAI63/NPtRg6L3KT6xtq3gPJ8d1uCiH3/5A?=
 =?us-ascii?Q?9bQ8IN2NLT4EKE1/SoFjDFxrHHi/u4JiBUNHTGcOzSAJKz8XqenNl/QsyfUi?=
 =?us-ascii?Q?picS8sbhQ8GnyNId8sj8qsPZ+Br/wr9Qvj1RG5plkI8UUxDtNxJxeIUREFaQ?=
 =?us-ascii?Q?siZTNpT6ielhfymx9apPutWOllIZXCQBksX8A6HFcs7vohlYPF6AsqzTIzKt?=
 =?us-ascii?Q?yKiIaYO9ty0Ake+Fcan8FL3YfyHuHJIvXTbX0QPHx44491kfZMSrWkeIPEym?=
 =?us-ascii?Q?QPz18zwIhyCQGCuQW0LQf61KLSHSGnYyFBSSI7buKkGybVnv5QnaqtU+A+xg?=
 =?us-ascii?Q?BAyUqEV/MTUbCGlsFPXYCzjyw9A9mkAZrXoqoNOgkk+gvNz5c2YZGv8cJjXf?=
 =?us-ascii?Q?NXTeHCgl0FwnTp8HcUlc+xQpnkOLHD/UkPO3AiD8aSYmIIjq6ydeXLXjWmJP?=
 =?us-ascii?Q?vwzVTGdsTaVXL6dT65r7ji+y1vvOdHmmuMwfCFaEhGuoyyVI8463P6s7znDp?=
 =?us-ascii?Q?FSCNfJP3P+mAhg1uV2dj3PF+jk0nP7HqT/hnqPjCZxyvtrNpA5ZFNJRm5iZc?=
 =?us-ascii?Q?2TS7RiP/P7kvCEa40I7E6RSCebhMOsr8ptN/kX+KWhNkJUu16PdCPosi23wJ?=
 =?us-ascii?Q?og9rBSuL1T0Z5V9DoLlFlkvDfsRfmZcatzDDXWzgPs7zN9VYkhUSCTBfGuk0?=
 =?us-ascii?Q?iX1zoT6AguGDtpnc60ymlneWkWuv+SI2KkYWaE+TY+LP7cbzfiRpqTyQLiyh?=
 =?us-ascii?Q?Z75vmgLd/vERPMyr8LqtHfbnDiGkpIat5VEJLh8buVYcgXRr7HGg1IsSx2C5?=
 =?us-ascii?Q?OlcXowHjQX4l6uB34oQ7tIwgCq46ZKFXNpPWRO3vM+zP+UswsvK14YLl+wpX?=
 =?us-ascii?Q?AyPlpz2eoGV+0eaCqc52TMGzxRKXGZQnQVBgm1HvxjoUXwpDwFZ9ODE39H0g?=
 =?us-ascii?Q?u/zQ5Rt31MH7b1BDYe1+PuB12c3/WnvjD5RNn0PGELSc0AFLb4dRTkKDL997?=
 =?us-ascii?Q?gdq4BXxlOr0A7IN/SFI8TcmADw+WB9dDh12qgvdsLGH3RnHeTMPBImFriB37?=
 =?us-ascii?Q?ybptgFsCr78kkHaKmU22icry18uVv55hobKFl7ijgzWATcufms9ulbqsmFyk?=
 =?us-ascii?Q?iqa7DrVGtI1vazZIoJcC5ZbmN0bVWF83xDbL0ZC9YRblFcHXhlUaeZSKVZAi?=
 =?us-ascii?Q?nE8c/KeaphN0Cl/o9iqtkF/a+1hJwj0JdxPXIGZpfuTB+/SHkXPYSvFOS3nc?=
 =?us-ascii?Q?3+AnyzbbQcpdbVf2Vn0sx3CQF+guOoXO2dY5SXPATu+RM4dB2Gc2ei5if5vn?=
 =?us-ascii?Q?EqVzUP5qU3VqeXiGzL15KO6tEn+VpAbwNcl3LbKi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd340da-abc5-4304-6913-08de12c1aebd
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 05:53:40.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkkM77dtT7Eq7DjBjOghVzXtnOLKe+lOzig+x7C4A5PM13vp0Xxyv3M3gzTLLToDamfoukLaR4fJJb/CDp+/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9758

From: Robin Gong <yibin.gong@nxp.com>

Since sdma hardware configure postpone to transfer phase, have to disable
dma request before dma transfer setup because there is a hardware
limitation on sdma event enable(ENBLn) as below:

"It is thus essential for the Arm platform to program them before any DMA
 request is triggered to the SDMA, otherwise an unpredictable combination
 of channels may be started."

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/spi/spi-imx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index cd40db61d8d1..765ea507dd8d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -529,9 +529,15 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 {
 	u32 reg;
 
-	reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
-	reg |= MX51_ECSPI_CTRL_XCH;
-	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	if (spi_imx->usedma) {
+		reg = readl(spi_imx->base + MX51_ECSPI_DMA);
+		reg |= MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN;
+		writel(reg, spi_imx->base + MX51_ECSPI_DMA);
+	} else {
+		reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+		reg |= MX51_ECSPI_CTRL_XCH;
+		writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	}
 }
 
 static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
@@ -772,7 +778,6 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
 		MX51_ECSPI_DMA_TX_WML(tx_wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
-		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
 }
 
@@ -1539,6 +1544,8 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_tx_completion);
 	dma_async_issue_pending(controller->dma_tx);
 
+	spi_imx->devtype_data->trigger(spi_imx);
+
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
 	/* Wait SDMA to finish the data transfer.*/
-- 
2.34.1


