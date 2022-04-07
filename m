Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299F4F81D8
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbiDGOgu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 10:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344154AbiDGOgn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 10:36:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4FB1E3E2F
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 07:34:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k23so11284349ejd.3
        for <linux-spi@vger.kernel.org>; Thu, 07 Apr 2022 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMc3AfG5H7Eoze1riLsoKQySy0boPTnHcGifTlbw67U=;
        b=ACt2wLpnHluTK801WClxUNjv0T9X0tOd4oKiCIIrZ9eNjavRSu/0d5x723ScrD6OQJ
         4ycrRvTpZwenEIWc5szrw7Xy7HZlT+y1tGmDJX1OMZr31b6onPuNIXxnElG8KwNEHG8v
         7cO8koLd+3k74YrxsfvbF4gSaFYQmeSEhO1sAvwcmL/frMNgxZdh5zphOLrEI0Sir9er
         DC9hAsYxXq9WhYZGMdDJ0rR2BpvJwQH5Utv5DyHXDBxGVwcgUk5UG0UAy1cblo+jn8md
         HomLK/kqgRoT+SxkiPmU1UQqoCsxtMxO6f0uP0EAexdHFKupYpNvhem6YnmogCUO6aYv
         /jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMc3AfG5H7Eoze1riLsoKQySy0boPTnHcGifTlbw67U=;
        b=xE7fb9oiazGmNLV9tYEwdNubHR5REGZt64ew8Rex252eiEIWvU1fyOxIVVDtYIaN/K
         n5iTuiXpjilaq/wjuDHFJKI1c6UOrvLQdr3Mc088yjM9iS8wKLmRux1TG+OtBZ9PQc2j
         yPk9GkmdRYbGVSMwJaI1vL3dIB4artproz27ghjKHfDl1MhCfiW8fbYF0b3WqMwJsgN3
         iy3E4VpBmTH7z14ohBXkVfmrbHVHvTECZTMNU/3kJrMrXF9OdxHsD09WbOukgNHOiqkj
         bzL45GrfpSrb8ffK0SifUPpxtO0zsVOmm59L6h+gkt9mlVq6wCaqUTr0NBoPsXzH4j79
         6j5A==
X-Gm-Message-State: AOAM532s3CG+5Ifv98Gl4cLxYB10vz9DruqRUQgn4rsFSUegUfMiG/Ga
        7d0oacSzx7YCzLhKtrHqVKGThQ==
X-Google-Smtp-Source: ABdhPJwXyL4FeMCVoeo0dwl9+9FIwF5PtSlfyv2y65g/77g1GH8eFdummy9lPfT8/0+oXckSp7xQIw==
X-Received: by 2002:a17:906:9c8e:b0:6df:f6bf:7902 with SMTP id fj14-20020a1709069c8e00b006dff6bf7902mr13552991ejc.191.1649342050635;
        Thu, 07 Apr 2022 07:34:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r18-20020a05640251d200b0041d1600ab09sm107835edd.54.2022.04.07.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:34:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:34:05 +0200
Message-Id: <20220407143405.295907-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt | 2 +-
 Documentation/devicetree/bindings/spi/spi-davinci.txt           | 2 +-
 Documentation/devicetree/bindings/spi/spi-pl022.yaml            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt b/Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt
index 74981520d6dd..a99de13c7ccd 100644
--- a/Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt
@@ -17,7 +17,7 @@ spi-nor-controller@10000000 {
 	reg = <0x10000000 0x1000>, <0x14000000 0x1000000>;
 	reg-names = "control", "memory";
 	clocks = <&clock HI3519_FMC_CLK>;
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 	};
diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index 200c7fc7b089..f012888656ec 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -78,7 +78,7 @@ spi0:spi@20bf0000 {
 	interrupts			= <338>;
 	clocks				= <&clkspi>;
 
-	flash: n25q032@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p32";
diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index bda45ff3d294..0e382119c64f 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -143,7 +143,7 @@ examples:
         <&dma_controller 24 0>;
       dma-names = "rx", "tx";
 
-      m25p80@1 {
+      flash@1 {
         compatible = "st,m25p80";
         reg = <1>;
         spi-max-frequency = <12000000>;
-- 
2.32.0

