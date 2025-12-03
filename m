Return-Path: <linux-spi+bounces-11739-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 997EEC9E568
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 10:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DC07348E54
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5B2D7DED;
	Wed,  3 Dec 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fCL6HsZp"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADF2D7D47;
	Wed,  3 Dec 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752429; cv=fail; b=BEV4xK3WlvnOfwCIk+MoR27OAqT0jGOYOgoWVw21Fnn+4kbl15YO+0xufWkEtsMWT7fPjY/XRxprPOI5LLLJdwt4LxSdFxN27j4WgevUFs0neR7FCx4sOswqCoc9inCK2+gN4pPVFUwCXvUV9wbwrqy5ZlNwUTnYzqnmLB1LXsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752429; c=relaxed/simple;
	bh=g5nY8SYJMX6KHE09wP+iuL6IEmMxaX3kwVMCJAqe6mY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VLhKxnh7U4ERX9WT6xzKiC3OCV9djZSxwVleGdY5ObErO0DoughsSviPeVBYVZn1zjUbfcw4IABGCfbGD60CuKGqwyW1PYAOI4qPLJxPR8aEu4H7HO4kBKQPN6lvBVL0GUtkagYn5/2fKn7Zc+tli+ek21QoieJphL1+6mONZk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fCL6HsZp; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEZ9bAq6QxSEXCb9OCoxeGvLiF5fPJuR+OPlXIKO0NuxxDK20s1j3W4yvyJSIULN5yl8AAh9oQaXKm0c5J8r8xgo46ZzHXiKBIhmpD+XTXhlE/uwQICP+6lqcWoViEEmiVzanc6kgt473Tv7rHT1i6xizvAW1r68WopF/VL8oBEGqv3Ymasfi79DBZfLBCmsVKw0Yl8eX5qt4aXghtWvar0rRJXNf1ifT6I1aNraS6i2ymZYupYoVuOn276UDYHPZChKnZuv4+Cg6AQTzlXYtZD5LcYbuK6p6IbEEbr/iTvWm9Z+WfJQs1OQLaQxQ6jH/rF0wUROSnZbMP6podkGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dnI4qh/0aH4OV9bjqxyLDoFu9l9WIC4Cg3Yx8x3/FU=;
 b=oIDaYxyoATLsnBaOCE5jDY6UUL0TiA/C46+MB6aQNEuRhKcTGpHbuzd/CTFAou1b4TFCzkfwRXF6tBnW2D/56lmmKsZ2EZ/KDrIu05YnCP1r5asHJSsfrEpFO5KQnWaaP21nd3fMpgkENXfJsd/tp+BfnODT7hV4nDo2d2DScRyEOtptVRaez56MS6FEp5epsYo+hQPuwvG015BE7Y0X72bhZoOhlLwa7JCTq/wms3kibXV6weHHicDyJB7AU/D1EHP+d+AmninnLDgDvJFF5ipKyjhrtADpMSouIZZ+ly+sXrm+9qXNvGDCfhYQcCzRTAAl5gBI7Tt7a9yvnW5GCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dnI4qh/0aH4OV9bjqxyLDoFu9l9WIC4Cg3Yx8x3/FU=;
 b=fCL6HsZpNicQpcNKdCyn5xAtKuNeJ29bDhRDonfxDsue+x3jQMNav3cijUFV+wcFBVsf1s799QqBe5tB7YLq/Z6tqg81OIp/y8LOKRKX0qVlfQjDeNMUCJcXVeZPgm6nLKnm+cawF4dPHYXbwXArROs/XKx++PJ9y8VxPvUbp+YxF7IQEz1HdF4uPROzw+nBrptRT6A0Sz1usQWpPThULAVRp640krL6m2MBPFzcUEp8LqjBDRax2BNu7wpjHA/WrnD9yoJYi99WCctbhDZjeP7VeFqUrVO3BnufCMeV8aadpvZmv3qkkH99rHKe1D16tmqcF4hQjacGobD8Zz0eyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA4PR04MB7981.eurprd04.prod.outlook.com
 (2603:10a6:102:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 09:00:23 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:00:23 +0000
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
Subject: [PATCH v3 2/6] spi: imx: introduce helper to clear DMA mode logic
Date: Wed,  3 Dec 2025 16:59:45 +0800
Message-Id: <20251203085949.2922166-3-carlos.song@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|PA4PR04MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6d0161-26c8-458c-e00c-08de324a6496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FsSD4Mei7+WO17cjljjsbSa10HJ8/2byxPFGGZjbx4C5xL5Jt/YMh6o7iagZ?=
 =?us-ascii?Q?j+uYRT5VlOySF3uXBoiZ07fbOmvfGvHPESVGjgF0qM6lGFNZFwECYF3USSuv?=
 =?us-ascii?Q?ge/6POPqW9idx1K5jzmSUdBuR12o2Rn3v+cvwoTKPv0TzpKYw0UaJZPuVmU+?=
 =?us-ascii?Q?bSSt5WyhusZElZ28xYvbqAovlfTk4nApEBT0QGHgE1f1Z1s3MjJRemLaKCKR?=
 =?us-ascii?Q?fFPPN1ed0Xo76JHkSDubMpdfdWKVQE8JOLfrUdlEsWrbswry0OL1n4IMGlue?=
 =?us-ascii?Q?H4EvBP/wa5mSg16VLGdwTzaP3ozSydavBRqj32u7WbxqM25T4n9XTUwqBKxw?=
 =?us-ascii?Q?Hr7h4KSImu4vUNiIs0CgR/32DXPmTRH0mN/p7Nf2IVuQg6KydEqvWImceI/Z?=
 =?us-ascii?Q?Dj3z/cccijk2/Be9I0V1N0zsVJCRlKxT6Z3WMvPWzyHlHc1Bc1Oq1zdLicO9?=
 =?us-ascii?Q?PaRzXLfR8E5xbVzs71ATc1X/aJgHpw80UHZn3rdJ0FRNADfYXIPlBEmPSw4H?=
 =?us-ascii?Q?cARRwcVw6gK2QCllb20rDCtmVCq36fGc7oR/G1fzYbov/ONl+xECll8zf/+e?=
 =?us-ascii?Q?2xRfGJo6u4TJtw9UGvcwup2mKy/ON6M/pynoXtCYPAWHuSHDlnPpiJiNdryc?=
 =?us-ascii?Q?+uNJzMKCQylKfW3H+3se+xzS5ehxVsFOT0wA2S00eI610MX+rxc0NDQGOdpZ?=
 =?us-ascii?Q?hLOZIInIF0v1UCRCyQEsysOVZ9ow9UowitjLmDEi96ujl5KnzM8dSFHlc+9j?=
 =?us-ascii?Q?j7rYq/pE8Sy9JaEPqkCugWXNXXGAZGEmNcLCEGg9UX1DIJXYR13OzNUDF09b?=
 =?us-ascii?Q?Ig2SgYscmesBoAlVUjygjDuX5mdbHOR12+4ep+7BKwdIN2QXaYCCqEP0MtYf?=
 =?us-ascii?Q?1+BjIWuDfwkAWxflStYr2GM0GJ2/OzucREEjoQ0ybpig6WcQpkgXL0Kefl10?=
 =?us-ascii?Q?63JCX5BtFyrup1Lxu9PePzeF4z0fUC4k1gQV7IPMEGThSKzR3mjDDT+HIALw?=
 =?us-ascii?Q?UtP9diAneKBwTFBq9i0ZdEhGtpAWWfMz8jJREffbi0zOTaAMLEoJOouCEZig?=
 =?us-ascii?Q?nUUbDyakwAnkDz6eu2hH1ATgP/qXR2QYndhx58BLRYbAXuKikSGlZhjCah7L?=
 =?us-ascii?Q?NeacCtAhq0dHFB15WjQTtDmePFuRNIXjFBz189zQusB7ul7QIEZPefwl6b8F?=
 =?us-ascii?Q?WCxLBbT1sU4TwQ7yt5N9xT5E+K1MeehccIJF0No5XdP/J3KvpZ48NAZ/S1nm?=
 =?us-ascii?Q?kln2gPEcPso5/1zZ33EBBnNPPgkXC/dPL3F2t7Op/JaIC9+MFEFckkILddkl?=
 =?us-ascii?Q?yM8OXEuojtzTqM9RKO3yxeTgV/N9ykzQoKjCuqcts1SaYy8TpPFWZXb0MVtj?=
 =?us-ascii?Q?vaRDaM7aYnyllAJ3jMUdsxFvaDYu7femIJtm3n/jEs+IqbrPl4dsu+4z0OS0?=
 =?us-ascii?Q?97311ZrYo9xbdqNeodc4+NtrONyBethlOVRVWJV3UXyYIek/p++R4bW/p540?=
 =?us-ascii?Q?Ir6ZqgKYTfjW9rkhBqNEGbexYnn3DT0GhL3p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SxKBWdzZ0NrztVRHDkS6AuLI9Mkq7DVuv4KfkF6ul43GwF6jAuZACsOs4UCY?=
 =?us-ascii?Q?lrU5NXINZ+/9+bnZYruy2QAj9UXDxm9qGgc0IDit8zxEG+Q7aPL90JFciR0d?=
 =?us-ascii?Q?bIuwCeSFJHpEXJWbq5JMkYDJrYWjjfbc30fOtsQheWf4B2Dq0MSwVVyWK/7r?=
 =?us-ascii?Q?Tjm701O4dKc99v24O6f+luGFyBTAR7yRNblj0KJ/ZMmpTd/WSBeD+gM0m/qS?=
 =?us-ascii?Q?uXKVoTeM43VhpRMJcv6cUAAf8pKT/he3MbRNZifQ1gUFCer/7zekOkCDjyeb?=
 =?us-ascii?Q?SY+UE7WVv7SQ6DKWep6yW1dK9mhyvlsG1J07cyaBKgxyCEYZH6y5++AdHEy3?=
 =?us-ascii?Q?Ik97pr4OCJTppFwKvTaF/UQ/lZpJvOAuX4f+pWwAsOa3MqtQUOmF9v1Ha8l8?=
 =?us-ascii?Q?Ov3onU/k+g+3Bf+0TBzQIAIvm6oDGrlaDJ7GKkmzXWYc1V0/2KxeihyXPpgi?=
 =?us-ascii?Q?ljHxnFVT/FJryczPMsvNRprXIlFJOw8Q9HkQU3otiNfwmsFcy9kdUZiRm9Xt?=
 =?us-ascii?Q?zwsteu2adk8ZY1T3EXeuUbUfGJ+xTkeAs47bd1Wo5+VBpwENDfCrAIXY0Ptv?=
 =?us-ascii?Q?4A9fFfB/1HrW8EvH6k98FbUwVTQCrOybHrkcIG7QKobr9WdGBUKCKFRJcaHJ?=
 =?us-ascii?Q?vrWjFl7/nWzFuBYBefdrYyuhS++/UbG6v4nbYlXomLbvxliTEMfpg31Z8Cbz?=
 =?us-ascii?Q?4M/b69x2NsmsF1ZmYwKw3vlNgbWuNULHwetC2cb/BQR+1sRQwEdtSXMP+SBc?=
 =?us-ascii?Q?2OI6pfSSsjIHoIbvrbYTO8kx0zRPepEbOYa3L1tb3p3WFc9qUpCIgUvQ1KOr?=
 =?us-ascii?Q?P50F+awJIVnVR7qxIiXO6toyPRCa2ISK4hcyZ4yqPDbaj9R/P7WBYOV1JQM0?=
 =?us-ascii?Q?fTIlUTveI8cDSLp51nb/utKQeDfeQy/lm3SNKu92QE6c8mPa0xJ2MfM6WrxQ?=
 =?us-ascii?Q?Em5M4BSkREwjO6FcgoM2EFjbgYKpPRYj8jxMCffT1p4ogAHKACQF8mKtZOar?=
 =?us-ascii?Q?Ski7zN9IqONFa7ooqg58jdkd3ef3SPvC3MAlhXmhcXoCOWeYhVPhCYOHToM6?=
 =?us-ascii?Q?FGtXYcrkjByO04ZOFjd05Ed4TWPAntBrefd3kRcx5MzX93kxDYBTesyY8wge?=
 =?us-ascii?Q?xr3W+SUCiSnwwaDzkGxKRinRFGaQya+sPLLx11b587+bP6C4dDdcNZxpREH+?=
 =?us-ascii?Q?ElTGRtlqhqGZQikVPUFLywY66+to2mfP1ACwW9VR+xKyawqRCXV9SZU5CxJn?=
 =?us-ascii?Q?vL1uY/M4gYR27s8zaYb51CBKitrL7wJ0N1mHEKxX4be3V48flXj2il2zylEx?=
 =?us-ascii?Q?Bzglll1JRTSgolsvvkkAWWVGDQOai6ZIERsMeVIIdvm4YQY6HLAA9zaaKOBN?=
 =?us-ascii?Q?JapjvFZeJ4cleghhZK/meZkssygxzAQZuaCWHBAeO54CHCA7UjWvMrGBCmuB?=
 =?us-ascii?Q?U1um4hV3BDj7CK5MEP5bcq1eUD4dpaVYy1PrnBU/aoZiLpMKDuEfJi9fVmiL?=
 =?us-ascii?Q?Nj6vQrYIUjhDQ1M5JIzhtXzCOCH6fHgEHPz12F/+C2/PPaTS2a8+oPCNanw2?=
 =?us-ascii?Q?XGdmtHOH8J11En+UB550qUxoM/hZAopEeLb8tXPO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6d0161-26c8-458c-e00c-08de324a6496
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:00:23.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCxIA246Zt37z0wdX70uQQzL+qr2YMSUMn0+AQqZf6rQYGVPf0WbTyn8OO4XNFJZ86zB4zspHO4ptB1hVeHorw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

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


