Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89C40E366
	for <lists+linux-spi@lfdr.de>; Thu, 16 Sep 2021 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbhIPQsG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Sep 2021 12:48:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53238
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243088AbhIPQpt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Sep 2021 12:45:49 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 737103F2FC
        for <linux-spi@vger.kernel.org>; Thu, 16 Sep 2021 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631810667;
        bh=yBmMOuuxnsSmKY/MvasMRfssB0igqWI4HNZ3xPJ3pBo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=LP15ITHZHQGlpdsaO2ph90tBi39b1T6EnyUR4FKNckDBuv6OzLUvuzuvewdSoVMto
         pBKYSDKkhupDbut1kwl8pys5rkNvB0T/nOqW6jPPLtaE7w9P7qpTHpHKg9ju6CEUbI
         a+7EG9Z6x9+0/1xvt1oJCpVnVu4T2HBCLfT2HArVo/Knkwp3oKI3crFfswM7991Cku
         La4rqbaUS1Z6CT2xuKFbid90cpgCgxXyEtBT+V+flQ6A4Q3xNcNbH2Y4du0nTsISR2
         0+UbKmxF1CHssnnpxK/bfG4UYRC7bQatmsM8/qGYhEZ0pwgkRF1C4o3Ctd9SI2MbMu
         m3PuQ8Q35H41A==
Received: by mail-wm1-f71.google.com with SMTP id g130-20020a1c2088000000b00308ecd761e8so498279wmg.2
        for <linux-spi@vger.kernel.org>; Thu, 16 Sep 2021 09:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBmMOuuxnsSmKY/MvasMRfssB0igqWI4HNZ3xPJ3pBo=;
        b=eESSiqARGEjOj/8ADRKlb0cg0u9kWvAd8DTUIJ+OG2C6aUM4X+df54vunp+wd9wIFN
         3m+iGlH/YVQe8ZhsLHivA+S5cjhw5PKQj+YpsJSwKCyyH5FgZL3xd1sgzNcPzBxjnZx0
         B3i/yGhXuHpCHHdZmLfIN1SBlrl3716CuH+lXS+WjNrJFSnHSGjuI+V31gfWcnohUvoP
         CN9qNqnkYvykOEB4UJM5dxMR/i1ISbK/xbpikC4RwcRlh3HqFiRejWr1JCFvzFo7s82i
         LrZ4fxUCzHN2wrAw2AtfKUruqdvcVSt18T/cdXlDTdD7LTkJZirYPdV2C3CAvPOyKKkT
         FxGg==
X-Gm-Message-State: AOAM532Zj0xW0sfbGQnVL5rPOria+eKPXcBJwfhAZcmDlgw2pFMW23Qi
        auU7tSmHQ8IrMD7znNuEtuqg5ex0wBW/KW4/DpBsO4iViaoBbA2w+nwrvtx5V3DZDGcURbvzExj
        cNcKI4S1f+ut/5y7X27NmZsochY4ciyakfnFdSw==
X-Received: by 2002:adf:8144:: with SMTP id 62mr7325141wrm.144.1631810666989;
        Thu, 16 Sep 2021 09:44:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpsyrgDKxaM6Pd+NJV9qAsOHR82paB1P4J3TxYLo88IvDY24kRO2y6ux/ve5eKWqDHLRW+rg==
X-Received: by 2002:adf:8144:: with SMTP id 62mr7325127wrm.144.1631810666810;
        Thu, 16 Sep 2021 09:44:26 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id 129sm3747538wmz.26.2021.09.16.09.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:44:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] spi: rspi: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 18:44:22 +0200
Message-Id: <20210916164423.134603-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi-rspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index d16ed88802d3..41761f0d892a 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1427,4 +1427,3 @@ module_platform_driver(rspi_driver);
 MODULE_DESCRIPTION("Renesas RSPI bus driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yoshihiro Shimoda");
-MODULE_ALIAS("platform:rspi");
-- 
2.30.2

