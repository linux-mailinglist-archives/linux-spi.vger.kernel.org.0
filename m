Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7456A607873
	for <lists+linux-spi@lfdr.de>; Fri, 21 Oct 2022 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiJUNbq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Oct 2022 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiJUNbo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 09:31:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61AD263D2F
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:31:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bp11so4540121wrb.9
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hO6u+TED5AV65kw0TGqwDPOYy64CaLI0AQeOAz3rUlg=;
        b=XftffleNs/SDrTzvj3RL404tfe0D0G94sEfSTAx+QPOAohy66BrA3nLxjU7UBRSg+L
         gfwH3Kg/EPEWnUV6yu5A6aJzBRkJ2G+B0caF+hO6BQCJrIfCFapTv0ml5zFpNXKCgJEW
         yyERdl5dasuMNJfSUbMQP7KoV3hlbSlH0wak5wYTFVX0qLRnHbLXPNDuinolw2dy4LLm
         qKsqqGvQ6ttxt8/zaSiuGtoSs4N1akd8GHGfosn4mtrnPZ3MbIncc7sN/3nR6v+q6sxZ
         JS4YlOEIHnNJgvL3jF7KbjgEUGjc5E0uQxdW4oxbfxqmV6L+GHDYZ18TVL5SiG99Utpe
         9rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hO6u+TED5AV65kw0TGqwDPOYy64CaLI0AQeOAz3rUlg=;
        b=0UFOXzhIwglcNr/i3YIQCJ6tFA4yQMLFAqg+mvOoE8pKakBGNHjWWUluYA70xYu8aU
         5UUN77d2Gjt65eiPcuHvLys9c5zRIAoxTcIO62Q8aff0E863dkCdq1H5iK13aqsFgjhw
         Y1M7SyQMx8W8T40KwZmc2UAEWXtAy0DZcJ2TM5FzK9wRDW/y57UHH+p4rl8jjF2ItrZr
         k+KJrbwxrvm2HevToCE5lvk34DS5qPGcfFJbmNQ2X2pDy/CiVHg4sII7/3OyU66yAef8
         7z7p0sdsmDGOMghA0qf/QycfNBOXzyzi/f+ZAMGNHEPNbViiCXTqvzE7MvD1hsM2hRof
         b9FA==
X-Gm-Message-State: ACrzQf281gjDYRMPKIvj+Orlwe/Mx6eSTDb7Pde5FNnKVub5PW0NJre6
        +1iVCsM3SLKbuaIHSNOhKyOFIA==
X-Google-Smtp-Source: AMsMyM7RDGlYUmFt+uk/UpjANtp7mSMOjFGUDLhcbDkDXV658mYnUAxfeyAQlis0jr3+rAPgnUVoNw==
X-Received: by 2002:adf:8bc5:0:b0:22e:3873:276d with SMTP id w5-20020adf8bc5000000b0022e3873276dmr11869184wra.402.1666359099122;
        Fri, 21 Oct 2022 06:31:39 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c1c0800b003c6b7f5567csm10325280wms.0.2022.10.21.06.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:31:38 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 21 Oct 2022 15:31:27 +0200
Subject: [PATCH v4 3/4] arm64: dts: meson-gxl: add SPI pinctrl nodes for CLK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221004-up-aml-fix-spi-v4-3-0342d8e10c49@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666359095; l=919;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=1L7zyfIVhCZJcKzTBVkOA0R/6Ewhoh6l/GXCUMDjLaM=;
 b=Zp/yYenSqGlzVa6vYtQoBdDUo5nHcdIjN9FTC6qkrBjM8QJTMaNWtHta1JjorcWWKM9T6PQnIONB
 FK+jff8nD3d+Gq6IuPYIEKx63QSIxJe2nU2ZEj6BX+F4KwZCX2Ma
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

Add SPICC Controller pin nodes for CLK line when idle for Amlogic GXL
SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index c3ac531c4f84..04e9d0f1bde0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -429,6 +429,20 @@ mux {
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
