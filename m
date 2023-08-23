Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E31D784F53
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjHWDdq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjHWDdn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF0E54
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:41 -0700 (PDT)
Received: from dggpemm500015.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVsCx0qV9zNnGQ;
        Wed, 23 Aug 2023 11:30:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 18/21] spi: nxp-fspi: switch to use modern name
Date:   Wed, 23 Aug 2023 11:30:00 +0800
Message-ID: <20230823033003.3407403-19-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823033003.3407403-1-yangyingliang@huawei.com>
References: <20230823033003.3407403-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-nxp-fspi.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 45a4acc95661..5dc950c87fe1 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -451,7 +451,7 @@ static int nxp_fspi_check_buswidth(struct nxp_fspi *f, u8 width)
 static bool nxp_fspi_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
+	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->controller);
 	int ret;
 
 	ret = nxp_fspi_check_buswidth(f, op->cmd.buswidth);
@@ -520,7 +520,7 @@ static int fspi_readl_poll_tout(struct nxp_fspi *f, void __iomem *base,
 }
 
 /*
- * If the slave device content being changed by Write/Erase, need to
+ * If the target device content being changed by Write/Erase, need to
  * invalidate the AHB buffer. This can be achieved by doing the reset
  * of controller after setting MCR0[SWRESET] bit.
  */
@@ -661,7 +661,7 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 
 /*
  * In FlexSPI controller, flash access is based on value of FSPI_FLSHXXCR0
- * register and start base address of the slave device.
+ * register and start base address of the target device.
  *
  *							    (Higher address)
  *				--------    <-- FLSHB2CR0
@@ -680,15 +680,15 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
  *
  *
  * Start base address defines the starting address range for given CS and
- * FSPI_FLSHXXCR0 defines the size of the slave device connected at given CS.
+ * FSPI_FLSHXXCR0 defines the size of the target device connected at given CS.
  *
  * But, different targets are having different combinations of number of CS,
  * some targets only have single CS or two CS covering controller's full
  * memory mapped space area.
  * Thus, implementation is being done as independent of the size and number
- * of the connected slave device.
+ * of the connected target device.
  * Assign controller memory mapped space size as the size to the connected
- * slave device.
+ * target device.
  * Mark FLSHxxCR0 as zero initially and then assign value only to the selected
  * chip-select Flash configuration register.
  *
@@ -704,8 +704,8 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
 	uint64_t size_kb;
 
 	/*
-	 * Return, if previously selected slave device is same as current
-	 * requested slave device.
+	 * Return, if previously selected target device is same as current
+	 * requested target device.
 	 */
 	if (f->selected == spi_get_chipselect(spi, 0))
 		return;
@@ -722,7 +722,7 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
 	fspi_writel(f, size_kb, f->iobase + FSPI_FLSHA1CR0 +
 		    4 * spi_get_chipselect(spi, 0));
 
-	dev_dbg(f->dev, "Slave device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
+	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
 
 	nxp_fspi_clk_disable_unprep(f);
 
@@ -912,7 +912,7 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 
 static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
+	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->controller);
 	int err = 0;
 
 	mutex_lock(&f->lock);
@@ -952,7 +952,7 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 static int nxp_fspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
+	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->controller);
 
 	if (op->data.dir == SPI_MEM_DATA_OUT) {
 		if (op->data.nbytes > f->devtype_data->txfifo)
@@ -1049,7 +1049,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_MCR0_MDIS, base + FSPI_MCR0);
 
 	/*
-	 * Config the DLL register to default value, enable the slave clock delay
+	 * Config the DLL register to default value, enable the target clock delay
 	 * line delay cell override mode, and use 1 fixed delay cell in DLL delay
 	 * chain, this is the suggested setting when clock rate < 100MHz.
 	 */
@@ -1062,7 +1062,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 		    base + FSPI_MCR0);
 
 	/*
-	 * Disable same device enable bit and configure all slave devices
+	 * Disable same device enable bit and configure all target devices
 	 * independently.
 	 */
 	reg = fspi_readl(f, f->iobase + FSPI_MCR2);
@@ -1100,7 +1100,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 
 static const char *nxp_fspi_get_name(struct spi_mem *mem)
 {
-	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
+	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &mem->spi->dev;
 	const char *name;
 
@@ -1137,7 +1137,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	int ret;
 	u32 reg;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*f));
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(*f));
 	if (!ctlr)
 		return -ENOMEM;
 
-- 
2.25.1

