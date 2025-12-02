Return-Path: <linux-spi+bounces-11708-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD43C9A959
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 08:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E67B54E3A0D
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 07:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCE53043C7;
	Tue,  2 Dec 2025 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMD8DHAK"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B9305066;
	Tue,  2 Dec 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662155; cv=fail; b=i6gELwWZ4v0nXn9hhACzMzI9tKnOjSyWor92IAkpr7h36sTM2LQwLwiq/gcrgi63h54z0Y/I6v+scHf0OM9dIyDCI947QpR63TlXY6uFLSYF9CG2owh5WT+g6Qw8+knr+zAcSscVGOmkphZfiftVmighu7fJq86GWZp+f9daqC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662155; c=relaxed/simple;
	bh=g5nY8SYJMX6KHE09wP+iuL6IEmMxaX3kwVMCJAqe6mY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KwSE2GKAVuYvp6ZdRtdPyKuqnH9vAeWREv/mcMgMV0nyahdY8i00Z6rQzRF+kkwrArsiHWwj24lo1P0noFj82ys34lV8l2lBs7klzzK0JC7zHI0jJD1Ym8kmeLfc8qdigHENMbgrW7t8D4drrm1Vcjukc/9jCDUA+5EKwCkc+fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XMD8DHAK; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW21Up1416/YcCf+YttVqe9QVqUo6Mk3B+V/b0cwwoBzYPIST0ptfFo7Hk1DT7qLzH9zNg/7EpvBrzaAbehoeofc61q1OM8k3WRkLnNLtx7KjPm02mI4mD5V0dPySrsaL2OHqxFdwsRiV1vLQuqV7zmN03A7pEHfw7brBM9o+nnBQAmpw+qM1pALqoE+VdTvn7uoNa4vJyZcDEUQRcnxvwc63trY8Vrshqcyi0N7HI0I9bXT8KNOyOuRhQX9w2a/ychbToEPjdNG8CcEEISkpfuPi0ggivkIlMMN9NI50u+7oG6JbnLioXkmIswhG+eHE1W3Pq8hUZZ3QRa/eaNuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dnI4qh/0aH4OV9bjqxyLDoFu9l9WIC4Cg3Yx8x3/FU=;
 b=RWo09zJs0Vqqlvy3oCtpLPkGBZX/NIMz+4PiyrW6dGiz48lhqm/hk0N0DXG2VAYJNMrVAEEVHGWFZSgLnMD2fDEN/m8eCKte8mImOBvZDGIKANcF+4hS/j+8CxLvhzQfbuC3OJkEfmBxOmL+tVZwM1QshmT1MaDHHi7t9zRYy984C8CmYMeB35CJO5Sjus0PICpddZvGItluxuuPnwHopf6wWvqoRpgggAECKGgVc1OmXBVZx9XtOh++8GoAs3m5vChAWXif4EJLDbkqHH1yFNjtZh6ByQDPI12Vhyv92T3X60va/o8mr/2XFKhIcU24hXUlYea4g6S43AunsVrf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dnI4qh/0aH4OV9bjqxyLDoFu9l9WIC4Cg3Yx8x3/FU=;
 b=XMD8DHAKQ7fgBMm2xJSHYkLVdNLETilPEHwIBGh8NUBQaPiGSgR2kJQvIzxuBve61tNgeoDxwsPQsRJTjIApSVewgbc8n43TfjHb9uiq6EEj1rD7K7nygzYwsgdo17CDSJZEJFFwCByNccO0Y2jWZEncWplTGgZoRH0fH/x1ObsDmqJSHIA7q2MWsXUwUrVixckeqQmt6hKoqC3NxcPRsyPVbM5plAqB7VNzzLciIEMoHUG6XA0KncqdgQMb4V67Xo6s8ybj5B/79RB07RICP6C2TcWKWkJaJ2BRlmL8ig7FXfeDz81P0eetlXgv7NlznWMqFG9xLg5x0cYWytmmnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by VI2PR04MB11171.eurprd04.prod.outlook.com
 (2603:10a6:800:29a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:55:49 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:55:49 +0000
From: Carlos Song <carlos.song@nxp.com>
To: frank.li@nxp.com,
	mkl@pengutronix.de,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 2/6] spi: imx: introduce helper to clear DMA mode logic
