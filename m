Return-Path: <linux-spi+bounces-11509-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBAFC845ED
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 11:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD24A34E559
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3CC2EDD5D;
	Tue, 25 Nov 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jp9M3CE7"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AE2ED872;
	Tue, 25 Nov 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065266; cv=fail; b=M8sr+KKaRjF7TJNwy7X06njiAZwFmiZ6BW6tWr3JfElYm4jvkqPVRnSXkN/eXiqdFDdtFKe8J7Oq++M+h5IwKzUubgSZlW6VANBbLJ4WM1nCK8t9u8JLDl+l83TDlJcZ6oiP/nay8M4qGHvy2Wy8EGWUUDyWva7aldNIQt2PoQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065266; c=relaxed/simple;
	bh=fuHIhYLfXcxVm0++I87J5tyl9EMbhR3wm1tZr9uGn0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opXR/W/rMLpK2C4lqVN/4OmADR4bs6LW5C2/pdc2o5qlwLGqYoTSo3HKb1UGjISqYrDriYFuq5badApkXoLev1xpz1EbbkunGLyZa1/qRXFQKd/Hmu2zBGHMKjJHn5Vmm/ecaTn+tjC6Y/eHX5et9mBsluMp/hYBzsrZxSBpg5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jp9M3CE7; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0ergP2CCrGNxelyMT7WEps23uoDHtYzOqP75C6GJo3Ti9MCjHmX7uYu/uFEDFmHHzNnreZXdb1/R2LutlSDsJlJw4y2CVEWFaJ5UyslFORA89TTFxSqmgEFtelThDUhZNF6Zm8QxNC8gMrEELYHZ7wRrHVyq6lrnZnkXHNLtUTmsJcHpEw/9keks+b0bh34zKRMlXvm5a+x0ROWSIG6oyY0Z7FeBZGAcsf+Rn6Y5bCbOgaM1X4iDkWBcOXbU2Fi3DIzQhOx8OHPHceiOQfYWgrcBgYJlqwWkj/jcL6Ak0SDIgRuHSaDAS8Xmdo/fN6GCztIpWwabJAeJgIM+Y3yYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5omwozhtKUB6sgYuzBCRGVqivL/wwxka10LNWSCaZ8=;
 b=nP1Ef1arppiimhT2+noMrRm5nU6f9eG8Au1Ze6uG3JpHU7uukCL/YXYfzOLiR2IUtBELr6TEmFBIMgxGI3FUrLvGazeV9Iq1D6sm9+HdMCLl1ZuFvEB1BmQWAwDKcCx90kuPQqLkvAaK8sulc4fbZyxIGaGnQVR4Pr0VNIsO5J4cZHDGYIJstdWRibGUPSXZanOvUVXzifSTpXm9+sE37gA3M+PPP6ImFhZPBRUvlcWyMS/FWaOxD289+HU/nSaEenW8Z1/wAh9HhxUb1siYrvmoNBUD2EMxL6NTuT6woDTPKYrzVZjymXk7w/Nec1FKkAL20t4p8DfaArbSMj8z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5omwozhtKUB6sgYuzBCRGVqivL/wwxka10LNWSCaZ8=;
 b=Jp9M3CE7PBDeGhu2uxBu7l2ZK5ovsbRpS+OxCx/higCkFzLVoBVFtQomZ/uW84LCD4OwiDmHgCs5ji/CnM0jva9h9vr+6cyHwh8NyQ4Yerg9leKX6gEWUInS12IzTyVcqGWwgRujhBTnKxUVJ53c7+ilJYik0f7ZlHdmEydKIgw8sXCESE+6WUr36ubwdDEaJPo7M9zYpPOrxNYhk4orw6LBoKLfodrKO/5Rl70/H19M+V64zoTtINrfEBRWACHgdpUY+BKLdymIw/c35YnHvwyCoRzBY1taCklFAUs33Ddi1dQfRMQmHJiZI8AuK2mRUep4ExtBJ9cuH+AbkJcBpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DU4PR04MB11340.eurprd04.prod.outlook.com
 (2603:10a6:10:5d2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 10:07:41 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:07:41 +0000
From: Carlos Song <carlos.song@nxp.com>
To: broonie@kernel.org,
	frank.li@nxp.com,
	hawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA mode
Date: Tue, 25 Nov 2025 18:06:17 +0800
Message-Id: <20251125100618.2159770-6-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125100618.2159770-1-carlos.song@nxp.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::14) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|DU4PR04MB11340:EE_
X-MS-Office365-Filtering-Correlation-Id: 639a02df-5263-4632-e650-08de2c0a77b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wHohhoW75vCBtIyW4/M1KZ1UC2FTroPMV3OD6DdsyVdBE0bNYnKTTKu44L1c?=
 =?us-ascii?Q?FEHr4FYqP6Xjx6UBHHyMkmbbsbTJd6dOkjk8wacEfyVffMwlll9Jk6VMshM8?=
 =?us-ascii?Q?zF9XFyBYD+IR/J7j8sf5tVnpsNTKB8KSZxth5aObW7bT2n/wRdC4k+H9n/bh?=
 =?us-ascii?Q?RpH2yAFaXeD/wXVOkKQiHQKd2vGEoO0/ln79rwC4JV9JN4nfEArfbplC5+PD?=
 =?us-ascii?Q?kwGXC5HcNrCJ5etDC7lLr5+fMvI+0HDFVBwyXmY+0MdmjX8DGXDhJR11T30s?=
 =?us-ascii?Q?Ig3ADw95iAFOGTvGhic6oYc4voKnhT7rZy2ep1rxpHyzjWeuyOO7HAHuf8dD?=
 =?us-ascii?Q?3X0aI7oPecKtMqRA70mZnOKebPsND5b10dkGVBA9SLTHbhYI+lP+rguLHjoQ?=
 =?us-ascii?Q?JihloJzJVpjya9h8kcW2hP1zEgjy+wuRVC/NuKMtUgBTl2t8T67cd4Bu/Iq7?=
 =?us-ascii?Q?7je33hFvbogs5Er8n3feriigUqE3Pjc1E3JY79CuXLbk9sRnUCG6WiVKeXU1?=
 =?us-ascii?Q?g+wCACmfr7Y+a7De3tZkd/AVW9JWrXGY3drGi/Pg7kDqH2LSQHIc/CdTg0ar?=
 =?us-ascii?Q?N7SD3iTGJHSLSdjgGp0BK+FTij8647wXgEHne7YJEY7EHdrfyqt+q0/B9UxB?=
 =?us-ascii?Q?4YlJnA1WO7pLA6DX0GBI0cysrG452yuJJzYPQFVI00rkBZJVSTPxJotsLCXg?=
 =?us-ascii?Q?VPQ/SvekhZP69plkKJTnHvAWUv3Y8GuspUv3ijaeDJJyvz47w22XvF5+6czz?=
 =?us-ascii?Q?aPAGUwT11g+AxqDINHHR80vNUszDbJ/0pQC37PqGY2c/8sJNapGx7vlnWEB+?=
 =?us-ascii?Q?AqZVl90LF5mTAZrYOxrUOBD0pawA5v2T2LYOfPtVf4NjuZn7DwPGJ671KX76?=
 =?us-ascii?Q?aa8J67Wr4qmEyQD8JtRUIB+Uezl8ixsX8uvzBPGZYhfbLHN8TDY8vwcvp2De?=
 =?us-ascii?Q?KpOQHaOzjQM6opsAB/VHAEkxCioE8xtFme/9Hg4Ay1tDGqqUnJN1N43OxKEJ?=
 =?us-ascii?Q?tkZKeIK9MbgM1siP+yHsvc0hgs6dBdqwHsJVcqbpU/j5WO4Sk0prikhItGfP?=
 =?us-ascii?Q?pPi7YpTChaPciqxz2qdMtgUzybENTSg/b8Fj4CNgT9kSY5ITdDSZd2EdkYvJ?=
 =?us-ascii?Q?Z7TYgKs9EhNIxan9KBPi0pyAvXeqVA4vQkc4RyESgC43sQ+IXYhLb/JiLxqr?=
 =?us-ascii?Q?whw9EsPmRidMAfRrAFbHjy3aXLvrTVf3Y6A15YYgmIp0RBADl1TPLGdlfvMr?=
 =?us-ascii?Q?UNPusTBmZLQfCaOv+iuqQq69JlJaEKzVJ9e9sMNrcRH3okQeczGSbvOcFOW6?=
 =?us-ascii?Q?MrO/33UUxYu7D9L7EZ5ie+Ww3FXRq38PVEJ/KfScRrJLnTZe2D+FurpAiw+i?=
 =?us-ascii?Q?/SYlYHjIuYPm6g+AFlgpZxgsMHymV+LOJcVq31BxK1jT1biX5niOvAs5AZW9?=
 =?us-ascii?Q?5+s2Vfl5QkT3WSZcHbZoXUncvgeBZdC958HW8jcXzygmfAoqq3rUPzGNaV4t?=
 =?us-ascii?Q?U+ijpbILhu3prbL3vjXY3r2LiFO8l/gLV5m+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NYj+F2WJFKv10Ryvlq8OHSKx4e5H4jAk8DuSoDyA28Xte+O8fShIgYgTngG/?=
 =?us-ascii?Q?CDNgO94opXpnf6FVInj6xX6Wvb08ELgqS2+yDhUKZkbdzrBWFHORjJhMu5H1?=
 =?us-ascii?Q?fjk7cjyiJOPt61ndY4Wl6LwnOloDm5Us1tsHV7WzguTPz+QbygP4+hqI9mTc?=
 =?us-ascii?Q?LV1gHJVa9wB61zXWU4B/wYN8IBRTiIuLdt/4gtOFvUZzmpJXifTPu8Ej60Eo?=
 =?us-ascii?Q?z2YK5/Hj2WkICWtNtQz82qPtjY9iD7ghcBaNy+R0DN+8rQ3+uewaNFLfPxiE?=
 =?us-ascii?Q?ic5sdeVZJZ7bdxQtKNaJXLPU/+yGsyn9YGNg/aLm8VtYwFT0h+vmpot0miEN?=
 =?us-ascii?Q?KpLRVVygyclWzffmXSkRxv9ozl0hIoGm2quWPvtWK+OcyTOWEfOWQss4fy6b?=
 =?us-ascii?Q?9fNc1tIGJQzw+68AwtSCiGPMSX8uwvRLn/8b03yMEEBzTLM1V0lHzARUs2+g?=
 =?us-ascii?Q?hPJhzkYaxH0JrQZodZlx0HBmP+vOnTT9ZLkG8Te4QBtMFs0GNDmT2Mkhl/yG?=
 =?us-ascii?Q?+pbViQt/K/PrN6ls30RrQ5KE9AB9G78dBTGbVSA8iL17wxaFFq7I4affeb5/?=
 =?us-ascii?Q?phI0Ztly3sNF49GvjkvrKD2Dxp25dSDMwUvLCqpR4rPm3OdDTcJBtoiFscA+?=
 =?us-ascii?Q?LjIsRs5f+GlIWennqPHgdXOBfEnT4/wBClNVmHq2aNnhIQTjPn8zBSeP1yBd?=
 =?us-ascii?Q?DhCIg42CveulwFz5iyp0fY1xVH/haWDvqp5Mf8bKeo6c5pRGP/HsQBzTGTtG?=
 =?us-ascii?Q?P0KT0mW639aLPZgSj4ViEyEl9Zg0vxA3nv3MaNkcU/4Fxyju4VaclQBHqmTx?=
 =?us-ascii?Q?6mjTxBNJ9/A2A1JwG54elhlnQxrrmMqKKrWhPjhPK0wb4avZBBI9Z+xVZdcC?=
 =?us-ascii?Q?pJVQjrtAkCuMM/9Ne6IczXDKsjtdHMTJV/Le7TUmhkzK/4H8U9rcbbaOd8Xg?=
 =?us-ascii?Q?8Svqvb426s8aKFJSJsp+42/z0JtF5zO3d8DEBpGZyIpMJJhCCSn83/HsFBLa?=
 =?us-ascii?Q?51G+e/awb2mx1x+WnoZjqc55gJgkXqRSjgzWe2aJReZa7/P5YlQIxa/HJf5R?=
 =?us-ascii?Q?4O0SnSJji4B3mx4iw47Dvg30r+2xujmiWqbHORmZrUMDpp8CtR7KmFCNA8ML?=
 =?us-ascii?Q?DETzKLkSopPaYdpTih+LmjFs9hfgUjSxush7+4FGTGKveGpw5WH8alt0G1lj?=
 =?us-ascii?Q?2e/XriNvfBRypf5BREkQW8w8n1JizRPOb6n1pW1ZGsMKd1kaeMzxopMRnfIh?=
 =?us-ascii?Q?yM/pZPR2Mef/Ku1/oi42CY7SnpNUov5bto5vjB8iPZpmoiniu1Q3c3ogbHvm?=
 =?us-ascii?Q?vqPX3l2stm/vDuQe9o20pQv7PUXxTxhSeQNiADtBm84EL79/Ym4OnDKL9H3x?=
 =?us-ascii?Q?zrCAHfY8GCVAoHmAsvlrf6MKL4vFpC651/sXKhqhqucYrCAxW7sfG6lXM4XO?=
 =?us-ascii?Q?gl3Erb12qYCkqYeh58X68w5fGgGYQYivUF83cRMH6NoiAoKt724UfVollrKf?=
 =?us-ascii?Q?nUGzVy83sQ4ppRQvJavDoju6h6hOEUvUqkOtq6/AbAJWJZogDy33miQjQ5dZ?=
 =?us-ascii?Q?fa7McKSMmk5Ka3DuNreeisEVQ6Fm8jgmVjC376aZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639a02df-5263-4632-e650-08de2c0a77b2
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:07:40.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh1g8+JCduS9pijV/4D+imc3uvYxnmrA7nPJ3U3D8rz/dHfJgEx2XhvQ7rrrspwAZNB1RQH5kuVfVPCCa39C3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11340

