Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53E14FD1F
	for <lists+linux-spi@lfdr.de>; Sun,  2 Feb 2020 14:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgBBNAH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Feb 2020 08:00:07 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36475 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBBNAG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Feb 2020 08:00:06 -0500
Received: by mail-yw1-f65.google.com with SMTP id n184so10516379ywc.3;
        Sun, 02 Feb 2020 05:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e6rN6yJZ4eWmG/f569Zn9OH6A2Ob5WD1MTBuZuc6gi8=;
        b=BcLLBaeoTaZLKReT7xF4F380ZCod3MrDwYOq1eGTKZIqQMNmr/gbg7LiBc2mA2N0iG
         WFS59R7WRetlc/VIrBYgx7UAHtA5axveGDhJDGDTKfxjTZr5i8n9fTCYYGGiF1FsRTj/
         7g1c8UYiok0vKv/IDcAXqKagTPllBhPvvG40EgkYEABz+U0iGnZf/YwWnmQnzVGmNOqe
         oJVfDLUqkBD1frBo0JfA+4FYGgFai5IO5sAzpX6MdM46TgBXUIt5O1eYstP2Vq8FKf7i
         E2pvLkUffEnd4hICkRz/YirAScywfADg/ll1QZ0CXZoXVfHHPVhIHuJ25hWb4ms+mOsh
         ckRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6rN6yJZ4eWmG/f569Zn9OH6A2Ob5WD1MTBuZuc6gi8=;
        b=kO6bt//qkML27/CIsr5X8eZVC/II3EJObnIrJl/aIAcBBHp7927WUTG6jM07Eb9g1q
         quMGWpxJocdvnjsy7MFUoqM7UaR843PEBSoDCAyxrWko2sg1wtnMuDdC4SneuEEifepZ
         dVZtlZVdFs/Qt+fOYZbFQYa0SkZrsheB1Y9IYE2+QilP8Im1RfJArm5oWAH1aAs4KO3c
         xKdDGV1CAYm7ITHRtn6df+Zc5rL0hSYNOOWxGVA/i1WpSzuMqnHeODxvPSidumxMRFzX
         /1JK3XG6dgAC+l2sMVc2g/r0pG+eOA5ByrPpFohb32hjV0KpRc64V32whfJhCYUb4hD6
         Pbvw==
X-Gm-Message-State: APjAAAVlfzHyjs+MFF5PPXqMRQ3HGg1J8nHk1vYaRG4Vfgm4dxv8IVI4
        QnTkhb8EhHMZVf5uMGkLheGUr5QEmD8=
X-Google-Smtp-Source: APXvYqx70kY7wgGOPXJWRZfeWiF9DHnZy7tefw85FuCVEcE9QFZkCaWdjfQvnlYHtM2j9I6yKoVLNA==
X-Received: by 2002:a81:6055:: with SMTP id u82mr9702017ywb.35.1580648403893;
        Sun, 02 Feb 2020 05:00:03 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id m137sm7090013ywd.108.2020.02.02.05.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 05:00:03 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Han Xu <han.xu@nxp.com>, Adam Ford <aford173@gmail.com>,
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
Subject: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
Date:   Sun,  2 Feb 2020 06:59:47 -0600
Message-Id: <20200202125950.1825013-2-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202125950.1825013-1-aford173@gmail.com>
References: <20200202125950.1825013-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Apply patch from NXP upstream repo to
dynamically allocate AHB memory as needed.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2: Reorder s-o-b lines to give credit in proper order.

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

