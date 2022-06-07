Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB07539229
	for <lists+linux-spi@lfdr.de>; Tue, 31 May 2022 15:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbiEaNvB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 31 May 2022 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbiEaNur (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 31 May 2022 09:50:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73D0544E0
        for <linux-spi@vger.kernel.org>; Tue, 31 May 2022 06:50:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x17so9726268wrg.6
        for <linux-spi@vger.kernel.org>; Tue, 31 May 2022 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uV55XMdMMXm/8YBcA+hYcRdN/Sy/q9ytKejpU0TX1a4=;
        b=ydZ0fPc4/noMrgY/rszzHccN97Dm96R2jV+wrzbjo52SSgkXsjX2+EmRB8HsR5XPRy
         OVhxeu+TgJKJQmJ8ptz4ZS7KSw34lKfJHR/Oh1KxcrGhn/iCWSi/i3mbLTb8GgMD5vo4
         pr0FmYobyv9iFimX2s+CYCufeQZNf5yKkJ6M6nUmnNbMUbsURMc58EQ4rsJoD++egq8e
         XahX6EwRKB1QJ10UyGUAm9BQzptgx5KvmldEadtAjoKFX5UJv5AzOa20xrPpQB/aVtrR
         qLyOwm378YQrHUZMrdxvMFzDfZaVWFwOrMrwzLddQGIhcZrd9/nkoQi88OD6OFhcqZvG
         /tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uV55XMdMMXm/8YBcA+hYcRdN/Sy/q9ytKejpU0TX1a4=;
        b=jJXQKk5YOnvaQz2xJWGtXI8+zdqPPMACYE0YoWRvcnlUZd2y+YUr0k0x3Uh4JXkNJi
         rUEIhjBMB5wFTjS/E4vi8VXiSgUvJcfB1I9sVCeE+owrO2VdJXRG00DB1hgWr9OepOqa
         2vdyxXQmA6kdeQJnucv1kHzkg0DI/bVXwmroZEba6bpDDyBOihjdolcYaDn7zrPkLnc0
         cOXRLdF2BuW8U1S4MVCttAVWmb98ggR3PGCSoCzrSC2VjkxNtmBtuUhZCoOLe8azCyMX
         M9EsfgB2hItoXIe6fxhlZgo4F6putU1NgYgNj3iSw7Dw3pCmJDztuyeaDFRWjnyxiAox
         MyIg==
X-Gm-Message-State: AOAM531nF9UCr3A7emyxLe6ytUGwjkhTyU/Vwht5s1yGBvd6KJcpcyvh
        LwZ5hTC1aD6SItVqKKKp9qms7g==
X-Google-Smtp-Source: ABdhPJxv8/PQNV+ezFLIiwnnP78JfWw4efymnBcIzCpOQsc85VBTswc/napM3IwCND/u1AFwGmeM9A==
X-Received: by 2002:a05:6000:1869:b0:20f:c1a4:111 with SMTP id d9-20020a056000186900b0020fc1a40111mr43818748wri.261.1654005045408;
        Tue, 31 May 2022 06:50:45 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:50:44 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 04/17] dt-bindings: arm: mediatek: Add binding for mt8365-evk board
Date:   Tue, 31 May 2022 15:50:13 +0200
Message-Id: <20220531135026.238475-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add binding documentation for the MT8365-EVK board. The MT8365 EVK board
has the following IOs:
* DPI <-> HDMI bridge and HDMI connector.
* 2 audio jack
* 1 USB Type-A Host port
* 2 UART to USB port
* 1 battery connector
* 1 eMMC
* 1 SD card
* 2 camera connectors
* 1 M.2 slot for connectivity
* 1 DSI connector + touchscreen connector
* RPI compatible header
* 1 Ethernet port

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 4a2bd9759c47..a4b1288fa837 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -216,6 +216,10 @@ properties:
           - enum:
               - mediatek,mt8516-pumpkin
           - const: mediatek,mt8516
+      - items:
+          - enum:
+              - mediatek,mt8365-evk
+          - const: mediatek,mt8365
 
 additionalProperties: true
 
-- 
2.36.1

