Return-Path: <linux-spi+bounces-11742-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D3C9E5AB
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 10:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A547B349266
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5E2D73A7;
	Wed,  3 Dec 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d3IwLcUa"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE972D6E70;
	Wed,  3 Dec 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752450; cv=fail; b=b8SZ0WgsSKNnx8nJWfdTobrNPBX3XkonokMVwG2tzS3Gkci3l5bZp/a2c5bmwxgbdRPG49c8Ab84pydYkz+3SYUbaUjzuqzoAtHJsD5k95UEb+odkB5uji7boGTz/ZY4YwuQJIl4ob1PfewvFciIzDX+06bMzLoUiYRHfPY0D8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752450; c=relaxed/simple;
	bh=EborCir4qam+eEPdlgjnryTrttyY6rs698YXrBjWPhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2gdmv+iSkGLe69DLFyCCOoJJDr2ykyVoEviqZ6NjeWbdqS/R1DKx+eWfbzPRUtpaYgapzY4IKVpC1XWdfIYHPAEk6VEDe//FxbExQwgyVJ3XC0sGj8F6IBrCbozQAciAmQNIJYXYIcOW2Qu+6EBQOht8f9U8ntibnid0NQGC+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d3IwLcUa; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsRHCKVwDs5RWJTskc01hPZNOm5rtQ43BT/gCyUJo8hxmzuTesU54DDGufV/3FZ/waErSZeGhyvEsU0uXNZT2Ag3ZLi+ILerwlZBrlynSHw4nCLPOZSuvO/8Kv824pZbUAaY3w9kk8hVzRl4NnmJ/vJmKX/B5pmXI24iuKvJFFTTZISppBvjfMQNu03oR8IumnBUCJOwmXAhs9054T+Y8gEGDEQOCAClBHhmlXgt5wMeMfwEqrGF8w4UntrvsHndedn4Z7kQIq04k8XnP3vYWD5yuDIx3OZ7q4UNORMJGaQK+x5OHTQfFHrEbDOBRJuy+ly1NL6Ptdr0kuoovNDTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVkeB7iAyOpsyZzok3gHzZf6pNc/u9xhlnAI6NFRhJU=;
 b=copRFGO8ADtFKsmqxktusDIv8rHcs0z4GB+eK6dyKu8Vrlxgk89c6D5Cf+tFjsnDRj4qd2KY/36mIx6Q6Uv+7mirMDTWbjKg45lGDZExvex4vZZ1r+goDJ4sY94l2VgKOnB534gFUzzVnFirsoHQoMuTe4hSVrmygpjWWvztDENgOC7KXJhQ1hMdg/nEs3xykCE4e+De2J9F2rb45Ty5Y+p6BEfM8c+WftX5uq5jCsVZxBuF7+vLIEX8qWoUlDHVDeFYN9WvQy8kIhnwiOsSCAnCBI2qvMx3pDvf+1ZSKzEfOjclxpYKbOZoa+WSBMEasvhcQC5LU1F5MdDZbwI3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVkeB7iAyOpsyZzok3gHzZf6pNc/u9xhlnAI6NFRhJU=;
 b=d3IwLcUa9LgKwMUvgPbu5A8js1QYwAUCspp2OmUunYHNLarfunpHXwoRIDDHektNEma/UQPBsg5g/9o6QCXWIc0n9t8GTqozwT82Vzdi8ZUN8FRIdQ3PkoE2EshmZ7WN1sIjJ1QZjYR8l6YK/H/smqb1me+/pf35eh7++Dkw1CHFB4aVFvJyaKDJW1F8pdwCIzqodh2k/zFESEr+6/3x37+j+lSR2eztMuiQL0kgmt/cKi4tTZxBU3kD/e5iMvhhbvHtH1F6OSnw/Bhn+s6nEhilAqSifpOmjYHZEZnUZq6SpiumZgvckZgkIwlj3xAv0imk76IGZIYWAYg8Uw/g4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AM0PR04MB6868.eurprd04.prod.outlook.com
 (2603:10a6:208:18c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 09:00:45 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:00:45 +0000
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 5/6] spi: imx: support dynamic burst length for ECSPI DMA mode
Date: Wed,  3 Dec 2025 16:59:48 +0800
Message-Id: <20251203085949.2922166-6-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203085949.2922166-1-carlos.song@nxp.com>
References: <20251203085949.2922166-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::27) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|AM0PR04MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 987927b4-afa8-49f8-1f14-08de324a7168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPGfSagLjFq4jhu/FrbTlCkyklXej9aXLZMQeEmkQ3hF1wJLs4NMC+cdJU4+?=
 =?us-ascii?Q?gq2OQFkPcEef+jjQ4N6+a5/H7vxVX3/Lqgyzt8BNoMXQvNRQ29nDDUy6QEiL?=
 =?us-ascii?Q?1/CagiBzG1tFCVP6omTUr+iwwon5zgmdtCSioCajHHgWsy8EsYVi3xy8YOhO?=
 =?us-ascii?Q?8wxmC2D/LJShXUk8MusQ2QfRa9nu1DCei8tWTWWl6NF4nQFPTgMCP/V2fuks?=
 =?us-ascii?Q?67/B84rPCa7RAmxElv/hkZRI49T01zk5V2FPSpxRkaW2Izxucabl7vSNo3iY?=
 =?us-ascii?Q?ifkDeCqDXUpiCAyNAnQ1qdsl1Wq/xrF3kJKSXMPMH5/cHBy2OOKGWp/bUADW?=
 =?us-ascii?Q?r2g2Mnz67vGAPrMnTYLlL7mNyjAaYRIx8VHkWB+eW3AoOYBsU/4uInWi9n44?=
 =?us-ascii?Q?RCS8V/BPst5rRgD0VwvsB4X0oDMGyvL13XCPJpd0HnMevKXxdMm+7ZI1Wjav?=
 =?us-ascii?Q?y/CO2x+xsnsVh7sxeX3c/HuxzpBlemHIDVIFgUU7kMD9HApA43EBCBX1EwPs?=
 =?us-ascii?Q?7IuLFUE7W2sOiOW8YTFyqJlEGaMEBlnNTITRvI6eNVxa1BkNylGem9XgCGLg?=
 =?us-ascii?Q?Jwjk12bNuwG2Gnzm2H6YrLs3ZgD4zj6RO0+JaHLOxaZ80aZaYTkY3XSOHLfw?=
 =?us-ascii?Q?CizBiIbIFoITtlzjayEeohlxM4RhhFFykT3yCdshRkY4MLzkl5zC/Te3xGeY?=
 =?us-ascii?Q?aYk03D4WkBcWsGRp+0A2vvEwXtUq9NRkTTIIZLCNmHVT1aq1ZejsJQ6h9wID?=
 =?us-ascii?Q?b6VVTNST99IBJqELR+3h20UeUDXzPxu18US0SnlhVZl7QEztHkbAZHsr/PDD?=
 =?us-ascii?Q?/nj/cCwZhDxn0i86b5HRSx7EJFs7TBxsZigZs6cr2S4zsxGOefYhtYH65hxy?=
 =?us-ascii?Q?cMq1ZRXzXdhPw4nWC6iKYGzEXINtvu29bhmKqYFRXPzk6EnKYWqoWg1U4Q1N?=
 =?us-ascii?Q?ojE+znME82IGBB809DG8GTR1Kukc1jBLBaJBtIPRXuooe/swr0+/yPaiRq1o?=
 =?us-ascii?Q?I/vddw929A+MhA43zxBgXcO79r3FxolHoZAMM2hO1TilbTVGbBLiOmC/+DLS?=
 =?us-ascii?Q?jhRva2G+iPYIoWjzyAIXNrRMgRsUVdhOtR/H/yTXlVXAk05TRh46J6okXa1J?=
 =?us-ascii?Q?Irdu85osKc5kRJmK7EWSDv1l3THS/7XcNvli47sLNdLypZCBz/7HhRztGurx?=
 =?us-ascii?Q?uuhR5tYfAZyPYOPExkNz+cLh9rnCow0Qh+jkExFVFLM486D0ePQVHd4IdH2V?=
 =?us-ascii?Q?go0e/a8j1HgYxSOXuj3+bDKL6W8Ko2SCPEnpbODXwYMi7c5yVx/NYuG1Kop0?=
 =?us-ascii?Q?RkbyUZSsAg+JKcCTAOgeb8ocqv5I7xNHZVZkDUVYf0yjbH4DbtWPF6+2IGNk?=
 =?us-ascii?Q?VnKg3ly/fHWX5w4m8KT+VlOaPP+/osgIc8q819DIx39VtNIt3aOZlq+Gucd9?=
 =?us-ascii?Q?NO4rsjntXKsOsWu0FUg2fI0ed19qLvlU4qJpmvNnVnP3j3Ws4yNVF4e0lXOo?=
 =?us-ascii?Q?TYsra57pj5sgmgFesP9A03Pzv3cAG0Piiv89?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UlbJaMN5bRXALsrKXrpPjYYzhULqHaGIUfpa2HZet10vQVVf0P56XeXkoFPE?=
 =?us-ascii?Q?ecImTA2405ooMSBkLW5guVKN82lQcnzGHbws5W/LpOGuZSSkcnFD4VgKQBAa?=
 =?us-ascii?Q?W+kN8Xe9ofuCbtgLyCWRq27gxHgCFhnNvHOnS16C4fv1w7X1rbtyC0O3PH1O?=
 =?us-ascii?Q?/mSjG4CabHr6kRJB6BLyoUsiDE6YZ2oEGBJ82/nOGPCCC9u3c4QEhhQ1gpB+?=
 =?us-ascii?Q?oN6uvX4wmCCx66RMesXzRvmweZb5m55cEWlskz7vFsO1XHic+JeqRv2CgTZl?=
 =?us-ascii?Q?F8ENRnEmlsx2v1T6eOqRXPGQPSfRntN7EW/qXozydmt2uMQoKtCmXB/rzrAR?=
 =?us-ascii?Q?/M5Yd0+jX4YY4RDftm8hVCNDcuWApMnBqlGLeS2C3+lcObEgYy2FyEnCGZpC?=
 =?us-ascii?Q?Nx+XpqxjanJh2Oi8vCRJz8ByxqvDXixSFkoFF9R6oCfPmqPqAzuk7mafzSSN?=
 =?us-ascii?Q?49vV3oQZ6ZhGVbhYWilCRIDcnCmYBQdSCDRGbn3123uCh4iC6beOagrkjFiZ?=
 =?us-ascii?Q?td3JNvPkCty21jZrxkoNORz8YqobuOwZqr+ySS1bkjWGCdGWvKvKzBZQySDg?=
 =?us-ascii?Q?jlKvILDAcsQFYCTjwhgS4M1IdxRfMlq2cTHhRyByO0ujlKyUVrmXXzATCRo4?=
 =?us-ascii?Q?4RIFt7uN9b4oxbXEM3IK8teL/4cSC5lRxX/9k1Z0H5aE5tQtUulDKwDbJZcI?=
 =?us-ascii?Q?YN3dU8mNssf/inn4hOi9srXvmAxvFYl+UEp+CvToxvCKUu5ek6HOKxjO2OrB?=
 =?us-ascii?Q?IwgWKb7simg2+67t+G3XJJqAfsiLK1QeI9A1Sccy43XnkFYD2bIqAcAQYabo?=
 =?us-ascii?Q?g0UU6+OSt70DPvL8bbkayHtnJNCDWidDQvMtcWfuaYd6ZS6fxiTw0tqOhfX+?=
 =?us-ascii?Q?07dNhTm5JMqHJ4xn9Do9AAlXQHTJv/0pi3FQTsenX9kcj2OYJk2X2atrdTny?=
 =?us-ascii?Q?crfkytVPndcRR+uFIvMUScZlhaudAnJhnVpOlyJpsDqgN64f5Zve2ybckC1O?=
 =?us-ascii?Q?G4X/bVuDhz8eKNvjVsPhnryvCGOoeNO+NCtZ2LQNammkQOJrls2H5lqTkkfj?=
 =?us-ascii?Q?js6d/2Hni/SI6kJEw56ZIPIfNmoEl1DR6aRPtkg58aqBhczTWx+33/YQvsEe?=
 =?us-ascii?Q?MlmrR0T2BkkEdNaLA3A+qzHJ3OBV6RPNtH+LKZxAOt7oLZ0LLP3PdE+6AOZF?=
 =?us-ascii?Q?pXsfoQ4em5KJjVt1CWoA3VxYiazsrbRTEJrWs98vd579CBbqfYhpXR6yHrCc?=
 =?us-ascii?Q?RQcTM3RVlBfncH/qXP5CNKcxx7DJxV0nZWY8OkfPrHkKz3eaFHA0jPvo7xOA?=
 =?us-ascii?Q?DiRV18N7x0+Lv5qtjq1IABuEXqF6XWUojJwJhyoR/fxKBCyPRK/yRndrL/oS?=
 =?us-ascii?Q?tmK3nWeP2PoXtgV9p7OBkjh8vYGHDxp/fbPCvXDBBfIpopAGXio3h1LMPzwA?=
 =?us-ascii?Q?oYckrGVtgkbRJIwZodt8zjUs0dKr47BBO+k1hFrMl0ADcOilse1wJeLh4IPg?=
 =?us-ascii?Q?SCFQmcRbmOI2H0C2pa2MtGD9O7NpJKt+SfbJKJPr0Yb4bQ4T7kzWfu4WO1b8?=
 =?us-ascii?Q?za+R7S0DNZcmZp/cjc93uLO+kItgO5IJ0S9OAm1V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987927b4-afa8-49f8-1f14-08de324a7168
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:00:45.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ye57I6jhS73wQL7/RGIFFrSHJN6Xqs0iFpfg1OKeXBF0k52Hnb2EAUCek+Cr38HEyQa+SufF4ApFXo+SiUmdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6868

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-imx.c | 413 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 377 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 42f64d9535c9..04a492e7dbeb 100644
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
+	dma_addr_t dma_tx_addr;
+	dma_addr_t dma_rx_addr;
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
+	size_t dma_package_num;
+	struct dma_data_package *dma_data;
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
 