ECSPI transfers only one word per frame in DMA mode, causing SCLK stalls
between words due to BURST_LENGTH updates, which significantly impacts
performance.

To improve throughput, configure BURST_LENGTH as large as possible (up to
512 bytes per frame) instead of word length. This avoids delays between
words. When transfer length is not 4-byte aligned, use bounce buffers to
align data for DMA. TX uses aligned words for TXFIFO, while RX trims DMA
buffer data after transfer completion.

Introduce a new dma_package structure to store:
  1. BURST_LENGTH values for each DMA request
  2. Variables for DMA submission
  3. DMA transmission length and actual data length

Handle three cases:
  - len <= 512 bytes: one package, BURST_LENGTH = len * 8 - 1
  - len > 512 and aligned: one package, BURST_LENGTH = max (512 bytes)
  - len > 512 and unaligned: two packages, second for tail data

Performance test (spidev_test @10MHz, 4KB):
  Before: tx/rx ~6651.9 kbps
  After:  tx/rx ~9922.2 kbps (~50% improvement)

For compatibility with slow SPI devices, add configurable word delay in
DMA mode. When word delay is set, dynamic burst is disabled and
BURST_LENGTH equals word length.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-imx.c | 409 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 373 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 42f64d9535c9..f02a47fbba8a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -60,6 +60,7 @@ MODULE_PARM_DESC(polling_limit_us,
 #define MX51_ECSPI_CTRL_MAX_BURST	512
 /* The maximum bytes that IMX53_ECSPI can transfer in target mode.*/
 #define MX53_MAX_TRANSFER_BYTES		512
+#define BYTES_PER_32BITS_WORD		4
 
 enum spi_imx_devtype {
 	IMX1_CSPI,
@@ -95,6 +96,16 @@ struct spi_imx_devtype_data {
 	enum spi_imx_devtype devtype;
 };
 
+struct dma_data_package {
+	u32 cmd_word;
+	void *dma_rx_buf;
+	void *dma_tx_buf;
+	dma_addr_t	dma_tx_addr;
+	dma_addr_t	dma_rx_addr;
+	int dma_len;
+	int data_len;
+};
+
 struct spi_imx_data {
 	struct spi_controller *controller;
 	struct device *dev;
@@ -130,6 +141,9 @@ struct spi_imx_data {
 	u32 wml;
 	struct completion dma_rx_completion;
 	struct completion dma_tx_completion;
+	struct dma_data_package *dma_data;
+	int dma_package_num;
+	int rx_offset;
 
 	const struct spi_imx_devtype_data *devtype_data;
 };
@@ -189,6 +203,9 @@ MXC_SPI_BUF_TX(u16)
 MXC_SPI_BUF_RX(u32)
 MXC_SPI_BUF_TX(u32)
 
+/* Align to cache line to avoid swiotlo bounce */
+#define DMA_CACHE_ALIGNED_LEN(x) ALIGN((x), dma_get_cache_alignment())
+
 /* First entry is reserved, second entry is valid only if SDHC_SPIEN is set
  * (which is currently not the case in this driver)
  */
@@ -253,6 +270,14 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 	if (transfer->len < spi_imx->devtype_data->fifo_size)
 		return false;
 
+	/* DMA only can transmit data in bytes */
+	if (spi_imx->bits_per_word != 8 && spi_imx->bits_per_word != 16 &&
+	    spi_imx->bits_per_word != 32)
+		return false;
+
+	if (transfer->len >= MAX_SDMA_BD_BYTES)
+		return false;
+
 	spi_imx->dynamic_burst = 0;
 
 	return true;
@@ -1398,8 +1423,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 
 	init_completion(&spi_imx->dma_rx_completion);
 	init_completion(&spi_imx->dma_tx_completion);
-	controller->can_dma = spi_imx_can_dma;
-	controller->max_dma_len = MAX_SDMA_BD_BYTES;
 	spi_imx->controller->flags = SPI_CONTROLLER_MUST_RX |
 					 SPI_CONTROLLER_MUST_TX;
 
@@ -1437,10 +1460,252 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 	return secs_to_jiffies(2 * timeout);
 }
 
+static void spi_imx_dma_unmap(struct spi_imx_data *spi_imx,
+			      struct dma_data_package *dma_data)
+{
+	struct device *tx_dev = spi_imx->controller->dma_tx->device->dev;
+	struct device *rx_dev = spi_imx->controller->dma_rx->device->dev;
+
+	dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
+			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+			 DMA_TO_DEVICE);
+	dma_unmap_single(rx_dev, dma_data->dma_rx_addr,
+			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+			 DMA_FROM_DEVICE);
+}
+
+static void spi_imx_dma_rx_data_handle(struct spi_imx_data *spi_imx,
+				       struct dma_data_package *dma_data, void *rx_buf,
+				       bool word_delay)
+{
+#ifdef __LITTLE_ENDIAN
+	unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+	u32 *temp = dma_data->dma_rx_buf;
+#endif
+	void *copy_ptr;
+	int unaligned;
+
+#ifdef __LITTLE_ENDIAN
+	/*
+	 * On little-endian CPUs, adjust byte order:
+	 * - Swap bytes when bpw = 8
+	 * - Swap half-words when bpw = 16
+	 * This ensures correct data ordering for DMA transfers.
+	 */
+	if (!word_delay) {
+		for (int i = 0; i < DIV_ROUND_UP(dma_data->dma_len, BYTES_PER_32BITS_WORD); i++) {
+			if (bytes_per_word == 1)
+				swab32s(temp + i);
+			else if (bytes_per_word == 2)
+				swahw32s(temp + i);
+		}
+	}
+#endif
+
+	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {
+		unaligned = dma_data->data_len % BYTES_PER_32BITS_WORD;
+		copy_ptr = (u8 *)dma_data->dma_rx_buf + BYTES_PER_32BITS_WORD - unaligned;
+	} else {
+		copy_ptr = dma_data->dma_rx_buf;
+	}
+
+	memcpy(rx_buf, copy_ptr, dma_data->data_len);
+}
+
+static int spi_imx_dma_map(struct spi_imx_data *spi_imx,
+			   struct dma_data_package *dma_data)
+{
+	struct spi_controller *controller = spi_imx->controller;
+	struct device *tx_dev = controller->dma_tx->device->dev;
+	struct device *rx_dev = controller->dma_rx->device->dev;
+
+	dma_data->dma_tx_addr = dma_map_single(tx_dev, dma_data->dma_tx_buf,
+					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+					       DMA_TO_DEVICE);
+	if (dma_mapping_error(tx_dev, dma_data->dma_tx_addr)) {
+		dev_err(spi_imx->dev, "DMA TX map failed\n");
+		return -EINVAL;
+	}
+
+	dma_data->dma_rx_addr = dma_map_single(rx_dev, dma_data->dma_rx_buf,
+					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+					       DMA_FROM_DEVICE);
+	if (dma_mapping_error(rx_dev, dma_data->dma_rx_addr)) {
+		dev_err(spi_imx->dev, "DMA RX map failed\n");
+		goto rx_map_err;
+	}
+
+	return 0;
+
+rx_map_err:
+	dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
+			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+			 DMA_TO_DEVICE);
+	return -EINVAL;
+}
+
+static int spi_imx_dma_tx_data_handle(struct spi_imx_data *spi_imx,
+				      struct dma_data_package *dma_data,
+				      const void *tx_buf,
+				      bool word_delay)
+{
+#ifdef __LITTLE_ENDIAN
+	unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+	u32 *temp;
+#endif
+	void *copy_ptr;
+	int unaligned;
+
+	if (word_delay) {
+		dma_data->dma_len = dma_data->data_len;
+	} else {
+		/*
+		 * As per the reference manual, when burst length = 32*n + m bits, ECSPI
+		 * sends m LSB bits in the first word, followed by n full 32-bit words.
+		 * Since actual data may not be 4-byte aligned, allocate DMA TX/RX buffers
+		 * to ensure alignment. For TX, DMA pushes 4-byte aligned words to TXFIFO,
+		 * while ECSPI uses BURST_LENGTH settings to maintain correct bit count.
+		 * For RX, DMA receives 32-bit words from RXFIFO; after transfer completes,
+		 * trim the DMA RX buffer and copy the actual data to rx_buf.
+		 */
+		dma_data->dma_len = ALIGN(dma_data->data_len, BYTES_PER_32BITS_WORD);
+	}
+
+	dma_data->dma_tx_buf = kmalloc(dma_data->dma_len, GFP_KERNEL | __GFP_ZERO);
+	if (!dma_data->dma_tx_buf)
+		return -ENOMEM;
+
+	dma_data->dma_rx_buf = kmalloc(dma_data->dma_len, GFP_KERNEL | __GFP_ZERO);
+	if (!dma_data->dma_rx_buf) {
+		kfree(dma_data->dma_tx_buf);
+		return -ENOMEM;
+	}
+
+	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {
+		unaligned = dma_data->data_len % BYTES_PER_32BITS_WORD;
+		copy_ptr = (u8 *)dma_data->dma_tx_buf + BYTES_PER_32BITS_WORD - unaligned;
+	} else {
+		copy_ptr = dma_data->dma_tx_buf;
+	}
+
+	memcpy(copy_ptr, tx_buf, dma_data->data_len);
+
+	/*
+	 * When word_delay is enabled, DMA transfers an entire word in one minor loop.
+	 * In this case, no data requires additional handling.
+	 */
+	if (word_delay)
+		return 0;
+
+#ifdef __LITTLE_ENDIAN
+	/*
+	 * On little-endian CPUs, adjust byte order:
+	 * - Swap bytes when bpw = 8
+	 * - Swap half-words when bpw = 16
+	 * This ensures correct data ordering for DMA transfers.
+	 */
+	temp = dma_data->dma_tx_buf;
+	for (int i = 0; i < DIV_ROUND_UP(dma_data->dma_len, BYTES_PER_32BITS_WORD); i++) {
+		if (bytes_per_word == 1)
+			swab32s(temp + i);
+		else if (bytes_per_word == 2)
+			swahw32s(temp + i);
+	}
+#endif
+
+	return 0;
+}
+
+static int spi_imx_dma_data_prepare(struct spi_imx_data *spi_imx,
+				    struct spi_transfer *transfer,
+				    bool word_delay)
+{
+	u32 pre_bl, tail_bl;
+	u32 ctrl;
+	int ret;
+
+	/*
+	 * ECSPI supports a maximum burst of 512 bytes. When xfer->len exceeds 512
+	 * and is not a multiple of 512, a tail transfer is required. In this case,
+	 * an extra DMA request is issued for the remaining data.
+	 */
+	ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	if (word_delay) {
+		/*
+		 * When SPI IMX need to support word delay, according to "Sample Period Control
+		 * Register" shows, The Sample Period Control Register (ECSPI_PERIODREG)
+		 * provides software a way to insert delays (wait states) between consecutive
+		 * SPI transfers. As a result, ECSPI can only transfer one word per frame, and
+		 * the delay occurs between frames.
+		 */
+		spi_imx->dma_package_num = 1;
+		pre_bl = spi_imx->bits_per_word - 1;
+	} else if (transfer->len <= MX51_ECSPI_CTRL_MAX_BURST) {
+		spi_imx->dma_package_num = 1;
+		pre_bl = transfer->len * BITS_PER_BYTE - 1;
+	} else if (!(transfer->len % MX51_ECSPI_CTRL_MAX_BURST)) {
+		spi_imx->dma_package_num = 1;
+		pre_bl = MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1;
+	} else {
+		spi_imx->dma_package_num = 2;
+		pre_bl = MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1;
+		tail_bl = (transfer->len % MX51_ECSPI_CTRL_MAX_BURST) * BITS_PER_BYTE - 1;
+	}
+
+	spi_imx->dma_data = kmalloc_array(spi_imx->dma_package_num,
+					  sizeof(struct dma_data_package),
+					  GFP_KERNEL | __GFP_ZERO);
+	if (!spi_imx->dma_data) {
+		dev_err(spi_imx->dev, "Failed to allocate DMA package buffer!\n");
+		return -ENOMEM;
+	}
+
+	if (spi_imx->dma_package_num == 1) {
+		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+		ctrl |= pre_bl << MX51_ECSPI_CTRL_BL_OFFSET;
+		spi_imx->dma_data[0].cmd_word = ctrl;
+		spi_imx->dma_data[0].data_len = transfer->len;
+		ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[0], transfer->tx_buf,
+						 word_delay);
+		if (ret) {
+			kfree(spi_imx->dma_data);
+			return ret;
+		}
+	} else {
+		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+		ctrl |= pre_bl << MX51_ECSPI_CTRL_BL_OFFSET;
+		spi_imx->dma_data[0].cmd_word = ctrl;
+		spi_imx->dma_data[0].data_len = DIV_ROUND_DOWN_ULL(transfer->len,
+								   MX51_ECSPI_CTRL_MAX_BURST)
+								   * MX51_ECSPI_CTRL_MAX_BURST;
+		ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[0], transfer->tx_buf,
+						 false);
+		if (ret) {
+			kfree(spi_imx->dma_data);
+			return ret;
+		}
+
+		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+		ctrl |= tail_bl << MX51_ECSPI_CTRL_BL_OFFSET;
+		spi_imx->dma_data[1].cmd_word = ctrl;
+		spi_imx->dma_data[1].data_len = transfer->len % MX51_ECSPI_CTRL_MAX_BURST;
+		ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[1],
+						 transfer->tx_buf + spi_imx->dma_data[0].data_len,
+						 false);
+		if (ret) {
+			kfree(spi_imx->dma_data[0].dma_tx_buf);
+			kfree(spi_imx->dma_data[0].dma_rx_buf);
+			kfree(spi_imx->dma_data);
+		}
+	}
+
+	return 0;
+}
+
 static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
