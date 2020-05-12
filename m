Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951911CEE4C
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgELHhA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 03:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELHhA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 03:37:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C904C061A0C;
        Tue, 12 May 2020 00:36:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x10so5035592plr.4;
        Tue, 12 May 2020 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1+50jpOtQ+yabtvOjIxdeqHbLW4bp1NAnAuKLsw1+do=;
        b=G47sGn4TN89HEfDHIlpV4L/1OTdbO4A512abcr2Q6siKyVvi03Bex0c/ELQlwJIxeC
         tIZpjUJVEe7tdocPqLpuCIdwP37zsuHnu0unHBL/9tyMyfq1xvzsfWMgamvXnH+oueZR
         0oOt/MwLxV7aWWjGONudiPRNYxzkoYYoEw0jmndA2AKTJIZZ7i0UYciPrlJjdTGNVwX8
         L4fm20sFG926zL5N7wAcGAXpX5Ix5B/lirLwhzDXmd8U3B1P/u9toWrSxuaOZ1KI5/gJ
         +rv5oc7F+faxwweAeljXXxhEzJY90igkfcWkaPenQrTaS+0UzDx86i9KAACaGvXOCFo7
         BRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1+50jpOtQ+yabtvOjIxdeqHbLW4bp1NAnAuKLsw1+do=;
        b=PGshP2vQN7KEVdzFBGpaUY64ymL0HUQaa92XbZgklZK4y42a+uzAdUgFwR3hdbvWai
         knkZtQJBKnFF9JEWYyv+pEirq2rBuF7QEP1sBKGmexWQAPCOD+PrBuUoZCUyPYB14ra3
         tbhk6JE90pVyu36pTI3gwY8ngUi7ZTJ7tSEUvtrzWI9415SQfhwSTuMHtZLu8VRkxGgi
         1APqYvwLackl87l5/s5glXiqPe5D1iWwGANogRdG8+7LRiD50gxb9tqaqqA4WvidQLVj
         b41XJnn4kVFmtqqf374S1lWh6/eWmGUUNVgYXCbBRiJtHLmrjLExybGynMvrOh0h7YhL
         BV3Q==
X-Gm-Message-State: AGi0PuZUYjaCBI9LfPVsV0x6h8xFlhr29RRDtVyPeBMZEb3mg4yrDuq0
        zKBn/vfc3h1TtwsoNyHBAIQ=
X-Google-Smtp-Source: APiQypIro3QqgqzACddslZcezZZ3teK8Kwq4T65hw26DXUKtwZPMtU58nk+jjImORx23aPyHjnHRfg==
X-Received: by 2002:a17:90a:7046:: with SMTP id f64mr24142240pjk.205.1589269019133;
        Tue, 12 May 2020 00:36:59 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id 5sm11732471pjf.19.2020.05.12.00.36.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 00:36:58 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, broonie@kernel.org, p.zabel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, dillonhua@gmail.com,
        dillon.minfei@gmail.com
Subject: [PATCH v2 1/3] ARM: dts: stm32: Add pin map for spi5 on stm32f429-disco board
Date:   Tue, 12 May 2020 15:36:48 +0800
Message-Id: <1589269010-18472-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
References: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
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

