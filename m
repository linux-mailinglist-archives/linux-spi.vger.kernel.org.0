Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0361C91899
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfHRSBc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53696 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfHRSBb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so1074451wmp.3
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dkYDxI8wguLcIaIj8QW7MSQKchs08y3QkQZxcgs/Oc=;
        b=r8INi0drJNmxP/LdvPlnfwsKG5Fis5h+KOHhkyvFTGS8QCt6WlN4B2CMjNvLfXncVu
         qP9RhSHNKBiMxUIWKRweZxxopzUCU3udS3waO0yePJn61m1/Xwlm2EW9RS+1bcuvvNFi
         6LRDRd+uSdwQkhJrhC1khJnScWBaJscEMRqBoOgzKwKwYJNcrz5LvzjCSP5LVfXnVokD
         CiYXFA/IyKFDmLzKOCCu7p8o8QCvW38OCGBn9NfJyu3xwc7dbMb9/kwj02oySG5sQrdD
         53ruOp9yCJ5689pvj9TukAds0oN+L6LCumHkZaJKZV24JYdnyemSqdSSa3VCwz0WISbL
         PQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dkYDxI8wguLcIaIj8QW7MSQKchs08y3QkQZxcgs/Oc=;
        b=Vle4ggsajySY+gAoPq6ZMHerr6mj1iGHZlu+fTJ695qRB6rXs2SLEWg/mm+x07IZiN
         1FuP3ve0hQYYMl0+VKAMBnyMxq93s6ErMN3G/veKq1UbTL0536UkCKAaNT/UvIYMd9Uz
         C7pyGWjV8Q33nQFD6p5K2ZbsbMiChlzRWQVRfxltBLWBJt4NmegcuaAOeJ4o63dZM465
         4Jvi6h/7NGKjfaqWJIoLTKysBxBAo3Mu/mD8KPs0cP62l3SPNV9PWmxwQ5Vh9ClWR/Qh
         BD69+lhEv8h4I71hD1opX3B4j8xpeqqw2YzmCFOcfJ8w8hEzXjOrTtremncj0dXMEmhq
         jicQ==
X-Gm-Message-State: APjAAAWXu3MqIWVu7urLz1TdgzwemM+xSKCnAthXltF5rLUYTlfCtjMW
        ck8e6vxkZwugjul0JuKl36U+Fxnf
X-Google-Smtp-Source: APXvYqz2Rzbxcf7WtZrZnYma4CbelTIkUKRMI8R+gy7IeaQE9UYnhTt8Miy976QJJr70RIRrLvrQPg==
X-Received: by 2002:a1c:45:: with SMTP id 66mr16411921wma.40.1566151289348;
        Sun, 18 Aug 2019 11:01:29 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:28 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 10/14] spi: spi-fsl-dspi: Use reverse Christmas tree declaration order
Date:   Sun, 18 Aug 2019 21:01:11 +0300
Message-Id: <20190818180115.31114-11-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch puts variable declaration in the reverse order of their
length for cosmetic purposes.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a9bcbc458172..e2e71bd73b5c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -268,8 +268,8 @@ static void dspi_rx_dma_callback(void *arg)
 
 static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 {
-	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
+	struct fsl_dspi_dma *dma = dspi->dma;
 	int time_left;
 	int i;
 
@@ -346,9 +346,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
-	struct fsl_dspi_dma *dma = dspi->dma;
-	struct device *dev = &dspi->pdev->dev;
 	struct spi_message *message = dspi->cur_msg;
+	struct device *dev = &dspi->pdev->dev;
+	struct fsl_dspi_dma *dma = dspi->dma;
 	int curr_remaining_bytes;
 	int bytes_per_buffer;
 	int ret = 0;
@@ -383,9 +383,9 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
-	struct fsl_dspi_dma *dma;
-	struct dma_slave_config cfg;
 	struct device *dev = &dspi->pdev->dev;
+	struct dma_slave_config cfg;
+	struct fsl_dspi_dma *dma;
 	int ret;
 
 	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
@@ -527,10 +527,10 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 			   unsigned long clkrate)
 {
-	int pscale_tbl[4] = {1, 3, 5, 7};
 	int scale_needed, scale, minscale = INT_MAX;
-	int i, j;
+	int pscale_tbl[4] = {1, 3, 5, 7};
 	u32 remainder;
+	int i, j;
 
 	scale_needed = div_u64_rem((u64)delay_ns * clkrate, NSEC_PER_SEC,
 				   &remainder);
@@ -652,9 +652,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
+	enum dspi_trans_mode trans_mode;
 	struct spi_transfer *transfer;
 	int status = 0;
-	enum dspi_trans_mode trans_mode;
 
 	message->actual_length = 0;
 
@@ -752,12 +752,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 
 static int dspi_setup(struct spi_device *spi)
 {
-	struct chip_data *chip;
 	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
-	struct fsl_dspi_platform_data *pdata;
-	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
+	u32 cs_sck_delay = 0, sck_cs_delay = 0;
+	struct fsl_dspi_platform_data *pdata;
 	unsigned char pasc = 0, asc = 0;
+	struct chip_data *chip;
 	unsigned long clkrate;
 
 	/* Only alloc on first setup */
@@ -990,13 +990,13 @@ static void dspi_init(struct fsl_dspi *dspi)
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct regmap_config *regmap_config;
+	struct fsl_dspi_platform_data *pdata;
 	struct spi_controller *ctlr;
+	int ret, cs_num, bus_num;
 	struct fsl_dspi *dspi;
 	struct resource *res;
-	const struct regmap_config *regmap_config;
 	void __iomem *base;
-	struct fsl_dspi_platform_data *pdata;
-	int ret, cs_num, bus_num;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!ctlr)
-- 
2.17.1

