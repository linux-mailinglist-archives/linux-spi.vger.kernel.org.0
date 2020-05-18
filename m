Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22BA1D760B
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgERLJi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgERLJi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 07:09:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42347C061A0C;
        Mon, 18 May 2020 04:09:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nu7so2444954pjb.0;
        Mon, 18 May 2020 04:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=STuSyGO/SfkcGFSauy0QHw5IqCNUH9D9huZMTiB2y2k=;
        b=dsYJfxLEd6xbVQlENcWPZzU+WfiP29b3NMO5WPeGK9V/39gTQ7A+H7bFPOu4Kv9N1r
         6IDQH14A5+eKS7P5FL0Sq/5SiYYqyMtcIxg2wrkQN4/A17gljEPX0iDZllkLx9w6/bO6
         +TwDy196nfJdIdS9ROL+TE2Jw5nc3tgtYxhQDGvjdo0FciStS01boz11hBGliU01WiC4
         K+KGnpLlMie0QC8MqcgIsvYASooQm1WAdJ7Lso/HjuXkQZCifiOc7i/ODp6kXbNBzdsb
         rzb/jmP35rtmcaRxVvcZah+syxO1XpzSaSwS1ndM7XP2cqA1meMSUDpuTvbSaH3QF2Bf
         fOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=STuSyGO/SfkcGFSauy0QHw5IqCNUH9D9huZMTiB2y2k=;
        b=sHZ13vE1MF4nhbCAbK6EYHVXkav/5TyGPLuITu2+t0GJUVv4Rc214xoTtNr9Poic+n
         NBv4Y2Y1ZhpYRGxoz4+Hou3D0Vt7mvyosJE7jANWYD0uF+ORi7xGxJZmcm2+TRvHNHzX
         aVhtpvc+7Bpp5QcX8eo7eqTYCzGXwiAH6pWIHbScKjibzzFZaywIworAGgTu5TFE3Gr9
         65Vl262G4qBRSJttmYhBA0E/j/QYHJa+2jrrzq+XrFV5W6TyHR6RPDX2C84jAZ6VBxtC
         20gt8q9+fsL6HdapwnxBv51tKCHKdmz0VxftDOKSsfNxCU5d4SaV6mGO+8BXIRVqRd3S
         jMgw==
X-Gm-Message-State: AOAM533ZEq3k731Flo5JdYc7DpaiCmpTsZF/Pd8ok2Z/9Zeztslb+NDu
        W4lI32FQ8pHldj1woxuueDk=
X-Google-Smtp-Source: ABdhPJy4R9lorCsfCy2+A+sDPo3PPj1Wk+rtgXPYIIzgip88QiSihh3BtYXToRutgkUN36Ums0zoEQ==
X-Received: by 2002:a17:90a:f098:: with SMTP id cn24mr6322869pjb.201.1589800177920;
        Mon, 18 May 2020 04:09:37 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id a15sm8290630pju.3.2020.05.18.04.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:09:37 -0700 (PDT)
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
Subject: [PATCH v4 1/8] ARM: dts: stm32: Add dma config for spi5
Date:   Mon, 18 May 2020 19:09:18 +0800
Message-Id: <1589800165-3271-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
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
index d777069..5820b11 100644
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

