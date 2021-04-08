Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A37357D9A
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 09:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhDHHvA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 03:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHHvA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Apr 2021 03:51:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C7C061760
        for <linux-spi@vger.kernel.org>; Thu,  8 Apr 2021 00:50:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w28so2425249lfn.2
        for <linux-spi@vger.kernel.org>; Thu, 08 Apr 2021 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6U45pNdM0qN4a1O10k6aqNmRvSwq7HC5E/CC+/6kbdY=;
        b=XRR7rBXeebmDkxmYIYN5rgebwUcGncYOZ/PtkC0j6YsuR86lapKeh9k4XFXaGaij0Q
         Mtg8Odet2Ylc4ejK8w+BGU5HatAvS9MHUSI3u7WeBzvWbCZ1rFUYMKzZ228J7+iAPdGE
         hxWZQ6/neNSpnTXs8BnkGCPJYEuP8ex/ksnjMmD2QP1mUEt/kuSsiLyHNLh9hT7Gcq2i
         6qK6Q1t7b46s0onC+usETpAMoEvkmgCm5W/cM4GR7MjW2Wa03G4Oz0490Q+FWMIy/hoJ
         X4Krso3ijAvumBIbYB9FL53tp6lpfji0dhBaGETduQsqJ4ssQr3rL56z/NDDxwU39pQz
         rG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6U45pNdM0qN4a1O10k6aqNmRvSwq7HC5E/CC+/6kbdY=;
        b=sS27P683Fm04IA9J769ifgMqdy3s8BHaMWRYoAmaSLC51ddeg1IVvlxj/j8Hp5EHRQ
         i33zzSNBnA/WC1+Gbqc8JtvLdzVcCVYqgr2tvP5kTLsax2YazGG2rUguaU1cfWKBO2xd
         NmC9V4UV1uHSk0sE+XFnNmipbUY4V6nLdR0GbanKNqcLnTiluEVHa04WcDcQHbeLB2ZD
         /6WggqdJLQhYwxgRCtEMpwvgNQtzEQ2B/jKdbI2MmOdr8QCpmF1DPjgkgYOyQqOwynCK
         UM2FTHLAPYswD+CaBlElW8pIDWBr2wFJsdDmbRFnKndH1xY0Br2PU5op2QtfLVW62RJk
         ITzA==
X-Gm-Message-State: AOAM530bmMehRtZFskW/LmUW8gVgP/JIJg90YpP1QgR/UeVab/LVu9EZ
        Q7aJ+DT2kAHpVj9D8iXKHOGUTw==
X-Google-Smtp-Source: ABdhPJxschS7sHftq6y4Nq9zxIS/tz3Z1oIIE6idpIyBg0/cTsqk75eWFELbJzLgDos498C6xETIAw==
X-Received: by 2002:a05:6512:1102:: with SMTP id l2mr5243471lfg.501.1617868247771;
        Thu, 08 Apr 2021 00:50:47 -0700 (PDT)
Received: from localhost.localdomain (c-14cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.20])
        by smtp.gmail.com with ESMTPSA id x13sm2777709ljj.4.2021.04.08.00.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 00:50:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM/spi: spear: Drop PL022 num_chipselect
Date:   Thu,  8 Apr 2021 09:50:45 +0200
Message-Id: <20210408075045.3435046-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

A previous refactoring moved the chip select number handling
to the SPI core and we missed a leftover platform data user
in the ST spear platform. The spear is not using this
chipselect or PL022 for anything and should be using device
tree like the rest of the platform so just delete the
offending platform data.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mark: please apply this as a fix to the SPI tree unless there
are protests.
---
 arch/arm/mach-spear/spear320.c |  2 --
 arch/arm/mach-spear/spear3xx.c | 10 ----------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index 0958f68a21e2..926d5a243238 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -195,14 +195,12 @@ static struct pl022_ssp_controller spear320_ssp_data[] = {
 		.dma_filter = pl08x_filter_id,
 		.dma_tx_param = "ssp1_tx",
 		.dma_rx_param = "ssp1_rx",
-		.num_chipselect = 2,
 	}, {
 		.bus_id = 2,
 		.enable_dma = 1,
 		.dma_filter = pl08x_filter_id,
 		.dma_tx_param = "ssp2_tx",
 		.dma_rx_param = "ssp2_rx",
-		.num_chipselect = 2,
 	}
 };
 
diff --git a/arch/arm/mach-spear/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
index 8537fcffe5a8..f83321d5e353 100644
--- a/arch/arm/mach-spear/spear3xx.c
+++ b/arch/arm/mach-spear/spear3xx.c
@@ -30,16 +30,6 @@ struct pl022_ssp_controller pl022_plat_data = {
 	.dma_filter = pl08x_filter_id,
 	.dma_tx_param = "ssp0_tx",
 	.dma_rx_param = "ssp0_rx",
-	/*
-	 * This is number of spi devices that can be connected to spi. There are
-	 * two type of chipselects on which slave devices can work. One is chip
-	 * select provided by spi masters other is controlled through external
-	 * gpio's. We can't use chipselect provided from spi master (because as
-	 * soon as FIFO becomes empty, CS is disabled and transfer ends). So
-	 * this number now depends on number of gpios available for spi. each
-	 * slave on each master requires a separate gpio pin.
-	 */
-	.num_chipselect = 2,
 };
 
 /* dmac device registration */
-- 
2.29.2

