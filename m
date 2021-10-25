Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC795438D23
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 03:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhJYByf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 Oct 2021 21:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJYByd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 Oct 2021 21:54:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FD8C061220
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa4so7063070pjb.2
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRd+RlVLZdu2e4cewW0/Ur3V/oVt9QlpNhBXQEbtHVc=;
        b=meCBAmuRcaBBzXvw2aIzrz5WcBDbY4G4NP0hyRptI7+H1CduSFxgamDAS47gpgtYu4
         eeZigcteWARCfs6adcNJ/JrxfCgH6tImH25tjPhyLkhus8kxtbP8c0//4jzVJ88nNFyb
         lPKmiPxWk/gugRegCg553xppYKAL8liZkOhKLhk5e2z8k5FvsoklpqT1XSU41BcylUsI
         juXXoUttyyuXkBUa6i5rGjInZlUTxLQyT8Lb6ldti+1R0QcBhOyKDlSsMOFywVurzgdP
         vX/JI92XRazZK2phbuppB0yfnNPwLj5DLfO/WaYvlSpvuBOG8AmQ53EPPn5ybaQzzdKj
         ajJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gRd+RlVLZdu2e4cewW0/Ur3V/oVt9QlpNhBXQEbtHVc=;
        b=p/MBjCrR/FW4GbgaG5JyjL6bYjmw8ZIwCdN5hOTEHR90spanGegTcBTTgwXSeaDZ/y
         1MbspR8BQjsye+5KuGhhMmzPXhNYFLh+QVTXxfaQgpLkxURIucNWAxSm00JxYfNurC1R
         XVGu26O2zt7G6fZLsQlHGIYpjH/f3n2mJXdAGVT8eKOfTiwQ/N/2OxkOHvTahfVA6B0k
         1sQ4fzDFq+unnRk4t7WoW2f7E/Ao+tn9q3n0ZhZ4Pv6z6hCH0Cbjh9GMWcMR5bPmOoHi
         7vzht6v+FynXB68sKcUREDf6YQ0aJKiTgz4M3DIZTr8w2MwFfnnGnXz+lqZ3RWi5Y4wq
         rvFA==
X-Gm-Message-State: AOAM530fQ+/ZSJ2fRNqnpeXXNpSw79tvjI4G40r2ELt75VRbCL2j1xEp
        14J/QmVvgPrDm1f2CAGHx6L97A==
X-Google-Smtp-Source: ABdhPJxuUmAc+grc3TitHnXVwBQJMnHzMIBQfbm+w4plWIkTkOTL/0HHOucMVEz0h2CNOcR+M9qUVg==
X-Received: by 2002:a17:90a:6b0a:: with SMTP id v10mr31822835pjj.130.1635126731699;
        Sun, 24 Oct 2021 18:52:11 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:11 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
Date:   Sun, 24 Oct 2021 18:51:48 -0700
Message-Id: <20211025015156.33133-4-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025015156.33133-1-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Pensando Elba ARM 64-bit SoC is integrated with this IP and
explicitly controls byte-lane enables resulting in an additional
reg property resource.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml         | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index af7442f73881..6c68b7b5abec 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -15,13 +15,16 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - socionext,uniphier-sd4hc
-      - const: cdns,sd4hc
+    oneOf:
+      - items:
+        - enum:
+            - socionext,uniphier-sd4hc
+            - pensando,elba-emmc
+        - const: cdns,sd4hc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
-- 
2.17.1

