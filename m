Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E355D1A9
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiF0Jpu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiF0Jpr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 05:45:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13C6390
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 02:45:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ay16so17945472ejb.6
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOM4uBpjoRyrBuD75f9zY98ri1MNJqUrdS279t95jyI=;
        b=HtwfbijywEnyhZiyXyHDF8ZyRkA/74CcMliWnKNk1HA3ZYUhGS+qDoC7zLO5JE+sb7
         XjbtB2e1Vf9sLcwW1CV4eTD/uHg0AVPCk+5R9DDAt5sLv0jnRkfV1xgE0RM8mdSx3IUF
         aLtwEPG3wBYfFtxX8fz9xbqXcJAWkamtqf0S9kcvzq5u98nYfdHGyeMSpX1Ta/8THjEC
         907BS8+vNC7iJcX020no7Bj+ogBziY+MLVywrvXamFvx0nUsbhtZ5cXLqXM83FmzubHl
         o/S61Oe9x9yCMZTqImukOJQ6fw/LQbkJ5V7s1EK2yqTNE7S5EtDgI7nesmPLP5OfZzUr
         Ckkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOM4uBpjoRyrBuD75f9zY98ri1MNJqUrdS279t95jyI=;
        b=K6sNI+djVFqYJr1RkoXmIIb6PLRCDcPQsRBZPc9JUk+AkGY/FmAVbMIQnzHSSAjuVS
         7zgSz2JB3n0D3loHitEOAskeHX2HicDVlYQf9wtmLQgeYhH/0IqaVDgDGYB7FbgQBvA2
         1BuoE6PcRwfLHx/LYHCExmLyMnDN4cbnbu81onspoitdFNM2axaBmE1rGICzGAmXj811
         KNNPlhQyNT/shvPMzY+P88JdXtqrf+5/06ZtiVWicDtRo57bkY5G3YzL5EEkAVmPN9la
         o6V5yiU0odhIrzrYud+DNohV660Yyd7CZKTqyNailEK73dldqOMO3UCdRmEJLtixjQt+
         Avaw==
X-Gm-Message-State: AJIora/ujmV8u4YGke1NuWjbbP2GBaq2rUQ8tYRorinyxHyGy9KnKsI1
        L4DfsmhoLZm02qg9DasmDVv4Vg==
X-Google-Smtp-Source: AGRyM1tXAXrzh2lfaT89gjC9w/IEcbCwI5549GpsimLV4qylK/qfZfxq1Hk84cBf/Vhl8eQGtJtfMw==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr11631366ejc.243.1656323144363;
        Mon, 27 Jun 2022 02:45:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402005a00b004358f6e0570sm7223331edu.17.2022.06.27.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:45:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] spi: s3c64xx: constify fsd_spi_port_config
Date:   Mon, 27 Jun 2022 11:45:41 +0200
Message-Id: <20220627094541.95166-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

All struct s3c64xx_spi_port_config should be const.

Fixes: 4ebb15a15799 ("spi: s3c64xx: Add spi port configuration for Tesla FSD SoC")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 819b660dae82..499c56dd875e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1421,7 +1421,7 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
-static struct s3c64xx_spi_port_config fsd_spi_port_config = {
+static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
-- 
2.34.1