+			      struct dma_data_package *dma_data,
 			      struct spi_transfer *transfer)
 {
-	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 	struct spi_controller *controller = spi_imx->controller;
 	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	unsigned long transfer_timeout;
@@ -1451,9 +1716,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
 	 * before TX.
 	 */
-	desc_rx = dmaengine_prep_slave_sg(controller->dma_rx,
-					  rx->sgl, rx->nents, DMA_DEV_TO_MEM,
-					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc_rx = dmaengine_prep_slave_single(controller->dma_rx, dma_data->dma_rx_addr,
+					      dma_data->dma_len, DMA_DEV_TO_MEM,
+					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_rx) {
 		transfer->error |= SPI_TRANS_FAIL_NO_START;
 		return -EINVAL;
@@ -1471,9 +1736,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_rx_completion);
 	dma_async_issue_pending(controller->dma_rx);
 
-	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
-					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
-					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc_tx = dmaengine_prep_slave_single(controller->dma_tx, dma_data->dma_tx_addr,
+					      dma_data->dma_len, DMA_MEM_TO_DEV,
+					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx)
 		goto dmaengine_terminate_rx;
 
@@ -1521,16 +1786,16 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 }
 
 static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
-				     struct spi_transfer *transfer)
+				     struct dma_data_package *dma_data,
+				     bool word_delay)
 {
-	struct sg_table *rx = &transfer->rx_sg;
-	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
-	unsigned int bytes_per_word, i;
+	unsigned int bytes_per_word = word_delay ?
+				      spi_imx_bytes_per_word(spi_imx->bits_per_word) :
+				      BYTES_PER_32BITS_WORD;
+	unsigned int i;
 
-	/* Get the right burst length from the last sg to ensure no tail data */
-	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
 	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
-		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
+		if (!dma_data->dma_len % (i * bytes_per_word))
 			break;
 	}
 	/* Use 1 as wml in case no available burst length got */
