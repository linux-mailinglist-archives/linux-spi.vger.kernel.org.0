Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098A31D760D
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgERLJp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgERLJo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 07:09:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC01C061A0C;
        Mon, 18 May 2020 04:09:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k19so4082869pll.9;
        Mon, 18 May 2020 04:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ywJR2u0sxzCry1AhZGxYacIrf0h0wV/3/P70ewifITY=;
        b=lsv+ci5O3BF5pp/Fzm/71bOqUhzwDhdV6mf6dmUZaX8uo7eiJj/O+bcYSv7PKy+8ty
         F6Jd/TsIHQfj5p/2VSeALGViY//PoM9iSxbRxo/QhYUCAkBuvp+pZVb3S8A6h56MIJma
         Rw7hOJo1IldF2kRvbRkdap29xtOomIqWhbV6Bk+reqa3cq6T2Xwzee2Z0+JMiiEvlSUb
         zAey2q/StEBydV5XSapPsH+hiTMxklq/qW7VLynMmIya4v1AcpH5tRzILJLSkUgNyBnu
         UHB9dw9Q7plOKVWzHLip2o679jj2TVpXaij9RfG76b9aKjARBZkn2+ZM2oQKU4HFn0tr
         M5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ywJR2u0sxzCry1AhZGxYacIrf0h0wV/3/P70ewifITY=;
        b=hwVrbXG0edfASYrsIZ155GJDU3dtld0sFDBsf1NYjb6yu2YFEGZiKPyarmU3Is41dq
         DeK3InImC6Z8FKAQnJeIUMvMzL8IyYdQCdl5IviN7OiUb+mi8aM3zAQBTm+LPQXpv4Ye
         jnm/JhKxByj+tTRtc0yvjqL5hQGp/BCrCVEdPMgqr1QfVgcIKVQjddjZt8l86eOnRAkd
         9xbPU2CcmV4eT5YpYxSKzF4kmKyJAkN9cXxK9Xx6TXwbxV+wwumVhCoy32m7um1rPFrm
         K/wU6xyP+WZcr1eRcnLZ49/KTcux2wrB792n/xjxN2PSEaeUWfr8s+IzpmGldxBFKUpd
         sOkA==
X-Gm-Message-State: AOAM530TMLGHV6rjt1ln0XKDA4EzqDJH6f+msoPrynJPz9j/3DkO1tVb
        O0/k2DMTdTD2GSuqZ818N88=
X-Google-Smtp-Source: ABdhPJwCSYCh/1rzKVFG/X/BBP7KphC+GH9RMiQtvUBzCQoZyfTGn1DBeXe1tcs+tZRW+3x1Osg33w==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr16338427plq.84.1589800183045;
        Mon, 18 May 2020 04:09:43 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id a15sm8290630pju.3.2020.05.18.04.09.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:09:42 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 2/8] ARM: dts: stm32: enable l3gd20 on stm32429-disco board
Date:   Mon, 18 May 2020 19:09:19 +0800
Message-Id: <1589800165-3271-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

L3gd20, st mems motion sensor, 3-axis digital output gyroscope,
connect to stm32f429 via spi5

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

