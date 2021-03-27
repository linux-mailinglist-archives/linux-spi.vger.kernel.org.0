Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261C534B954
	for <lists+linux-spi@lfdr.de>; Sat, 27 Mar 2021 21:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhC0UeQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 27 Mar 2021 16:34:16 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40463 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhC0UeE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 27 Mar 2021 16:34:04 -0400
Received: by mail-ot1-f44.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so8539455otb.7;
        Sat, 27 Mar 2021 13:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQr/YqDsL+N492tX6ZjUqsg1uzoT4TgP24HOhBmQEDc=;
        b=oYgSwWR67448JSls+1HW11JwnJa6fP6y+XDmoEU2jm0KRA9K2TMKLsuD5ZdVYZjfSA
         KnndGXkiZJE6nP+f5GW9EN+D1/UR/qqkMrCcWKPvAQBc2QiNBbcdeDLkdsJD/jdnZcvG
         0r15sm/om7xQmY5GSj/Mlaxr0z6ZeuO5r4FTNc+UYe9Cu/sPkXWvwE7TliTydx4DDGYo
         76IPUxfFQaEMCbCwG8qNG+CjACxpkGNGCLeHSTHfDlOIVxrnrHlGWkkXgeFnA7pSPf+h
         x/XR124tQrLOuEfba8R83Guoi9LC4dwA2CwaAqo3MN940P1ebQ4BFW3FXW7l72K127u7
         9bNA==
X-Gm-Message-State: AOAM53386/vYn+sG92YF515H7D0KlCQUIK8NWNvjYiWqcVlsNq5fgvvc
        rQV4ynWZMoSOCTgMN20Fwg==
X-Google-Smtp-Source: ABdhPJxnwkzW4ynrK8b9s45ZSbG6Op+W2lZ+P3SHBvp8SxMAvx7JmrZb6yxUP07j651JgD22SDKGxA==
X-Received: by 2002:a9d:663:: with SMTP id 90mr14934121otn.311.1616877243571;
        Sat, 27 Mar 2021 13:34:03 -0700 (PDT)
Received: from localhost.localdomain ([172.58.99.41])
        by smtp.googlemail.com with ESMTPSA id t19sm3121198otm.40.2021.03.27.13.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 13:34:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: nvidia,tegra210-quad: Use documented compatible "jedec,spi-nor" in example
Date:   Sat, 27 Mar 2021 15:33:57 -0500
Message-Id: <20210327203357.552794-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'spi-nor' compatible used in the example is not documented. Use the
documented 'jedec,spi-nor' compatible instead.

Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 35a8045b2c70..53627c6e2ae3 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -106,7 +106,7 @@ examples:
             dma-names = "rx", "tx";
 
             flash@0 {
-                    compatible = "spi-nor";
+                    compatible = "jedec,spi-nor";
                     reg = <0>;
                     spi-max-frequency = <104000000>;
                     spi-tx-bus-width = <2>;
-- 
2.27.0

