Return-Path: <linux-spi+bounces-11741-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA46C9E56E
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 10:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F353A4716
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4972D5930;
	Wed,  3 Dec 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWaW8Pcy"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84D218AD4;
	Wed,  3 Dec 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752442; cv=fail; b=Y/2jGueQN7NzXswRCvt8xY3IV4FWJcWKSzR5XZIrQGHmvN7abdJoW8cEsVIXtanrqcrxnu2WjfyH5lBVdTCfJ/+WBG+JlDO5+QRw4R5FVmXcCiXuojxrEn6dd7OZCrCX8v6Ums4xpzcs+JyqnywYqRq6GCATzLcRgP7uZPLLTw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752442; c=relaxed/simple;
	bh=H25pw5D5zL6skjChnyxfweuc79CQ/ylSxbjW+YJVPF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ur7IrvbteuISofLrMLjVNFFsVCP/9FtVl3OE8H5dJpLMiR+JIbaLsTTpfdegG3nVEwOZgwfbmoSOidTPvYTT5k8/VX/MMBAxUp9+2OTmYpk56LphprS8kmrqTrr7o6zjghgueIO4dTRrhTQoc7aHYRE/0pRQ6hh67z5rm2dCop0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cWaW8Pcy; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f24PbhGq0Z0yGTTx+Sd7dw9ZFMqVSI/1ryWw4auJcjdO46zoaY1L3Ohi+M/l1A88wSmjKa2BNNv5sqA+CC+98d3MRYwdgjXj50qLn7j/BqIQIznMvl1yPDh+0QWZt1LTS1PXwOo2b0YGmjpwO7mMcPU00wO4sH89kufO+9/dIV4Cu22mwx7fZBOvzJQiHjJCm/SDkXWy8Vl6KB9mY4+WEN2q4HwKnvcqW9ocGtu2JDwtNphjcqA/7o1Zle02+KXJ5GxTHf1tKBf9DT4X3EsXctcUR6M7EzjCAopYJ+eRpP+jcER1YyaaaB5af3cSQpCOWGacU8G9dBmdWpzHWDe5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sPjGfJ4KUeawhjCFNtgrNytcqNmzSFeWPen5MoTn6Y=;
 b=p2NdMky+ZcWUT561tWZM6ZpCBjCC4jWc+qL//bbL1unjCGbexPvFiFEce5hUXF+XlSQXJnAYrAgklv9Gn16ExchNzYU/4xbfRUPk4z44ZN3+Sao3DmhC1uClYRhNSCfAAh/Heiez36lXuWdC+o9k6IFUi0UvbLO7oLMlSdvx9MJ+iKSXnTzcR+TopPQHIMg/Nz6ezpE45ROtPy5NZRPhFNXC5qPideoPMVqoVeLVpvOzvrdpwp7ZBXvb8WQCUZkxVahm1VusAyP/CqM+ckYicqGI+H1qWGqSrBBxaBLFt3rRQZFh104Fw3NF2B8PxAZ54zY+g9gv/9c+TQfidjRf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sPjGfJ4KUeawhjCFNtgrNytcqNmzSFeWPen5MoTn6Y=;
 b=cWaW8PcyAss5MnlaquAFcBaj9XDFxWF39b5uUjbKmJclparXCZVfJc0txYBlJ3/PzeGvKvtLK5byjbQjsMqqy8OsyCijo6q3oext+uZrDB2iit4/Txp8MhgN8ddrNfra+DkY0J06nKc33N5n+Fymk5g7a0IPd0IGiLmr4Gnm4Pk2DMmA2kOFx+goNlOB7lm9lqJrC+fOq0mLiRh0k8DE/+b0KZo1+9RgV/hnN7FSvdZSd1uBCrXI0IbkBKQztAtJviTrdNge58s7Wti2Rv3v0eS0+eoaIizE9GZLeIJYQxq4B6z4ul0kkBhAABpSvrogR00ggudzY8zCd/6p+I7Z5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA4PR04MB7981.eurprd04.prod.outlook.com
 (2603:10a6:102:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 09:00:37 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:00:37 +0000
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
Subject: [PATCH v3 4/6] spi: imx: handle DMA submission errors with dma_submit_error()
Date: Wed,  3 Dec 2025 16:59:47 +0800
Message-Id: <20251203085949.2922166-5-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d6fb37b-83d3-42c9-a9cb-08de324a6d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oaSytfZjEKOjeSeATW/Ym/oso2reIL9l09fRVhRstqSxaHvyf2KJl1loAAtb?=
 =?us-ascii?Q?2POHs+vPH3/V2mLLD4brAnGI/AoiaUAoKxaL6J7lb7HpQENuuWpyjW7tbPmy?=
 =?us-ascii?Q?JtFiPk1tyJNyx24FIYKo4U1Upn+yZFSqjB4CYrJTorrtWfI27Qy2MWsenLd+?=
 =?us-ascii?Q?fMbotXZAjukOxnXlZNcrSLwFdDcd3yYfmJ5L+qpxoAfgyEOSLQJoNINbrMZv?=
 =?us-ascii?Q?LcDQuySqXW+7o0FAaXSu0Y1PqJw5H7L4l1FFkvZOrwWZQakUV4Z+FtLFuBJA?=
 =?us-ascii?Q?gow8PYzhNxKo/WDovoJdQns5ZzM3Sn9lGTmsyauTt0qqf8XhNGSylRQ+ygHr?=
 =?us-ascii?Q?4vVJjEQzAtKKV5SMEyB8Dfq82pSIc/7iQ4R5W10SQLW4qLkL11ugAOO+5hJK?=
 =?us-ascii?Q?uRmI9KPJBDUuK5BncZ3PCSeqxigbZwXI1q/B/AjO6i6HOStrDmm9v75ZdHF0?=
 =?us-ascii?Q?UrDdnmIh7BX26PYz9h1ZQKC5GyMGixlWi7ngq40vE0PXJRqRMBk88G7C8+eu?=
 =?us-ascii?Q?AspYHofViS3WzZTngAf37d4bqXJXDv+WqeK88H8FiX4qLfjVMA0SAp1GCNq5?=
 =?us-ascii?Q?/3nQTaPm59ehR9ru+60/1BCneKiqOT8zlNNy9FqAjcySEWeQgnKWIenYKGDI?=
 =?us-ascii?Q?mphK/wn7ASP/lRDUFHaUj9TXueg8g5Rj1nDBYGVturHLr0YtWufp7Ktg3967?=
 =?us-ascii?Q?zuZOwxWW7ViBj1YUwA0q4TZkz8OHLot9Ltt9LkXPJyU4i65mmyssOKMIEM8N?=
 =?us-ascii?Q?Bt3lLlFYe2I1DwHyuh7L/63O1rXWE5YLM4YKvBIT3QblNjvtJ3p8AXRA8i+0?=
 =?us-ascii?Q?FdWAD/kvNXQkWETzN7hjqo00lfxCP4YVFM1K7JI9amHfRjzHhJ6MC6j3Z52j?=
 =?us-ascii?Q?4HBVJvGDpSceABWRA2qjviyde76enr8qnm4o+mRLjxwhDGu4+PRS1ycC7sAs?=
 =?us-ascii?Q?Pi7dw6BrwF/tFK1InJJubwCgGc7By9Pzs0Fx5uv144kVW3MoHoFiftIfTVWI?=
 =?us-ascii?Q?RS5TfLDBeY7Az0MdcHfC0aelbkdvQ+dFzSxy+Cbg9NUYRG1GEiPqOw85TYFW?=
 =?us-ascii?Q?iHNYq8gnL/hokFXr96LB24pbEZfRgCtvOtxROIfESYOlXUavbiRn6F/XyPia?=
 =?us-ascii?Q?Owy9t6bcmDRRUpGY/+G5gMR764Rkg9yE7qh/UbCCXJ1CVDIruEiaFIsmSMfz?=
 =?us-ascii?Q?aDM+D+yvVRkhjYxKk3A4h+0OLWglwt9OJQe4JBXSvAUSNC+vRT0FMUSwz37f?=
 =?us-ascii?Q?WAAYkIPeuXh31e92zt9v3MFkOlZFnURNQ+1YJ+hZR15YXLdXzvTVfAuY5Asw?=
 =?us-ascii?Q?eQypWwMyVhI8cciqPD5k6LNY202GYi7T6OwdekpX4j4ibozPVC+F7Z6RIS7W?=
 =?us-ascii?Q?VdKdp33kT4fTHwFImzHf93zkXohfpQNP0y5gDZHN074hnbYfLTuon+/VpYrC?=
 =?us-ascii?Q?A49+ka58R4RTcZIKTSGHBqXtgqz/rQdgTIWW4rV86bUzJfpUY98Qnja436Xy?=
 =?us-ascii?Q?QqNVCfDrGN4wbUpyFtdDIipT2/3X7ncFfLiz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wX9IwYutaZQoYwVvGtufp9D8emRqRJiaYvI/LTNjbzn4ZyAlnVmCe6EwDW2v?=
 =?us-ascii?Q?Kw746ByQsdYEhJs32up1IAp5+MoyVewonZd7RofiYVEnmQUKnV60Jfl8fLHd?=
 =?us-ascii?Q?eQCbiHRDNOkDjyz16A1ilVduSAno9SCfrpJ+uh/D2A5DTQsDne8ViKMYrxvb?=
 =?us-ascii?Q?vcukOkA8TqTbhqOZb8Ic3iSnrTaZIikV2VVmYXFMXY6NP1UqFQ8qd21wRQSP?=
 =?us-ascii?Q?M+Nfmv1tIoxQMSwlqa8iMphQZ/C46GhWRzdFSM9g6a8x8Da1J0uXHHI2j9UH?=
 =?us-ascii?Q?CygdL06YVZ9E9bgYmDRX8Qp3EKmzErbTH/riX+C3bI2HTzu9pKn0TTm4s0e4?=
 =?us-ascii?Q?yzOkmr0D0tQcG9l5/RYNNSXrAW0G48p6vThls+j2k29viY8fGCZvM5oTYYnv?=
 =?us-ascii?Q?9/aOY3gkQKjPXHXbI7B5tIleLBihWMrCiIXdPHGL7KQ3EcoLjJmj7eMVWYLh?=
 =?us-ascii?Q?G+JodAp3Bi6GXZOlJI0bB6lD4oGm9MbuAxgPENyZ5IgHQBaTF4tF/x5p7nnm?=
 =?us-ascii?Q?03+Ei4/QHaVnikxJSFCS/lZvAHMdCHfh3TKKuyUUJ+0M76AXzVuzjSJz1z8R?=
 =?us-ascii?Q?3Go6CKaSWhLLJum8FdQfAi798G4P5hcy5n5UizHGb85U8eLqV9NEFkczErak?=
 =?us-ascii?Q?RQr+dxnvtaZb0SIgyrhvkOVDbjoYRXxHQXXADuDKei9PjXseXKxUyyXcsbSu?=
 =?us-ascii?Q?LEXOl+RzKm5M4b2p7FxonxA6lVu3z3p4MkMVNFLejCULTjWIJPcktfR8L8yd?=
 =?us-ascii?Q?u8bW6KgNpscNrCubBXduLKX22yxlcwAid0OISDtTze4eAPfYiYJMz5szPT7Y?=
 =?us-ascii?Q?1iTy+ZHwoOlw4AZlhMABYqGR7HIh+IEeKRJLg2oLR3fETaGF5mV/LzjRag3p?=
 =?us-ascii?Q?asJlDx5GW6kbpS2MUOqEthkTy4gIsqilDYQRF6NRGQS+ZG6GfxUIMq6DjapA?=
 =?us-ascii?Q?/dGtXnGy3lLyw4Y7Uvi5xrjWpEZi/qpqYCDD76PD131m++ep2bM8a4T8WDhq?=
 =?us-ascii?Q?JwVdtgSkpJN97aOktlCxUbHClRbzdPEPMOcyZjmeBSCLyTPZ2IemQzRBvRyy?=
 =?us-ascii?Q?bsfQSQkVoQxNoea7cqD4Fs08cYJ/CWuMkBOwcCA+sHL3wWaC1nrms+tiCfB/?=
 =?us-ascii?Q?jx3/maZWRunf+DPEvWzgROBic5jfwj2yjyg7MqWHxgPXMcg+Sh+iBVWt6xYj?=
 =?us-ascii?Q?eaEvHfHUBLqWus9/hqlzpxXbpWNeXJoK4GMeJLeToimkcDobPQOBZ+l0437x?=
 =?us-ascii?Q?RImjebxS/LwaiVNJuq4nOj8ku1Js27n1DlDYdDtawe0IhofH8H8XR6HHXaTp?=
 =?us-ascii?Q?3YAYGyqG8+MAfutXkWqOCiKlarLuCb5GJziiqzmOlEGWwzv+d1WXTJEHfR+M?=
 =?us-ascii?Q?nWIkLQrdGubW6uKqLl7pn1zdJ2e0U2WpGqbhTtY8zZel9dYdW+mZ1a+90mo8?=
 =?us-ascii?Q?vsB0rtVn3p+1qPTabE/itVqJWs8aywPNpfzM8tUALbTCt2gU4AuurodncQ3i?=
 =?us-ascii?Q?m6aYFn7IFxT9JEj4pHqPGexFfDN6MDKr/2SIemwJTgSK+wcxaVDAzT8GPJZE?=
 =?us-ascii?Q?P6aFDHoHwuHMYe1w70u0n3++MSGCHJivxx4KMXbo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6fb37b-83d3-42c9-a9cb-08de324a6d11
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:00:37.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhqji4Tlca4d9jyx0Nasp9s/yKCRkXK45XdQWMBuf+A4iLYC3vTcLipHLZZc5zhJtU7WkyYgOXPtzD3Aj79bDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

Add error handling for DMA request submission by checking the return
cookie with dma_submit_error(). This prevents propagating submission
failures through the DMA transfer process, which could lead to
unexpected behavior.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-imx.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 186963d3d2e0..42f64d9535c9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1445,6 +1445,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	unsigned long transfer_timeout;
 	unsigned long time_left;
+	dma_cookie_t cookie;
 
 	/*
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
@@ -1460,21 +1461,29 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 
 	desc_rx->callback = spi_imx_dma_rx_callback;
 	desc_rx->callback_param = (void *)spi_imx;
-	dmaengine_submit(desc_rx);
+	cookie = dmaengine_submit(desc_rx);
+	if (dma_submit_error(cookie)) {
+		dev_err(spi_imx->dev, "submitting DMA RX failed\n");
+		transfer->error |= SPI_TRANS_FAIL_NO_START;
+		goto dmaengine_terminate_rx;
+	}
+
 	reinit_completion(&spi_imx->dma_rx_completion);
 	dma_async_issue_pending(controller->dma_rx);
 
 	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
 					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc_tx) {
-		dmaengine_terminate_all(controller->dma_rx);
-		return -EINVAL;
-	}
+	if (!desc_tx)
+		goto dmaengine_terminate_rx;
 
 	desc_tx->callback = spi_imx_dma_tx_callback;
 	desc_tx->callback_param = (void *)spi_imx;
-	dmaengine_submit(desc_tx);
+	cookie = dmaengine_submit(desc_tx);
+	if (dma_submit_error(cookie)) {
+		dev_err(spi_imx->dev, "submitting DMA TX failed\n");
+		goto dmaengine_terminate_tx;
+	}
 	reinit_completion(&spi_imx->dma_tx_completion);
 	dma_async_issue_pending(controller->dma_tx);
 
@@ -1502,6 +1511,13 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	}
 
 	return 0;
+
+dmaengine_terminate_tx:
+	dmaengine_terminate_all(controller->dma_tx);
+dmaengine_terminate_rx:
+	dmaengine_terminate_all(controller->dma_rx);
+
+	return -EINVAL;
 }
 
 static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
-- 
2.34.1


