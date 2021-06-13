Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820433A5AF9
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jun 2021 01:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhFMXdj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Jun 2021 19:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhFMXdj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Jun 2021 19:33:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CE9C061766;
        Sun, 13 Jun 2021 16:31:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso11712942wmj.2;
        Sun, 13 Jun 2021 16:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lr00zhwGwG4GL85hsYk0DjVuGde5MrGHUlbq816anbQ=;
        b=SKuPsRvX/oKpVnvtfkkVIm4w3z/RIU4efHyzUPW2ZF+FOJ3TrQZL9neN0fCu7HcjIH
         wlm9ZT+Y0mbtcRT+NJuJY9zmbrxdxMUy/2KOthm0Mi/lGYa998mTOXYaO9IvVZbkq9vQ
         XbN7dDfHw6pc0IvTBAGvxW+2nHeBqKfflUS1uLw76XVvT253b5GDR3S/gd2ckiOfQNSm
         wwjbz4xFLA98AAE7yvZ7BfGTQhEnppOck1pneyCsnphL5k9uCIy+zNjsXYAv4Of11AsR
         QMOVwUG8qRtaSj3nV5vBaxQlb03zgm7inrrVJXKgb0jMVA5DIp66rX+jaYmrTonalgf8
         s9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lr00zhwGwG4GL85hsYk0DjVuGde5MrGHUlbq816anbQ=;
        b=tBycTo3VSCNzELDm0hkP/LxG6KtJ6ILQ1EpwV1IYad/vzrSsUKBb1nhpzx5g9Rz9rP
         twQq/IMz0aRj9kQtItKORIRrtyLGScwaGwgI03njozoqHJP/iQFzXMOT3UEK7w821Lys
         Ih3sD7HF+4nckjWM7XgzHYOSJbgBoPopui3NfQsozpaV/14jS+/TkMeXDZiJqLYyCLl4
         LGhsm0tr96oUd7JYxjtZyFGsSnc3qN1cZIWsBE4ZJH/1JFGnlcjRzgeXZ6vFGJU9uWid
         uGykqu6mqG2WDWplVVtypGfGkerigYZuHngVmxsf3HnX5lC3nsX7ijJesbOSJEOi8w/m
         yF2g==
X-Gm-Message-State: AOAM532lhon95l3beJtOHhGZ/JcgxyVXGSrggYG7Gj7VLhG1/1M85Dg1
        X5dw9ONbpWR7K+pd2wQWRMs=
X-Google-Smtp-Source: ABdhPJz8wAQLW+ssDQcjo0EjSi/belsFbqh/retmg1dMepV3cUAwYS5soAFTxr2wNaW3kbHdlPhNzA==
X-Received: by 2002:a7b:c20a:: with SMTP id x10mr13249392wmi.141.1623627081516;
        Sun, 13 Jun 2021 16:31:21 -0700 (PDT)