Date: Tue,  2 Dec 2025 15:54:59 +0800
Message-Id: <20251202075503.2448339-3-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202075503.2448339-1-carlos.song@nxp.com>
References: <20251202075503.2448339-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: bde3e993-181c-4eab-633c-08de31783507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZAh/uUeg9UI9whtu9KnasCgEnySjXE5cBxMUmV6QIhj0Q0TYyAWNEak/qztn?=
 =?us-ascii?Q?5iuf9GFtxyVRoC5scns/G9SGYOL0tQXpqEoVu9dJz0zfI95wwFh7XpbCrU0y?=
 =?us-ascii?Q?xNUZaYMryK7Sm3lhAkQiSwpvYoPWGlYUx07tStl97a2e9FR9apq3uRSHZNCp?=
 =?us-ascii?Q?mmaycMwuODDFrVPTQwUiaHsdpo5MQGI5qxmnWwzTZnsY5aKjmbyVVWV/5xYx?=
 =?us-ascii?Q?B592YQvSDtSt01GBz5UPWBberCq5Bj28z9CLv82oLoztC7CxxCqJgjYHUSud?=
 =?us-ascii?Q?OtWH7ofK6BwAdGZejK8tZ43K+0sbCrtngzLJtP3sMFROWZ0l0nq6jfS693NV?=
 =?us-ascii?Q?gw2gu60f8A7aj9SSyU4xX8gnkQ9JVmrV2mOhxq+sndeQIG0L4xtCb/RuDyvw?=
 =?us-ascii?Q?3xCkL/0AUo3r8D+vJxSV+R5m6ESQJxWC01mHD7GaDi8TGKutc2V5+Tp7bKKh?=
 =?us-ascii?Q?/IQrSor4zaMx8qfcmBPvuHjevY1+J4pfAGunGhlNBBiyesS4ogwn9NUxeEpw?=
 =?us-ascii?Q?jz7BI8RPRul5KS0huJmCHs5ADM1lexR9VRGdvKXDYWYp6AtkzcOa4taQkAUo?=
 =?us-ascii?Q?lXey1srkDVm7cO6X5jgF1OMC4e/JlBvZWG53Cv56/CK8dX4CgWEYrRly8j+Z?=
 =?us-ascii?Q?6RIJWdTAGBgMweppqrHuB4SJ0QzszVrWEmaj+P0S4MIoNVI/JJjVfQiz8exe?=
 =?us-ascii?Q?tfKvavjPFs7Akgep3eJ8j1t6z26J780n9be5d9uWS6LWPqHyZ2IJ0/ZdPU7E?=
 =?us-ascii?Q?JbY309MHdCBVlyddhaiFrJYcfD8S4NZBG0hyed0Zb5mNjjT+12dmzaT3EeFq?=
 =?us-ascii?Q?IAJltl8CgpXr8ZZeT6RPVQxPNN4SEVDoBN/DbAC36Ik4eKUSdxpcu4r9Ma3W?=
 =?us-ascii?Q?7mFaFxO1mw2LK35rAdHze+mMs+HSI0bYMO6sGubmrB3EnjTGKAdu6tDRXBPn?=
 =?us-ascii?Q?gewmAhnvM6LVlaMb5uqZ5B/9ZMWVcum+bu4Y8OSvsySqUK5lm4O78MAzKhhR?=
 =?us-ascii?Q?7A0zLic46zfeW943Pdowjh8Df9+2T/bOYGBDexOU+8es6QbY1O3HSNP9Pmd0?=
 =?us-ascii?Q?d7vaSN5Teku7ZS8EpCWjELm4rViTZakTz1xp3q+xqbasCWSXtOW633yUwbFl?=
 =?us-ascii?Q?3Yo2rhagBP6IakYP5yvUHz8sIayFB3P4J0pimnh1QY1LGI8briqSiRNuL2YR?=
 =?us-ascii?Q?rhLyNMsJBGAUUOWdfwiIrEiktkKdCuICtFTIPp4dUBBHMVk4rmtK57YORlSU?=
 =?us-ascii?Q?lRox5WpIEHLEttmJl5+bXrA8aXYEKn1WOOBF6RYTWXQHLodYcJu8SySKdp7j?=
 =?us-ascii?Q?vJvUzncFE7DG7mxmESoJlkSm0xZMNBFkOfVwd3hsFHiyO/9hEyFA4v41BcBD?=
 =?us-ascii?Q?VQ+R3y4CjzOniHz7jbaShji2RuKNJdLgl0nk9pp/TwDuwo+dntPay9T9qEyD?=
 =?us-ascii?Q?UWCjEbkLZPCjPa89cHa0ha9Xj2lGi+kxgd2wQxCuIOgZSCFBEaMYguADJFuj?=
 =?us-ascii?Q?G4sJo8vrubsveZxb/CQQgTWwMRgJw1jaGmM1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASV1a/rVpl3TFramRDoydviAQwtoOOEBpevClGUVcJGHFaX00+q8NH0AoIfY?=
 =?us-ascii?Q?ASwuKJ4uTenaPtSr7mUoicQIMSdOdniR0TCATh/msnnPZjGTNf0bzo3hQEGr?=
 =?us-ascii?Q?8dThcTERH1KyilLt7kJei2Cs78kHG2iPtizaLnH+AVmVnsaf47Nqd3PVIYL3?=
 =?us-ascii?Q?jhhpJ6nkv2HkhrP9XnTFxNo0RTW4zrhBeEP4htmUuO0BKq4DARwZ/yMdVa43?=
 =?us-ascii?Q?s8UQ7APYik/gsVrH2CAFSZuBPDQ+xWx3Pr6v/DTUIL0cJHuI2kWNjQepYN4t?=
 =?us-ascii?Q?p+vCUXM/t1Df1rJ4v5hYf429Z9Y52+/7L9337XDxrsg6Dc7orHFhciKBhaDO?=
 =?us-ascii?Q?PZ6pbPvlRlykJLJaxvM9LkagFowx7F6WTdG5GHRPm+iyGBdoWcTkHgjLmrHg?=
 =?us-ascii?Q?3TCqaWqvPq7OjCv+P8d5eOs8OZMCdYge2IKfG7Ti1spUrFZyAHYzTxYC0xTD?=
 =?us-ascii?Q?oJ0ozkIbHSPKQkqsvGEjLVbSpGWscPsyDh+r2sY5H3KvxiW4PvRLz4MSYSPr?=
 =?us-ascii?Q?9HYr8z8z+JffqR005XY7IfDqfp6JSLRSJDQSBFwvWLUPtSkaf88+x6j1mejY?=
 =?us-ascii?Q?06kIuSKGrz/MZVfe2JKdE10H/YWj+/aQoaryAAm/SC1Ds9ad9CkEGRREa3h9?=
 =?us-ascii?Q?cucGuuodr1bTmV95xaIKE/eS1Ww5g7jcHLsCTqINoBufHirnFqfdHgrhy3lP?=
 =?us-ascii?Q?pdaLgd7Q09Zy3mFWEu2kwlwbcotJNXkIhDmV9oTUDH0bqwGAiNFE9cH5wfdM?=
 =?us-ascii?Q?jmcFm6Ggudo0jGxrqYOUmmJN/4quLQer/E8027YTfnn2W+D06CtXInf+yeqx?=
 =?us-ascii?Q?XB2yyKxPyqUmTbgRh6UxcdTZqgua3Gs0915TDQlpdWbPcUAOe7JMBodIkxcA?=
 =?us-ascii?Q?Mv2vlu9DrnPtbM69DF5K6I2X5d5usuhy7F8Bovjv1hi4L44090A7njTN4Y6N?=
 =?us-ascii?Q?lxTifkjpBoXupGhw3m+UIL25yRyOhNtwvPLUqCI4JrtN39sOs6a4v/c/GaAU?=
 =?us-ascii?Q?RHYAaEFyHJBpQPjBYOaIBjb1THPPQzb1Xrjg37W9Ljs2zg0DhH5S8wNn7LXw?=
 =?us-ascii?Q?4tpke+nAdRH9jInrENeSk+Es6yYYfASHOg4ILDpexuZcDAjxcpDemSae0edD?=
 =?us-ascii?Q?UuXfRGYHGe0CausJBOnGFlQj+LMwtDo+w98OdJavP6U8LSRwBs/eXXSY5xw5?=
 =?us-ascii?Q?g7vJEo4UW13hbrveiOXEsgh15a8vjso3XxYkGM0Fiya7pmCS4KhA/WDE3eHd?=
 =?us-ascii?Q?7oIPK3O7rYOeTwVXfMUgOeDGup0QbKY8ydEGL8dFignI0KhisJoKhS1jtrnZ?=
 =?us-ascii?Q?nufOKbKw4TKKclHk4qrq4b52bEcDkUnf09J0yg4Mk0dNiiIRbWZ0BUhf2puq?=
 =?us-ascii?Q?Vl3GO/3xFbwdN78biXFYchyiCvMESYiEIJjmVU/MtK83zSxoR37yu5MqDpZB?=
 =?us-ascii?Q?QBwWLrJ8E156jhAIOcQSy+ogxgaj3OQ2re+Yb7hfmnYVrTZjDKLMaeiiswRV?=
 =?us-ascii?Q?KzAcNAIIZ5wcCgYGGbJ8pXaCFkFUWkA3U6voGsiVHymRtszu/6f9c5VWo0wy?=
 =?us-ascii?Q?0EPunJtv5oUVvJfBUpfxDbJY7/SJDJFguRvXVGzZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde3e993-181c-4eab-633c-08de31783507
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:55:49.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fkp631rkUel99lpTBX8J25jIpD7hITeqCCrR7B8mcB3qt8T4TjqDhfVcvKOl8AHa2luvyGQkTYxkeTUdRK/1Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

