Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3CE34EE74
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhC3Qt2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhC3QtQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 12:49:16 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DBBC061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 09:49:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b4so24786698lfi.6
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwuBPFGLSpKihZVKEG15+3y/R2q1McqdWhbHkRumoJ0=;
        b=Vm8j58rbTFraz7ojmqwXZHv94P4XwE3m03Okzpw2JV2WFtRBqde2VYPWB28tRlPya9
         fRTd20ByT76bFES+dlFLszeXm4rwYkpEViff/l+Gv/qFKEbDOqTPlgY04G4LoOZY6Fre
         ZqPwKXu5CgQJrTrQJxla6XxpD0/zZOqliZgQSTSsxLwQGldgebDkducWBtLe3Gq0TN0B
         KIsxsuxOr+GJv3UE6IiAWpjEdtCZeLxCkQVkEPCqNn+k2EtF++Hu4tC2Tq6eA2z5HR/v
         WvBqZrgZCA7mOKIHnVENyo8B5r4p+snbE+dUomlKKQ2z3ge2hqkORIM2MP4kwB0p55eP
         2CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwuBPFGLSpKihZVKEG15+3y/R2q1McqdWhbHkRumoJ0=;
        b=ptNoioxopbtT/li5tawgAPGMri+R5KyiaYHot2b8fDTBujd5CrLQ0uqyFDhpHUeCzL
         C7gnaRwg6CpsICY2x832JKPWL+FP5Vye9tvh+oX3ieXmz1smFM1HU1VV+wPvXbWePcHV
         dn3bEv2UpxQUW3CHppcKmrY97aTFS6KB/j1CWfLU5OKCf6pP0Ru2wgzVq2O/NpisBV4U
         n1pWlGEnb1uz6aTm3vledtSSzM+NG02sbU6jqz+zN2HDE1TujtFl9KG0s5TjDShJcTH1
         PTSiJvb/QEwPSVlr6ON4viR4YdTh2fzTq7dI1jlgv4bMoaPuiW8kZ6QCyLBb3+vF0nsO
         Xv5g==
X-Gm-Message-State: AOAM531rz5B3EMA+Ci27hYK6TkymnSK/p6Noi1rh4L9taiu2YxWyapGQ
        CdFbmQduZaigPi48kDU8tEMZ+c8VtNJEyRmi
X-Google-Smtp-Source: ABdhPJypyDkkXsOTT7gCAh5qoYCqEdFsY2wzZLz49U4yg5EP1kGKpNh73I8DER+uJ80p3/TDZbwSNQ==
X-Received: by 2002:a19:234a:: with SMTP id j71mr19798896lfj.448.1617122953538;
        Tue, 30 Mar 2021 09:49:13 -0700 (PDT)
Received: from localhost.localdomain (c-14cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.20])
        by smtp.gmail.com with ESMTPSA id m19sm2839025ljb.10.2021.03.30.09.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:49:13 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] spi: pl022: Drop custom per-chip cs_control
Date:   Tue, 30 Mar 2021 18:49:05 +0200
Message-Id: <20210330164907.2346010-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Drop the custom cs_control() assigned through platform data,
we have no in-tree users and the only out-of-tree use I have
ever seen of this facility is to pull GPIO lines, which is
something the driver can already do for us.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c    | 26 ++------------------------
 include/linux/amba/pl022.h |  3 ---
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index faaca7373b40..e5dd7756c2ea 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -412,7 +412,6 @@ struct pl022 {
  * @enable_dma: Whether to enable DMA or not
  * @read: function ptr to be used to read when doing xfer for this chip
  * @write: function ptr to be used to write when doing xfer for this chip
- * @cs_control: chip select callback provided by chip
  * @xfer_type: polling/interrupt/DMA
  *
  * Runtime state of the SSP controller, maintained per chip,
@@ -427,22 +426,9 @@ struct chip_data {
 	bool enable_dma;
 	enum ssp_reading read;
 	enum ssp_writing write;
-	void (*cs_control) (u32 command);
 	int xfer_type;
 };
 
-/**
- * null_cs_control - Dummy chip select function
- * @command: select/delect the chip
- *
- * If no chip select function is provided by client this is used as dummy
- * chip select
- */
-static void null_cs_control(u32 command)
-{
-	pr_debug("pl022: dummy chip select control, CS=0x%x\n", command);
-}
-
 /**
  * internal_cs_control - Control chip select signals via SSP_CSR.
  * @pl022: SSP driver private data structure
@@ -470,8 +456,6 @@ static void pl022_cs_control(struct pl022 *pl022, u32 command)
 		internal_cs_control(pl022, command);
 	else if (gpio_is_valid(pl022->cur_cs))
 		gpio_set_value(pl022->cur_cs, command);
-	else
-		pl022->cur_chip->cs_control(command);
 }
 
 /**
@@ -1829,7 +1813,6 @@ static const struct pl022_config_chip pl022_default_chip_info = {
 	.ctrl_len = SSP_BITS_8,
 	.wait_state = SSP_MWIRE_WAIT_ZERO,
 	.duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
-	.cs_control = null_cs_control,
 };
 
 /**
@@ -1940,13 +1923,8 @@ static int pl022_setup(struct spi_device *spi)
 
 	/* Now set controller state based on controller data */
 	chip->xfer_type = chip_info->com_mode;
-	if (!chip_info->cs_control) {
-		chip->cs_control = null_cs_control;
-		if (!gpio_is_valid(pl022->chipselects[spi->chip_select]))
-			dev_warn(&spi->dev,
-				 "invalid chip select\n");
-	} else
-		chip->cs_control = chip_info->cs_control;
+	if (!gpio_is_valid(pl022->chipselects[spi->chip_select]))
+		dev_warn(&spi->dev, "invalid chip select\n");
 
 	/* Check bits per word with vendor specific range */
 	if ((bits <= 3) || (bits > pl022->vendor->max_bpw)) {
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index 131b27c97209..29274cedefde 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -265,8 +265,6 @@ struct pl022_ssp_controller {
  * @duplex: Microwire interface: Full/Half duplex
  * @clkdelay: on the PL023 variant, the delay in feeback clock cycles
  * before sampling the incoming line
- * @cs_control: function pointer to board-specific function to
- * assert/deassert I/O port to control HW generation of devices chip-select.
  */
 struct pl022_config_chip {
 	enum ssp_interface iface;
@@ -280,7 +278,6 @@ struct pl022_config_chip {
 	enum ssp_microwire_wait_state wait_state;
 	enum ssp_duplex duplex;
 	enum ssp_clkdelay clkdelay;
-	void (*cs_control) (u32 control);
 };
 
 #endif /* _SSP_PL022_H */
-- 
2.29.2

