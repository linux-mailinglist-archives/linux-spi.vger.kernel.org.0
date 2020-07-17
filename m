Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1929B223D66
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGQNy6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgGQNyj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D220C0619D6
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so14951184wmg.1
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZd/W0TpHswu0SuYSG0OcLxLAj8b5WuGZfRv6Lvmmao=;
        b=CLcRog2efhriOmziPd49uvqHp4X3kgn1MMhEVojt9mJGnBLfyFuKfUqJx5yUzpj2Zj
         5Ym61ZRmqQ3DPrfbITu3j1YnCKySperMNZP3cU9/bdO1TgPDWdDmjQ7d0qmWsdesIvOB
         bpIYUeLDljadMWctNzF83RAoClWIdr6ZSV9f6nz8BgpWTi2y0Wbqedj2QUGb4eXYyhXl
         YxdqabjHzf9qfpd/LXuXtREuBS0/PiNBbOp/snlxaqVb4l4MNvOyJybjndDRwjdnl8LP
         v+6owkZu7AR/Jbyz9Uap9KGe77zwO5b6d8Qz+tNE0W5rLJK5uCHXMlkkdJN/ItaZQ7br
         qxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZd/W0TpHswu0SuYSG0OcLxLAj8b5WuGZfRv6Lvmmao=;
        b=jCIycAN0kT6unT4FaKg7cP0EIUvzCY7GUeVGj3Zp6SdA5gca1mh9Xix+kVY5HLhdgv
         5Tc0mw1do7Uit46lbmUYBMzr2gqKHy1f4H+T8eNRrisr/1ecnqfRkmfvPVEh5K1fvIWZ
         RKWj35akMtBTCkYnzl+I2PaeSF18zZkUosoA9f+Uahftww+vaE/SRBg+CWaseJSMHC75
         +M9EZ653R0eweQN9121Wpj7ChEPw52ijr2XwcC5eWwXMzhVwNV8967dkx3ys9/R2Y+rD
         lYnXRYVO5mNV13mxtfMbceHJtfdI8cAaBN24Bum/sInityeLGosqpvAMKaaH6KFdfvuz
         UjzQ==
X-Gm-Message-State: AOAM530zd4M7CsvEnZ3I7X+yhkUS6szP906cZ48wqW8XHs61+A3MyIQz
        /GOj2RcOOKwm0ZronMGcTlf/DA==
X-Google-Smtp-Source: ABdhPJzmXBAH1xHG/f+/U5CPsM7W8OR1I8fHDdWt1wtsnnCdoWIGjeRov6Uqg+/snJgO/SsCP9UkMg==
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr9010367wmc.7.1594994078207;
        Fri, 17 Jul 2020 06:54:38 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 11/14] spi: spi-topcliff-pch: Add missing descriptions to 'struct pch_spi_data'
Date:   Fri, 17 Jul 2020 14:54:21 +0100
Message-Id: <20200717135424.2442271-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'io_base_addr' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'pkt_tx_buff' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'pkt_rx_buff' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'dma' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'use_dma' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'save_total_len' not described in 'pch_spi_data'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-topcliff-pch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index d7ea6af74743e..baadd380cb297 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -122,6 +122,7 @@ struct pch_spi_dma_ctrl {
 /**
  * struct pch_spi_data - Holds the SPI channel specific details
  * @io_remap_addr:		The remapped PCI base address
+ * @io_base_addr:		Base address
  * @master:			Pointer to the SPI master structure
  * @work:			Reference to work queue handler
  * @wait:			Wait queue for waking up upon receiving an
@@ -138,8 +139,8 @@ struct pch_spi_dma_ctrl {
  *				transfer
  * @rx_index:			Receive data count; for bookkeeping during
  *				transfer
- * @tx_buff:			Buffer for data to be transmitted
- * @rx_index:			Buffer for Received data
+ * @pkt_tx_buff:		Buffer for data to be transmitted
+ * @pkt_rx_buff:		Buffer for received data
  * @n_curnt_chip:		The chip number that this SPI driver currently
  *				operates on
  * @current_chip:		Reference to the current chip that this SPI
@@ -151,7 +152,10 @@ struct pch_spi_dma_ctrl {
  * @board_dat:			Reference to the SPI device data structure
  * @plat_dev:			platform_device structure
  * @ch:				SPI channel number
+ * @dma:			Local DMA information
+ * @use_dma:			True if DMA is to be used
  * @irq_reg_sts:		Status of IRQ registration
+ * @save_total_len:		Save length while data is being transferred
  */
 struct pch_spi_data {
 	void __iomem *io_remap_addr;
-- 
2.25.1

