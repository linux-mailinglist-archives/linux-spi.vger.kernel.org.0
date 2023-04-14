Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B26E22D6
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 14:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDNMGA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 08:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjDNMFz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 08:05:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1DFB740
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:05:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f66-20020a255145000000b00b7f75c3cafdso3263596ybb.16
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681473944; x=1684065944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z3uzwpPzb9VI4QQ6yS9D24bwvkUC2CAvsehyf1JMvE=;
        b=Ou1uK5F20L6r3e7SB7x5q5L0CnE5r9AV4LcR+uW9hQU807GkWv51UdfdG7hInhv4sM
         TNNn+GqUjNNfnHNcELyJ6nNkzMU/nFDuGtm7ka9C/fJFayqz1Y9IeoJA4Te8fjpMEk8y
         PWPDwfq3O/CTnzodGfkYJu2s7O42iceHNvs/hU1pMm+Dd1PFsUJUsbWWLEgpNOvvmq2+
         c3kRMzcKSmWAj/UehpADE7vtrRG+TBX247ste/8w8NdDB49ftji2AUEcHCQ5HMny19sS
         C50QI8ZkJ022JaYREQbDb/jiIK4AVfkK4mI7aG1lYSrkGVnGDwTFheR4qlrcgPMGmHBy
         KycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681473944; x=1684065944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z3uzwpPzb9VI4QQ6yS9D24bwvkUC2CAvsehyf1JMvE=;
        b=WS6eMMXpzfKGGMCee+253nwsKxuMiAWqTz2FTn/ISTiEBM3ZtCPZmxV355B7L5jqg1
         8s0aLluTrGR/AZHvFtMrb3ZmZjlfdNjNfYMpzxrx6AsyT5BKC8azHOle8uQf83u8m/hq
         y3qzJdTXBtIw0dTWi7auKGXo4FIXH0+iMCs0r36c6NNVLAzRGLozbXB6uYCCXS8T/fF4
         4FyulDlH+v5un5dmNoofyl9DPyiBUxxjaXRxrmdJkLxoEIT4d3plPn/ILrJPU3OxOcHQ
         2sgEl5BVqR9IQ+0YwV/NPhgf+D6WpdQCpme+zxUfkVJlWLztbrEbYqk5aJ7IdSQYoYMM
         z9CA==
X-Gm-Message-State: AAQBX9ew2h72CRqHQ0hFR+ZxXYCq3z9AUEj6vYAKD2QNCX2BoFS2dKG/
        QBl5A+GRWw5dbKamEDiNsLC00YOgfBhBiw==
X-Google-Smtp-Source: AKy350ZqSm5SfWAbvP/hpYF8agstj/3XeSp2uhP5Ya1Any3Gz8rMS2RMteYaTt3rWSqbP5Bc3Ob9khp4BmEdjQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:af1e:0:b0:52e:e095:d840 with SMTP id
 n30-20020a81af1e000000b0052ee095d840mr3677516ywh.0.1681473944443; Fri, 14 Apr
 2023 05:05:44 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:05:19 +0000
In-Reply-To: <20230414120520.360291-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230414120520.360291-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414120520.360291-5-joychakr@google.com>
Subject: [PATCH v6 4/5] spi: dw: Add DMA address widths capability check
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Store address width capabilities of DMA controller during init and check
the same per transfer to make sure the bits/word requirement can be met.

Current DW DMA driver requires both tx and rx channel to be configured
and functional hence a subset of both tx and rx channel address width
capability is checked with the width requirement(n_bytes) for a
transfer.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 17 +++++++++++++++--
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index e1dd13fe4fd0..45980c46946d 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -97,6 +97,14 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 		dws->dma_sg_burst = rx.max_sg_burst;
 	else
 		dws->dma_sg_burst = 0;
+
+	/*
+	 * Assuming both channels belong to the same DMA controller hence the
+	 * address width capabilities most likely would be the same.
+	 */
+	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+
+	return 0;
 }
 
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
@@ -237,10 +245,15 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 			   struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
+	enum dma_slave_buswidth dma_bus_width;
 
-	return xfer->len > dws->fifo_len;
-}
+	if (xfer->len <= dws->fifo_len)
+		return false;
 
+	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
+
+	return dws->dma_addr_widths & BIT(dma_bus_width);
+}
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 {
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9e8eb2b52d5c..3962e6dcf880 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -190,6 +190,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	u32			rxburst;
 	u32			dma_sg_burst;
+	u32			dma_addr_widths;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;
-- 
2.40.0.634.g4ca3ef3211-goog

