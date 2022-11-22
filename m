Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C4633DD0
	for <lists+linux-spi@lfdr.de>; Tue, 22 Nov 2022 14:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiKVNhK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Nov 2022 08:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiKVNgu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Nov 2022 08:36:50 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2906D657F2
        for <linux-spi@vger.kernel.org>; Tue, 22 Nov 2022 05:36:32 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id w4so9278153qts.0
        for <linux-spi@vger.kernel.org>; Tue, 22 Nov 2022 05:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UkNEKCQ16FMxkrHYVFQf6e8K188fnshAA38kAxfjKU8=;
        b=QbuTusYomnVJaeY21Fj9W3eEOnRQHuFxac07KrLEArsmb7jkYaQSErevjsEaN4Sq2G
         CIZVgJQNaHT881QEt5m63hClrwgqJ01bRQmosMGCcwhvOGULLxeeXAyLqNFekczB3WZu
         7cdg9BnUXcReStZAz1y54TGgN0tgFmtdIfqcUj7KLvjeMOkHwC7vug25ZD6uIrurAt7D
         5Vf70H+2NwReKirgfuB9DBztExfJ/VL3hOja1ExyW7CZAkyDVUMVYdu6/7rMbJUCq7Hr
         0fhwfqnXoQxhxTJSkv4zkSmp4Li2BqxpK7u0wYpRhj7krnRVcm++WIzHLQ1qiDYPNDpt
         Moag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkNEKCQ16FMxkrHYVFQf6e8K188fnshAA38kAxfjKU8=;
        b=ddHgsl4HClJh0i41D7qzn9WlBLzv85o7tVMLgKu2vYpvIxovaSNlpbuW+CMT+FdmrX
         SqX6DOe52nedh8ncnYzojnl6bkJTuq33XZ3TPc1dj4Zsy5odAJczCRl1idlbyDrNInsR
         phpElqI2YGd+5P42ENa7+aBlc3AnpG7QCu/nTSCHdVHPGnTgKcaTDiRsGpPw03VWurxQ
         Stjh6y17qbGQSVvsFWRx5P9/wuEzCLi5pF/viqazwuUF/Ym6h4a5xrJgwhB70D0NAjcE
         OukCww4iRRC8qNLSS22NQ9mPrFzpfw0pBKsw29aEXFrM5+VSKKHU5EMeXd6xasNZAxiZ
         gBqg==
X-Gm-Message-State: ANoB5pmvGa4wSvc0KA8Rg9Dn/fREkA18So9al/OBlG2VHnmcRhkAZxKe
        anWQWtYR+OjrGGVkPsUH4kvTZQ==
X-Google-Smtp-Source: AA0mqf6D3HygNB0CzVApEgtr3ebu7Oqjj0W7lPeYhyi3Eb3MHz34bc0OLNP942A3sEpLJ2u+k892dw==
X-Received: by 2002:ac8:7216:0:b0:3a5:fbf9:1f40 with SMTP id a22-20020ac87216000000b003a5fbf91f40mr4806012qtp.323.1669124191317;
        Tue, 22 Nov 2022 05:36:31 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id az20-20020a05620a171400b006ec771d8f89sm10223517qkb.112.2022.11.22.05.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:36:31 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com, nathan.morrison@timesys.com,
        p.yadav@ti.com, vigneshr@ti.com,
        vadivel.muruganx.ramuthevar@intel.com,
        grmoore@opensource.altera.com, lftan@altera.com,
        Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: cadence-quadspi: Properly pass buswidth through to underlying SPI subsystem via buswidth_override_bits instead of mode_bits.
Date:   Tue, 22 Nov 2022 08:35:50 -0500
Message-Id: <20221122133551.91536-1-nathan.morrison@timesys.com>
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

While trying to enable Octal SPI mode, it was observed that
SPI_RX_OCTAL/SPI_TX_OCTAL were not propagating into the spi_device
spi->mode setting.  This was causing the SPI device to always
operate in 1x mode instead of the desired 8x mode.

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 447230547945..c92a95bdaa05 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1589,7 +1589,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "spi_alloc_master failed\n");
 		return -ENOMEM;
 	}
-	master->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
+	master->buswidth_override_bits = SPI_RX_QUAD | SPI_RX_DUAL;
 	master->mem_ops = &cqspi_mem_ops;
 	master->mem_caps = &cqspi_mem_caps;
 	master->dev.of_node = pdev->dev.of_node;
@@ -1686,7 +1686,7 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,
 						cqspi->master_ref_clk_hz);
 		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
-			master->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
+			master->buswidth_override_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
 		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
 			cqspi->use_direct_mode = true;
 		if (ddata->quirks & CQSPI_SUPPORT_EXTERNAL_DMA)
-- 
2.30.2

