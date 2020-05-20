Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2BD1DB378
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgETMea (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:34:30 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:58020
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbgETMe3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:34:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwPecu1/CSKHjCL/JPXVVe/gPlUAPvpX+WOEVunwzvKUHSRdVblqYSl8Gq9aez7af9+vfNzv9sLWPohUCRMf/vV6/P5+KyfcvodbjCd3Z0IdqN7yP9Xjm/H5BQI0LqPkQAZxEgYT2P5X4y1Jlwx1f3NR76VXV1sjF5EWmFqvWq7W0ddXMGhf19+pLr0TFOLWnd3RkKA4mDct8Kwz8XYi/5IHfohn6eo+B7QnD6IHKpqUVqQiqtsliT/7Z3fa5gWLRpOUGOAIobHkK7gZ4rmRfXao/+Thsjt9o7xYQWzfnAJ0ElEjwVyqWcYaeygh7RDYtLISqAEiovx4MuS9iHW2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bxh5YmZTtwLq8JEI9R2YgVGDoVMYkkcc+uF97ycmWaA=;
 b=BRxv1wh4jHDFwsuuKnj5S0AsbNJbOuLfX7xoY4Net2CLMHrSmCny7dc172gMi86RhGZaYZ+oi+zR1pVKHX5e2SI3DuX/vK1EfQ+wLKgIV6jNnYE2fv3vIpkR5r1FrWtGr5zXx8DTWPxmEoz4X4jXBp/W5Ck6RFwUoXQfYqCe1nPO3PAS4jnhhi4IxCTBIiJlUKf5T6MV+lIUcMl54od+FTkSQ1FOu1JcJ9M4FLDQb5J68+A5aDkFa+F+C6oc+JH7cdCsQFqaDvGAoZgy70jcJvUI3AUDuiwQW9RO0npudCSH/cJQd5SlKbucWExFY7ZzOBM80c2avJZAp0s0Y1VpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bxh5YmZTtwLq8JEI9R2YgVGDoVMYkkcc+uF97ycmWaA=;
 b=mwyDgBL0xG3OCzl1kiNoOClMRI8Ok/fbSZstyqgitXQ2oE0nKd9lnJiFUhljflcuGpfem4Ld0vS3aVPItz2TSE86jDTG9Ao/wY7/vgEXyg7aVm/32gWM4k69zRNlU0HO4p+C/l2DKsbjhAwK5I0ftJbZluOJCb2BhcgQFEhFmbc=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4279.eurprd04.prod.outlook.com (2603:10a6:209:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 12:34:23 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:34:23 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 05/13] spi: imx: fallback to PIO if dma setup failure
Date:   Thu, 21 May 2020 04:34:17 +0800
Message-Id: <1590006865-20900-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 12:34:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd178ef5-c5af-45eb-6741-08d7fcba2054
X-MS-TrafficTypeDiagnostic: AM6PR04MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB42797C99BAC273AAF960B6EA89B60@AM6PR04MB4279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkqwRgc9a33GmVXITHnw9tMi2c4HpIW2vG5P8tM2p6HK1qDuCp2JHH7l4ZSHgILWl9Tr2yeUAxrzAE9fC3WKrY+coVSWFRtiAqEREC2rWIRc9CAKb1Z/RzTHzPVuixMa9cVVgv79v5VQc1EPwQYTbvHdk4pLwSDOFsx/4IWbDOUY7u/6tQ6S9P6uchPaNf6gILbzthQ/bNKmP6XNsOcabog9G8pvPDz7yhV6sd69GfWTty8eoFdBR5+/vHa28DSDuCjhRhTmx8Zmco6r3PVXinyn7KSSuFC17XKdyASFVugmFe5/2gW6b+v7cA3WAeNtbT5nNTFSjQP68vf3XTtdO37JuJL16HXD47tz7iK2es0HolAId+M51x8CWB+J4KqRGkNe4jnc4CNqYrdvfLLJrdMd+M0pNvHdmvxhgR4QR8L3MqawClA4jtIXj3iNk15y9tstER0UksMz+nAl3EsjK2zMPbrHSra7aY7y4kVVUuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6512007)(36756003)(8676002)(52116002)(66946007)(66556008)(7416002)(8936002)(66476007)(86362001)(5660300002)(186003)(478600001)(316002)(26005)(6506007)(6486002)(956004)(2616005)(4326008)(2906002)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XvOt+uEUIdsND+BanwOZxdoEL01q0ezaNL7upWkhF/iIbZOAQMXN8q06UqmX5iwIbC9e2sDgbWNAAal0gaLKmngt0weEyoxn0ja0MYt/o4d94XTRrPzoEAKieAUDVsQH3lSlH1b7rz7afl0iTy9qAl1mqqHiN8eNCHxBHyzuGAmEyQDM0HjgphYK9UnM0a2y0B1DBxTpkUtkHNuQsVMh56wRb2qzONZkIhV2Mhj3v+Yar61sFt7ylhdspmCkT6QjMLpt34FM+wjWDYbzQw8YKZ2olCKxdGUUGmKbD9dz9uCd9zbZiN68TTRh9vhAL1GHdycogC7VkTmKYIJcQ4ClOzq1CtUYzOkRbLKzMwSFsIXutd/14XfvM2Wqa5DYQcRTK96H+g83/nOWe0/xCHAuNQ740tlLnOptCAJfHYU5vxnVJzF/wwSyedOZwp+FqQWnrNy18Qr7htwJxXNjJqTVA5z4m/93Z/+23YaUSlS0yPI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd178ef5-c5af-45eb-6741-08d7fcba2054
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:34:23.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7GuEBFvAOzsb9H7wC8bvJP4Gj+Mb+jz5JzfyrhtXpEDlmvhMX4Hx3eSusgNNnbBpq44G9p4yEl+kJ1moUA7Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4279
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fallback to PIO in case dma setup failed. For example, sdma firmware not
updated but ERR009165 workaroud added in kernel.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/spi/spi-imx.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f4f28a4..b7a85e3 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -71,6 +71,7 @@ struct spi_imx_devtype_data {
 	void (*reset)(struct spi_imx_data *);
 	void (*setup_wml)(struct spi_imx_data *);
 	void (*disable)(struct spi_imx_data *);
+	void (*disable_dma)(struct spi_imx_data *);
 	bool has_dmamode;
 	bool has_slavemode;
 	unsigned int fifo_size;
@@ -485,6 +486,11 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static void mx51_disable_dma(struct spi_imx_data *spi_imx)
+{
+	writel(0, spi_imx->base + MX51_ECSPI_DMA);
+}
+
 static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
 {
 	u32 ctrl;
@@ -987,6 +993,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
 	.setup_wml = mx51_setup_wml,
+	.disable_dma = mx51_disable_dma,
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.dynamic_burst = true,
@@ -1001,6 +1008,7 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.prepare_transfer = mx51_ecspi_prepare_transfer,
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
+	.disable_dma = mx51_disable_dma,
 	.reset = mx51_ecspi_reset,
 	.fifo_size = 64,
 	.has_dmamode = true,
@@ -1385,6 +1393,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
 		dmaengine_terminate_all(master->dma_tx);
+		dmaengine_terminate_all(master->dma_rx);
 		return -EINVAL;
 	}
 
@@ -1498,6 +1507,7 @@ static int spi_imx_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	int ret;
 
 	/* flush rxfifo before transfer */
 	while (spi_imx->devtype_data->rx_available(spi_imx))
@@ -1506,10 +1516,23 @@ static int spi_imx_transfer(struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return spi_imx_pio_transfer_slave(spi, transfer);
 
-	if (spi_imx->usedma)
-		return spi_imx_dma_transfer(spi_imx, transfer);
-	else
-		return spi_imx_pio_transfer(spi, transfer);
+	/*
+	 * fallback PIO mode if dma setup error happen, for example sdma
+	 * firmware may not be updated as ERR009165 required.
+	 */
+	if (spi_imx->usedma) {
+		ret = spi_imx_dma_transfer(spi_imx, transfer);
+		if (ret != -EINVAL)
+			return ret;
+
+		spi_imx->devtype_data->disable_dma(spi_imx);
+
+		spi_imx->usedma = false;
+		spi_imx->dynamic_burst = spi_imx->devtype_data->dynamic_burst;
+		dev_dbg(&spi->dev, "Fallback to PIO mode\n");
+	}
+
+	return spi_imx_pio_transfer(spi, transfer);
 }
 
 static int spi_imx_setup(struct spi_device *spi)
-- 
2.7.4