@@ -1437,10 +1460,259 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
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
+	void *copy_ptr;
+	int unaligned;
+
+	/*
+	 * On little-endian CPUs, adjust byte order:
+	 * - Swap bytes when bpw = 8
+	 * - Swap half-words when bpw = 16
+	 * This ensures correct data ordering for DMA transfers.
+	 */
+#ifdef __LITTLE_ENDIAN
+	if (!word_delay) {
+		unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+		u32 *temp = dma_data->dma_rx_buf;
+
+		for (int i = 0; i < DIV_ROUND_UP(dma_data->dma_len, sizeof(*temp)); i++) {
+			if (bytes_per_word == 1)
+				swab32s(temp + i);
+			else if (bytes_per_word == 2)
+				swahw32s(temp + i);
+		}
+	}
+#endif
+
+	/*
+	 * When dynamic burst enabled, DMA RX always receives 32-bit words from RXFIFO with
+	 * buswidth = 4, but when data_len is not 4-bytes alignment, the RM shows when
+	 * burst length = 32*n + m bits, a SPI burst contains the m LSB in first word and all
+	 * 32 bits in other n words. So if garbage bytes in the first word, trim first word then
+	 * copy the actual data to rx_buf.
+	 */
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
+	int ret;
+
+	dma_data->dma_tx_addr = dma_map_single(tx_dev, dma_data->dma_tx_buf,
+					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+					       DMA_TO_DEVICE);
+	ret = dma_mapping_error(tx_dev, dma_data->dma_tx_addr);
+	if (ret < 0) {
+		dev_err(spi_imx->dev, "DMA TX map failed %d\n", ret);
+		return ret;
+	}
+
+	dma_data->dma_rx_addr = dma_map_single(rx_dev, dma_data->dma_rx_buf,
+					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+					       DMA_FROM_DEVICE);
+	ret = dma_mapping_error(rx_dev, dma_data->dma_rx_addr);
+	if (ret < 0) {
+		dev_err(spi_imx->dev, "DMA RX map failed %d\n", ret);
+		dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
+				 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+				 DMA_TO_DEVICE);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int spi_imx_dma_tx_data_handle(struct spi_imx_data *spi_imx,
+				      struct dma_data_package *dma_data,
+				      const void *tx_buf,
+				      bool word_delay)
+{
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
+		 * For RX, DMA always receives 32-bit words from RXFIFO, when data len is
+		 * not 4-byte aligned, trim the first word to drop garbage bytes, then group
+		 * all transfer DMA bounse buffer and copy all valid data to rx_buf.
+		 */
+		dma_data->dma_len = ALIGN(dma_data->data_len, BYTES_PER_32BITS_WORD);
+	}
+
+	dma_data->dma_tx_buf = kzalloc(dma_data->dma_len, GFP_KERNEL);
+	if (!dma_data->dma_tx_buf)
+		return -ENOMEM;
+
+	dma_data->dma_rx_buf = kzalloc(dma_data->dma_len, GFP_KERNEL);
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
+	unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+	u32 *temp = dma_data->dma_tx_buf;
+
+	for (int i = 0; i < DIV_ROUND_UP(dma_data->dma_len, sizeof(*temp)); i++) {
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
+	 * and is not a multiple of 512, a tail transfer is required. BURST_LEGTH
+	 * is used for SPI HW to maintain correct bit count. BURST_LENGTH should
+	 * update with data length. After DMA request submit, SPI can not update the
+	 * BURST_LENGTH, in this case, we must split two package, update the register
+	 * then setup second DMA transfer.
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
+		spi_imx->dma_data[0].data_len = round_down(transfer->len,
+							   MX51_ECSPI_CTRL_MAX_BURST);
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
@@ -1451,9 +1723,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
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
@@ -1471,9 +1743,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
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
 
@@ -1521,16 +1793,16 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
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
@@ -1540,25 +1812,29 @@ static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
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
@@ -1584,15 +1860,17 @@ static int spi_imx_dma_configure(struct spi_controller *controller)
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
 
@@ -1603,10 +1881,17 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
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
@@ -1614,6 +1899,57 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
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
+			if (i == 0)
+				transfer->error |= SPI_TRANS_FAIL_NO_START;
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
+	return ret;
+}
+
 static int spi_imx_pio_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
@@ -1780,9 +2116,14 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
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


