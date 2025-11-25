Return-Path: <linux-spi+bounces-11505-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E1C845D8
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 11:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F10FC34543D
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929042857FC;
	Tue, 25 Nov 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lHbX1sqt"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D6CA4E;
	Tue, 25 Nov 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065229; cv=fail; b=m6yOm1txIDman5CApbVHOKMCZIQRjmZqmWB3Kb9oJAxTNwWGHqikWZWGhF0haBXs8MbtuyAT58igw54PSfJQh/GvX25CukzzWpBokfLcpdCJ5M/qjwzWhpPWV8tOpy5f2GgxrqDnvZ+7DraZdP87uhVQaHSu+nEzGEEooRaOK2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065229; c=relaxed/simple;
	bh=jB+abD0qEBo08+vASWLstuj8K1dPuXDTLZVxFeRxgyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5F5TrFQlff41wiHc0h57FumK6NtgdUtp7UgDhytpfRitm9CBzrzERgJ6i6RnTi1EMnPniPU3KZ+MYFQp5jt44AP4cd1mNzBiqMB8IWWHLZh2bDX9mFAQkPJykP7WAJgydTGYWQj9WNGwVOR/PQGpRCa5d6GPUQyiBrF6GEFbZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lHbX1sqt; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky3mqwrlbff6UecUBV/VJb6YHkIH41hEhfvUI/uBjsq+6bacSZc6QqfbaBj9BfBkzv/4gIrOWffhfO5UH3ZhkMajW3BZJNbw7o5e6jtVcItsskXg94S8kELbDmAVvoSUXw6Xix36r5QHvXfQ3Y0F0YTrtkhWSeBuoTDqC2eQ23o7jNG+i5X4Q182frSTotngYh6qAky6Pkcz4624mVjN9T00Pw2ltxIew4SDHnZo5liSXCkX8sG/V9kHVZW5my6KTMcYd/P/Xy0cf4qTVUejwRgDTz07RvoV89tqNn28WRA4ruUC8Bzu2IpfA3TBbuiNljcnkCkuKPuRnaE4BLrlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vydL92+taC+nnqA1XDMJzr5sXiyUTtEeJcHMbdcm80g=;
 b=gq1lshEueMcO2+NwFy+Aygz29S8Txd9qqsA+LRTkz6Cf6J7wxOgg9eBAzZETh9vY1bfSpCkUpzoTOF0bknOSZR7CP4BAR2fBAUAIA0V7QcS7rBOHaBOcO4WqWA5X3Lk+AYgRI3/riB1onh5h3VrIyq+FHKb6rwcPyNG7MR0+LQuOESD+PaH72gnmSSmtA3d4al5asQibSY5/k0NhF4wIHyNboZByh8BiNJzLAxAI8Io47Nnvq/7XMzrgliTA9fIBYxLnFsoWDxzsHvUn6iCEM1WF6843fMPQ7xGMJnZIie5TC9fmz9xiC3mBMkbTrw4uYc+RU80KUWDl2mlNn4AdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vydL92+taC+nnqA1XDMJzr5sXiyUTtEeJcHMbdcm80g=;
 b=lHbX1sqteFY9EVmB2gPdTGRgpFGFI/ggAvEUu//SUfdVIFOJ+FlyObKrH0TEeq9FE5nAP3dg2p9o3Mtq61mLCupMFPpJ6FB7deX3fp6fGz9iTHlkx7gYz1bwiAFpwLq0DVKhz+6+OUcPPNpuwvsHFCLuEepgT/9CDnRHrL0TaDXaTrQfuNJyMIHe+uU8dgSkIcgjG5grmm/bjaK0f/iHGmTht9d3jb5EIX6p8fRA2t2qvKLSFteu4nDEdX+VS5Ku9YNJlpYyah6FbWBd5fEOPfNjGdMfqHYkD5eAv0ys7D4HpDtql7fnwh1oaqJugzy3MjJv7m6Rjec7ZmuiGthNDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DBBPR04MB7657.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 10:07:01 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:07:01 +0000
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
Subject: [PATCH 1/6] spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
Date: Tue, 25 Nov 2025 18:06:13 +0800
Message-Id: <20251125100618.2159770-2-carlos.song@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c11299-6a5c-435a-6c21-08de2c0a6059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rpNaxChICDCaX8geZu3Uycecl3++VsSZw63o9Dfg0VXSXlQ3+J56nI2oCup+?=
 =?us-ascii?Q?61u5S0GVGxu+1mz75nVZZxI8Qi8WofNIJOj59lDZOVSt2UmP3hzc7OBW2EGt?=
 =?us-ascii?Q?D/g8OCo1pVcFQdTGmXSrGPdmDA0+nZefjqSaxwb2ifi9t09zUNFDvHl5jT93?=
 =?us-ascii?Q?PVoZANjRN/9JZWnoF1lWiE3+dgHeYvaY9cFfA7YBdJ1Jxnkvppa27v9BATdd?=
 =?us-ascii?Q?lHjVsjWsAOphqUrsesUJeRLvqtyb5vJ2ZRi9tI5g+MffWR7uEV93zjHk3/iG?=
 =?us-ascii?Q?l+1B1qGhLcJ1EpeoQPteDc0KNR82OdYFbgqgrVX+4fUk4zvR28KJtoIcMmN1?=
 =?us-ascii?Q?npCQoItb0gtcxXFJSte2wMDFjPLNffj6Wp1Q5Uu4mBL9KcFjRYudu9+boVq4?=
 =?us-ascii?Q?SsRGXuC4804t2oZgozg0z6vnikXKY0314PWwzoC3mWUCH6v0VgNWh8FThRMW?=
 =?us-ascii?Q?rMkYFnUwYj2vYon2dRrreRaZSMdDhLxewuKUC3uIrXZlcUonBHqwibCyZH1c?=
 =?us-ascii?Q?3GEW8S3nq6Ff/Xh+xJKJ8NlTFtfioK3IHr6U0HeSCK5A5TZBWrM63nNqKO72?=
 =?us-ascii?Q?SlDhe1/NroZ0uyPtcfsni3S1LqDRidfd+/raaB3zsv438axQI+ZCMWlnybZe?=
 =?us-ascii?Q?urBqR7u0pJY7nX547fJr/CCIRPIhWpHT5PmpFU+HMjKtSyrBltR4nGTpib3r?=
 =?us-ascii?Q?40+gB1X/R0DTWg63/+kmtkaQxjt/STwgKOgMGgwIYc/MLK25/Qv9lcqubuqx?=
 =?us-ascii?Q?1vyrYeY0WJG8SuKP3BcqTn/soFLGymnl+SkKknRqJeZ1OPF+7SLQUglGflt9?=
 =?us-ascii?Q?mWpnp/ht0fi0PqJibX5IN6XJ6KiQlV/rcfINh9nTlVXDLi09T0tOuvAf2hXZ?=
 =?us-ascii?Q?Cf9As8Yf7/3++JSGsmfoTQ+pW0zHj1Gn6bMeX/Rc2dh4XCz3kszAYZZGG9et?=
 =?us-ascii?Q?XAXT2vZwA+qDQTBQO4HxX4HswNCkN/zRVqM1BVqCNRrVzDf7bUG+IZt/z6B7?=
 =?us-ascii?Q?CbciJ7FHIBqUB7kK6DwuMi66MgIh/ycPFfkMVM8V2QpOvOY0QkNFpzRZb2Ww?=
 =?us-ascii?Q?0kJ1NJKAi6cBc0FuaNytVBuIjTwpUqYgmZT//v6LwEz7PKfyUP44Ayw4Hgfz?=
 =?us-ascii?Q?6TS7pOGbHqm8tEhZo/n+sri8x6z3PSA+ODz94vvvpRcxemvHelV55h3MSvyh?=
 =?us-ascii?Q?zcZCJQgrRRugS3QuQxx6TfRHlJVL9HEs+8T9LIwPcjd8vDtYibsLb1R4uz39?=
 =?us-ascii?Q?jZDTwE83339QxoU902IFboIRN8MtjXPfVH6rEBJPSNyvWkqLFusEMtjUpsZb?=
 =?us-ascii?Q?fvOfRbQ0JwlBOiBe5ZTpCtXFm8UIZ7orcn60Fx7ZmwRn++Rm961gE6qBdw54?=
 =?us-ascii?Q?NmElI+nvFp9P4XzbMgfbEowsMUPX3St65+Ib+EY/7A7pXMbqCq5f8L44lL7/?=
 =?us-ascii?Q?+qMDSaG3uGI3E7QpiJflneEVR6gyISd8H34HaYQ7nGon5Xr+GZlxZFY6VSMN?=
 =?us-ascii?Q?lV4jDBCTN7DfXhIVdgRBzzIaDmSeZm8ygP2p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zp3yS5NRYA1sgP+9rYBiXkM7GvlFaFg4udqnZRfXE6dL9Xst4a9Y/qrJ78ko?=
 =?us-ascii?Q?32P3x3yzZI5OOl7RJP62IV1Szvve0bba8mZi4V2eO68R/WJQIwS8fuuARYsa?=
 =?us-ascii?Q?o0ohCR36SuugzwZRJsy1T4xyRrtISRX4HrqMAuXZDPxXyt92/cZdLXH/Y0vq?=
 =?us-ascii?Q?2/+7G+KkqyFSFvWavrkcrrkTTZf1kkXCsLPHzK5S6wihmF757VlHktZ+dOkG?=
 =?us-ascii?Q?46/oMDUztr3uurdcnFTLwqMthy6/AhQ9v4vXmCBD62a/3/NGIJf2uew8OJIh?=
 =?us-ascii?Q?Erl3uEV7r14lBIRkbfJ6y/cQgOGuc7oHykO10YL8tfH7uAFeZeiAjDJLApx8?=
 =?us-ascii?Q?89924S9t+ScWzKmbtzHIe0snyA3e98jKP6dm8ctTmojnJmTUN7pEJ573Cg1M?=
 =?us-ascii?Q?ueXLbbwr9EdXAjfyAUDW5IlWQ2tKzk0yj4k7UJXIwxdxWhd67l0BtS/bde4I?=
 =?us-ascii?Q?41yliYzG0OMRLubXmVuU1I+4/pMawEJSrI9x7/kpT4AY2++vws4QlErV5NqN?=
 =?us-ascii?Q?Arqvk3iq1iftRWE6uxOFWU7IuDS0nu/Shbn2IwKGJPTAHqjMfFiddWx71ff2?=
 =?us-ascii?Q?JAZvvT4k2tFBsqsw7COKBGmI41Axc3rL5JBTBLvtPWJph2gDX6AsLLVoOgg9?=
 =?us-ascii?Q?ICft15KDyZ3MYop+q44ST/V1ygq58sJX4DJr7TCvZ9e78ys7TwSGNcbkRDlL?=
 =?us-ascii?Q?rx3x4OOPKfOL2JF6gLZXgAnmhNLhaFzvyuwC94S0PzsC13qVzqCZPJrxxvfH?=
 =?us-ascii?Q?islfrxmABVYk2pPvXA0V5Q5ulYYFHutj7cFm808pfPO1xXUbX+uLwExJhic6?=
 =?us-ascii?Q?CdS+zYuduzvXsw9sEBhkTgfmK/DpS5FI3mk2Kf4UjNbk3YyEj9dWtjdIBGYD?=
 =?us-ascii?Q?+TxFKRjmXVv+eoq919vWZffYHVa0uRnbWFHe1TvcP7o3RZ5x46xclMF5UHcC?=
 =?us-ascii?Q?GkL2DjRKNoKS4vkkaLjcEz7r/31IIkzWBVopF12Dw1cDJF7uFKo0G6xkM3DW?=
 =?us-ascii?Q?7UMw0p3pyDnGY7QMtNtro0p5+9EgRqyvwW6ZTyR722bBJ1/yjfFZvRqCVitY?=
 =?us-ascii?Q?nA/3e8q9nbHp0tRwfXyNJHOjL0D7ljEUTMP5nskcZ6xmx+pAuiw9se8D8pJz?=
 =?us-ascii?Q?jWAT004AoUOcRGiDK8zFASIaelBdO06iNKlrsFT8mPsZ+dQhXTwyEAV2f6W0?=
 =?us-ascii?Q?QSIuhgf6iTmy67/g5oPLapKx8VvdtiQ8ClXrcqOYr5v1rtZTKIm18YEJrpWT?=
 =?us-ascii?Q?dVJf2O+Npe09SRc2DYgDQA32IHbizFy/YX3icp4RV7nJnNHM3tfkh4o4o4Id?=
 =?us-ascii?Q?dafKDQCRkWc1AHscZN1DylBTFvJh+gq833ahsrZplxYecijkHgk7QzIC/oyq?=
 =?us-ascii?Q?/Zdv7/eqMp4NXnoyrpaI7QOaxaPeSCYovjP/lMm59BnoutfE2VchkPuJLkO5?=
 =?us-ascii?Q?zfqtv2uGhg1uPXYgFB+5vQLhinHAAFzm54YRYkx0MTm2z0CNEmyaoIrMe+s/?=
 =?us-ascii?Q?xwjVh5izsp8TwdtYqA3SnpOiz8TmUBHZ0J1/CMI4njH+SisLNxT9i+kaVN5O?=
 =?us-ascii?Q?0hhsbFR4JHWHf5Pb8vc9JH3RErSHmcxgm8NFT74j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c11299-6a5c-435a-6c21-08de2c0a6059
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:07:01.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvzJ/QXjAUkPtc/lYjNBxHEaB4mGWGXkL/n6Dx9k9zQ/tirgxd80sczlsBY9r+GIM3fghLKkGh7BePF/JHQVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

