Return-Path: <linux-spi+bounces-68-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B793C7FB5B7
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51149B216B7
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518748CDE;
	Tue, 28 Nov 2023 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED899D5A
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:28 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SfcSB636Kz1P8q8;
	Tue, 28 Nov 2023 17:22:50 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:27 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:26 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 21/26] spi: xlp: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:26 +0800
Message-ID: <20231128093031.3707034-22-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

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