Add a helper function to handle clearing DMA mode, including getting the
maximum watermark length and submitting the DMA request. This refactoring
makes the code more concise and improves readability.
No functional changes.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-imx.c | 164 +++++++++++++++++++++++-------------------
 1 file changed, 92 insertions(+), 72 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e78e02a84b50..012f5bcbf73f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1437,6 +1437,94 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 	return secs_to_jiffies(2 * timeout);
 }
 
+static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
+			      struct spi_transfer *transfer)
+{
+	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
+	struct spi_controller *controller = spi_imx->controller;
+	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
+	unsigned long transfer_timeout;
+	unsigned long time_left;
+
+	/*
+	 * The TX DMA setup starts the transfer, so make sure RX is configured
+	 * before TX.
+	 */
+	desc_rx = dmaengine_prep_slave_sg(controller->dma_rx,
+					  rx->sgl, rx->nents, DMA_DEV_TO_MEM,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_rx) {
+		transfer->error |= SPI_TRANS_FAIL_NO_START;
+		return -EINVAL;
+	}
+
+	desc_rx->callback = spi_imx_dma_rx_callback;
+	desc_rx->callback_param = (void *)spi_imx;
+	dmaengine_submit(desc_rx);
+	reinit_completion(&spi_imx->dma_rx_completion);
+	dma_async_issue_pending(controller->dma_rx);
+
+	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
+					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_tx) {
+		dmaengine_terminate_all(controller->dma_tx);
+		dmaengine_terminate_all(controller->dma_rx);
+		return -EINVAL;
+	}
+
+	desc_tx->callback = spi_imx_dma_tx_callback;
+	desc_tx->callback_param = (void *)spi_imx;
+	dmaengine_submit(desc_tx);
+	reinit_completion(&spi_imx->dma_tx_completion);
+	dma_async_issue_pending(controller->dma_tx);
+
+	spi_imx->devtype_data->trigger(spi_imx);
+
+	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
+
+	/* Wait SDMA to finish the data transfer.*/
+	time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
+						transfer_timeout);
+	if (!time_left) {
+		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
+		dmaengine_terminate_all(controller->dma_tx);
+		dmaengine_terminate_all(controller->dma_rx);
+		return -ETIMEDOUT;
+	}
+
+	time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
+						transfer_timeout);
+	if (!time_left) {
+		dev_err(&controller->dev, "I/O Error in DMA RX\n");
+		spi_imx->devtype_data->reset(spi_imx);
+		dmaengine_terminate_all(controller->dma_rx);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
+				     struct spi_transfer *transfer)
+{
+	struct sg_table *rx = &transfer->rx_sg;
+	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
+	unsigned int bytes_per_word, i;
+
+	/* Get the right burst length from the last sg to ensure no tail data */
+	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
+	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
+		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
+			break;
+	}
+	/* Use 1 as wml in case no available burst length got */
+	if (i == 0)
+		i = 1;
+
+	spi_imx->wml = i;
+}
+
 static int spi_imx_dma_configure(struct spi_controller *controller)
 {
 	int ret;
@@ -1484,26 +1572,10 @@ static int spi_imx_dma_configure(struct spi_controller *controller)
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
-	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
-	unsigned long transfer_timeout;
-	unsigned long time_left;
 	struct spi_controller *controller = spi_imx->controller;
-	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
-	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
-	unsigned int bytes_per_word, i;
 	int ret;
 
-	/* Get the right burst length from the last sg to ensure no tail data */
-	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
-	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
-		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
-			break;
-	}
-	/* Use 1 as wml in case no available burst length got */
-	if (i == 0)
-		i = 1;
-
-	spi_imx->wml =  i;
+	spi_imx_dma_max_wml_find(spi_imx, transfer);
 
 	ret = spi_imx_dma_configure(controller);
 	if (ret)
