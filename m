Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00C3ECDE6
	for <lists+linux-spi@lfdr.de>; Mon, 16 Aug 2021 07:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhHPFDL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Aug 2021 01:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhHPFDK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Aug 2021 01:03:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C13C061764
        for <linux-spi@vger.kernel.org>; Sun, 15 Aug 2021 22:02:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so12155211pjb.3
        for <linux-spi@vger.kernel.org>; Sun, 15 Aug 2021 22:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:from:to:cc:subject:content-transfer-encoding
         :mime-version;
        bh=v7nlQsnphMSr3EzPyBvjABCfh9pFD4bxG5B4zI4h+Cg=;
        b=j0mE6M8yeO9QCDN3jye7QNPxNFM4vsVnVsZ6+CZa3dm9iR0bE4jcF2qXsMMXQy9JN6
         IcfNZnbjvw92LIqBJy1Nt5xqVqyYKiBIVv2cZbAlRJ1BIULmcnYSPThvzxSEDT4Fe3yG
         pl3042rdD8x3vJKEcTxicZubC1QEHuhSloE5i65UJHIjqfqhEHwhGH8RPgrpAYw6kGZ4
         ZCNn62AK3i6yH2sCkM88dREWhTXtqm/Efm84lxUtjmmoHLEjHZkchki/CVyCFqf7wpNs
         JO8Mt8nPzFGwvRXmT2li5/dFCfK5ZSej5+ERsUv2t06xXIZ6ko9PJPsKNqmMJZ8Xe/br
         YgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=v7nlQsnphMSr3EzPyBvjABCfh9pFD4bxG5B4zI4h+Cg=;
        b=W8AMQJ4RTHU8YAUWUVBKQi1jOyzHnenuVdpQdIHN00fPNOJF0s2iO9MHr6NMnZ24Q9
         qPSBCpB6mko+Fr7yKvTl4g6RItXvzf2fiV613RVH6pczbGbkqOUNSfPpFVec4X82G2o/
         dI9nSuAp8JImZ0fMzIi2r4b6AL+UnUyAvv5LNDc5YTY5LvUsIkKs+3kBQuvpLT1vE1Qu
         3/Y50qKNvrPPohJbfbSPsyBZrrETPFhtUNaQHE4lTa4QP/pHWRut+4jy7Aav8pb7sEgI
         VmReAIhh+BITUC8P02D6EEKYeRH4f/ZX3elFoDjT+KrsgvLKw9yjVKsEqEvwTObuSCim
         3xkQ==
X-Gm-Message-State: AOAM533UxxwCxDXDE0nHFxfqWs3IqgtRjwGcP2Teqtu3hJgDztreMSbB
        DJ6AX+AuOYpySNCa6F0CvNhStg==
X-Google-Smtp-Source: ABdhPJxkKVMqDo6kKiqxHBatMwDvg3+4eO4AtgW0k97jzgOzpi6e/mfWaQ58CNa8Rt+ow3WLP9nhug==
X-Received: by 2002:a17:90b:1693:: with SMTP id kv19mr15151928pjb.158.1629090159209;
        Sun, 15 Aug 2021 22:02:39 -0700 (PDT)
Received: from [127.0.1.1] (117-20-69-24.751445.bne.nbn.aussiebb.net. [117.20.69.24])
        by smtp.gmail.com with UTF8SMTPSA id t10sm7971610pji.30.2021.08.15.22.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 22:02:38 -0700 (PDT)
Date:   Mon, 16 Aug 2021 05:02:28 +0000
Message-Id: <20210816050228.3223661-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-spi@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: orion: Prevent incorrect chip select behaviour
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

When clearing the chip-select mask, the controller will switch to chip
selecting the native CS0 line. Because the control register chip-select
mask is not updated in a single write this will cause undesirable
chip-selection of CS0 even when requesting to select other native
chip-select lines. This is additionally problematic as the chip-select
may still be asserted. With the ARMADA 38x SoC the controller will
assert both the desired native chip-select and CS0.

To avoid any undesirable behaviour with the chip-select lines, update
the control register with a single write. This avoids selecting CS0 and
causes the (de-)assert to apply at the same time.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
 drivers/spi/spi-orion.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 34b31aba39..e8de3cbbfb 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -328,8 +328,16 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct orion_spi *orion_spi;
+	void __iomem *ctrl_reg;
+	u32 val;
 
 	orion_spi = spi_master_get_devdata(spi->master);
+	ctrl_reg = spi_reg(orion_spi, ORION_SPI_IF_CTRL_REG);
+
+	val = readl(ctrl_reg);
+
+	/* Clear existing chip-select and assertion state */
+	val &= ~(ORION_SPI_CS_MASK | 0x1);
 
 	/*
 	 * If this line is using a GPIO to control chip select, this internal
@@ -338,9 +346,7 @@ static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 	 * as it is handled by a GPIO, but that doesn't matter. What we need
 	 * is to deassert the old chip select and assert some other chip select.
 	 */
-	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, ORION_SPI_CS_MASK);
-	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
-			  ORION_SPI_CS(spi->chip_select));
+	val |= ORION_SPI_CS(spi->chip_select);
 
 	/*
 	 * Chip select logic is inverted from spi_set_cs(). For lines using a
@@ -350,9 +356,13 @@ static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 	 * doesn't matter.
 	 */
 	if (!enable)
-		orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
-	else
-		orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
+		val |= 0x1;
+
+	/*
+	 * To avoid toggling unwanted chip selects update the register
+	 * with a single write.
+	 */
+	writel(val, ctrl_reg);
 }
 
 static inline int orion_spi_wait_till_ready(struct orion_spi *orion_spi)
---
2.32.0
