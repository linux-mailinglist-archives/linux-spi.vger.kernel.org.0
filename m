Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC1673041
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jan 2023 05:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjASE2r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Jan 2023 23:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjASDoj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Jan 2023 22:44:39 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078214CE67
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 19:41:11 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c26so504331pfp.10
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 19:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ulh9dhCQ0Y1jVBFO0FQi7/v9JSmPpQrHfos2awuevGM=;
        b=GaVHmjsZ+DpWxrEn+ErGek/cfIYIaI/KzyIYazQPM/SB27ypEJbkCgP1UcEg9/VVIs
         eFc5QaFggoPXzVWRuO9sqEFEl1g/f1n4JZJyhvOFCHj+/YuZcMDvjq1k9xocFOTANSIW
         rC9ivBoyyn8GHgBsajv/1IavM5z1F/wrms5h6uz3BvJbbsK0oXfCS2rRG6v/hDHCPtiw
         BEjzWhCVHPGEMG5FUQAvN00kgEpVMROqrb+WmdeHK8b62Kg0yhnuOwLWkdb9jLIqq24F
         5gWXgMOqnLtl7LWPqtj2VU1/HvwFOFH8eJG4lUpN+0uu8FZEGj4H2vXfI7PAAofPRU/0
         qeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulh9dhCQ0Y1jVBFO0FQi7/v9JSmPpQrHfos2awuevGM=;
        b=hG5GCwUcMg79e7AV8kTP+DRekDxp0qBtHqgHSuJSKdxP2IQ00qhJOdkNhvhYe3fuaq
         +HRw9aR6B5uGQsIG5PKBgvsYmSBaATNCz56t0Jf0J8jtb3tjOOJh70hN3nTxbVvkClkn
         xXdnWTmhDaBsy9WhIGvSTLjX1uiMqMjViMC3hHYTw3VhUwgHku6i5zB9dqsaN3+uDQyN
         v2mQG/LDhZRJUTJ3K2/+ZhtT+96rrIIqnUHmPHrEEJslpioeHDwZ6E+E7j9oq3bpMd7Y
         UNe6SNoYjQHJYvHIgbCcktib6RYL7XPgkjcaV7uFZ1BV/dtT+IQ8dRpQ7sPpIlA5qC3i
         XDWw==
X-Gm-Message-State: AFqh2kossGFyJcvLBrirv7uBbwe2ZiZX4KRa6PiYqXKkOtjGPsxFg2YR
        1qnL/pzz8mkirElbx5EWsLXkqw==
X-Google-Smtp-Source: AMrXdXuOBw6fphSPEv9y9CFVXwOwgGsLGFBUJgvOuWSBGXL5pCvmfq2rfonHGrQ7bGCYELnHsyBmZQ==
X-Received: by 2002:aa7:8bd6:0:b0:588:e132:a2f8 with SMTP id s22-20020aa78bd6000000b00588e132a2f8mr9180671pfd.23.1674099668598;
        Wed, 18 Jan 2023 19:41:08 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:41:08 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 12/15] mmc: sdhci-cadence: Enable device specific override of writel()
Date:   Wed, 18 Jan 2023 19:39:15 -0800
Message-Id: <20230119033918.44117-13-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SoCs with device specific Cadence implementation, such as setting
byte-enables before the write, need to override writel().  Add a
callback where the default is writel() for all existing chips.

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- No change to this patch but as some patches are deleted and this is
  a respin the three successive patches to sdhci-cadence.c are
  patches 12, 13, and 14 which do the following:

  1. Add ability for Cadence specific design to have priv writel().
  2. Add Elba SoC support that requires its own priv writel() for
     byte-lane control .
  3. Add support for mmc hardware reset.

---
 drivers/mmc/host/sdhci-cadence.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 6f2de54a5987..708d4297f241 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -67,6 +67,7 @@ struct sdhci_cdns_phy_param {
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	bool enhanced_strobe;
+	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	unsigned int nr_phy_params;
 	struct sdhci_cdns_phy_param phy_params[];
 };
@@ -90,6 +91,12 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
 };
 
+static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
+			       void __iomem *reg)
+{
+	writel(val, reg);
+}
+
 static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 				    u8 addr, u8 data)
 {
@@ -104,17 +111,17 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 
 	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
 	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
-	writel(tmp, reg);
+	priv->priv_writel(priv, tmp, reg);
 
 	tmp |= SDHCI_CDNS_HRS04_WR;
-	writel(tmp, reg);
+	priv->priv_writel(priv, tmp, reg);
 
 	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
 	if (ret)
 		return ret;
 
 	tmp &= ~SDHCI_CDNS_HRS04_WR;
-	writel(tmp, reg);
+	priv->priv_writel(priv, tmp, reg);
 
 	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
 				 0, 10);
@@ -191,7 +198,7 @@ static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
 	tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
 	tmp &= ~SDHCI_CDNS_HRS06_MODE;
 	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
-	writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
+	priv->priv_writel(priv, tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
 }
 
 static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
@@ -223,7 +230,7 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	 */
 	for (i = 0; i < 2; i++) {
 		tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
-		writel(tmp, reg);
+		priv->priv_writel(priv, tmp, reg);
 
 		ret = readl_poll_timeout(reg, tmp,
 					 !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
@@ -386,6 +393,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
+	priv->priv_writel = cdns_writel;
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
-- 
2.17.1

