Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C721EDBE8
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 05:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgFDDrF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 23:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgFDDrE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jun 2020 23:47:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A8C03E96D;
        Wed,  3 Jun 2020 20:47:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so2580891pfe.4;
        Wed, 03 Jun 2020 20:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ljd1gL0a9YiLaECGRPUeWMWqu+jwE37ussa58cXejzA=;
        b=KFOe7x6IauMLNFE6HuIGA9laJSc4wQ8x9ZS2Kto1ySLnTDNb85y66ci+0Meqq7qqy/
         5K+adi8U+uMY5S2TtJ8ek0N60iZ5UHt8DrBbU9vN/NlexZkaZSrcsT2mK/VbDiNas0Wj
         55H9G3/nXOALk9OhppEKn1xUs0OMCg+QZ4kbpUTHnewmfqXsjToNh8rMRwoDdTGGKHZX
         sj00WxYzUPlGyf7sDohmvVnRDurXAq2pZso/3HiHo7fVNhSX6hEw2N9J5PdlIw378rqu
         Dt2kAGGlAyb4laYnEodsJ2kr1a9A3bstMmu64hRqIOrRA4bo80PMEwXOLNqBgXzBdAi6
         EjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ljd1gL0a9YiLaECGRPUeWMWqu+jwE37ussa58cXejzA=;
        b=fahz0hmDVyz0gJfrdpIXHf5farpnThBpHqeqRrPNwjDH5Y9RFWz8PCVfvNB0aTTb/u
         38aahd3gQ5Bk8kcYqx9kbzHZvOOOskZGW/o+v+CHZrLvlf2cwYq6EfQqEOUdMrHVJws1
         np8hbK11dW+ridHL2n0a1Qn6Ul4ErihSdphzwuIzAmwyoTpuXi3yXwmQ8Nhn+MtzVoN+
         kWbC4AsFsNooLJLGVmFLH7bxRkuDx2vCHkBI0789J3ZlOSD3yd5qD9Z4m4/QVnoj2n1g
         EzdUwWR7hrmkiRKtoNtLml3wKEVM7kkZSidH5x5YF0i/AKs+pb9eBwFwlsENncI6WhS9
         K0AA==
X-Gm-Message-State: AOAM531xdqo8iGloNj48FBcT6vapus3a/Oxit8F8lL+bS3xstMRjVEAo
        GUEDsrKl+mnnH1R5a3JShHPndlcl
X-Google-Smtp-Source: ABdhPJwNVk3QpeeMpbblNbwAltfHbm6Ih+XSP+R2DYxvoDZBP0fN/cf2VcALRGiRxP0aHkdT0nmoYA==
X-Received: by 2002:a62:e703:: with SMTP id s3mr2151197pfh.43.1591242422257;
        Wed, 03 Jun 2020 20:47:02 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p19sm3083367pff.116.2020.06.03.20.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 20:47:01 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Martin Sperl <kernel@martin.sperl.org>, lukas@wunner.de
Subject: [PATCH 2/3] ARM: dts: bcm2711: Update SPI nodes compatible strings
Date:   Wed,  3 Jun 2020 20:46:54 -0700
Message-Id: <20200604034655.15930-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200604034655.15930-1-f.fainelli@gmail.com>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The BCM2711 SoC features 5 SPI controllers which all share the same
interrupt line, the SPI driver needs to support interrupt sharing,
therefore use the chip specific compatible string to help with that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm2711.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index a91cf68e3c4c..9a9ea67fbc2d 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -152,7 +152,7 @@
 		};
 
 		spi3: spi@7e204600 {
-			compatible = "brcm,bcm2835-spi";
+			compatible = "brcm,bcm2711-spi", "brcm,bcm2835-spi";
 			reg = <0x7e204600 0x0200>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
@@ -162,7 +162,7 @@
 		};
 
 		spi4: spi@7e204800 {
-			compatible = "brcm,bcm2835-spi";
+			compatible = "brcm,bcm2711-spi", "brcm,bcm2835-spi";
 			reg = <0x7e204800 0x0200>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
@@ -172,7 +172,7 @@
 		};
 
 		spi5: spi@7e204a00 {
-			compatible = "brcm,bcm2835-spi";
+			compatible = "brcm,bcm2711-spi", "brcm,bcm2835-spi";
 			reg = <0x7e204a00 0x0200>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
@@ -182,7 +182,7 @@
 		};
 
 		spi6: spi@7e204c00 {
-			compatible = "brcm,bcm2835-spi";
+			compatible = "brcm,bcm2711-spi", "brcm,bcm2835-spi";
 			reg = <0x7e204c00 0x0200>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
-- 
2.17.1

