Return-Path: <linux-spi+bounces-11510-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5D0C845F9
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3620F4E8EB7
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0162EE5FE;
	Tue, 25 Nov 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jCekCVHI"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA82EF660;
	Tue, 25 Nov 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065272; cv=fail; b=Re3AaLVBaag4WuarFZv1iiEsvNGtM8fvG/DYo2qDuerKmflbidaEr4jPckjb7OLnHUHlCoqTKhYgeasCFyEn6ocBT0ZQJvxOHaUdNZxlsxwkEhNPWEpcli/KFCxkYH8vTnUmglFYLsQm0KKHPWfAIQCOfmaKCDG3S7UsAISoUw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065272; c=relaxed/simple;
	bh=N+hogIfUHEJeUbemKeZMl2dj4qSlJGmD1T98N5Atg94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVb7aGORmYgobsP25wFr2fbspK3G5PWc5uP/H273H7cBYU21FLmxWig90qCTO52RtejxZ8s19XPKqEb3043BxQniOEaH+C2H5KZWJPCLifoJvq6DFKXWaPywf/5hvDXXq5wo4WZPXsIPFp0br+e0huVWyvm6/hBsgJdKq8qnzRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jCekCVHI; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN6maPSzU/mEIG/t9mdEoDyZ0cPD9HX0p53CL7e/R1utQrmyQMd4wyFgNKeyI9NE15Hg3qd4kku9+hFJYMK4O/ErZsbN1AmlG6mVilHOKdpU8+js0jBDIprTUrYvxCiY9gHoK8heklEPexsUlDqJFGnBNHbUXf0Z7ZalbRAWcqd0I8G8wyNbIpQ/L6IL0kg8kE0CGoldoHI7Bggfe6yrP+lWLY+afHYWIzDKgxtH0hkYZhx8YwmWBsAaKncz9+2E31/KoQSFiEGsj/CTyrSRvt5xoC9pE2JzdiU3D0RjWUl96Rg/oYTILgVcKuB08GrwHysQbMiLOZuQDrAlTy7q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ss1tWDbReyyc/jH6U7kp2NH6Etc7v4E9SPswlZFYzY=;
 b=E5ReI6lMcawC4u62g9y1N/YlMqoitIAtWLJFIO8b+iFJbJzc3bz3RdBeb0h/vWkXisGwm0HVIpqO1w3LrIKjoX/6fRRokY/9VN/u4BfOZfGJLH3cWTdhjz8dYS6Z3vucEoDzqgG2GZR6hDYekQa41YVwvGrTa86rHXmVHcz7GRIrvjr+68BPbM8M7ISHOUzAcnZCtZ5NaLN9qY8k2xlSVUA1yefpOhYqa1xLxzuznxaxSfxYIt/a3Ow7EI8PdDvZPj1BncGtPruoBRBbTK9UaJoXb84YkrWqa5YI/U8AJQ2Ow7Jnlmy46GsJkOtL5QajW3oseP0ReqqPhCaz06XS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ss1tWDbReyyc/jH6U7kp2NH6Etc7v4E9SPswlZFYzY=;
 b=jCekCVHIc64uISxJrZvA0ZYEgLNx5iLHBU+tM3Gu6zloagxkC75RrXfo6OXOc1UdoIlCS7q5tTxfqIC/7DL/hv+YJMN3fe7oMjzsA33HUZWlJIp7sC+V5glKTBvSt+OmGhcev5Gh/Mb5/6qGYcB3NRFrAlBsygKyMR13AVUX1GbR/Va/IwBwDEMylSJuvd7qjhngIhbdHFPAWmsf2vPobMZaFckLH9/RlSWSEPY5BzHYMo96OmbFKYuyAgWKd9IAj3wkwMxn6KoVV33n7RWnH4odfBELXTWNn/ukqR1451q3x4TvkK5uRLvQhIfOqAY5XClI8o2O5SoJKv2k+/A4LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DU4PR04MB11340.eurprd04.prod.outlook.com
 (2603:10a6:10:5d2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 10:07:46 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:07:46 +0000
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
Subject: [PATCH 6/6] spi: imx: enable DMA mode for target operation
Date: Tue, 25 Nov 2025 18:06:18 +0800
Message-Id: <20251125100618.2159770-7-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6f9ed86-53ce-457a-e9f2-08de2c0a7b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLGH316iG+DLpwSUrfcMwWbldKWdU+ERxMH/Swb0oj6/ViEfI7YfQm845WrL?=
 =?us-ascii?Q?NA7xoTBLBn6s+yFdACksvNXpvG4qliJF06fIS+p6eOxE9ClG7blnKLG38l+k?=
 =?us-ascii?Q?gXANAMHHgZSBclA0p2lhJx2I2X1wulNi+0HJHZ5fxI2hXYedHX4s2xRDjdyr?=
 =?us-ascii?Q?3+OqcT/avfSGHnjV1+w/YW7ZUfk5APkPjePzQpjUKjsG0rdoq1lMye/Yb2U1?=
 =?us-ascii?Q?DdZpnT53OQzkYHSabOXS1+53KuouHg0R0iaMjvBQYF0Lc19SZIMyrWOeNqa0?=
 =?us-ascii?Q?vJqsqXuE/dBbvY9DxDM2qBdcOBC3hO6oDedZTXgluK+KjxxW0KBoUkpTpNUx?=
 =?us-ascii?Q?BieXSX6Uumy/rKyxRtK/qrvXpaY7/Mo0rAAlzmRUCrOnou/Tkbunec+isyJV?=
 =?us-ascii?Q?pct2wPfAHdUpjnR8mrJzYveR2RPgvczP057n0Sr92oKZDJeDSfltzq58UZYk?=
 =?us-ascii?Q?L7qS5Q4n/yp9ppKWtXz3ntoq28kWhtpCEcmdWBZ4pshdng10r5ghwhw2CZs9?=
 =?us-ascii?Q?xsO+QdgtCAY1O20Oi7/1Cf8ILBO/W9NgIxd6ZaO2sdvWoR16CclkMW5ULB3c?=
 =?us-ascii?Q?+TS62RcpzoqhE7DBg8oXkDXRxp1ylXOizBH5OhGmnXiL+IWXtFkub6lt2plS?=
 =?us-ascii?Q?PEed/QW41SskKHTAoDqUv6KKhD1woiCSfmlvdFDuhnBTcBgkFXV42yfr6nZP?=
 =?us-ascii?Q?3ayahLJLw10dweDUxGo4NfWUQvFWLd4agg8PYC0r33VZRP1QXAn7q+GaI/Bt?=
 =?us-ascii?Q?Np7Z3MILCut0q0jqFOSLYRhguDQ207HjLiN3JrnzBoXJb76QbQFLqfd3s8T8?=
 =?us-ascii?Q?/ycrjhQ6ROZdj+ArZkizMNSQm3wQu17pFlP6CcCWcZxrNu6D1Mf9fDpRFMm6?=
 =?us-ascii?Q?1SxCIR4hjejG043zCCGowU14oXWZQNSAF4d/pdTAexFLJkYkQIq7lc3noY0s?=
 =?us-ascii?Q?iWp+/ZKGKm9lDc06QLEjZCeNUC/uJ9vBy7PtCWiKSrW4H5gbj5X54URixK7T?=
 =?us-ascii?Q?WYkdevtLOtW+Qenzpjyf2K0Efng+8P1Ouq1j0Edmp9qr1c7LDAkL7n+cpxtD?=
 =?us-ascii?Q?MIbtIAdGlpaEq88caF/hBTHdBQQjvWICEBZ7EoL+pDfcapscl0BFP0U/Q6U0?=
 =?us-ascii?Q?gEslOhp0lcZjLLrQGkYgK4abjaXiMe4Ao1t+fSiCYFppoLtd7a32qakFX2Vv?=
 =?us-ascii?Q?A602gFf+Rk9kr7CZMvEWXaXMirhfNKcgSL+blTVG4qlN5mke/F3RyJSUO52g?=
 =?us-ascii?Q?BdFzyw7ieeQFmaEWCWDVK0UlLmH/0VkK5it6HfAezmiMEjDKS80O8yHZ8oBl?=
 =?us-ascii?Q?92+cqGP/VW0MpuxBoe46F2upTOjfnrG0ac003IpIK+0qVJF8OgslM6M1P3oF?=
 =?us-ascii?Q?FjSlA7IA+lvgNXlSWhfwKu7MrfVXcUFoUOqP8lf2AMWgjrF83Ts2+Yx6T7ep?=
 =?us-ascii?Q?5ndljPemGqqw/7V3b9iWgjCihasVxGsquHLmsMQMugg+1T9YI5WRFqtM8Mus?=
 =?us-ascii?Q?XGZ1x4oGyxarkQ8FkfpZO2XTqd4L+pQCU+65?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Koj2i1Ko1GjSCYFUaGLHqzYbpx+2+URHD/03eHOjuRm9K1ZHnEzgC3RvKXGT?=
 =?us-ascii?Q?JKHF52PKQJoOFSeT5vzLOvehF8shmpQLqNYpSOAQTQI54FNDHSviJrSszrkh?=
 =?us-ascii?Q?QLG/jEe1nka3KRYq8jP6B43gR5MZmxAPQ6U+T/SoSZyQIZpH+pk768yotsyE?=
 =?us-ascii?Q?IBZbAqH7J7JKnb2Ki7LXTHwgqM3n3v1F3jjFemJmyPag/gakqBwXE3QV+8Lh?=
 =?us-ascii?Q?VUdJ3iXb64jHmOsrLPXOjTvG7AvuvWVaAiWZ5BSwsQbE91H3ZRa37uvf5mNn?=
 =?us-ascii?Q?4b+qM8IvbbpaATrki/+o5X+4hcGbB0kK/k8z9ykSTa9Sma30mrBDIsLiGi3/?=
 =?us-ascii?Q?eOAT/9dqki4Ay6DykotYzhMJ9hJzP8OBxofiveN67OFWvQRcQFUGDTh+W+t+?=
 =?us-ascii?Q?hPnarYT9RbVT77tGmAo+kkKcmaQiASfQhEGWJB2ziw1S7zMAwu//HMbVZlg+?=
 =?us-ascii?Q?UJlBwO0ZbW/kH5GA6cQhF6EVnXAf+/eY81efjsFvmXrioIrzThsLMfBhRj8j?=
 =?us-ascii?Q?OzORB9jI0tlxcQnH8Na8el5L//z++pHUjw53gfDO9FLjJ8L3FWyAUiyQyDyy?=
 =?us-ascii?Q?nFalwX9xum12PG7ZLU5e5Kji+d9oXADByKtPTv9ctt57xJxrk95APTwuOhCA?=
 =?us-ascii?Q?cnXLyPbb5jnQRwroDx2vwGfx/1mklnCfG/S2WGPlprFMAgcJyRPGhv27B4p3?=
 =?us-ascii?Q?6snjkLXLUgrQ65EQ4j0fdo9Vh8Vi12qRlIvoQXPo570w+29tu0SeMiPNg0dm?=
 =?us-ascii?Q?KYGqH5kRZ4MZjR6JZ+9GTEccUj1XtCNBf23/1DVgUQN90skXncXmaOWRXbBr?=
 =?us-ascii?Q?orE/oANFizZ2SI2Ag2DlHhTpsoeWj93FGOFWIsnxOZ09rA9gnLTGlCjH/rJI?=
 =?us-ascii?Q?Y9+DUbx7xqKBif0gBYh05niZCoYRozzFeW7Y5aoW7Uz+/K+BiEz26yBbV1Qz?=
 =?us-ascii?Q?QvbkkpUGx9tLDdtgT28S3nFsz9boLvft11DTR81U3fGmgyMDBceUWyZjAf2W?=
 =?us-ascii?Q?R9ZmFwf9i4WpaMfTSvI5v9Z0Q82q9YcCc/Krxk8/D+10zhaMLgpi8G1/6q9f?=
 =?us-ascii?Q?yqZLK7U1ce2VXBiU8q+4rO5r+9uJdUPtZICvJn0aFWBMO3J3CzoWpuSfmXLY?=
 =?us-ascii?Q?q7h/tVSVxnkRyP+c/kHanQoCFVwG6dV2hZr9eVQ144INCJXjkKDnttNFY6Bg?=
 =?us-ascii?Q?MMr96cbm+HtpmM6S2TdINHRkfDIZrCqMu8G4ejMtttJtptJXj6YVWPfJ2CTn?=
 =?us-ascii?Q?zHmVS0Sldl7gVyj5osg3ECSFtWtKZGfdDAStLHYZFhMQtam1ob6Hc9s3Vang?=
 =?us-ascii?Q?I/FVdAbbOrFtjn19nScfNRqVj35OjaRZmn0Ao76csA5328Nii17iS4JDcd6p?=
 =?us-ascii?Q?5P2MtwGBNALC0P2HQaTWTF93Sun/Oh0lYHN4/KJ7AuJev7RyOw5kp58Mn/+9?=
 =?us-ascii?Q?MG9Wp3gZTqcs1A9ib2PUa0oMtvlYxUZTkcfHIGl8rUKvk5j1qUDW53Cro9JK?=
 =?us-ascii?Q?414CiiedHuuTMvPN3yabkFSYG8/jVEHk++Cq199ZLA4vmoKmy2v8b4g8C3wV?=
 =?us-ascii?Q?d8971Un2rlqpuup4jcwtpUxn7GnRVmkFkQc8rs+C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f9ed86-53ce-457a-e9f2-08de2c0a7b13
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:07:46.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQpDArexJM8DB2COViGkXAbjqi6UyG2uyI7B4ZTGBsyadt0cQ0s+wGvHRuPUu+3OxuVyyF6Y9hsL49wM0UIkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11340

Enable DMA mode for SPI IMX in target mode.
Disable the word delay feature for target mode, because target mode should
always keep high performance to make sure it can follow the master. Target
mode continues to operate in dynamic burst mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-imx.c | 78 +++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f02a47fbba8a..16b7d2f45012 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -264,9 +264,6 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 	if (!controller->dma_rx)
 		return false;
 
-	if (spi_imx->target_mode)
-		return false;
-
 	if (transfer->len < spi_imx->devtype_data->fifo_size)
 		return false;
 
@@ -1756,23 +1753,51 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 
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
+		    spi_imx->target_aborted) {
+			dev_dbg(spi_imx->dev, "I/O Error in DMA TX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			return -EINTR;
+		}
+
+		if (wait_for_completion_interruptible(&spi_imx->dma_rx_completion) ||
+		    spi_imx->target_aborted) {
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
@@ -1895,10 +1920,16 @@ static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
-	bool word_delay = transfer->word_delay.value != 0;
+	bool word_delay = transfer->word_delay.value != 0 && !spi_imx->target_mode;
 	int ret;
 	int i;
 
+	if (transfer->len > MX53_MAX_TRANSFER_BYTES && spi_imx->target_mode) {
+		dev_err(spi_imx->dev, "Transaction too big, max size is %d bytes\n",
+			MX53_MAX_TRANSFER_BYTES);
+		return -EMSGSIZE;
+	}
+
 	ret = spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
 	if (ret < 0) {
 		transfer->error |= SPI_TRANS_FAIL_NO_START;
@@ -2104,7 +2135,7 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 	while (spi_imx->devtype_data->rx_available(spi_imx))
 		readl(spi_imx->base + MXC_CSPIRXDATA);
 
-	if (spi_imx->target_mode)
+	if (spi_imx->target_mode && !spi_imx->usedma)
 		return spi_imx_pio_transfer_target(spi, transfer);
 
 	/*
@@ -2116,7 +2147,10 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
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


