Return-Path: <linux-spi+bounces-12380-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C81CD2368A
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69F59306595F
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012D35A93E;
	Thu, 15 Jan 2026 09:19:32 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022122.outbound.protection.outlook.com [40.107.75.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B036342509;
	Thu, 15 Jan 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468772; cv=fail; b=Bk6NR+2Sjji8Q2DSlv76uTCnLJGnfJU5bt1/t2Mn8tMuv2//QcCpbHfTmaplQMPbkBONmmykPURTblG/Twp/TeWCB7F8W/aJcfhvTxEVjAfOMCiiStePgcMStYWyNkOzaTaXAneL6S3cuDHLsXCLq5bVukq2zLwx2T2X2Im+Ikw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468772; c=relaxed/simple;
	bh=3oNUr2AIle4VtupD/cGDdBQj0l4jilQHb5VGo+0Uc08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eUiJ15S36sc5sALU79Vd/SjW7b4alp3Ypx6pRvuM6lqBomgiDj2ll5fzV5HIxMcCG2yPDKHHfDDvv+bxsZM3TWgeloQgDAK1VodvGw6FHUSEO+uRwWC5rcQUZKKEcPcnUWk+VucMldBvHKML6TcaMm3sRcILi3c4WM+BDBZmpio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmBIriSrbpR0MPE0QZLUgfTWWZzeBThNEdXOR4u4ZQFbqCFHRIkaRgjQPN1HsWCDtakgocfDLk6VfxBAU5AfTH3kGxoaAT/YBWUcyzF0MmUnxw2wX2gV90X1rMOb1RxBLfeXh9Upc+k2K1qWeGTEEaMxjKIJXx3YCcIdmguyDWiwkd5NbovKdxhU0ZOt7DbjR4p8TRB8Er1azm6XR/UvZF9eE1HhOeMvsy2N5egxUcFPwmJlX+W2Pz56EC4O+gaGXaCawy452MC58+zIOmTC6ghc/SYypdx8Ql6P04XeLAvFWBahceEK8X0Wsrwi61pJsTTVr7FOp0ByzA8zN01udw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dWfl3sjEvBKj8G2GM5fFahd/GZ1zztXtPwDy4/aluQ=;
 b=e8vEQjZEwsFc+p/ZiA5U0lwBqEtIGcoyrHTnyrgfdee2W53ziGWTaoaG0Vv/P3KmReCtd/pusvpNTCrWKtaj2HX6Fn2JmFzvtAt7l9j2lNzFs74a2I9Nc02+Q0awmGctIKFAMB4am1Qd8uwtvNQdEDc3xOnlVMtqk7qbeINKXScc/PYwmsaNd+lF2X1yShy8+Xro2C39SeBiduZ/eMHgr2bm73nzY7TAZRBpEl0SgmlJYYWU2hAssTbr3AWOtXCfaVnm4aS+frL0xc5Hu6ORtZI7d92vMrkxFn8rzBvuU9Usw+mwR/1/psghyR9QzGolGSY6oV2g7NAlxOQXtKR47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY4P286CA0068.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:371::9)
 by OSQPR06MB7203.apcprd06.prod.outlook.com (2603:1096:604:292::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 09:19:26 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:405:371:cafe::3c) by TY4P286CA0068.outlook.office365.com
 (2603:1096:405:371::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 09:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 09:19:26 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1E9424079A20;
	Thu, 15 Jan 2026 17:19:25 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	broonie@kernel.org
Cc: 455.rodrigo.alencar@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH] spi: spi-cadence: enable SPI_CONTROLLER_MUST_TX
Date: Thu, 15 Jan 2026 17:19:24 +0800
Message-Id: <20260115091924.844179-1-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|OSQPR06MB7203:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f40b2c4e-c04e-4603-cfe1-08de54172dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nSmNxf+Hcp9cJHu1e2PQN+9/1680vMbYdCIcv6ZN5rG6qrfE3yXNyCo8uqhW?=
 =?us-ascii?Q?UYu/vV/c89VdC5ylEa32eHFqTcS/jtHNKM9D0z5hhGEZZRjg6uKyym9VdkS0?=
 =?us-ascii?Q?m35TH/4AlwgKEoWEc4iH6VS6rhYzA9DfyoxdDMgTVF4RmHkiDaiZUhdMpDHY?=
 =?us-ascii?Q?mkHUNFTjIXSiKh6pPTic9C5gJ21s+d+Ft3sQNAOn1EC4GaE9VuNldiuj3OfR?=
 =?us-ascii?Q?ErMKGE+sTOUlkhoVJU72C6TFITl0sMJtHrXx63qq1xR2/ruPlW/NDINuKITJ?=
 =?us-ascii?Q?TD7/tOLFiXS0agFeCEGPy6sKPgWGS2YngakAm3N4t4AUM3Srup/falT4Nivz?=
 =?us-ascii?Q?Vxv3NjCfkUNPkcOkKDok6CYp2c27Qzp2rEz4Yst7AF5adLkpm2byuOwnfdxw?=
 =?us-ascii?Q?sckpq4A/j0t2BKTPbRGbx0Iymj5BemIjRZ0RmUghRQWSHUQUV+Pply1ex5NE?=
 =?us-ascii?Q?avRvwL7SadchqksG6A+De47kcMwU77LOH4Se7xQ+eS2SOQGWCuiAvBxB8RHi?=
 =?us-ascii?Q?ArgZHvEDsLLOL0mJiKc9dYogRPP9R/HVYhU8hhdMfVli00oB1QtisYRTcCtl?=
 =?us-ascii?Q?iFGODWH7eyQh+ID0qfDdCrocLtTHLx8TG5OLH4J5XZIp9YRA420U7IYTfw7N?=
 =?us-ascii?Q?mjfYGCxc5Kz9Tt2mnxVMO/Qe1uzJrV7lwOi5mQPWYftz8H/TXDWAWFzrlzUn?=
 =?us-ascii?Q?k4Oz/jLAP6owqkoVTUDzXRcpFRCsltt9OGKEqvbGyRsfdZj/5VZkL1bf6Avt?=
 =?us-ascii?Q?WU8cb7d60IU/OWTw+LtXpXIexrJ5H5w+LwdWKw4Rt6eN9tVN1L17/+OUTeqb?=
 =?us-ascii?Q?wD6Ibg8tWnxDeHb6+9p4SFU9DjhuE4RVBrc+alYw3eTLJBidv90OYMkOHtBY?=
 =?us-ascii?Q?f9x6m/xQQTwv0pRz64Xz7algqUAw3qNu4t3xQmCqx3HnCGkLp0rXg62g4Uk1?=
 =?us-ascii?Q?Z39e8EaIzF67boOuTWv08ivJL2U9vQjg3SRsq8RUrhDsA2LzhQLcFkypWnPU?=
 =?us-ascii?Q?4rGXlShQzoRmxTlicWIn5oEHPg2WujmvNL9j1cRBi03X2NsMN5pWLnRB7Tqr?=
 =?us-ascii?Q?VzqKBT5fzP/6w6+bhJO7u+vkVSVDM0J7nw6bB3RGuGrf6z32zNmcutEeDU6x?=
 =?us-ascii?Q?oNYsrA83dnS2q6qgZ8cyQ/PQOK+PzTb9Hf9dWwXiHLxYQmyvce/F7TFREwno?=
 =?us-ascii?Q?x/l1gwROqG/UNTbRu51QUOlO4CjLWR7ZYS0NlapA7my6jTbs5dV153XZ66tb?=
 =?us-ascii?Q?g679LZKgakJmNYlByjtHhPmUVoy1tZIyc5FeNABSvwplSbwmQ453XT+I8t2k?=
 =?us-ascii?Q?RU17jfKTH9L/yL9kp7TJmOV+PGzX1LCumwr1T0RSynPD8IBkzqp5XYhohNFz?=
 =?us-ascii?Q?GGVtAKtXChju3c0J40wFfUy0NdKieAV8smWEbKYEbn400tT8ihElfj3sOrqF?=
 =?us-ascii?Q?SUy0k6ztMrIlcQaPs9YhtFRg1mIzMfZ8BtGeP2MyAdERHmQjZjEktUFmhKkP?=
 =?us-ascii?Q?J+irQcLixne5uNkrmQL/AAaP5/14qdme9HFNdMxC8UEqtnkzFTcfx11wn6fi?=
 =?us-ascii?Q?VgxlgiXgNYEBXvgFpAquxUkyJbwMnrLdOMiOO99TEzmSA8eBDqLf2V/uvFAh?=
 =?us-ascii?Q?SYuiYx7MyiHFHVFeIt0r+LODdfLv9GGgYyE2O+Sxe/6zkOt8PKNpZmhsqj1c?=
 =?us-ascii?Q?9hL6Eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:19:26.2192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40b2c4e-c04e-4603-cfe1-08de54172dec
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7203

During an SPI read operation, even if the xspi->txbuf passed to the
cdns_spi_writerinterface is empty, it is still necessary to call
cdns_spi_write(xspi, CDNS_SPI_TXD, txw); otherwise, the read operation
will fail to obtain data correctly due to a lack of clocks.

Fixes: 4e00135b2dd1 ("spi: spi-cadence: supports transmission with bits_per_word of 16 and 32")
Reported-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Closes: https://lore.kernel.org/all/lbijvnnwsnddonmm5pveqzap6iibxhl4maneq43x4j6w64dev6@u75qhm5cwiob/
Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 drivers/spi/spi-cadence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 47054da630d0..41b5b58cbfac 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -729,6 +729,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	ctlr->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->flags = SPI_CONTROLLER_MUST_TX;
 
 	if (of_device_is_compatible(pdev->dev.of_node, "cix,sky1-spi-r1p6"))
 		ctlr->bits_per_word_mask |= SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
-- 
2.34.1


