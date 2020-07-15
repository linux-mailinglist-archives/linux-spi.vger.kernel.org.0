Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0395B221051
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGOPHa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgGOPGp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF42C08C5DD
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so5935593wmg.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtRzZ5KmeCiCWZA3g8vq3ZlMKJB7i9QBYHFK4C8GH0s=;
        b=mm5H0gktuRl27KwOE3Op7rhTrBCOq3IjXtDklC9duhaS3OTT2AIBTmiUK7enabkTxf
         phcZ+mlV/fhB5510gdwnlVT3Nu8bq+sziuBIoKP6hjoayECw6hdssq4P9CHFYDMgDvIQ
         ErWfZyh4qn06Cfihd8RkCok4YpfxkvExmV1F49S4++6DMkMoaoPjSjicaXvmiKHPAhAs
         zamOm620KAFOcYr63wq8QipRJwm8ft++56w68XfTbJiF0Y/z8iqjB7oqiRiK4B4uUWpS
         X6Lp1A3i1p5aH4zsuxlrzFMGCAXnMp1cnAVb07VjMsCZTEORkYIDT50YyijZRN7wzI4Y
         PcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtRzZ5KmeCiCWZA3g8vq3ZlMKJB7i9QBYHFK4C8GH0s=;
        b=cZSBmAhANt9nfZPUAfnfH9XjJ1OnEY/qm4HYH1sowzzbnfKtsiiU9OJKGL8SIp9/tH
         PQCnsXkn9Rke+GGL160VZJ7g6zoY6Y6nqg+V9cR/OeXWBnuIiFJZa83YyxsowHs7uJwX
         FnVGmhJbk1/G2aMf+MIR7bZxyAUGO8i+RJ0PRvwF+4oA2ptkaahaWXy4SwXew7FEEGmi
         7yb36QyIc0stLxFaXeWyb5QmQj/ZZDriXummaOCeVIeQVHP+fTx3HC2wiR2+CWuicqxO
         XMVi6NxnFQqBcdbdcm0nVYYtHC9WB/s/Scv3gxdgeeJS57t8H6ykfHwSEiGtNdO+pYyb
         Xiaw==
X-Gm-Message-State: AOAM5315Y3OWpkIR9AG5Fo3npteXEuN4qunaCmH4LURUZRG34b0tchJn
        QqMNywHw8ZUh9uz+IrRDEMViyunID98=
X-Google-Smtp-Source: ABdhPJwPI7700rZiGUg8UA2/gAzTCD4H6EyDR617KU4GnsAL6bxdbGHlfr3Qjde6X1ytzLoqJxXbAg==
X-Received: by 2002:a05:600c:21cb:: with SMTP id x11mr8697229wmj.141.1594825603705;
        Wed, 15 Jul 2020 08:06:43 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>,
        Jaswinder Singh <jassi.brar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 07/14] spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
Date:   Wed, 15 Jul 2020 16:06:25 +0100
Message-Id: <20200715150632.409077-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-s3c64xx.c:150: warning: Function parameter or member 'quirks' not described in 's3c64xx_spi_port_config'
 drivers/spi/spi-s3c64xx.c:150: warning: Function parameter or member 'clk_ioclk' not described in 's3c64xx_spi_port_config'
 drivers/spi/spi-s3c64xx.c:189: warning: Function parameter or member 'pdev' not described in 's3c64xx_spi_driver_data'
 drivers/spi/spi-s3c64xx.c:189: warning: Function parameter or member 'rx_dma' not described in 's3c64xx_spi_driver_data'
 drivers/spi/spi-s3c64xx.c:189: warning: Function parameter or member 'tx_dma' not described in 's3c64xx_spi_driver_data'
 drivers/spi/spi-s3c64xx.c:189: warning: Function parameter or member 'port_conf' not described in 's3c64xx_spi_driver_data'
 drivers/spi/spi-s3c64xx.c:189: warning: Function parameter or member 'port_id' not described in 's3c64xx_spi_driver_data'

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andi Shyti <andi@etezian.org>
Cc: Jaswinder Singh <jassi.brar@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index cf67ea60dc0ed..924b24441789a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -130,9 +130,11 @@ struct s3c64xx_spi_dma_data {
  * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
+ * @quirks: Bitmask of known quirks
  * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
  * @clk_from_cmu: True, if the controller does not include a clock mux and
  *	prescaler unit.
+ * @clk_ioclk: True if clock is present on this device
  *
  * The Samsung s3c64xx SPI controller are used on various Samsung SoC's but
  * differ in some aspects such as the size of the fifo and spi bus clock
@@ -154,6 +156,7 @@ struct s3c64xx_spi_port_config {
  * @clk: Pointer to the spi clock.
  * @src_clk: Pointer to the clock used to generate SPI signals.
  * @ioclk: Pointer to the i/o clock between master and slave
+ * @pdev: Pointer to device's platform device data
  * @master: Pointer to the SPI Protocol master.
  * @cntrlr_info: Platform specific data for the controller this driver manages.
  * @lock: Controller specific lock.
@@ -166,7 +169,11 @@ struct s3c64xx_spi_port_config {
  * @xfer_completion: To indicate completion of xfer task.
  * @cur_mode: Stores the active configuration of the controller.
  * @cur_bpw: Stores the active bits per word settings.
- * @cur_speed: Stores the active xfer clock speed.
+ * @cur_speed: Current clock speed
+ * @rx_dma: Local receive DMA data (e.g. chan and direction)
+ * @tx_dma: Local transmit DMA data (e.g. chan and direction)
+ * @port_conf: Local SPI port configuartion data
+ * @port_id: Port identification number
  */
 struct s3c64xx_spi_driver_data {
 	void __iomem                    *regs;
-- 
2.25.1

