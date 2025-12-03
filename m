Return-Path: <linux-spi+bounces-11743-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841BAC9E59C
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 10:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8033A4A12
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168962D979B;
	Wed,  3 Dec 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h85CwMjQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7342D7D2E;
	Wed,  3 Dec 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752458; cv=fail; b=CykJ6Moaum7qFcyEUdU+UZdZkpSNFsBqF0niSfpTTTF8AUruV3QIadIm4opLKUgEaUWP3nxcvBSR5dM8okAhAlQHii3viHOgO0JOc+nRFYQOsFTWEoBKpfeB5q1EOWqwlpDcDy2hCg+c6sWHSeUmm2oz4c8ZeALNNOgxXeFhx+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752458; c=relaxed/simple;
	bh=jkxY2bkg0TcHRYCBDmLxafdUtO4TAzRixmnKbi8rEAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+5DAA0x6p/qK9N/seKNEpu/zQ/PbRiie5S/pyZm/c2Ky7p5MJhWufiKYE7e5yDCyYNhi+afYfWqiR0bxu7UMnX8YZBh0vBPeIM/ZEFqhJjRxrTQ78VHtxkcOmb4CRg4gk+i0HSaC7KMFKGBCFHvaxnkNyXSYn335Qq/MsO24rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h85CwMjQ; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RL9H1QIluKc3ZrA7wqKroB/KtYPs1g7coRjdsxVYwM+JjZ/baO1+opuycripbvU+Tt1dY20xLNIdz7KqbEBxHhW6qdQvOGt2mqCd/GFTW9/X6B56gJxcoRMEd1T5Mnj219v6AyXKSO1pZ7HyZ4A66WZjDvoDBT9FimAvoQuEskKvtV6UD089MFr63pNXHcW2CQQKBM4/AAuNRkai+2Vhf3GVjCz5dClFPTDSMy69x8t5oaH4he2+BGTnHIcR/mUSUz1HXsdLK0gvFIUYkvdmh5R5Us6XzuIelenHLOVZ7qqrGEdLCidQOQVpHqKTf9GeHdZY8DWoEKFFLRQPVZGXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2Pfr5aps/xEZ5KQ2jqoZlAKVnhnD7dxYFk+wcBi31w=;
 b=LvmF/IGuoxPcU9QnHfDYJLq/ens61Yq+8kQL7BbRyFrsXXIXKJskDsd5K5JV7Qf+q3rU41MBxq+MEVhPmH/W4KIDGs0m+a0xQHkOkSJhHsYpa6/LR9o7hXffBBaqImYzVCPgTvQDZ8srWVIv9P793i7MQVHOmLhkY+fpIw5N0fvQky8+Glp6hyKDNrZb1yikUMvRDOFoXmmolqc1rAbJqfWufrYCfzvz+wLhSR5e2XZK9VVOwhwN5oT4yridXNwFv0GwYw777JUN28NPH8OhRHqAWSUMQ+V4f2i3c9kQZeJtQ+7KS/btZT2ZMpP2nTj65tP08Xy0wEkl/xafGg2P/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Pfr5aps/xEZ5KQ2jqoZlAKVnhnD7dxYFk+wcBi31w=;
 b=h85CwMjQ5fqqc9QUJFVnbcOCy41MkSnzt5gRsFjSaJ4xSZCqSRal1MOKMk258gz43Tnufw8sQbqEuXGvmnm6aJdxNZtfBvnva9HnHBnkZZmQu09OvPokOLXgXl0PLod1dky/xPFSBV3BHP8gukzG7u4KxA+7G3ONbmZHB/IasWVOciV0N3qrJeqqOOwfLmCfBiSws6amIs5FXdFqKwbd75U6aGrO0iSrzj/tnHLPvWG7HTM3jTJKacT2kjyuuhigHxTWDIom7WSsSYQkzvw7QLuQ1FkGZqIG/PFJyCsORbi9Yito2qdOcWboSicWR5qV8TzxN85XuyIiBRwjMLPIpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AM0PR04MB6868.eurprd04.prod.outlook.com
 (2603:10a6:208:18c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 09:00:52 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:00:52 +0000
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
Subject: [PATCH v3 6/6] spi: imx: enable DMA mode for target operation
Date: Wed,  3 Dec 2025 16:59:49 +0800
Message-Id: <20251203085949.2922166-7-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a0b44db4-25e2-4d93-3b1b-08de324a7597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tlF843RdE8+C+ODP0mKdoMowHQAYUtdl4sNa8FXLiMDCJppyPJiW7xd5eOk1?=
 =?us-ascii?Q?XI9l7bsWs8Vx7J2ZFJjAUyrPFLdxXYlAwYtI2q+hQaQWbbIQgvivhxPj+1Y5?=
 =?us-ascii?Q?fpTLFYuVsbIe7EbQt/WaOej3QonnoVakXQvd4KNv5zXP+EgpNBBS6SNd7CpR?=
 =?us-ascii?Q?HLUn/4sa0jZMT0BVS8ApE8xBd/E3Swd27hwZRTzNfSTCwet1HXuvgAw+XBl0?=
 =?us-ascii?Q?9MG2AL082KSAc9SImpPy4YJV4uiTkbrqBHTofu2XAzGjlCNtmQX4Y11VatNd?=
 =?us-ascii?Q?MKQJbw8j975t90SDKZT7oBMbKMf8Xdfssj0lGgYbUQUP8LP68UpFqzZCiEMh?=
 =?us-ascii?Q?fAIclUs7JjgjRo03Tlsqp2JwLF8UdVJI3AfdMvGhcCNggygf3qo9Tyf1TKg7?=
 =?us-ascii?Q?sWbGPTxZElv6P/BM08rojnrwBoG7PtKhJQE4P1XJN8ncHEHIecWN4kOiP8Ve?=
 =?us-ascii?Q?LiY7hDiCJRMFNbQWtWqOxSxLkx2OYzE5erzBp7a/7ctLko1PD4OL9TES3QG9?=
 =?us-ascii?Q?MgugvAFntnUOG/4yYmp5d38o70h3qpD4+tjCJT/Kjjj5x7iZjycQ8Etb3LlE?=
 =?us-ascii?Q?ulgjFmCbC+bvbGG8whXbM9gEToF1Bgy6QTJV2fdBMCsDSE5juvlyx0GcQgkN?=
 =?us-ascii?Q?TPXRk7QR+b6Gi3trvfkiVkZ39ED0p8DGotYr0b1dQpgn1UqEudSMJ/4CCzvv?=
 =?us-ascii?Q?hKNrJKPnakOd4o2eYX7IIC75e2bVUuGvxq8Xp7AoX0jRZAy9n8ITUUni9Pxp?=
 =?us-ascii?Q?rDu3UXnBwQ92zMFQPDACn2pIVYZhlG0kZhBnSoYBIpoIChY2pQfT0ZXTIocY?=
 =?us-ascii?Q?iXd+3wrp3oeLoI/qH7b5/0gHTay4MWKCye9F5OxGELjfdMUO+btSsFLWP81f?=
 =?us-ascii?Q?DuvTnSOHYqHhxH6damHtq9aLmbLH8J2K79gQtWVu4YMEoPpervmd+C+BPDaY?=
 =?us-ascii?Q?HiTGh+X49APDX/RPwOtMBfSgW8cTMxwi6d/YvXBYLu8RpUkhAo89r+Lfje8k?=
 =?us-ascii?Q?13TQJWie/v6PkXarfRA1otznUujDlqWC1xVw1codnz8DTpZ89LjUQ7Zn0Z8s?=
 =?us-ascii?Q?vbXuzbr6NdFLR1vo5q1tiGxB2ppeUqskPp5MU3lPnMdBbz2Na51wnqBoaTH7?=
 =?us-ascii?Q?s4YmdHq2lbC3MOXcJtKMv5GT5cjoh55aCongppDF2xDI6tO5u7BN3ZOh1lW6?=
 =?us-ascii?Q?5/eaG3HvQF/wY1YtxpZlFD9tI+bdWi/n97wVExt9RViuD3oNPrZYXb9VizCG?=
 =?us-ascii?Q?fJM6+L1S47Iy78i51ADzQhXY2LscXoE/ynbfQu89vsa0CWboaKuJeV5U9IFk?=
 =?us-ascii?Q?IDl3cIuQNeFBkrtTEh2sj0MNJ7rQZ09S2vSJrTC5XHu5Ng0ZtUhdxa5ktUIM?=
 =?us-ascii?Q?I2VlaRb2psne13XFjMqibvmoDFAJ13VnhBbzZlKtDFs9LMydPROcSFWCKtmR?=
 =?us-ascii?Q?34UC1yXqxTvOD5hJBEK3t640WQ89Az+vlckhyByG4GKF8R3kZY1K6bgVH6VU?=
 =?us-ascii?Q?iUrisCznJHrh3bkjqvWAWNdelYVMPhn9EGl7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g/m64OiYMNGFVkVkVYZnLgaa75s2K1kE4/lZLMN0nHUjCE21Aj2eAGEH/iof?=
 =?us-ascii?Q?0um70bisWfSC/ptwzSSqbl6uOGJo+eO4Ti4kArK/TbtUehsFMU4FeIPckrte?=
 =?us-ascii?Q?ktL2wnnjFc3tCtOO274AsCMSAYaFbExiKC4Yxk5o7sSH0kLAD13Y+07m+m7C?=
 =?us-ascii?Q?l2nCa/phK0aQKafQWuK0SC+Fr9kMBbJhrKP8+oUtgnSCSzxindMTuix3+GY1?=
 =?us-ascii?Q?JsH1l5EnYemIw1tryAx5q2opCpmB+gDaIzzyY8g5xJqf7aGTSQCr1X6WV98H?=
 =?us-ascii?Q?hqvsDS0QQA4rxOuJdhPVPs2gi4GuPfBhvgLZP8QQ01hnczPeR7XDIA1hnexm?=
 =?us-ascii?Q?5pZK0e/YmX5w2PIbf8kBu7lFCW3zlpu0WPfYXsRzAz2PtGgaVVr43dM8uoC/?=
 =?us-ascii?Q?zBmAxRrIdt6rodQRTvqaFa/ZLAXrfv9qOzXr7qSq/FvYtjrqgVKxKtG58YAI?=
 =?us-ascii?Q?FMqW3LcA4MamXNgfbZm3mDRSKZ0SivAipNs7roqdFj9JMsQnvazVIGnkgwgI?=
 =?us-ascii?Q?I9Ut6+O1VIQ81WKI2pUwesMn3zY4UpRVQNOrVPrORheabMI9//J/16or/00w?=
 =?us-ascii?Q?0tO+gC4O1wOEPiHdaEL3NfUx4oaf3ITfPH6VNmrrVBO5ux5EH7tLsH0YlOhl?=
 =?us-ascii?Q?eFbREnayPwcVwVPN5EGJrl5DUbNZ43auRcGX9aaTCw55t1lBwXIGC234q1jo?=
 =?us-ascii?Q?j67iKxSrK9s5NZSlESiXTwovrKGDG6AyAuzd5+KWcb+EeeoPNny0bQu8+D+W?=
 =?us-ascii?Q?+in2SG1ukrPpuD7TzbGxqOt+166pR9DJFgjg046c05ApbPe6dm4oS6s3Y+5G?=
 =?us-ascii?Q?/0uk8PI6rTNzEiAkkLCzJLX6tnhaqkWFT00xk8aY1Mt8JOpWsDDnLX1hJpFl?=
 =?us-ascii?Q?CB1DrcGC2CbG3jV1DSbRoIZeUYN9ak3a1L9rv/cL3Gf1atPHMEs0AlLLf5tg?=
 =?us-ascii?Q?Bi44xisc60USpWmGOKOlHARmNqN1INx1XtHA/MuZaiPfK+F3/puSM+pL1seA?=
 =?us-ascii?Q?VHkkWasev7pB0bqA/t3zOhQT3dUXW1SLCri6Yhsy5s41vGX3Rkwuu5ct7KPX?=
 =?us-ascii?Q?QWRIiTd1MiwlVzg7inbh6M2Hvfq8NmGULNCjzGuklLdh6yHJpxb8/2ilLBZN?=
 =?us-ascii?Q?VTWJOLRVJRg/LlI/eMEC7u/Cluh3sXeU9sE/V27CqJPnobzWqTsuZj2fNoGm?=
 =?us-ascii?Q?+enkvpnWIctRPhfUwK9gLjFfknkQPjX+W7DwDJQRtiD6t0Oa/BCvxpzTTNzl?=
 =?us-ascii?Q?5G6B6t8h3FHtNxel3GnMRwtVM3BZjaOyYkvF4XJboBfxOJImbaEa7oaulVyL?=
 =?us-ascii?Q?8ij1l8RsFZFxb1iCUm6dBKF/bxUmCPtgtPVhn7GO+NmC5Q80xEurWTdM6eva?=
 =?us-ascii?Q?JgNpyv3FtUqRvXbE5XSoeW1oMzilSSuqAiPJYxUVNBTYdG1/iHk48u7qHPpJ?=
 =?us-ascii?Q?2FvqtABPStER7NeiJH7Rgtjeuds7CLdE+KqZnFzO9X4mo9CSe51ip+pP50Ce?=
 =?us-ascii?Q?it28hN8GWabC+9eNi37c8Aj4uYQ/jVJHNyr7WWCB1W8kWce7CGSd7ZqC7ohp?=
 =?us-ascii?Q?gPsKJyzpLiRHg1LvIfeJ2vIGRRWuHDQKFsEVXw3k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b44db4-25e2-4d93-3b1b-08de324a7597
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:00:51.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVZN0unySKTNSRAHAyIJQqpQs/xEA9mkSRLHmBHjCiwfP2zpzTJPx2GRmTco1B9lfx7EhoQxpAbOytEH8zi28g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6868

Enable DMA mode for SPI IMX in target mode. Disable the word delay feature
for target mode, because target mode should always keep high performance
to make sure it can follow the master. Target mode continues to operate in
dynamic burst mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-imx.c | 77 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 04a492e7dbeb..69c288c8c737 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -264,7 +264,13 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 	if (!controller->dma_rx)
 		return false;
 
-	if (spi_imx->target_mode)
+	/*
+	 * Due to Freescale errata ERR003775 "eCSPI: Burst completion by Chip
+	 * Select (SS) signal in Slave mode is not functional" burst size must
+	 * be set exactly to the size of the transfer. This limit SPI transaction
+	 * with maximum 2^12 bits.
+	 */
+	if (transfer->len > MX53_MAX_TRANSFER_BYTES && spi_imx->target_mode)
 		return false;
 
 	if (transfer->len < spi_imx->devtype_data->fifo_size)
@@ -1763,23 +1769,51 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
-	/* Wait SDMA to finish the data transfer.*/
-	time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
-						transfer_timeout);
-	if (!time_left) {
-		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
-		dmaengine_terminate_all(controller->dma_tx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -ETIMEDOUT;
-	}
+	if (!spi_imx->target_mode) {
+		/* Wait SDMA to finish the data transfer.*/
+		time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
+							transfer_timeout);
+		if (!time_left) {
+			dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			return -ETIMEDOUT;
+		}
 
-	time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
-						transfer_timeout);
-	if (!time_left) {
-		dev_err(&controller->dev, "I/O Error in DMA RX\n");
-		spi_imx->devtype_data->reset(spi_imx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -ETIMEDOUT;
+		time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
+							transfer_timeout);
+		if (!time_left) {
+			dev_err(&controller->dev, "I/O Error in DMA RX\n");
+			spi_imx->devtype_data->reset(spi_imx);
+			dmaengine_terminate_all(controller->dma_rx);
+			return -ETIMEDOUT;
+		}
+	} else {
+		spi_imx->target_aborted = false;
+
+		if (wait_for_completion_interruptible(&spi_imx->dma_tx_completion) ||
+		    READ_ONCE(spi_imx->target_aborted)) {
+			dev_dbg(spi_imx->dev, "I/O Error in DMA TX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			return -EINTR;
+		}
+
+		if (wait_for_completion_interruptible(&spi_imx->dma_rx_completion) ||
+		    READ_ONCE(spi_imx->target_aborted)) {
+			dev_dbg(spi_imx->dev, "I/O Error in DMA RX interrupted\n");
+			dmaengine_terminate_all(controller->dma_rx);
+			return -EINTR;
+		}
+
+		/*
+		 * ECSPI has a HW issue when works in Target mode, after 64 words
+		 * writtern to TXFIFO, even TXFIFO becomes empty, ECSPI_TXDATA keeps
+		 * shift out the last word data, so we have to disable ECSPI when in
+		 * target mode after the transfer completes.
+		 */
+		if (spi_imx->devtype_data->disable)
+			spi_imx->devtype_data->disable(spi_imx);
 	}
 
 	return 0;
@@ -1902,7 +1936,7 @@ static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
-	bool word_delay = transfer->word_delay.value != 0;
+	bool word_delay = transfer->word_delay.value != 0 && !spi_imx->target_mode;
 	int ret;
 	int i;
 
@@ -2108,7 +2142,7 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 	while (spi_imx->devtype_data->rx_available(spi_imx))
 		readl(spi_imx->base + MXC_CSPIRXDATA);
 
-	if (spi_imx->target_mode)
+	if (spi_imx->target_mode && !spi_imx->usedma)
 		return spi_imx_pio_transfer_target(spi, transfer);
 
 	/*
@@ -2120,7 +2154,10 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 		ret = spi_imx_dma_transfer(spi_imx, transfer);
 		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
 			spi_imx->usedma = false;
-			return spi_imx_pio_transfer(spi, transfer);
+			if (spi_imx->target_mode)
+				return spi_imx_pio_transfer_target(spi, transfer);
+			else
+				return spi_imx_pio_transfer(spi, transfer);
 		}
 		return ret;
 	}
-- 
2.34.1


