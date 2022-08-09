Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451A858DCFB
	for <lists+linux-spi@lfdr.de>; Tue,  9 Aug 2022 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbiHIRU7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Aug 2022 13:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbiHIRU6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Aug 2022 13:20:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA9B24093
        for <linux-spi@vger.kernel.org>; Tue,  9 Aug 2022 10:20:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z12so15041557wrs.9
        for <linux-spi@vger.kernel.org>; Tue, 09 Aug 2022 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=y545aVrkkuDGPQff6D7mZBdsso6g+4hQEnF5Ijp4clg=;
        b=mwm18OvAvb3DN1qMcM6AJRveexnF9QeK2qJBPRDNYGf7ZskAiyyp7cqKO+165fN9Ny
         cnRcxxAYqIZnMVfhFK2yPzYW9JA9JBZT6ocT+r+5QfEA8ofsx/1r5jPDKCqMJv5T7cDh
         0iXVd0XPxwIs1T4eBVIWlcS5pJ0rs0qizPcAQODhbdftpgVKKoHdJ2EvkmGNqXnVw+0D
         iyOGoPeNcS0PLvl6QA3MtERhJQSzgs+ILk8UFg2k30D+BH0Bt3IKZiY/Tof4etb7r6KQ
         jQ3V6EEtmFNaQXUD3SfXHZjC060HODxuj2msch63CZSE14EwVFCd8fzIegfKJ6D2gjh4
         ppyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=y545aVrkkuDGPQff6D7mZBdsso6g+4hQEnF5Ijp4clg=;
        b=GD6ra3C201z8UIlnsb+FyDkM15RgK4S9/Ob3YoCU+jO/YkOvOQnauITnUo2Em8zCUZ
         tW5NfETxZ0h3M+NS3pji6PeUxC8KkaNdoTqJh3TmtxtaLAHoF/fZK2c3s0d8xFdxz0x4
         nDxHyLKOlOLTVs1eHcjgvcnzvVEVN6rJ8jlBWxpbUDlZe6W1NKeRoHo05cTaYjXy/Lbj
         mC2nDcza+n8TkkFmk2O9AodTOayqtS/Bwo7CF7sbAsVT6TRJkOBc/93PBoLpiXmWTVvd
         O7VvYkUZP8fu+mWl/ohXMYTFc8gWHZ9H36MHpyJxaTcZVeas9YwzVJ50ttHWaklIkJj9
         H0IQ==
X-Gm-Message-State: ACgBeo24oeZ4RBwsTbCJ+N9bcGtg0DIciEtI+OxXUe0I//2EqtQf4hRj
        QbYRWfpdPNtQfMs7tgQuWDGCaA==
X-Google-Smtp-Source: AA6agR7oIC+WFbM03wya4VinLOUGhi0StzJsyj9eBnMCq0cT6vT0Oq+1Eh1Yn9+7C+63+1UPZ0SEgg==
X-Received: by 2002:a5d:63cb:0:b0:21e:b81d:8b0d with SMTP id c11-20020a5d63cb000000b0021eb81d8b0dmr14767021wrw.526.1660065656092;
        Tue, 09 Aug 2022 10:20:56 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id b3-20020a05600010c300b002206261cb6esm13915030wrx.66.2022.08.09.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:20:55 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        narmstrong@baylibre.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Da Xue <da@libre.computer>
Subject: [PATCH 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
Date:   Tue,  9 Aug 2022 19:20:16 +0200
Message-Id: <20220809172017.215412-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809172017.215412-1-aouledameur@baylibre.com>
References: <20220809172017.215412-1-aouledameur@baylibre.com>
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

SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
pin biais when idle. Therefore define three pinctrl names:
- default: SPI pins are controlled by spi function.
- idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
by spi function.
- idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
by spi function.

Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 50de0da42c13..10707a8216f5 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -43,6 +43,14 @@ properties:
     minItems: 1
     maxItems: 2
 
+  pinctrl-0:
+    minItems: 1
+
+  pinctrl-1:
+    maxItems: 1
+
+  pinctrl-names: true
+
 if:
   properties:
     compatible:
@@ -69,6 +77,13 @@ else:
       items:
         - const: core
 
+    pinctrl-names:
+      minItems: 1
+      items:
+        - const: default
+        - const: idle-high
+        - const: idle-low
+
 required:
   - compatible
   - reg
-- 
2.37.1

