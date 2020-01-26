Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CDA149AF1
	for <lists+linux-spi@lfdr.de>; Sun, 26 Jan 2020 15:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387393AbgAZOJe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jan 2020 09:09:34 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43038 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgAZOJe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 26 Jan 2020 09:09:34 -0500
Received: by mail-yb1-f194.google.com with SMTP id k15so3619731ybd.10;
        Sun, 26 Jan 2020 06:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0znyjyYbiAbfIQWL1oHWminydK6nnqolmIPai4FHJsc=;
        b=R4GqoCH0iaDMWEwxpz1GR5oUF1M/PE+kqz3xfrZFKD3jO36TKruKc+faOYkaorNk/D
         DeQeNy5D9BzFVEmzmhmt7ldcFyWlbkECndL6WYGi+2dHcJmOTM5hphD7ATLRFTHy0Clv
         6qug8RknOAOytZhosq2Mj6lbC7hNAdXnvnb/SZKEd6FrVJpcReBRiXvxv4VFKSalqBaI
         2AHJWwykNlWagqtgLAPvXb+ELm74R8e314A3RWKmipUwoPfEt2/fq1rHwUZH3v8E/Kcq
         YZkCH887Srp+xO+17qyxEA6A/5aUKdXRIu8TH+J9BVYQsb9e8Ax8qDRDur1Vawvob5vT
         QyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0znyjyYbiAbfIQWL1oHWminydK6nnqolmIPai4FHJsc=;
        b=gqOHYWPovDrVY05xbcdWqvufiN+viaHawL6tDK3jbn/75uVvbf4Ql8FNwfnLPPPmYw
         K7dw1ya/yVx19WX0rSpWW2Jj9sA43DOF0rTu1Rj+03Yo89xN05zilk8pSfa6rkAp4V27
         ba15+M8wDWOb6WOhu8dtVs4XlJop7IUPD6ozaCh5dw/hkFHHtbgYqRo8Nl8/4yNMPIvt
         WcULZarmaQ8j4UAZgqovceVqW6QxynDANZf0XW1QyhkqIMczEjltBVhyKXJwnMuT1sbx
         yOhkMDlPsV+4pBhJphBwJFUkdi/s2+9BRM0O9RClH4XLdFeICOY05Y/mCnmz4vHOFThK
         V40A==
X-Gm-Message-State: APjAAAU9P5SI1NYNwSC+b/YCbim1H7T5l3gAmEuwRthNhUI2FxRpjxbU
        /mKOtjz7CGXuZ/BtBMaN2FBayJbDSN0=
X-Google-Smtp-Source: APXvYqyZvLUQmp2PTyVD65ywAO78sFlydfcTzGCK8FC8Fn/wQl9dllTay7iP+Tj7BKw2LabEC8Xomw==
X-Received: by 2002:a25:d252:: with SMTP id j79mr9269996ybg.311.1580047772582;
        Sun, 26 Jan 2020 06:09:32 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id a12sm5237214ywa.95.2020.01.26.06.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 06:09:32 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     han.xu@nxp.com, Adam Ford <aford173@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] spi: fspi: dynamically alloc AHB memory
Date:   Sun, 26 Jan 2020 08:09:09 -0600
Message-Id: <20200126140913.2139260-2-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200126140913.2139260-1-aford173@gmail.com>
References: <20200126140913.2139260-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Apply patch from NXP upstream repo to
dynamically allocate AHB memory as needed.

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Han Xu <han.xu@nxp.com>

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 00c7899428a1..23abf5ae318e 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -307,6 +307,7 @@
 
 #define POLL_TOUT		5000
 #define NXP_FSPI_MAX_CHIPSELECT		4
+#define NXP_FSPI_MIN_IOMAP	SZ_4M
 
 struct nxp_fspi_devtype_data {
 	unsigned int rxfifo;
@@ -345,6 +346,8 @@ struct nxp_fspi {
 	void __iomem *ahb_addr;
 	u32 memmap_phy;
 	u32 memmap_phy_size;
+	u32 memmap_start;
+	u32 memmap_len;
 	struct clk *clk, *clk_en;
 	struct device *dev;
 	struct completion c;
@@ -657,12 +660,35 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
 	f->selected = spi->chip_select;
 }
 
-static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
+static int nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
 {
+	u32 start = op->addr.val;
 	u32 len = op->data.nbytes;
 
+	/* if necessary, ioremap before AHB read */
+	if ((!f->ahb_addr) || start < f->memmap_start ||
+	     start + len > f->memmap_start + f->memmap_len) {
+		if (f->ahb_addr)
+			iounmap(f->ahb_addr);
+
+		f->memmap_start = start;
+		f->memmap_len = len > NXP_FSPI_MIN_IOMAP ?
+				len : NXP_FSPI_MIN_IOMAP;
+
+		f->ahb_addr = ioremap_wc(f->memmap_phy + f->memmap_start,
+					 f->memmap_len);
+
+		if (!f->ahb_addr) {
+			dev_err(f->dev, "failed to alloc memory\n");
+			return -ENOMEM;
+		}
+	}
+
 	/* Read out the data directly from the AHB buffer. */
-	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);
+	memcpy_fromio(op->data.buf.in,
+		      f->ahb_addr + start - f->memmap_start, len);
+
+	return 0;
 }
 
 static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
@@ -822,7 +848,7 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 */
 	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
 	    op->data.dir == SPI_MEM_DATA_IN) {
-		nxp_fspi_read_ahb(f, op);
+		err = nxp_fspi_read_ahb(f, op);
 	} else {
 		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
 			nxp_fspi_fill_txfifo(f, op);
@@ -992,9 +1018,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - controller memory mapped space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
-	f->ahb_addr = devm_ioremap_resource(dev, res);
-	if (IS_ERR(f->ahb_addr)) {
-		ret = PTR_ERR(f->ahb_addr);
+	if (IS_ERR(res)) {
+		ret = PTR_ERR(res);
 		goto err_put_ctrl;
 	}
 
@@ -1073,6 +1098,9 @@ static int nxp_fspi_remove(struct platform_device *pdev)
 
 	mutex_destroy(&f->lock);
 
+	if (f->ahb_addr)
+		iounmap(f->ahb_addr);
+
 	return 0;
 }
 
-- 
2.24.0