@@ -1540,25 +1805,29 @@ static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
 	spi_imx->wml = i;
 }
 
-static int spi_imx_dma_configure(struct spi_controller *controller)
+static int spi_imx_dma_configure(struct spi_controller *controller, bool word_delay)
 {
 	int ret;
 	enum dma_slave_buswidth buswidth;
 	struct dma_slave_config rx = {}, tx = {};
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 
-	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
-	case 4:
+	if (word_delay) {
+		switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
+		case 4:
+			buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			break;
+		case 2:
+			buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+			break;
+		case 1:
+			buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
 		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		break;
-	case 2:
-		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		break;
-	case 1:
-		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		break;
-	default:
-		return -EINVAL;
 	}
 
 	tx.direction = DMA_MEM_TO_DEV;
@@ -1584,15 +1853,17 @@ static int spi_imx_dma_configure(struct spi_controller *controller)
 	return 0;
 }
 
-static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
-				struct spi_transfer *transfer)
+static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
+					struct dma_data_package *dma_data,
+					struct spi_transfer *transfer,
+					bool word_delay)
 {
 	struct spi_controller *controller = spi_imx->controller;
 	int ret;
 
-	spi_imx_dma_max_wml_find(spi_imx, transfer);
+	spi_imx_dma_max_wml_find(spi_imx, dma_data, word_delay);
 
-	ret = spi_imx_dma_configure(controller);
+	ret = spi_imx_dma_configure(controller, word_delay);
 	if (ret)
 		goto dma_failure_no_start;
 
@@ -1603,10 +1874,17 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	}
 	spi_imx->devtype_data->setup_wml(spi_imx);
 
