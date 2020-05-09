Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92011CBE3A
	for <lists+linux-spi@lfdr.de>; Sat,  9 May 2020 08:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgEIG6d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 9 May 2020 02:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgEIG6b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 9 May 2020 02:58:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA938C061A0C;
        Fri,  8 May 2020 23:58:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v63so2148160pfb.10;
        Fri, 08 May 2020 23:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1+50jpOtQ+yabtvOjIxdeqHbLW4bp1NAnAuKLsw1+do=;
        b=sOlIWa+ptEVcyXiLC/Bxln73BJva7q/80JuA5nMyFbl1isr96GlpRnuLTiIRXGrMvZ
         DBAeaHNoUDtcQUdx/w7pWDMhCtmoHwKGJM4udILbfyd/Sz10R3mBs0h4Ib3hos9TRIXh
         FnT/8XPlv9svitcANdJtArVywaD8oHJbX2QbjXHTm7WU2bX/iuorbNc22YS6L4DjcBKP
         PAaCuTDpQvv53QDfPqZddlPjWdtE6iAHjhOJGlIPlNERtF9zLgJNcgB+dHUawVl0Ta+B
         5D7oeM98d+YhAWeaB6r0qs4zI95n51fa2YMxrCAaYMfT9BmeFjqkN+H7SKPJb/czRjZh
         ue4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1+50jpOtQ+yabtvOjIxdeqHbLW4bp1NAnAuKLsw1+do=;
        b=cUm+/YwTLuCPqD20XpJgH3TlbspvMjJzZAmLkX9rFd/2mXvtp2LiycV2zQPKxOByDu
         /EdW+jogo+tgjaQWw1oWdV5YjEHUvQd6iKSG0iwRXWte7Bqpj1AARAcaBdHVUUcF9tTJ
         rGqeo7EOfpzCW9Zw2xz2rBx2UFK2VagZeb91nQpe+iVz1hXLUqgpgllcKOkr7psC4SJq
         UQgSD7+iLFJS8uZ4JuC+eoiCaZPT/vTE+0h7b+IX+0J0k0PW6P2NRwTRH/st5P/rxcTG
         nhSPmuqzJmxdwzfoHh6csA4lTRB7KX4iaa+ZouqiXO57AoMcRjQFcG/3S63YXSwN4TxN
         Rf1g==
X-Gm-Message-State: AGi0PuaMZYF2rfPnuoe0WF69QYUVq2SlJn9i/s+Taet3WKyTjhDTtAXF
        Pke9yFfL9ZPUXY6e7PEw3tc=
X-Google-Smtp-Source: APiQypInpnXmSjjXJsppu2FYVV/nnWDkxAp8QyIQOIObhx4wp1sle8YpOuNdgiBAcaE2pnKKmuwEIA==
X-Received: by 2002:a63:175c:: with SMTP id 28mr5011956pgx.44.1589007512399;
        Fri, 08 May 2020 23:58:32 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id w192sm3811572pff.126.2020.05.08.23.58.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 23:58:32 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, broonie@kernel.org, p.zabel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, dillonhua@gmail.com,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 1/3] ARM: dts: stm32: Add pin map for spi5 on stm32f429-disco board
Date:   Sat,  9 May 2020 14:58:21 +0800
Message-Id: <1589007503-9523-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589007503-9523-1-git-send-email-dillon.minfei@gmail.com>
References: <1589007503-9523-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch adds the pin configuration for ltdc, spi5 controller
on stm32f429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 392fa14..54c1b27 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -316,6 +316,23 @@
 				};
 			};
 
+			spi5_pins: spi5-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('F', 7, AF5)>,
+						/* SPI5_CLK */
+						 <STM32_PINMUX('F', 9, AF5)>;
+						/* SPI5_MOSI */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('F', 8, AF5)>;
+						/* SPI5_MISO */
+					bias-disable;
+				};
+			};
+
 			dcmi_pins: dcmi-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 4, AF13)>, /* DCMI_HSYNC */
-- 
2.7.4

