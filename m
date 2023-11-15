Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C217DFB07
	for <lists+linux-spi@lfdr.de>; Thu,  2 Nov 2023 20:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377359AbjKBTiO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Nov 2023 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjKBTiL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Nov 2023 15:38:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A891AC
        for <linux-spi@vger.kernel.org>; Thu,  2 Nov 2023 12:38:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77891c236fcso80086785a.3
        for <linux-spi@vger.kernel.org>; Thu, 02 Nov 2023 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698953884; x=1699558684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aaUx3IM/nYfDKWStA9Ff2X3zBWfKwgpoaBzpBVRw5U=;
        b=s+3Wx9alGYL3B6GcYlddhun4+VOnzPxSWOLIyS4a5d+mbApD14DHl2S82/O5bKKFF2
         LJrZPN+asfbs9NbxGqjaT2o1y0CDyHTqaLOtHpbZ7bhBTjIazanOUWyqQzxhDfRymnh2
         uA5RbeKN/nxnYRYqr43b2SthVRGvOSySh05T14r1RmCHlvJWzo7W6n4rL8+lhF+JGXG5
         WLJP6mbcupipsbwIZ96Ez4ctnk8GKEYnS8+64/jT9VKhOkKtASTxWt3H14b/YgypWCHx
         rgBB5+nDF2Vyw2QrQlA38MmVWNWqQPk1tyz8Ok+/c0HEAUrYxRoDqmZgiKbjYyPllP68
         SRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953884; x=1699558684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aaUx3IM/nYfDKWStA9Ff2X3zBWfKwgpoaBzpBVRw5U=;
        b=nHW4HQyBVczNRLmQP/4vhoreH2DMlKmfIqhhkkGtOfKaM8rcWhsU3z0Ly2pnzN0yxQ
         WW8Fe+ZcesHoDMBejRQ1gIZOqZX57p3LWLmoOMb5fHd9wBGX744w7wb6T0rB2hFXkQNh
         HjY9l0PfstWLPM7EOD6FPSmV3o2R5dXN8HW5fhDmDlXR3PezOkUMzAOkWFa8EVMCh35m
         NuL1vaaQlkib5DqHHMGweX1wTg6n3vz51IhExIbtLG5Fw+ciSXbGQN8UobTO/28/KqX5
         GkzEkCwtV7WnkrAdXyrNIGzCCVHVByBhaIYPLuyvICEmIhcadfKODe52VCNOpv7qfWE+
         sFsQ==
X-Gm-Message-State: AOJu0YwB9wCSEnKeslZUqPatYK0O2E5vsBT2m3rTPcNk/oVPZ9q4V+5K
        F0U1aHW1KAPgCXE2HMqTNUOXb+2r5liRRklPQ+8=
X-Google-Smtp-Source: AGHT+IGl1n2G2oeUX/4FgvKTLXfhf+P6aEP1OM//x0r4Ln54rPG+Aie8qOEQgGDLVsNuD/9Gag0UxA==
X-Received: by 2002:a05:6214:2688:b0:66d:9f40:4792 with SMTP id gm8-20020a056214268800b0066d9f404792mr26366649qvb.26.1698953884213;
        Thu, 02 Nov 2023 12:38:04 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ce90a000000b0065b260eafd9sm30654qvo.87.2023.11.02.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:38:03 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH v2 5/5] ARM: dts: stm32: add SPI support on STM32F746
Date:   Thu,  2 Nov 2023 15:37:22 -0400
Message-ID: <20231102193722.3042245-6-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
References: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add device tree nodes for the STM32F746 SPI controllers.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 arch/arm/boot/dts/st/stm32f746.dtsi | 60 +++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
index 53a8e2dec9a4..14ba51f2a13d 100644
--- a/arch/arm/boot/dts/st/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -274,6 +274,26 @@ gcan3: gcan@40003600 {
 			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
 		};
 
+		spi2: spi@40003800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40003800 0x400>;
+			interrupts = <36>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(SPI2)>;
+			status = "disabled";
+		};
+
+		spi3: spi@40003c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40003c00 0x400>;
+			interrupts = <51>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(SPI3)>;
+			status = "disabled";
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32f7-uart";
 			reg = <0x40004400 0x400>;
@@ -491,6 +511,26 @@ sdio1: mmc@40012c00 {
 			status = "disabled";
 		};
 
+		spi1: spi@40013000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40013000 0x400>;
+			interrupts = <35>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SPI1)>;
+			status = "disabled";
+		};
+
+		spi4: spi@40013400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40013400 0x400>;
+			interrupts = <84>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SPI4)>;
+			status = "disabled";
+		};
+
 		syscfg: syscon@40013800 {
 			compatible = "st,stm32-syscfg", "syscon";
 			reg = <0x40013800 0x400>;
@@ -554,6 +594,26 @@ pwm {
 			};
 		};
 
+		spi5: spi@40015000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40015000 0x400>;
+			interrupts = <85>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SPI5)>;
+			status = "disabled";
+		};
+
+		spi6: spi@40015400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f7-spi";
+			reg = <0x40015400 0x400>;
+			interrupts = <86>;
+			clocks = <&rcc 0 STM32F7_APB2_CLOCK(SPI6)>;
+			status = "disabled";
+		};
+
 		ltdc: display-controller@40016800 {
 			compatible = "st,stm32-ltdc";
 			reg = <0x40016800 0x200>;
-- 
2.42.0