-	ret = spi_imx_dma_submit(spi_imx, transfer);
+	ret = spi_imx_dma_submit(spi_imx, dma_data, transfer);
 	if (ret)
 		return ret;
 
+	/* Trim the DMA RX buffer and copy the actual data to rx_buf */
+	dma_sync_single_for_cpu(controller->dma_rx->device->dev, dma_data->dma_rx_addr,
+				dma_data->dma_len, DMA_FROM_DEVICE);
+	spi_imx_dma_rx_data_handle(spi_imx, dma_data, transfer->rx_buf + spi_imx->rx_offset,
+				   word_delay);
+	spi_imx->rx_offset += dma_data->data_len;
+
 	return 0;
 /* fallback to pio */
 dma_failure_no_start:
@@ -1614,6 +1892,60 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	return ret;
 }
 
+static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
+				struct spi_transfer *transfer)
+{
+	bool word_delay = transfer->word_delay.value != 0;
+	int ret;
+	int i;
+
+	ret = spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
+	if (ret < 0) {
+		transfer->error |= SPI_TRANS_FAIL_NO_START;
+		dev_err(spi_imx->dev, "DMA data prepare fail\n");
+		goto fallback_pio;
+	}
+
+	spi_imx->rx_offset = 0;
+
+	/* Each dma_package performs a separate DMA transfer once */
+	for (i = 0; i < spi_imx->dma_package_num; i++) {
+		ret = spi_imx_dma_map(spi_imx, &spi_imx->dma_data[i]);
+		if (ret < 0) {
+			transfer->error |= SPI_TRANS_FAIL_NO_START;
+			dev_err(spi_imx->dev, "DMA map fail\n");
+			break;
+		}
+
+		/* Update the CTRL register BL field */
+		writel(spi_imx->dma_data[i].cmd_word, spi_imx->base + MX51_ECSPI_CTRL);
+
+		ret = spi_imx_dma_package_transfer(spi_imx, &spi_imx->dma_data[i],
+						   transfer, word_delay);
+
+		/* Whether the dma transmission is successful or not, dma unmap is necessary */
+		spi_imx_dma_unmap(spi_imx, &spi_imx->dma_data[i]);
+
+		if (ret < 0) {
+			dev_dbg(spi_imx->dev, "DMA %d transfer not really finish\n", i);
+			break;
+		}
+	}
+
+	for (int j = 0; j < spi_imx->dma_package_num; j++) {
+		kfree(spi_imx->dma_data[j].dma_tx_buf);
+		kfree(spi_imx->dma_data[j].dma_rx_buf);
+	}
+	kfree(spi_imx->dma_data);
+
+fallback_pio:
+	/* If no any dma package data is transferred, fallback to PIO mode transfer */
+	if ((transfer->error & SPI_TRANS_FAIL_NO_START) && i != 0)
+		transfer->error &= !SPI_TRANS_FAIL_NO_START;
+
+	return ret;
+}
+
 static int spi_imx_pio_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
@@ -1780,9 +2112,14 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 	 * transfer, the SPI transfer has already been mapped, so we
 	 * have to do the DMA transfer here.
 	 */
-	if (spi_imx->usedma)
-		return spi_imx_dma_transfer(spi_imx, transfer);
-
+	if (spi_imx->usedma) {
+		ret = spi_imx_dma_transfer(spi_imx, transfer);
+		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
+			spi_imx->usedma = false;
+			return spi_imx_pio_transfer(spi, transfer);
+		}
+		return ret;
+	}
 	/* run in polling mode for short transfers */
 	if (transfer->len == 1 || (polling_limit_us &&
 				   spi_imx_transfer_estimate_time_us(transfer) < polling_limit_us))
-- 
2.34.1


