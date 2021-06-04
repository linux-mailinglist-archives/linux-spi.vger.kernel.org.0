Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315C039BB7C
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFDPOB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:14:01 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36394 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFDPOB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 11:14:01 -0400
Received: by mail-oi1-f170.google.com with SMTP id a21so10084251oiw.3
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za/Y7MXEJhVfJxix2rC6+OPvATSxOzABFwX8N4L6d/Y=;
        b=SMWznNsizO2hohyPrP6PEcwM9Uu7usTTW+xf1XScQfcKLdMvf35oThs0NlOU84o3mF
         ZZYFXi8q01mRkHJEzD+FOLmuweLTR4QLkSySA6zbzCbQaBYI40pe+9236Berfgy7CnEY
         TrtXJzuumu1fGhim8wvvL62U8DHg7G6Lkar6G87VPaJUdRepov8KqWj0f22AFjtHP9CP
         DA46CnY0H//ekab+b3Oa3Ajp4S5WE9PsGFvsqsTYND1wrowFTBrD1QEz7xmeLDctSIK0
         obC9uoSlAZ4MV31KN8BPd5F8cjg2ViccGV3VZQKwR15oUSVunHB2YroRRLBT6cPYrwiJ
         3Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za/Y7MXEJhVfJxix2rC6+OPvATSxOzABFwX8N4L6d/Y=;
        b=GJ6dSHkYvmSTM7DUFlhSC8OLw2zHIGY2kdMw0Lf1/FJT2slMb+L3/eLFFBMHfFh7aL
         F/88JFFH6sQDDgefsRFyHam5SQURN/H0HWNKX4wtHaFK7gR6ij4BNujfyOm+IOpHLM2X
         V74d8c00F/xmqvJlC70au0fsK4GeRPW6zOg1ti8v4uQaYua2bxN//m/Hy9McIxGZF7v1
         wDfMdz0JaJ9GrYqk0elH0aLVluYk7HK3hBgGXlKBa8FNIM2iC5z1N+eFpeeHHVL70krb
         O59R8TUJZgtyy05xIetp8lX8ndwG2jJ/6drduDzyJRWIaZAa0B1VDLhh4ZAvfHfGpTda
         +2Aw==
X-Gm-Message-State: AOAM532MCxDVAy48XOSeg8yoO4LB95LFF3tHzi+Q8hQNoNH2p98KmZjh
        sHH+d8K5rSz160FKBqV/KTMLPWYNRwY=
X-Google-Smtp-Source: ABdhPJzJSbGDUnw7PXR67GZz6QBZdYUZsnqLXf0hDVgXaEPAro6BxeKWV7O5Na477GgRdfoj1nGStA==
X-Received: by 2002:a54:400a:: with SMTP id x10mr11674852oie.158.1622819473377;
        Fri, 04 Jun 2021 08:11:13 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id k16sm523440otp.19.2021.06.04.08.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:11:12 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v4 4/8] clk: rockchip: Add support for hclk_sfc on rk3036
Date:   Fri,  4 Jun 2021 10:10:51 -0500
Message-Id: <20210604151055.28636-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604151055.28636-1-macroalpha82@gmail.com>
References: <20210604151055.28636-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the bus clock for the serial flash controller on the
rk3036. Taken from the Rockchip BSP kernel but not tested on real
hardware (as I lack a 3036 based SoC to test).

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/clk/rockchip/clk-rk3036.c      | 2 +-
 include/dt-bindings/clock/rk3036-cru.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 91d56ad45817..ebb628733f6d 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -403,7 +403,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	GATE(HCLK_OTG0, "hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 13, GFLAGS),
 	GATE(HCLK_OTG1, "hclk_otg1", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(7), 3, GFLAGS),
 	GATE(HCLK_I2S, "hclk_i2s", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
-	GATE(0, "hclk_sfc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS),
+	GATE(HCLK_SFC, "hclk_sfc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS),
 	GATE(HCLK_MAC, "hclk_mac", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 5, GFLAGS),
 
 	/* pclk_peri gates */
diff --git a/include/dt-bindings/clock/rk3036-cru.h b/include/dt-bindings/clock/rk3036-cru.h
index 35a5a01f9697..a96a9870ad59 100644
--- a/include/dt-bindings/clock/rk3036-cru.h
+++ b/include/dt-bindings/clock/rk3036-cru.h
@@ -81,6 +81,7 @@
 #define HCLK_OTG0		449
 #define HCLK_OTG1		450
 #define HCLK_NANDC		453
+#define HCLK_SFC		454
 #define HCLK_SDMMC		456
 #define HCLK_SDIO		457
 #define HCLK_EMMC		459
-- 
2.25.1