@@ -1516,61 +1588,9 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	}
 	spi_imx->devtype_data->setup_wml(spi_imx);
 
-	/*
-	 * The TX DMA setup starts the transfer, so make sure RX is configured
-	 * before TX.
-	 */
-	desc_rx = dmaengine_prep_slave_sg(controller->dma_rx,
-				rx->sgl, rx->nents, DMA_DEV_TO_MEM,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc_rx) {
-		ret = -EINVAL;
-		goto dma_failure_no_start;
-	}
-
-	desc_rx->callback = spi_imx_dma_rx_callback;
-	desc_rx->callback_param = (void *)spi_imx;
-	dmaengine_submit(desc_rx);
-	reinit_completion(&spi_imx->dma_rx_completion);
-	dma_async_issue_pending(controller->dma_rx);
-
-	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
-				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc_tx) {
-		dmaengine_terminate_all(controller->dma_tx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -EINVAL;
-	}
-
-	desc_tx->callback = spi_imx_dma_tx_callback;
-	desc_tx->callback_param = (void *)spi_imx;
-	dmaengine_submit(desc_tx);
-	reinit_completion(&spi_imx->dma_tx_completion);
-	dma_async_issue_pending(controller->dma_tx);
-
-	spi_imx->devtype_data->trigger(spi_imx);
-
-	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
-
-	/* Wait SDMA to finish the data transfer.*/
-	time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
-						transfer_timeout);
-	if (!time_left) {
-		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
-		dmaengine_terminate_all(controller->dma_tx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -ETIMEDOUT;
-	}
-
-	time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
-						transfer_timeout);
-	if (!time_left) {
-		dev_err(&controller->dev, "I/O Error in DMA RX\n");
-		spi_imx->devtype_data->reset(spi_imx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -ETIMEDOUT;
-	}
+	ret = spi_imx_dma_submit(spi_imx, transfer);
+	if (ret)
+		return ret;
 
 	return 0;
 /* fallback to pio */
-- 
2.34.1


