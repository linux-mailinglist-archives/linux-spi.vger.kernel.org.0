Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8C1DB381
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgETMes (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:34:48 -0400
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:52453
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbgETMeo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:34:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnelO1qEPkyOl1PKDVZSYH72a8RsQoWf21PgMDNpF50hETI2Fc5NP7AwxFilzVUGx0Uj6e3Uf0wRj6ozyANGWqHV3JIyzTH9WFpc8+d3sGO5JGX0Pgeue9rJNkqDGCmAH6JCHir3yb4IdanVnQ3mtrhbK+vx4Hnyqq1sHgZsidSDUlQSFIjhFwrVC5X/Hwnyawu8AN2zoPHZBtTGCdNZ4nNHrC3ao4THMCsRR3PdzsHj7hIVJ2EfnswPZlRT7IoPd3WyQisCczWWZAOWDlduKOxnQNTZkapBtfQUx9pYmuWj//asc60wpZAiSlQNtywB2NXUFZUqDwSaeWUE4OmQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3HKVqEfEEoMLoNCKTeO79UOzZO14FDHNMMqY0hWDWA=;
 b=Gnut1D9QaEmadWl4eLwsJD5SHjYYRHqrczaPCzEEZz0Yn9S0xse8PNoKDxtstw2Z+L5h7D99+0QErUmA5TM/4InHAUOLDzPmiZRVl69M8uliLfFL8ygGpLI6ENokm1YtU8xbXeDsa/MYskDrOdqqmuHkFmoD49mH2527LvxbZkEUmWRtFkQchAQu1E93LbTKU7v1whEwkUG0OMxQdrt4YVlHGmrZAt2cn2GI0gKmXNFzPNbnynmAKf++z2jDII+dVGr+2YYkeTQlg/wQyuTx/B9mti1iUY0kBSkAd8OZYTmKL8Ta+oOBp3XR1z64Gvx8ab6WwBcfu+r6Jm/26uDcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3HKVqEfEEoMLoNCKTeO79UOzZO14FDHNMMqY0hWDWA=;
 b=RcYflVOXEHkmK8WvqrN/Kj1CyzvUXh5q9pbyZXHyf44BHqhPzAPMKhrOvXKPfu6gzVYj43sZ1vgCz+Eeb1M/0XJ9787SkxFoamuPajL7ErLx1pCu/v+WKa20Z+1v2oPejed3pLWzohD2omiCzh6jF8hXmqiZ5kb/G1KzvxGqILg=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB5480.eurprd04.prod.outlook.com (2603:10a6:20b:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 12:34:39 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:34:39 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 08/13] spi: imx: remove ERR009165 workaround on i.mx6ul
Date:   Thu, 21 May 2020 04:34:20 +0800
Message-Id: <1590006865-20900-9-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 12:34:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 087f0494-50f9-4ed4-2b07-08d7fcba29f1
X-MS-TrafficTypeDiagnostic: AM6PR04MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB54804D42DE42571E8B95F88389B60@AM6PR04MB5480.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSP4aBtzliWSCXPEoKBv1yCmd/MVed0EHmT83HehPau0aJnTAmTJsu3GRLqww97a+xXCQ5/fPnB3NjRan/fdbZPFwESes1in9oBDKLiuMi6/RccvtA5yVenSn+4Mi4TWMt9eTcbL63rTX0+HJanea4eq9L/zuGOFMbZZH8QyO+HDDhCIAwaJDbGBmSXdyMQpnMPdqzZ/r6sqCQcOm8OFxcHhp4ZxJVbFQ+OzIj3Bg7bBVtwjTdPnzgG3K7OhLigqq6LV2xmDgjoV+h+5Kcspg5Hsurb3fM94KLnY+SDPvxqy0jMMkCJ5GCa7CDrgA8L+df/3agK69656lsl9A54zkMA4qB+Z3dVC7oBAx3sS3FvamHsAVuhcFc7+LxmallVVI4YathpXRGnwqBleTDS4V3Ghs8YQPbF9lhU/A7pyeL4hJzF23XGZoVb1syCQLbq/cZjWGSjtt89hSPwRmObuEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(66946007)(7416002)(316002)(4326008)(36756003)(8936002)(5660300002)(2906002)(6666004)(52116002)(966005)(478600001)(6512007)(6486002)(2616005)(956004)(6506007)(66476007)(26005)(86362001)(186003)(16526019)(66556008)(8676002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XZqdxFL7EeXllzbalbP1/bOZLuj8igAnMhmh1A8HjHNlyFni8tMvx79NmDOZxERSqbY1ZhClS+hQjq31Loihsg30ZDbfTff6qPSsaGq8y54+9WO26B7oUUe3Lf9NVyRyWUi72ihjVgNuU+BVtflInkzOGNinVYYgRGOaY6XLPU7vkNd5Tv1DXAxRs8bjj29y5kkbl/WbdmTrpNPkJ2561zMFY12oRkLSX0K8htwLRZdpb6OovlQx956zXTjRGwhEb3gJFlUTH3BVBO01rkn00/vYLkATDI9pWttWm3Yr1PI14HMj5q+YKBhnik7bvnuZHNuiw9WxCd1vHza0WuiNoTL9GvXapWs19+wv5He6fLa+3R2zLJMn7OI4Y0ZI7bs+nFCKL+tkGouTN6AFL2d44V6mhguEyjrG7wEgsVfbabOiPalVvYHwyTwfboT5BHBBZ0x0ya8WgkVTIDF+wOy7OoT2G7SbN+FSVwE/Ac3QaqI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087f0494-50f9-4ed4-2b07-08d7fcba29f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:34:39.6760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wskHCiFeImFYlRZ0URQ5rvvry2cypBmB+SSWri0Z2RpwRGgv0MaiinMhndhKDZU4q9B04Or8QDAcX3tbK9Ydhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5480
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
i.mx8m/8mm still need this errata. Please refer to nxp official
errata document from https://www.nxp.com/ .

For removing workaround on those chips. Add new i.mx6ul type.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 8f758db..9ac9222 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -57,6 +57,7 @@ enum spi_imx_devtype {
 	IMX35_CSPI,	/* CSPI on all i.mx except above */
 	IMX51_ECSPI,	/* ECSPI on i.mx51 */
 	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
+	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
 };
 
 struct spi_imx_data;
@@ -76,6 +77,11 @@ struct spi_imx_devtype_data {
 	bool has_slavemode;
 	unsigned int fifo_size;
 	bool dynamic_burst;
+	/*
+	 * ERR009165 fixed or not:
+	 * https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
+	 */
+	bool tx_glitch_fixed;
 	enum spi_imx_devtype devtype;
 };
 
@@ -132,6 +138,11 @@ static inline int is_imx51_ecspi(struct spi_imx_data *d)
 	return d->devtype_data->devtype == IMX51_ECSPI;
 }
 
+static inline int is_imx6ul_ecspi(struct spi_imx_data *d)
+{
+	return d->devtype_data->devtype == IMX6UL_ECSPI;
+}
+
 static inline int is_imx53_ecspi(struct spi_imx_data *d)
 {
 	return d->devtype_data->devtype == IMX53_ECSPI;
@@ -591,8 +602,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	/* ERR009165: work in XHC mode as PIO */
-	ctrl &= ~MX51_ECSPI_CTRL_SMC;
+	/*
+	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
+	 * before i.mx6ul.
+	 */
+	if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
+		ctrl |= MX51_ECSPI_CTRL_SMC;
+	else
+		ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -618,12 +635,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
 static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 {
+	u32 tx_wml = 0;
+
+	if (spi_imx->devtype_data->tx_glitch_fixed)
+		tx_wml = spi_imx->wml;
 	/*
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(0) |
+		MX51_ECSPI_DMA_TX_WML(tx_wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1017,6 +1038,23 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.devtype = IMX53_ECSPI,
 };
 
+static struct spi_imx_devtype_data imx6ul_ecspi_devtype_data = {
+	.intctrl = mx51_ecspi_intctrl,
+	.prepare_message = mx51_ecspi_prepare_message,
+	.prepare_transfer = mx51_ecspi_prepare_transfer,
+	.trigger = mx51_ecspi_trigger,
+	.rx_available = mx51_ecspi_rx_available,
+	.reset = mx51_ecspi_reset,
+	.setup_wml = mx51_setup_wml,
+	.fifo_size = 64,
+	.has_dmamode = true,
+	.dynamic_burst = true,
+	.has_slavemode = true,
+	.tx_glitch_fixed = true,
+	.disable = mx51_ecspi_disable,
+	.devtype = IMX6UL_ECSPI,
+};
+
 static const struct platform_device_id spi_imx_devtype[] = {
 	{
 		.name = "imx1-cspi",
@@ -1040,6 +1078,9 @@ static const struct platform_device_id spi_imx_devtype[] = {
 		.name = "imx53-ecspi",
 		.driver_data = (kernel_ulong_t) &imx53_ecspi_devtype_data,
 	}, {
+		.name = "imx6ul-ecspi",
+		.driver_data = (kernel_ulong_t) &imx6ul_ecspi_devtype_data,
+	}, {
 		/* sentinel */
 	}
 };
@@ -1052,6 +1093,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
 	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
 	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
+	{ .compatible = "fsl,imx6ul-ecspi", .data = &imx6ul_ecspi_devtype_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
@@ -1179,7 +1221,14 @@ static int spi_imx_dma_configure(struct spi_master *master)
 	tx.direction = DMA_MEM_TO_DEV;
 	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
 	tx.dst_addr_width = buswidth;
-	tx.dst_maxburst = spi_imx->wml;
+	/*
+	 * For ERR009165 with TX_THRESHOLD=0 could enlarge burst size to fifo
+	 * size to speed up fifo filling as possible.
+	 */
+	if (spi_imx->devtype_data->tx_glitch_fixed)
+		tx.dst_maxburst = spi_imx->wml;
+	else
+		tx.dst_maxburst = spi_imx->devtype_data->fifo_size;
 	ret = dmaengine_slave_config(master->dma_tx, &tx);
 	if (ret) {
 		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
@@ -1678,7 +1727,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 					     | SPI_NO_CS;
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
-	    is_imx53_ecspi(spi_imx))
+	    is_imx53_ecspi(spi_imx) || is_imx6ul_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
 
 	spi_imx->spi_drctl = spi_drctl;
-- 
2.7.4

