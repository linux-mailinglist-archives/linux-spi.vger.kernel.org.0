Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F57A658BDC
	for <lists+linux-spi@lfdr.de>; Thu, 29 Dec 2022 11:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiL2Kma (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Dec 2022 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiL2KmO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Dec 2022 05:42:14 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8208F1262D
        for <linux-spi@vger.kernel.org>; Thu, 29 Dec 2022 02:42:12 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NjQ0N4Smtz16LtH;
        Thu, 29 Dec 2022 18:40:52 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 29 Dec
 2022 18:41:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 1/3] spi: altera: switch to use modern name
Date:   Thu, 29 Dec 2022 18:38:35 +0800
Message-ID: <20221229103837.4192759-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229103837.4192759-1-yangyingliang@huawei.com>
References: <20221229103837.4192759-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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
 drivers/spi/spi-altera-core.c     | 30 +++++++++++++++---------------
 drivers/spi/spi-altera-dfl.c      |  2 +-
 drivers/spi/spi-altera-platform.c |  2 +-
 include/linux/spi/altera.h        |  4 ++--
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-altera-core.c b/drivers/spi/spi-altera-core.c
index de4d31c530d9..94fe6bf1b9a6 100644
--- a/drivers/spi/spi-altera-core.c
+++ b/drivers/spi/spi-altera-core.c
@@ -24,7 +24,7 @@
 #define ALTERA_SPI_TXDATA	4
 #define ALTERA_SPI_STATUS	8
 #define ALTERA_SPI_CONTROL	12
-#define ALTERA_SPI_SLAVE_SEL	20
+#define ALTERA_SPI_TARGET_SEL	20
 
 #define ALTERA_SPI_STATUS_ROE_MSK	0x8
 #define ALTERA_SPI_STATUS_TOE_MSK	0x10
@@ -67,7 +67,7 @@ static int altr_spi_readl(struct altera_spi *hw, unsigned int reg,
 
 static inline struct altera_spi *altera_spi_to_hw(struct spi_device *sdev)
 {
-	return spi_master_get_devdata(sdev->master);
+	return spi_controller_get_devdata(sdev->controller);
 }
 
 static void altera_spi_set_cs(struct spi_device *spi, bool is_high)
@@ -77,9 +77,9 @@ static void altera_spi_set_cs(struct spi_device *spi, bool is_high)
 	if (is_high) {
 		hw->imr &= ~ALTERA_SPI_CONTROL_SSO_MSK;
 		altr_spi_writel(hw, ALTERA_SPI_CONTROL, hw->imr);
-		altr_spi_writel(hw, ALTERA_SPI_SLAVE_SEL, 0);
+		altr_spi_writel(hw, ALTERA_SPI_TARGET_SEL, 0);
 	} else {
-		altr_spi_writel(hw, ALTERA_SPI_SLAVE_SEL,
+		altr_spi_writel(hw, ALTERA_SPI_TARGET_SEL,
 				BIT(spi->chip_select));
 		hw->imr |= ALTERA_SPI_CONTROL_SSO_MSK;
 		altr_spi_writel(hw, ALTERA_SPI_CONTROL, hw->imr);
@@ -139,10 +139,10 @@ static void altera_spi_rx_word(struct altera_spi *hw)
 	hw->count++;
 }
 
-static int altera_spi_txrx(struct spi_master *master,
+static int altera_spi_txrx(struct spi_controller *host,
 	struct spi_device *spi, struct spi_transfer *t)
 {
-	struct altera_spi *hw = spi_master_get_devdata(master);
+	struct altera_spi *hw = spi_controller_get_devdata(host);
 	u32 val;
 
 	hw->tx = t->tx_buf;
@@ -175,15 +175,15 @@ static int altera_spi_txrx(struct spi_master *master,
 
 		altera_spi_rx_word(hw);
 	}
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 
 	return 0;
 }
 
 irqreturn_t altera_spi_irq(int irq, void *dev)
 {
-	struct spi_master *master = dev;
-	struct altera_spi *hw = spi_master_get_devdata(master);
+	struct spi_controller *host = dev;
+	struct altera_spi *hw = spi_controller_get_devdata(host);
 
 	altera_spi_rx_word(hw);
 
@@ -194,20 +194,20 @@ irqreturn_t altera_spi_irq(int irq, void *dev)
 		hw->imr &= ~ALTERA_SPI_CONTROL_IRRDY_MSK;
 		altr_spi_writel(hw, ALTERA_SPI_CONTROL, hw->imr);
 
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(host);
 	}
 
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_GPL(altera_spi_irq);
 
-void altera_spi_init_master(struct spi_master *master)
+void altera_spi_init_host(struct spi_controller *host)
 {
-	struct altera_spi *hw = spi_master_get_devdata(master);
+	struct altera_spi *hw = spi_controller_get_devdata(host);
 	u32 val;
 
-	master->transfer_one = altera_spi_txrx;
-	master->set_cs = altera_spi_set_cs;
+	host->transfer_one = altera_spi_txrx;
+	host->set_cs = altera_spi_set_cs;
 
 	/* program defaults into the registers */
 	hw->imr = 0;		/* disable spi interrupts */
@@ -217,6 +217,6 @@ void altera_spi_init_master(struct spi_master *master)
 	if (val & ALTERA_SPI_STATUS_RRDY_MSK)
 		altr_spi_readl(hw, ALTERA_SPI_RXDATA, &val); /* flush rxdata */
 }
-EXPORT_SYMBOL_GPL(altera_spi_init_master);
+EXPORT_SYMBOL_GPL(altera_spi_init_host);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 596e181ae136..0b3302a29989 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -156,7 +156,7 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 
 	hw->irq = -EINVAL;
 
-	altera_spi_init_master(master);
+	altera_spi_init_host(master);
 
 	err = devm_spi_register_master(dev, master);
 	if (err)
diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index 65147aae82a1..cde12c4b9cbc 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -107,7 +107,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	altera_spi_init_master(master);
+	altera_spi_init_host(master);
 
 	/* irq is optional */
 	hw->irq = platform_get_irq(pdev, 0);
diff --git a/include/linux/spi/altera.h b/include/linux/spi/altera.h
index 2e2a622e56da..3b74c3750caf 100644
--- a/include/linux/spi/altera.h
+++ b/include/linux/spi/altera.h
@@ -14,7 +14,7 @@
 
 /**
  * struct altera_spi_platform_data - Platform data of the Altera SPI driver
- * @mode_bits:		Mode bits of SPI master.
+ * @mode_bits:		Mode bits of SPI host.
  * @num_chipselect:	Number of chipselects.
  * @bits_per_word_mask:	bitmask of supported bits_per_word for transfers.
  * @num_devices:	Number of devices that shall be added when the driver
@@ -46,5 +46,5 @@ struct altera_spi {
 };
 
 extern irqreturn_t altera_spi_irq(int irq, void *dev);
-extern void altera_spi_init_master(struct spi_master *master);
+extern void altera_spi_init_host(struct spi_controller *host);
 #endif /* __LINUX_SPI_ALTERA_H */
-- 
2.25.1

