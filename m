Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7BD457A63
	for <lists+linux-spi@lfdr.de>; Sat, 20 Nov 2021 02:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhKTBWd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 20:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbhKTBWW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 20:22:22 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BBFC061574
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 17:19:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z34so51123911lfu.8
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 17:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdQF9dwZk29V6xP1ZPUoOlKX4v8TPwGPHVAe2c4y5XY=;
        b=NYzFXqouKWnuxasaE+bE2hoSdipl8XAgX5+aHCOd5rx/DbgIZVEN1JwGJaMUQBD+WV
         gxhUxWf7MHi/ZVWLL+n+9Nh+NsokfBEMBzZnubbIW+FLePtOZG0DooSKuFaLQnXzJvzN
         O8R6gjG/oWmXjawd7XjBnb8FmA0YXb8XKKHitIlpSAMjNKiBM4DBITpCC2PMS95Y5dTR
         K0zmGPsrtG8sWD/cmNSkgNK0CFxNGGUMDaUXH62ZLGhjmD9idZqVDWH3CQYJbVJ6b2Vg
         Kyo8K6SYfidehyaNMAVt+3y3q4FX9CLVEIRa7RU3WnfM1uAcosGj1qqK0PO7IyJ9vXXG
         aXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdQF9dwZk29V6xP1ZPUoOlKX4v8TPwGPHVAe2c4y5XY=;
        b=OkokA3BFYu0UWwkDNuedBEVUYryS03U/P//cr9CVEm+HJZ7YEjaES674HKhTxeTa4y
         ydw3tK0gy9UI//FrejPZEGLkCQev4+H7V8I+onRFgbl5omC8OMMA+YJmsVurBfCWsobw
         a6co/OmP1hfb937S4mu26IS40p82b/rqYR0Zs/iWncHQa3g0NrXOlivoBqCcRDrEP9GR
         YTOtp6dJF9RzEYrCURbHf8PLSabw36W2DxZApsGNbRCQazRdQRKLrN50CE0mExxFgNN0
         qLP5wbRrxwQauBLDL0lM9+yhiXo+cclHJSiI0M3OW1dICW05mbeDpD2H9KfUmylgiRaB
         vwrA==
X-Gm-Message-State: AOAM533aMT4IWIfu/qFRwc6reAG0q/GkUh/GPulk00WA/V47EbghM/pV
        ILY0YmOVKfvY1FKJlBl7aipCgA==
X-Google-Smtp-Source: ABdhPJxhHd0ZZNhsrdBojJthpcVB3w2toAGRdWFRrbP6Tzl3L0k0RaNWgY+jVDBltYY1/gyiVQCrhg==
X-Received: by 2002:a05:6512:c01:: with SMTP id z1mr37968117lfu.136.1637371158197;
        Fri, 19 Nov 2021 17:19:18 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id o19sm168770lfk.280.2021.11.19.17.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 17:19:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: Add resets to the PL022 bindings
Date:   Sat, 20 Nov 2021 02:17:15 +0100
Message-Id: <20211120011715.2630873-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some PL022 implementations provide a reset line to the silicon
IP block, add a device tree property for this.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Probably it's easiest to apply this to the DT tree.
---
 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index a91d868e40c5..6d633728fc2b 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -72,6 +72,9 @@ properties:
       - const: rx
       - const: tx
 
+  resets:
+    maxItems: 1
+
 patternProperties:
   "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-f]+$":
     type: object
-- 
2.31.1

