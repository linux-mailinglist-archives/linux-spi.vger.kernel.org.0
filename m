Return-Path: <linux-spi+bounces-11508-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AB7C845F0
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 11:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACD53AD9C0
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028762E03F5;
	Tue, 25 Nov 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f3DWoVTd"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36152EA156;
	Tue, 25 Nov 2025 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065262; cv=fail; b=OyUvgV1KTmsOROceQlQFqdb4X79Umq7KJrNSjZHRiMsszkcb63e2DVsZ+3ZTN63l8MKuDVB2/1vVvNjMC3H9z8iGvHj6+kXQuLteFlOx4x8DL6+579VVKpIh/CNXXHbm+GIxtL2qN37NRUB+qrfviyCrBSkAyIRrGv3nrfNyDkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065262; c=relaxed/simple;
	bh=peKKjdMmIHNZ2ViLcqOkfjfIRHyN5JcGAJe+DZuzUlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXEzmDT5C2tCjXadQa2pBM7XdC2clywh8ZzZhVHt2LgmMGuBBlxDgn9hkhCFWpQ520JHkRpQLEGfbinaKCZYNyCScapyetiZd6IrTGxJ+pYjpip83Zo6OgYzP4wWUzsADy47xfu26eSfryO6PfiLTwKeqGanRzMV2yzSYA0RUFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f3DWoVTd; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iggE2W7stMqqa7uw1c4Pl0swvgNOVFJ4Mc7p89M1FqO39lo+x362XfCBM5SnLj83i1kCvVGAGH4NujcddJQ8PHKbPpsS9ZlCli6FxGWJy4Z9ZHc+ZE27ATn/G1XVpZc9yWHr+syGmma1ZfRd9FSIcUm2BpylBKjgCmp09UU+zTnopBxXwJWAacx3n8Q8U+RaHDxYnnZ4NAnDOIMyQbKcznaNyoDW2PxzSzqnP815qbOxiauvdckqSFMGi2hGBXf2TZjtMC0sKFcdietPHww4ZK/LXl2YubX+PXFqQunLKpXaij8UDcR/3xQGRR02MyIRhPq05qgAOde0NgBwZ238vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehlkSbPN+MOvgymNCMA3sok9RgPVu1Hu85snw0jkSVo=;
 b=JYAx3+PdI42/3NautnJh691O2MlVd1TRGwnDcRBePgAqFYmsBdn2qbhLsJvN9DxoDN9fJEfWhGly3saOic88Zj52P2QbDAdqFkTiuiS4GzMaFi020DovRnerdolQ373lC0Lj4nmNwgMz/Vft8izJcmvnlROu7q3SL7squJ2WLKMCCsNHPE+dogaf+DCWdQS3hYqm9LIxMWGOeLGN6XUs5XdwN/q7QQFamHNWLkdboqpQPDEvW+kDmHan7RADjTgd+MG0N/UrTrUc9/Ohwr6NFjo0KRl5aypT43flmDVqAibelovtOaNhs8S3ceRu8Fi5rlsh1Rc5RymeBFwhOOkA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehlkSbPN+MOvgymNCMA3sok9RgPVu1Hu85snw0jkSVo=;
 b=f3DWoVTd2jvNE+A7LFZ1HPF6BOWYbQVrLSK3riiiyD22JU5ZugdTYlR2jCIya5I7uKoDO3PZYLdvkGimp+7VwzvtwmuiSj3RHvA+rGhoENVCNdge17R6er0siud04MKr8+jcjiufBdhZF6flT337IYpkwFJ4McAsDJVJDOSQzXNf4p4QBuCPnBumWImcRQEdSUt7u1F6/47ddnITUIek31vKscAX8T/DwEpG0a4AiAccYWn83CzTFkYRdsvXpXpi/DFg//qjxTJmOitiUf02uVtUq2m1F6s9eWCkwnVGQUp0mXF2ufahpeciLczfbp/Kh/m0cUf8qUhDbT6dnY2zwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by GVXPR04MB9735.eurprd04.prod.outlook.com
 (2603:10a6:150:118::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 10:07:35 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:07:35 +0000
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
Subject: [PATCH 4/6] spi: imx: handle DMA submission errors with dma_submit_error()
Date: Tue, 25 Nov 2025 18:06:16 +0800
Message-Id: <20251125100618.2159770-5-carlos.song@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|GVXPR04MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 99eefe5e-5a3b-46cd-4e1f-08de2c0a7414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKtOCnLImrj4OZI5xs3p9pd6CiIehe0A/0Y374HpkdRLk0/ovDkvskpUlqw/?=
 =?us-ascii?Q?Bif9oik6Im4chlA+xV988Qp5MeoU2Lh1VPCe5A/xhoYFJZfZSgF5BED+/VDE?=
 =?us-ascii?Q?nvN4nxRPkbo/XuD0MDYQRhEI0HW8wmmblZ2aBYAnR+3HfZ3ybh/OHKip6Cfj?=
 =?us-ascii?Q?vhZ2rJXxlsWXaZj/1Vf2ZFgjVMlaZN+nQYnLhbcQaoV6WaRpoyjMd5QSuFB8?=
 =?us-ascii?Q?D8sNu+Srx5WnY9bf1GP1brUm5/w+M9PTe/KiCVkzcErXf6J+kbaXHIgLMhTw?=
 =?us-ascii?Q?5q0sfuKQ9m8zcoylM+ZbURsjgGFJZx21mkiyS2rR0gj4UQIRiMwzG7ykcpMc?=
 =?us-ascii?Q?HRGVfw+PX8vqT/q9jJClV/e1AHGzlEctUOVJKlJClFJxCR0DjKohyMBX5RM9?=
 =?us-ascii?Q?/xgU6X8IsDTz0x/giTmuXHc9HwT/z21TOP2JbK1fEkgFpf2offCRfTO6Vduh?=
 =?us-ascii?Q?pRT03OEiBxkuokdj+xp6h3F/HBemD+pcMCD3MOGjsyuYnr2/j3vmrTfarNWS?=
 =?us-ascii?Q?LHULOXKCKVt64bKzXfKzEEhnBVeYYT93beHXD5J6DPDDOEoT/v8U3JdkOqG5?=
 =?us-ascii?Q?wnaQxJigrTXPnX2onTk2/yBGk0Xf3tC36oReacDrBIATOoxDmfq7wScSEP76?=
 =?us-ascii?Q?9NY/qtgy1p6pzhJJkoNtu6w26wToATkUNI6Ub3vnB8/OowDS8WCk15rtNO0Z?=
 =?us-ascii?Q?LzvVvkDHbEX+udOVise/0lDUQ9z1ivTBJhPd/ugf5rDZDBTwaiVnnNj1S6Xd?=
 =?us-ascii?Q?figIScMPBJ+JGKInUO+gx5JXf/27TWk3XCiEohckGGyBQ13GMkdJTOujokmD?=
 =?us-ascii?Q?mSsgQ9bbz+741makKI7OK6QTGzsXjQmjLRiR9DZtnX/HQH8DZ8KomnA7co4D?=
 =?us-ascii?Q?hqoEfN3Ywy+jrx9SALJ8UTwBPyWJ2FigwYIh/4rub22G0tqq4tu0aQ562jBW?=
 =?us-ascii?Q?N6UXzcLZDrO3hYlh0HSFIdLiTENrNekIoSSIeudLzxDOBPmtSZ+bSHAp96xT?=
 =?us-ascii?Q?3NJLAzo0+U4v8hmFJUA2TkxQLqt6CmUixRiFnse0b4VmiVMcJn8anpT8/Cxh?=
 =?us-ascii?Q?fUFVaKcvKAIa3ViAWg9k1/M3Gvk5iXKoOOaP3YXMmw6XPuadq1ercixe/6nV?=
 =?us-ascii?Q?ogZBgA0QgGW89EfEw3Pr0RXuUmJXtYO+Jx1MP8QfrLdh778feSPkaa9mvmlY?=
 =?us-ascii?Q?0tl6UdW3lMFPIBCamIelCtEfkIFjdLyCdNouiujffYj7VXrsiogRomTZhu+i?=
 =?us-ascii?Q?ei0CT5CJCQ3r1pDMF4olwmvVJXWLAqS3dkkC/ufnkI/NX2KAi/hWbsiu0Bne?=
 =?us-ascii?Q?RB09Ne+S+Z6DAD1j2Ze62aJTHDKaqZJz1SwuA0z1M08BPMMZLvzIxNxK3zFw?=
 =?us-ascii?Q?T9xpGiwqMqsNzCMf7oliI0Hz03QT3yiDNWZeZtNeV8Lg928V7u/I+Yc4LW0k?=
 =?us-ascii?Q?qK2/UKsc5f/OAX5DjlPOxsH5ro5rpR9hwRLIm3jKGUKxQSUZsfRzhiT7PK+S?=
 =?us-ascii?Q?aTb26LmbzL1KU5RIdXGsGHgGdziDsdX1joeI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Pnbjtvn6imjLr34rLppZfMDNOHsEO6OiuOTQpkXz8YTASp9XupFvcvIDkz+?=
 =?us-ascii?Q?F/avHT9vDhpO8PVEubU34qWVxzX9iEKGmeoCuGw+sDV7HrYseLhj2IChjvUK?=
 =?us-ascii?Q?XvcSItMFTvHl5iIxkwOOPbXJIuOW95vUuQuYwD31cuDp6qS3xlDGtNW4WB0D?=
 =?us-ascii?Q?VkbA463OA5ZcAfo/jyG4Li3ASRlOUp8zLhsoqSzpFt/3sGh7nCzmRwQOCg0/?=
 =?us-ascii?Q?JtXWRnyR/rmAjra3TXVf76EdzGYCcM/wVH5gSaWanTtMdEMwsblZG5WhUHCK?=
 =?us-ascii?Q?fo3Dg4V3bxkss6EioF0SvH7pfURuBH4gFWvoqIcHfqvDNz7B9MdxIxV+OxM+?=
 =?us-ascii?Q?Md1cx0xrPOYK4IlXB74Wcr22EzRpegWcm/Wu0ua/gkq5ki+HfzjlFRERw9WO?=
 =?us-ascii?Q?ZuzZrlljtxOnxUeXE6w2XUnHEUDLU7TlNcnWB1cJnlYEP/fC43L2y+OWgYQ0?=
 =?us-ascii?Q?XrF6sfq/UuAX03XIE5VXM1lSvcLyIl3+781t/Sid7U0A5xJbnDaeH3Ah48ce?=
 =?us-ascii?Q?GEKScrp97zb9HWBKYP7g69q8eQJOqeThEc3uw0TQSy7AvWacaqaFFzAdXQZ7?=
 =?us-ascii?Q?g+uOagqz1d9Ynj2Ef6JhEzlBJUt1LhWDsOsVraUPO/dfZlBP8+eHqb+fcW5m?=
 =?us-ascii?Q?5R0PufY6yX71w4GjpH2m/byFIG5bofyabZgn68K/UzJsJIPe2HI+UJAYUEUg?=
 =?us-ascii?Q?KgHdrpZZKSeCiAMjjkvaqyyZTj1NpnU2FmhD9Fj1b4drG3zjPrIT45PQjSgo?=
 =?us-ascii?Q?rZuV9zU827o7ZdpOCgnQSQqpNJF48wFHePkPI2CFImOOE8cwLbqLEyacw0t/?=
 =?us-ascii?Q?hCEXDKGRFauFO1CNJD5wwTed7aOnryAgGfXvuVwj7vFUdAUBlE9ZaSlzC9t+?=
 =?us-ascii?Q?LnxZKoNbLWZX3xGMwuNoLcPrJ5lQ/bmro0mAD8N1UNKgHol1rXbDEiaEoCa7?=
 =?us-ascii?Q?3+DujuPg+RzwIM74nOy4cbn/wkpwEbuJyFQExhpZ18Pg1qWDSoirDmpk9bgy?=
 =?us-ascii?Q?ZZmUkl+r/wPtCohCAE5HdcJGLXovT6K9rqJs4n4+14/PCgRL8Y5Q3BQspbEE?=
 =?us-ascii?Q?lGc2PrM/YTVIWPY6fiWa+NaB+z99frk/Sl1ykOVH9v0YyWK5tscSLdS3a3jk?=
 =?us-ascii?Q?cW1UnT3Xez+QSRzawkQZavv3w2hbIeX/K9DF51N5IvznTauBuKLsso0n9FWx?=
 =?us-ascii?Q?LRAe13qu40XRH4/HFIUNvuVAsnv+Gn4lAz0fAQ9u63Djjp5HQaTEmXg8ti78?=
 =?us-ascii?Q?TOSCrP3z9G19L4rbvG4s+hjfQtw5V7ANIpQbQ6mifGYZJFCn1ZhyUGp7Y62V?=
 =?us-ascii?Q?mgbDuv6HLkmzdkIYGCnOKFwZ406zUzGPdKe/Q62FBhNm6U6X2u2heYRWc4jn?=
 =?us-ascii?Q?f1W6AagGKHsZNajExt/qWcKrJ+AWtZfcLp6SdWBq0eDk0X5eBDYDhgSJclYi?=
 =?us-ascii?Q?dP5haSqD4vac5Mf4ph4tBQqiB1ON7bAtTUbVpfRqXDx+Rkd1qXavv7cxK5sO?=
 =?us-ascii?Q?Dxn2xD/O5D8xrUEn5J6M6SSL9gZfKv3nzZJMVux8BjEy8km/zhwjzYhfw+a0?=
 =?us-ascii?Q?Th+j3+mxeNQVbXzopefj2nG2QVht7W0jsM4FyjJO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99eefe5e-5a3b-46cd-4e1f-08de2c0a7414
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:07:34.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsP9pv5RJ8FChr2k+M4cZGR7PRv1youqdLRNxSGVl9UUaYD3d3Cp8HZz9Ing6Z4Swd56rnz78mBnWKu0zY4YRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

Add error handling for DMA request submission by checking the return
cookie with dma_submit_error(). This prevents propagating submission
failures through the DMA transfer process, which could otherwise lead
to unexpected behavior.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
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


