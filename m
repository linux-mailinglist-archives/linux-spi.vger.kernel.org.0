Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13327668F0
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjG1JfK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjG1JfI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0727CE4F
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:07 -0700 (PDT)
Received: from dggpemm100005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RC2V36BF2zLnx1;
        Fri, 28 Jul 2023 17:32:27 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:04 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 01/21] spi: amd: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:01 +0800
Message-ID: <20230728093221.3312026-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728093221.3312026-1-yangyingliang@huawei.com>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-amd.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index b19766571f28..e4345ad5cd36 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -215,9 +215,9 @@ static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
 	}
 }
 
-static int amd_spi_master_setup(struct spi_device *spi)
+static int amd_spi_host_setup(struct spi_device *spi)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(spi->master);
+	struct amd_spi *amd_spi = spi_controller_get_devdata(spi->controller);
 
 	amd_spi_clear_fifo_ptr(amd_spi);
 
@@ -272,7 +272,7 @@ static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 }
 
 static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
-				    struct spi_master *master,
+				    struct spi_controller *host,
 				    struct spi_message *message)
 {
 	struct spi_transfer *xfer = NULL;
@@ -353,15 +353,15 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 		return -ENODEV;
 	}
 
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return message->status;
 }
 
-static int amd_spi_master_transfer(struct spi_master *master,
+static int amd_spi_host_transfer(struct spi_controller *host,
 				   struct spi_message *msg)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+	struct amd_spi *amd_spi = spi_controller_get_devdata(host);
 	struct spi_device *spi = msg->spi;
 
 	amd_spi_select_chip(amd_spi, spi_get_chipselect(spi, 0));
@@ -370,7 +370,7 @@ static int amd_spi_master_transfer(struct spi_master *master,
 	 * Extract spi_transfers from the spi message and
 	 * program the controller.
 	 */
-	return amd_spi_fifo_xfer(amd_spi, master, msg);
+	return amd_spi_fifo_xfer(amd_spi, host, msg);
 }
 
 static size_t amd_spi_max_transfer_size(struct spi_device *spi)
@@ -381,16 +381,16 @@ static size_t amd_spi_max_transfer_size(struct spi_device *spi)
 static int amd_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct amd_spi *amd_spi;
 	int err;
 
-	/* Allocate storage for spi_master and driver private data */
-	master = devm_spi_alloc_master(dev, sizeof(struct amd_spi));
-	if (!master)
-		return dev_err_probe(dev, -ENOMEM, "Error allocating SPI master\n");
+	/* Allocate storage for host and driver private data */
+	host = devm_spi_alloc_host(dev, sizeof(struct amd_spi));
+	if (!host)
+		return dev_err_probe(dev, -ENOMEM, "Error allocating SPI host\n");
 
-	amd_spi = spi_master_get_devdata(master);
+	amd_spi = spi_controller_get_devdata(host);
 	amd_spi->io_remap_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(amd_spi->io_remap_addr))
 		return dev_err_probe(dev, PTR_ERR(amd_spi->io_remap_addr),
@@ -400,20 +400,20 @@ static int amd_spi_probe(struct platform_device *pdev)
 
 	amd_spi->version = (enum amd_spi_versions) device_get_match_data(dev);
 
-	/* Initialize the spi_master fields */
-	master->bus_num = 0;
-	master->num_chipselect = 4;
-	master->mode_bits = 0;
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->max_speed_hz = AMD_SPI_MAX_HZ;
-	master->min_speed_hz = AMD_SPI_MIN_HZ;
-	master->setup = amd_spi_master_setup;
-	master->transfer_one_message = amd_spi_master_transfer;
-	master->max_transfer_size = amd_spi_max_transfer_size;
-	master->max_message_size = amd_spi_max_transfer_size;
+	/* Initialize the spi_controller fields */
+	host->bus_num = 0;
+	host->num_chipselect = 4;
+	host->mode_bits = 0;
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->max_speed_hz = AMD_SPI_MAX_HZ;
+	host->min_speed_hz = AMD_SPI_MIN_HZ;
+	host->setup = amd_spi_host_setup;
+	host->transfer_one_message = amd_spi_host_transfer;
+	host->max_transfer_size = amd_spi_max_transfer_size;
+	host->max_message_size = amd_spi_max_transfer_size;
 
 	/* Register the controller with SPI framework */
-	err = devm_spi_register_master(dev, master);
+	err = devm_spi_register_controller(dev, host);
 	if (err)
 		return dev_err_probe(dev, err, "error registering SPI controller\n");
 
-- 
2.25.1