Received: from localhost.localdomain ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id i9sm17882511wrn.54.2021.06.13.16.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 16:31:21 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-spi@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] spi: spi-ep93xx: Prepare clock before using it
Date:   Mon, 14 Jun 2021 01:30:36 +0200
Message-Id: <20210613233041.128961-3-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared ep93xx-spi.0
CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.13.0-rc5-... #1
Hardware name: Cirrus Logic EDB9302 Evaluation Board
[<c000d5b0>] (unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
[<c000c590>] (show_stack) from [<c03a5f38>] (dump_stack+0x20/0x2c)
[<c03a5f38>] (dump_stack) from [<c03a2098>] (__warn+0x98/0xc0)
[<c03a2098>] (__warn) from [<c03a2150>] (warn_slowpath_fmt+0x90/0xc0)
[<c03a2150>] (warn_slowpath_fmt) from [<c01d8358>] (clk_core_enable+0x9c/0xbc)
[<c01d8358>] (clk_core_enable) from [<c01d8698>] (clk_core_enable_lock+0x18/0x30)
[<c01d8698>] (clk_core_enable_lock) from [<c023eeb4>] (ep93xx_spi_prepare_hardware+0x10/0x30)
[<c023eeb4>] (ep93xx_spi_prepare_hardware) from [<c023c0f8>] (__spi_pump_messages+0x124/0x620)
[<c023c0f8>] (__spi_pump_messages) from [<c023e5b8>] (__spi_sync+0x280/0x2c0)
[<c023e5b8>] (__spi_sync) from [<c023e61c>] (spi_sync+0x24/0x40)
[<c023e61c>] (spi_sync) from [<c021f8a4>] (spi_sync_transfer.constprop.0+0x64/0x8c)
[<c021f8a4>] (spi_sync_transfer.constprop.0) from [<c021f914>] (regmap_spi_write+0x48/0x70)
[<c021f914>] (regmap_spi_write) from [<c021c320>] (_regmap_raw_write_impl+0x640/0x740)
[<c021c320>] (_regmap_raw_write_impl) from [<c021c49c>] (_regmap_bus_raw_write+0x7c/0xac)
[<c021c49c>] (_regmap_bus_raw_write) from [<c021bbd4>] (_regmap_update_bits+0xec/0xf8)
[<c021bbd4>] (_regmap_update_bits) from [<c021dac4>] (regmap_update_bits_base+0x50/0x7c)
[<c021dac4>] (regmap_update_bits_base) from [<c0290ea8>] (cs4271_component_probe+0x74/0x148)
[<c0290ea8>] (cs4271_component_probe) from [<c02889b4>] (snd_soc_component_probe+0x24/0x74)
[<c02889b4>] (snd_soc_component_probe) from [<c027e9d0>] (soc_probe_component+0x11c/0x29c)
[<c027e9d0>] (soc_probe_component) from [<c027ef14>] (snd_soc_bind_card+0x3c4/0x8a8)
[<c027ef14>] (snd_soc_bind_card) from [<c0291798>] (edb93xx_probe+0x34/0x5c)
[<c0291798>] (edb93xx_probe) from [<c02126e0>] (platform_probe+0x34/0x80)
[<c02126e0>] (platform_probe) from [<c0210bf8>] (really_probe+0xe8/0x394)
[<c0210bf8>] (really_probe) from [<c0211464>] (device_driver_attach+0x5c/0x64)
[<c0211464>] (device_driver_attach) from [<c02114e8>] (__driver_attach+0x7c/0xec)
[<c02114e8>] (__driver_attach) from [<c020f1b4>] (bus_for_each_dev+0x78/0xc4)
[<c020f1b4>] (bus_for_each_dev) from [<c0211570>] (driver_attach+0x18/0x24)
[<c0211570>] (driver_attach) from [<c020fab4>] (bus_add_driver+0x140/0x1cc)
[<c020fab4>] (bus_add_driver) from [<c0211c44>] (driver_register+0x74/0x114)
[<c0211c44>] (driver_register) from [<c02134f8>] (__platform_driver_register+0x18/0x24)
[<c02134f8>] (__platform_driver_register) from [<c047084c>] (edb93xx_driver_init+0x10/0x1c)
[<c047084c>] (edb93xx_driver_init) from [<c045ce88>] (do_one_initcall+0x7c/0x1a4)
[<c045ce88>] (do_one_initcall) from [<c045d184>] (kernel_init_freeable+0x17c/0x1fc)
[<c045d184>] (kernel_init_freeable) from [<c03a64d0>] (kernel_init+0x8/0xf8)
[<c03a64d0>] (kernel_init) from [<c00082d8>] (ret_from_fork+0x14/0x3c)
...
spi_master spi0: failed to prepare transfer hardware: -108

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/spi/spi-ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index aa676559d273..5896a7b2fade 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -550,7 +550,7 @@ static int ep93xx_spi_prepare_hardware(struct spi_master *master)
 	u32 val;
 	int ret;
 
-	ret = clk_enable(espi->clk);
+	ret = clk_prepare_enable(espi->clk);
 	if (ret)
 		return ret;
 
@@ -570,7 +570,7 @@ static int ep93xx_spi_unprepare_hardware(struct spi_master *master)
 	val &= ~SSPCR1_SSE;
 	writel(val, espi->mmio + SSPCR1);
 
-	clk_disable(espi->clk);
+	clk_disable_unprepare(espi->clk);
 
 	return 0;
 }
-- 
2.32.0

