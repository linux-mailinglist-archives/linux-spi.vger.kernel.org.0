Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958DF783780
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjHVBi5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjHVBit (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB6813E
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:46 -0700 (PDT)
Received: from dggpemm100005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVBlM2wXnzVkQs;
        Tue, 22 Aug 2023 09:36:31 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:45 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 21/24] spi: xlp: switch to use modern name
Date:   Tue, 22 Aug 2023 09:35:08 +0800
Message-ID: <20230822013511.4161475-22-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822013511.4161475-1-yangyingliang@huawei.com>
References: <20230822013511.4161475-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-xlp.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 3b91cdd5ae21..49302364b7bd 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -95,7 +95,7 @@ struct xlp_spi_priv {
 	int			rx_len;		/* rx xfer length */
 	int			txerrors;	/* TXFIFO underflow count */
 	int			rxerrors;	/* RXFIFO overflow count */
-	int			cs;		/* slave device chip select */
+	int			cs;		/* target device chip select */
 	u32			spi_clk;	/* spi clock frequency */
 	bool			cmd_cont;	/* cs active */
 	struct completion	done;		/* completion notification */
@@ -138,7 +138,7 @@ static int xlp_spi_setup(struct spi_device *spi)
 	u32 fdiv, cfg;
 	int cs;
 
-	xspi = spi_master_get_devdata(spi->master);
+	xspi = spi_controller_get_devdata(spi->controller);
 	cs = spi_get_chipselect(spi, 0);
 	/*
 	 * The value of fdiv must be between 4 and 65535.
@@ -343,17 +343,17 @@ static int xlp_spi_txrx_bufs(struct xlp_spi_priv *xs, struct spi_transfer *t)
 	return bytesleft;
 }
 
-static int xlp_spi_transfer_one(struct spi_master *master,
+static int xlp_spi_transfer_one(struct spi_controller *host,
 					struct spi_device *spi,
 					struct spi_transfer *t)
 {
-	struct xlp_spi_priv *xspi = spi_master_get_devdata(master);
+	struct xlp_spi_priv *xspi = spi_controller_get_devdata(host);
 	int ret = 0;
 
 	xspi->cs = spi_get_chipselect(spi, 0);
 	xspi->dev = spi->dev;
 
-	if (spi_transfer_is_last(master, t))
+	if (spi_transfer_is_last(host, t))
 		xspi->cmd_cont = 0;
 	else
 		xspi->cmd_cont = 1;
@@ -361,13 +361,13 @@ static int xlp_spi_transfer_one(struct spi_master *master,
 	if (xlp_spi_txrx_bufs(xspi, t))
 		ret = -EIO;
 
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 	return ret;
 }
 
 static int xlp_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct xlp_spi_priv *xspi;
 	struct clk *clk;
 	int irq, err;
@@ -398,28 +398,28 @@ static int xlp_spi_probe(struct platform_device *pdev)
 
 	xspi->spi_clk = clk_get_rate(clk);
 
-	master = spi_alloc_master(&pdev->dev, 0);
-	if (!master) {
-		dev_err(&pdev->dev, "could not alloc master\n");
+	host = spi_alloc_host(&pdev->dev, 0);
+	if (!host) {
+		dev_err(&pdev->dev, "could not alloc host\n");
 		return -ENOMEM;
 	}
 
-	master->bus_num = 0;
-	master->num_chipselect = XLP_SPI_MAX_CS;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->setup = xlp_spi_setup;
-	master->transfer_one = xlp_spi_transfer_one;
-	master->dev.of_node = pdev->dev.of_node;
+	host->bus_num = 0;
+	host->num_chipselect = XLP_SPI_MAX_CS;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->setup = xlp_spi_setup;
+	host->transfer_one = xlp_spi_transfer_one;
+	host->dev.of_node = pdev->dev.of_node;
 
 	init_completion(&xspi->done);
-	spi_master_set_devdata(master, xspi);
+	spi_controller_set_devdata(host, xspi);
 	xlp_spi_sysctl_setup(xspi);
 
 	/* register spi controller */
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = devm_spi_register_controller(&pdev->dev, host);
 	if (err) {
-		dev_err(&pdev->dev, "spi register master failed!\n");
-		spi_master_put(master);
+		dev_err(&pdev->dev, "spi register host failed!\n");
+		spi_controller_put(host);
 		return err;
 	}
 
-- 
2.25.1

