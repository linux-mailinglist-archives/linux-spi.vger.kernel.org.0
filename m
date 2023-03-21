Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897316C3116
	for <lists+linux-spi@lfdr.de>; Tue, 21 Mar 2023 12:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCUL7L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Mar 2023 07:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCUL7L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Mar 2023 07:59:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE92158B7
        for <linux-spi@vger.kernel.org>; Tue, 21 Mar 2023 04:59:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536d63d17dbso152776997b3.22
        for <linux-spi@vger.kernel.org>; Tue, 21 Mar 2023 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679399945;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r8A+qj8whaa2EVpkeoxnnh/JzSlsp2fevSoVTdtS9NA=;
        b=FHQCwsAW8fqwW3qGdSmkBeKZRwCBfzkqolPbAv31wLjIIw6kRYe+ei6tVVhL9K1Woy
         ltpIynSNN4Az+JJIpalXS26/Rq8SsT1ZjpOao2W3wjmFwspyl5NiH7g8QttxH/seA7zX
         tE0uQCXVZCdgWUXr+tVOtr9ZtjWqlu7TZCRXRuP2UWPdqcuH7WwO4BZ/CsQX/7DOwuIa
         iWkIcRdaz6PD7huMjKK+irzdzjTtQwY0r5hdvUH9Lrl8di1JQ6nCNa5DVdRTSoMBMqhd
         tgoZt6+ON+L4fVHfMV2nQ417zB8i35Zx+2+ulkhCMX7pclxf9TZWjlp5419kZxQ0AOzZ
         biJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399945;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8A+qj8whaa2EVpkeoxnnh/JzSlsp2fevSoVTdtS9NA=;
        b=3NAbjT0GMja1qWnD9s4I9DL00sLzOMrKSEj8eOkzdpZgJnmSkErPBYoct8W/uyfc0U
         RVpev9Hf9Cc38DchbGeTBbS3JvbycNo8fTECJomNn2jW2A0Xu36ByAXRkKUG2b0ev47k
         rcUUqXmuNM4lMkaJNSudEaxs3dwYsicY6hi6QSiG4+BNKg13zmKM/YkBwl9faCuB1N5n
         SESU6fCF9Npv6PgPM2jGOlEvQH46eykvpDFiu95CsAjUQjTYH9rBn3sIVSMrv7/9gY5R
         E2cTB3/1zTBWG9NOVYEgINAwv6lA4z9xE6MyKMNlGF3bWDcyAHXLF454fMeLPJcJOIVy
         bAqQ==
X-Gm-Message-State: AAQBX9fOK4kfl0M7NF23EinaGZCkq73/9GpEyyGTS1JE3HtcGVTfV6Aa
        9k5qYDE8MpkAswgcZFzUwoia4sEnuDHD7w==
X-Google-Smtp-Source: AKy350bcv35XCLD/YwBf/zYbbuW/VK4IOexHg+oZOgcpzwF9LW/+8TF8PnhwPAvl59Ik/aktxYjExneqKdSdkw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:8a0e:0:b0:b30:8d4b:230e with SMTP id
 g14-20020a258a0e000000b00b308d4b230emr1006235ybl.7.1679399945431; Tue, 21 Mar
 2023 04:59:05 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:58:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230321115843.2688472-1-joychakr@google.com>
Subject: [PATCH v2] spi: dw: Add 32 bpw support to DW DMA Controller
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If DW Controller is capable of a maximum of 32 bits per word then SW or
DMA controller has to write up to 32bit or 4byte data to the FIFO at a
time.

This Patch adds support for AxSize = 4 bytes configuration from dw dma
driver if n_bytes i.e. number of bytes per write to fifo is 3 or 4.
It also checks to see if the dma controller is capable of satisfying the
width requirement to achieve a particular bits/word requirement per
transfer.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 37 ++++++++++++++++++++++++++++++++-----
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..9ac3a1c25e2d 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -23,6 +23,8 @@
 #define DW_SPI_TX_BUSY		1
 #define DW_SPI_TX_BURST_LEVEL	16
 
+static inline enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
+
 static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *s = param;
@@ -89,6 +91,16 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
 		dws->dma_sg_burst = 0;
 }
 
+static void dw_spi_dma_addr_widths_init(struct dw_spi *dws)
+{
+	struct dma_slave_caps tx = {0}, rx = {0};
+
+	dma_get_slave_caps(dws->txchan, &tx);
+	dma_get_slave_caps(dws->rxchan, &rx);
+
+	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+}
+
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 {
 	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
@@ -128,6 +140,8 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_dma_sg_burst_init(dws);
 
+	dw_spi_dma_addr_widths_init(dws);
+
 	pci_dev_put(dma_dev);
 
 	return 0;
@@ -167,6 +181,8 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_dma_sg_burst_init(dws);
 
+	dw_spi_dma_addr_widths_init(dws);
+
 	return 0;
 
 free_rxchan:
@@ -202,18 +218,29 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 			   struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
+	enum dma_slave_buswidth dma_bus_width;
 
-	return xfer->len > dws->fifo_len;
+	if (xfer->len > dws->fifo_len) {
+		dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
+		if (dws->dma_addr_widths & BIT(dma_bus_width))
+			return true;
+	}
+	return false;
 }
 
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
-	if (n_bytes == 1)
+	switch (n_bytes) {
+	case 1:
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
-	else if (n_bytes == 2)
+	case 2:
 		return DMA_SLAVE_BUSWIDTH_2_BYTES;
-
-	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	case 3:
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
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
2.40.0.rc1.284.g88254d51c5-goog