Relocate spi_imx_dma_configure() next to spi_imx_dma_transfer() so that
all DMA-related functions are grouped together for better readability.
No functional changes.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-imx.c | 88 +++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b8b79bb7fec3..e78e02a84b50 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1282,50 +1282,6 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int spi_imx_dma_configure(struct spi_controller *controller)
-{
-	int ret;
-	enum dma_slave_buswidth buswidth;
-	struct dma_slave_config rx = {}, tx = {};
-	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
-
-	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
-	case 4:
-		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		break;
-	case 2:
-		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		break;
-	case 1:
-		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	tx.direction = DMA_MEM_TO_DEV;
-	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
-	tx.dst_addr_width = buswidth;
-	tx.dst_maxburst = spi_imx->wml;
-	ret = dmaengine_slave_config(controller->dma_tx, &tx);
-	if (ret) {
-		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
-		return ret;
-	}
-
-	rx.direction = DMA_DEV_TO_MEM;
-	rx.src_addr = spi_imx->base_phys + MXC_CSPIRXDATA;
-	rx.src_addr_width = buswidth;
-	rx.src_maxburst = spi_imx->wml;
-	ret = dmaengine_slave_config(controller->dma_rx, &rx);
-	if (ret) {
-		dev_err(spi_imx->dev, "RX dma configuration failed with %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
@@ -1481,6 +1437,50 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 	return secs_to_jiffies(2 * timeout);
 }
 
+static int spi_imx_dma_configure(struct spi_controller *controller)
+{
+	int ret;
+	enum dma_slave_buswidth buswidth;
+	struct dma_slave_config rx = {}, tx = {};
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
+
+	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
+	case 4:
+		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	case 2:
+		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 1:
+		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tx.direction = DMA_MEM_TO_DEV;
+	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
+	tx.dst_addr_width = buswidth;
+	tx.dst_maxburst = spi_imx->wml;
+	ret = dmaengine_slave_config(controller->dma_tx, &tx);
+	if (ret) {
+		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
+		return ret;
+	}
+
+	rx.direction = DMA_DEV_TO_MEM;
+	rx.src_addr = spi_imx->base_phys + MXC_CSPIRXDATA;
+	rx.src_addr_width = buswidth;
+	rx.src_maxburst = spi_imx->wml;
+	ret = dmaengine_slave_config(controller->dma_rx, &rx);
+	if (ret) {
+		dev_err(spi_imx->dev, "RX dma configuration failed with %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
-- 
2.34.1


