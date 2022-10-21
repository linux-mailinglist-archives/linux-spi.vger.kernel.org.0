Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE18607877
	for <lists+linux-spi@lfdr.de>; Fri, 21 Oct 2022 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiJUNbr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Oct 2022 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJUNbp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 09:31:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FED26478C
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:31:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l32so2186369wms.2
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7Qoz9jeBcfdzL9iyekJH2YPQjo48jyM8jlQ41M6YtQ=;
        b=J8v+969UzU9Y9w/SR7VUhM/aEcbhclODwWuAxD/2d3jJUKqh+EMU5hI0TGmOVQxIQA
         lYzdLAgH9Epw38urAuGMdecmgz8rRRgI6eqr3YA804isCcnKNSaTQsqntIVuaXkAZFVk
         4fYlMQORa8yVEOeIfgVLEewvRKR9p4kf26uJN+hCvkmpgzxgkIHv1KQW3g60H5Vy9VAF
         nlgq+EpW9yRisAMhpzDniP0fSWgLqcl1k0K+J1OEHFXH01QrM9J64woxI00TTdZsX87P
         m7LfLYndbJiQSP0I4a+6goeJN9afeibn43oy8f45JbpTmNh7ezVzjjuoYzSLuG4cDrT+
         PqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7Qoz9jeBcfdzL9iyekJH2YPQjo48jyM8jlQ41M6YtQ=;
        b=3yYzktrWtgJzF6WOs/zkr84kiLRjR6G60I8ZGbPd4MQsgIiLc3js4C9GHVB9Nf/+1k
         Wxo2a19B1w+Nr6ifV7Y+zQDA8591WQ3MmswiiOlqsKzsFHo5x6lOFPdUjs4NA3xvVHyV
         NmTUueZYssZiTMFYFj/J4Tz6/e8aEmhJbG3OirqL+JeT/nInyTAMgKIALx7JZMg7Ci0i
         W2060Nn7+qTG7cn8YDIbawS5DrhOxqv7+er44WWHP57NGurY0EYo5QvcNqf0vU3kA/In
         OL/HJDa14rCORKxssipbPl29aQa33wN44XxNF4TQ9HHYLbzt/7oTT3CaM+Ef9HXng26Z
         36AA==
X-Gm-Message-State: ACrzQf0fulniX9UnZgW9ChA7HLOLlWQDZTunS6XB+Z1SrUp/raCe4iuB
        hHK0XX1lB8SN7Lsqa7nYB3yNEQ==
X-Google-Smtp-Source: AMsMyM7vhBSUx8oFPqKPxgekjBSxnpKkMenQ/luY5NA8wvs3PPhn5weMl3uUeZtAfwwfplq+OXGouQ==
X-Received: by 2002:a05:600c:5119:b0:3c6:cae1:1512 with SMTP id o25-20020a05600c511900b003c6cae11512mr34727154wms.80.1666359100026;
        Fri, 21 Oct 2022 06:31:40 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c1c0800b003c6b7f5567csm10325280wms.0.2022.10.21.06.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:31:39 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 21 Oct 2022 15:31:28 +0200
Subject: [PATCH v4 4/4] arm64: dts: meson-gxbb: add SPI pinctrl nodes for CLK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221004-up-aml-fix-spi-v4-4-0342d8e10c49@baylibre.com>
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Da Xue <da@libre.computer>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666359095; l=868;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=ak0c2C3voqy+PYUNmJZvTOe1B4YCFcIjwb3vM78gKV4=;
 b=U08rR1DqiuMN+ZjEAxpTF5BvPqmpkiWEm+VeI5J7vmNpVuKEJ4/g+EhvlrAaKQ90o0QaPnwGQnN5
 bJ4hBA7zAGFQklbeHPuuVocBB1bNTOcICPKDHttTwFahly1iqCha
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add SPICC Controller pin nodes for CLK line when idle for Amlogic GXBB
SoCs.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 7c029f552a23..923d2d8bbb9c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -427,6 +427,20 @@ mux {
 			};
 		};
 
+		spi_idle_high_pins: spi-idle-high-pins {
+			mux {
+				groups = "spi_sclk";
+				bias-pull-up;
+			};
+		};
+
+		spi_idle_low_pins: spi-idle-low-pins {
+			mux {
+				groups = "spi_sclk";
+				bias-pull-down;
+			};
+		};
+
 		spi_ss0_pins: spi-ss0 {
 			mux {
 				groups = "spi_ss0";

-- 
b4 0.10.1
