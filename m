Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4C63AE10
	for <lists+linux-spi@lfdr.de>; Mon, 28 Nov 2022 17:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiK1QoT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Nov 2022 11:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiK1QoR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Nov 2022 11:44:17 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A067C1AD94
        for <linux-spi@vger.kernel.org>; Mon, 28 Nov 2022 08:44:14 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l2so7045379qtq.11
        for <linux-spi@vger.kernel.org>; Mon, 28 Nov 2022 08:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXSSzXQqwpqTp8kvMCywn3wDULboBrcJlaRyokBQ21k=;
        b=fejHIyNfaphEgkYKnCMhaL2S9tzT4NlOpJKoyQ/v4qpJLWqHeLSj8Q/Bt8hkvQgiNW
         kf190UpnS4b3+SMrlzWDpyElTt4EXZp6IxFfn6XkfhiwmSmG3dzw0+kBSjHu6elG+sBH
         76tF+npGB5JvlV3CaGWJ+G39ZWHYT+hbM37sQOLlOzLG5Uxtt87VXn+BS9DH3YYNPH0P
         yCzDWDNfhT6rLYKJVvz8pc1exJUAbkb0fmDJO8CDCXipAI+F8UtVaA//tWLZw+FAY62w
         wsVbyuA4jzpTNb2zMM6z0KtyvzP/DPYa0lmYAzF3y+okU7yq3liWGN9ajF3L8AUB8EqB
         WoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXSSzXQqwpqTp8kvMCywn3wDULboBrcJlaRyokBQ21k=;
        b=T+UWZGkpRk+koTfhyI2B1YLizcROprd9vxdgjszfiiFvibdq0Xc2LpqRKhFVwYbg5O
         siLbJ/SJAKx2/WqI+TADccQVaTx1V/KxocTyhCYmu57Gmtq/Dd0KhNITYA4axXcqJJ4p
         kHKbPff+Fw5UpogDN3xe3FtIl3K7DvmMn9ZgSclAJIdbc4C5HA8BNvVxEjKcY8uJo3oA
         pz9AzbC6JDdFrus/O7jCKGeytcROM1H5MeUfjy+yQ6Ml8eo7wxbBz86X9HkDvQsmveqp
         ID5P0+yz305EaHzkn+LnV7kvWyFLSRM1iOKiCvUL57+f6hfZdc/DRoskVhiHAD5ZV9cz
         ++oA==
X-Gm-Message-State: ANoB5pkDMLm8G63STRHSkbpT51KHdNvvFf4L0kDTBTTRsZOnz7KrmLa7
        xbbTEn+CIJw1HaFg7owL1DaMpw==
X-Google-Smtp-Source: AA0mqf7AtxhiM423WOE+xFxDY3JxLwBVPHLaeViLYBR9XRHLigeZ8k+EOCSYlJRNcx4+zIoCpf6HbA==
X-Received: by 2002:ac8:604e:0:b0:3a2:9fcd:59c8 with SMTP id k14-20020ac8604e000000b003a29fcd59c8mr34598175qtm.273.1669653853577;
        Mon, 28 Nov 2022 08:44:13 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id bn31-20020a05620a2adf00b006b95b0a714esm8724614qkb.17.2022.11.28.08.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:44:13 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: cadence-quadspi: Add minimum operable clock rate warning to baudrate divisor calculation
Date:   Mon, 28 Nov 2022 11:41:47 -0500
Message-Id: <20221128164147.158441-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This Cadence QSPI IP has a 4-bit clock divisor field
for baud rate division.  For example:

0b0000 = /2
0b0001 = /4
0b0010 = /6
...
0b1111 = /32

The maximum divisor is 32
(when div = CQSPI_REG_CONFIG_BAUD_MASK).

If we assume a reference clock of 500MHz and we set
our spi-max-frequency to something low, such as 10 MHz.
The calculated bit field for the divisor ends up being:

DIV_ROUND_UP(500000000/(2*10000000))-1 = 25

25 is 0b11001... which truncates to a divisor field of 0b1001 (or /20).

This is higher than our anticipated max-frequency of 10MHz
(500MHz/20 = 25 MHz).  Instead, let's make sure we're always using
the maximum divisor (/32) in this case and give the user a warning about
the rate adjustment.

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 447230547945..21b60b354404 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1119,6 +1119,14 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 	/* Recalculate the baudrate divisor based on QSPI specification. */
 	div = DIV_ROUND_UP(ref_clk_hz, 2 * cqspi->sclk) - 1;
 
+	/* Maximum baud divisor */
+	if (div > CQSPI_REG_CONFIG_BAUD_MASK) {
+		div = CQSPI_REG_CONFIG_BAUD_MASK;
+		dev_warn(&cqspi->pdev->dev,
+			"Unable to adjust clock <= %d hz. Reduced to %d hz\n",
+			cqspi->sclk, ref_clk_hz/((div+1)*2));
+	}
+
 	reg = readl(reg_base + CQSPI_REG_CONFIG);
 	reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
 	reg |= (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
-- 
2.30.2

