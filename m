Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D481E3A56
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbgE0H1r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 03:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgE0H1q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 03:27:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44574C061A0F;
        Wed, 27 May 2020 00:27:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so1136098pju.3;
        Wed, 27 May 2020 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UETiT/+hv4pHR/FxQpN8ElBZpgtWRVFOPMtYdets/m0=;
        b=adRZeb9Lm9Mw5bBmtIfv6dbOePFDu2sMfBHHzfZKYcv8RFY4FDsx76Z2h7qVYFEcFA
         SiAtTZRpKiu6ZGk28yBVC+DlKWd/LxQaSRsvi1xHYD+8SldaaJZSs3WvbxZpflRB0qJ/
         K1psQWI9snmWeyfED0jbFki2a2fiRcYvv8DPDMY2QdjMmij/oQmu7PB8aXeHhCbsto+W
         5BBXh/bQMYCLbQHkrl4NdUaBr+/5rI+/dkc2oxIch/OhpNYLJoF4GzDi5/UtkfDwYSdQ
         LZHeiRvVNBWyAszvLuEfCkcnjKxTn767Co+SsHu0pNEh4sS1CsjP7Ydsad+v7/0w7nhs
         P6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UETiT/+hv4pHR/FxQpN8ElBZpgtWRVFOPMtYdets/m0=;
        b=di8Pv6q4vibCvYqnXiBbVGY3q+vT7+SFfTb6wFEKUv1ESjqgAYqxYkB1diulo1ohkG
         bfs+YQfHpJ0hhs9wzUgwwaCN3lyj/1l8HZgkEk1FbKU2p1n2NSt5reF5D2C9R7ADty5m
         CyqmIrdqXqXZRMje+bEA82DSXyPujmCx5wSAghrjow03TU2ExbvNYb/MHFaz5C6U43Ul
         YGmm52zwCBzXaFUVmTcfw+yRtPjlSGTNs/pSrnsiArF3FtfoeF/pUrgFwkOobEKD0Kk6
         2BkQ6LE2V6kchmdsTSvOWujIRNxAx4YddTJ4c3/58WExXCkWAcRtUNCquRBkKk6plA98
         M9kw==
X-Gm-Message-State: AOAM532HI9+V//noU0Ll8+IR/LJc0XjX6LOiOuhSuJ6gO+HX9lSXtu66
        FKINs5oVwt3RUkxuCSvjLX4=
X-Google-Smtp-Source: ABdhPJz5gbkJ79n4grpbJ62IF8L3aiqo8pVw26w3l2Nkc2Ney24Q3/bI3BZNPFN2Svinwt0qeTx7Ag==
X-Received: by 2002:a17:90a:a017:: with SMTP id q23mr3572709pjp.4.1590564465807;
        Wed, 27 May 2020 00:27:45 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id q201sm1371842pfq.40.2020.05.27.00.27.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 00:27:45 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        andy.shevchenko@gmail.com, noralf@tronnes.org,
        linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillonhua@gmail.com, dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v6 1/9] ARM: dts: stm32: Add dma config for spi5
Date:   Wed, 27 May 2020 15:27:25 +0800
Message-Id: <1590564453-24499-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable spi5's dma configuration. for graphics data output to
ilitek ili9341 panel via mipi dbi interface

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index d7770699feb5..5820b11e7365 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -660,6 +660,9 @@
 			reg = <0x40015000 0x400>;
 			interrupts = <85>;
 			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI5)>;
+			dmas = <&dma2 3 2 0x400 0x0>,
+				<&dma2 4 2 0x400 0x0>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.7.4

