Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575B849417E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiASUKQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jan 2022 15:10:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46208
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357226AbiASUKO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jan 2022 15:10:14 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 80E7840055
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642623013;
        bh=OI1v3v2do2JpaG4iEWGXiW3KIkLzyCyv5Mi1khRNczo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IdST51vUadRwVmoLnIzcZ7a0UjvxLlUKvP5gEWsJYrck74FoCQA7zbE4040k4QJpx
         k2CIT70qgKmY/5s0BBv1IUOxO22lIWXDx+AERZAQzuyJ1/Dtw7HO5vVDW/+Jkpgscr
         wHjCQCBcKHfrUVlhQPb+ddAOlYHMh0mJN7YvtLjFLC3lksR1UYncOGWA975VXUlomh
         zOeLQpp6gVt1/Wv6f11lxEgBicLI4FN4zqLRvDMg0cW/Wg8aNfHUcdceaxuHz9Fg8U
         cK9nDC8XIyW38iSF0n7qe8ByG1qS83Et3Nr+M7fwYvH+V/XjdZqyhegR9v5vVV1YwU
         muhyMNfAKVm2A==
Received: by mail-ed1-f71.google.com with SMTP id c11-20020a056402120b00b0040321cea9d4so3700829edw.23
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 12:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OI1v3v2do2JpaG4iEWGXiW3KIkLzyCyv5Mi1khRNczo=;
        b=eCMsxhAXc5t+Qn9GWmhLQFqT8/p/uBNnYjQoGTt7pL+vEwi937MUNO3gz+twvl3+z9
         KOGGg54raJLsKJFPhi4/058AScfXq43hUZ9nfGo4KBWltFnnJs5zbgb6A6r517CO6AJP
         0hh2iKCJdhqpNwxO+eCW3+S+1R9o3MDNwr9D6gdPTi9unJQeXxwKxRWmygQUgKEU7/7f
         SfsDzeeI9+K8bohZAiP5hSv5GysUXv/TDVLziM1rTMW3iEKD6CGL7Osu6ctAmJU5JyWI
         jD/oqhqnQUxON6IRuXPljfVAEnKGMGz8+yEXVG08S5e9ZQGnCiwSqAhYDu9rLGmSSt74
         W8rg==
X-Gm-Message-State: AOAM531G1PSQwRU3ntK22Jl/39vmkyyQ1eNWVKS55IL7VkNvuPiJ12q6
        swDq2mIliv4enYAhPz3H3MX797neimQLwPyNdkRXofYA89cZligHvb6ggHyBFNQFhWGzCEXgBtB
        RUajO4s8V6p6dcS0JxQdk6i8fX07vXHw0bcjGdw==
X-Received: by 2002:a17:907:6d9b:: with SMTP id sb27mr16562552ejc.139.1642623012063;
        Wed, 19 Jan 2022 12:10:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbMDqql6veyRi+CRtgtcNlpTb3anuIsgG8+eGO4+VxQIYp/p5x9Z3ynE8z5H2EjzPVr7tcTw==
X-Received: by 2002:a17:907:6d9b:: with SMTP id sb27mr16562535ejc.139.1642623011894;
        Wed, 19 Jan 2022 12:10:11 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a26sm215005ejr.213.2022.01.19.12.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:10:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v4 1/5] ARM: dts: exynos: split dmas into array of phandles in Exynos5250
Date:   Wed, 19 Jan 2022 21:10:01 +0100
Message-Id: <20220119201005.13145-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
References: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

"dmas" property should be rather an array of phandles, as dtschema
points.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 139778928b93..102bb57bf704 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -496,8 +496,7 @@ spi_0: spi@12d20000 {
 			status = "disabled";
 			reg = <0x12d20000 0x100>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&pdma0 5
-				&pdma0 4>;
+			dmas = <&pdma0 5>, <&pdma0 4>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -512,8 +511,7 @@ spi_1: spi@12d30000 {
 			status = "disabled";
 			reg = <0x12d30000 0x100>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&pdma1 5
-				&pdma1 4>;
+			dmas = <&pdma1 5>, <&pdma1 4>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -528,8 +526,7 @@ spi_2: spi@12d40000 {
 			status = "disabled";
 			reg = <0x12d40000 0x100>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&pdma0 7
-				&pdma0 6>;
+			dmas = <&pdma0 7>, <&pdma0 6>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.32.0

