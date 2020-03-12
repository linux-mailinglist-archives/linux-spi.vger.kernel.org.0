Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA1183174
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 14:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCLNbl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 09:31:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36667 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCLNbl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 09:31:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id s5so7513670wrg.3
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2020 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPH/Dy/CjLCenRWLG2Luxl8lE2WdXQS9qh3kQnsN4TQ=;
        b=hUCDqIj0/ip1fGR0w8g9JiTgR3VggFXz6uXZBIuxQFF8RI6pPBFb0oKUQZqohHTRzJ
         EHaOdl7mpyqXAh2wOch+xrBgXcNlimpN9pUcYfJPjcxIWvdkyqbSg9NQI7L5ScEkAZB4
         rMQWh59snVY+t+sBELnc4M5c4DmKQy+T/hQ5cw5ip7/2BS8wARxIRgItz7sfFyakw9vk
         mlBrjYp4ALqFRuMLjLg7MJ0VyZcGPi4hjaD+7P3BdyiA5CPOMY/d5Ix0Gesh38EQ24E6
         X5/Ga0uTigrBvfoDF9cVkNYXejKr5vaVSAdDmf2Fc1HVBFXkq/IRQFrjALiYCP+VQjwE
         a/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPH/Dy/CjLCenRWLG2Luxl8lE2WdXQS9qh3kQnsN4TQ=;
        b=FW0z0pCs/Xjl1HU8pFUCakMMDrXvfjF1gBgXq3iTxPE5u3ILdfh6a1GfJhZ+CM01IG
         gWibYvUAYAHx6JdtKb0QMoQG9FbQRj1RZ8AmW62xv1j1Ix1C53MXfdyCuUnhJ3KRo1GL
         Ff9VpKsE3+vEcA+VTQzo1bixfa+2KQpyfpra/3yRevGCGrxRGhOoMBUGpvmkHZOzrEsy
         hCwsCScalI4LY4INvYOz9/5lbkNCD1flVmou3rmvfbRPrbwXu2lNtY4tuI2K6D7GwK+f
         qSxj+qx5uWZNN0Nkz2A6a1NoPC58+lSQRucX+ElEJet986wp6f30R8ZlgKZrNRNqpmt7
         sQTA==
X-Gm-Message-State: ANhLgQ3KcmpHSznhaMD1ikMe+ojQdS++FVl39FCGIQTCV3AkR9U05dtY
        RFvX8P+wplPyKnxDvNxc/EAYQg==
X-Google-Smtp-Source: ADFU+vvDGHCmjJAEW09IY2pn/rC0cuKnx5wPrdhmLydsBiF7dyxe06aMf+3l/75LbVxspehBFH2Fng==
X-Received: by 2002:adf:e911:: with SMTP id f17mr10602906wrm.87.1584019899241;
        Thu, 12 Mar 2020 06:31:39 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] spi: meson-spicc: add min sclk for each compatible
Date:   Thu, 12 Mar 2020 14:31:27 +0100
Message-Id: <20200312133131.26430-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200312133131.26430-1-narmstrong@baylibre.com>
References: <20200312133131.26430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The G12A SPICC controller variant takes the source clock from a specific
clock instead of the bus clock.
The minimal clock calculus won't work with the G12A support, thus add the
minimal supported clock for each variant and pass this to the SPI core.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 710b4e780daa..b5bd3a897e8f 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -132,6 +132,7 @@
 
 struct meson_spicc_data {
 	unsigned int			max_speed_hz;
+	unsigned int			min_speed_hz;
 	bool				has_oen;
 	bool				has_enhance_clk_div;
 };
@@ -685,7 +686,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 				     SPI_BPW_MASK(16) |
 				     SPI_BPW_MASK(8);
 	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
-	master->min_speed_hz = rate >> 9;
+	master->min_speed_hz = spicc->data->min_speed_hz;
 	master->setup = meson_spicc_setup;
 	master->cleanup = meson_spicc_cleanup;
 	master->prepare_message = meson_spicc_prepare_message;
@@ -736,10 +737,12 @@ static int meson_spicc_remove(struct platform_device *pdev)
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
 	.max_speed_hz		= 30000000,
+	.min_speed_hz		= 325000,
 };
 
 static const struct meson_spicc_data meson_spicc_axg_data = {
 	.max_speed_hz		= 80000000,
+	.min_speed_hz		= 325000,
 	.has_oen		= true,
 	.has_enhance_clk_div	= true,
 };
-- 
2.22.0

