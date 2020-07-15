Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598B522103B
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgGOPGu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgGOPGq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAECC08C5DF
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so3069197wrv.9
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjh7OhojJcRmD5KkKwacJpyMf8L6Fg+f9kXKvvMc3JQ=;
        b=rtO/R+gF9zsxdsObRHLZjii928eu9P6U4fV47qT04PDZqfN1Aq+9wmYpIrjcPldh7T
         yP1DLy0eimKSKjz+BYeWPwFsrz3w33TZgBqvD+zngaL580tLU7cwgnteXFXEa2cVb63a
         C3hCJVfmWgf8lgOF6706sYiBVu2V51RlGIqpapFdC5++3X0ambcY9JvZQCYe85kYOmw7
         bSpz8d0j/QI47062tJVsowpUDTU7eNVnWs3lPdNm2HUsKNOkvlscGCVf3IgWF57B7ma/
         SicBianzkJtzdwiwzI2qiNr5ecy2Jif9S6uDJm1um/jUNYgDmdZ52yFNt5ixduLTT+cK
         f0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjh7OhojJcRmD5KkKwacJpyMf8L6Fg+f9kXKvvMc3JQ=;
        b=OhmZB/aBsisf3goLGcA7959VMKkQKPfZ6p8MllvEYUUHG1qwo6190A7qnadgOtvYqS
         DnNh6CxPOZx2i0QWgqlmwBE6G6ZPw4dlTpqI+ERgHW7E6e1jYxhki6fxsc53tZKP1fva
         fFGfuoDdIjv0AjxcfXpxugihuJ6KG3p2MGrt+9fS9NAtyJxD42bdpYZOE4SnvoS+pmdr
         C2M65Tex/YBu2a6aVA7VJTkyWSAg3z3TZcwgipwQ+g7Mfs06iIzzjqa8wMTPkLxUZMde
         jZc+/6O803hivBEz7ctH6ti72e+jX4e4+gQnb9vemQ9E4CGjrku3Kupx9f8LlReK0ZPb
         zigA==
X-Gm-Message-State: AOAM531Rwq4T6JmC2+NwEBHOCmNMi9u3fB37nxMWg5OJ/uLcmjst/PQF
        Hj69oiWp1UcRnytTK5R/k62Tzg==
X-Google-Smtp-Source: ABdhPJz/qORqv4SB3JCQPZLx2YoBeuFRtlxnr/5oEScOZOZu+WtAdMW0hpudATx8mM94Ld2/ZEFr8w==
X-Received: by 2002:adf:fa10:: with SMTP id m16mr7456479wrr.134.1594825605304;
        Wed, 15 Jul 2020 08:06:45 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sachin Verma <sachin.verma@st.com>
Subject: [PATCH 08/14] spi: spi-pl022: Provide missing struct attribute/function param docs
Date:   Wed, 15 Jul 2020 16:06:26 +0100
Message-Id: <20200715150632.409077-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Also demote non-worthy kerneldoc headers to standard comment blocks.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-pl022.c:304: warning: cannot understand function prototype: 'enum ssp_writing '
 drivers/spi/spi-pl022.c:330: warning: Function parameter or member 'loopback' not described in 'vendor_data'
 drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'rx_lev_trig' not described in 'pl022'
 drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'tx_lev_trig' not described in 'pl022'
 drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'dma_running' not described in 'pl022'
 drivers/spi/spi-pl022.c:670: warning: Function parameter or member 'pl022' not described in 'readwriter'
 drivers/spi/spi-pl022.c:1250: warning: Function parameter or member 'irq' not described in 'pl022_interrupt_handler'
 drivers/spi/spi-pl022.c:1250: warning: Function parameter or member 'dev_id' not described in 'pl022_interrupt_handler'
 drivers/spi/spi-pl022.c:1343: warning: Function parameter or member 'pl022' not described in 'set_up_next_transfer'
 drivers/spi/spi-pl022.c:1343: warning: Function parameter or member 'transfer' not described in 'set_up_next_transfer'

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sachin Verma <sachin.verma@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-pl022.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 66028ebbc336d..d1776fea287e5 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -298,7 +298,7 @@ enum ssp_reading {
 	READING_U32
 };
 
-/**
+/*
  * The type of writing going on on this chip
  */
 enum ssp_writing {
@@ -317,6 +317,7 @@ enum ssp_writing {
  * @extended_cr: 32 bit wide control register 0 with extra
  * features and extra features in CR1 as found in the ST variants
  * @pl023: supports a subset of the ST extensions called "PL023"
+ * @loopback: supports loopback mode
  * @internal_cs_ctrl: supports chip select control register
  */
 struct vendor_data {
@@ -353,11 +354,14 @@ struct vendor_data {
  * @read: the type of read currently going on
  * @write: the type of write currently going on
  * @exp_fifo_level: expected FIFO level
+ * @rx_lev_trig: receive FIFO watermark level which triggers IRQ
+ * @tx_lev_trig: transmit FIFO watermark level which triggers IRQ
  * @dma_rx_channel: optional channel for RX DMA
  * @dma_tx_channel: optional channel for TX DMA
  * @sgt_rx: scattertable for the RX transfer
  * @sgt_tx: scattertable for the TX transfer
  * @dummypage: a dummy page used for driving data on the bus with DMA
+ * @dma_running: indicates whether DMA is in operation
  * @cur_cs: current chip select (gpio)
  * @chipselects: list of chipselects (gpios)
  */
@@ -662,7 +666,7 @@ static void load_ssp_default_config(struct pl022 *pl022)
 	writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl022->virtbase));
 }
 
-/**
+/*
  * This will write to TX and read from RX according to the parameters
  * set in pl022.
  */
@@ -1237,6 +1241,8 @@ static inline void pl022_dma_remove(struct pl022 *pl022)
 
 /**
  * pl022_interrupt_handler - Interrupt handler for SSP controller
+ * @irq: IRQ number
+ * @dev_id: Local device data
  *
  * This function handles interrupts generated for an interrupt based transfer.
  * If a receive overrun (ROR) interrupt is there then we disable SSP, flag the
@@ -1334,7 +1340,7 @@ static irqreturn_t pl022_interrupt_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/**
+/*
  * This sets up the pointers to memory for the next message to
  * send out on the SPI bus.
  */
-- 
2.25.1

