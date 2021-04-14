Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3089335FCB7
	for <lists+linux-spi@lfdr.de>; Wed, 14 Apr 2021 22:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244864AbhDNUe1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Apr 2021 16:34:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50459 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244433AbhDNUeZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Apr 2021 16:34:25 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWmD4-0007RE-R4
        for linux-spi@vger.kernel.org; Wed, 14 Apr 2021 20:34:02 +0000
Received: by mail-ej1-f71.google.com with SMTP id lf6-20020a1709071746b029037cee5e31c4so217139ejc.13
        for <linux-spi@vger.kernel.org>; Wed, 14 Apr 2021 13:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iWJ3bgZpUCfwGeaD2iQV5boaIsrvYIQwgNIcJKkeRc=;
        b=uVtmZ9JnG0LXbwRX+dOoRQXELaFSEkOT5QuInCbfOWW8OcWnCVquo2AbvhjxsemvLv
         YlmIyDVkm8Hjf9EiTl4UrrBrwhZxDh0LGJCFZF6Jci9b2q14ElIuRrw8f0SKoxA12IIQ
         FJAQmu2ygMITQInOe+Yttv3pJK12nW+KUs+wRQPL1tYoQ2+uitgXb8NPIczxHf65SAkP
         NA5SE5Y38j6QbR5csGCTmQ8LxLO6DxVRJc8vp99mLfZnpLerRB1Iq7GlqCUmqYhenvIC
         RztuSDoF/CSnvUMPWzDpWM1yMfjtJ17W20yGWjBd//L/OSooZCdmnZdL9Hw/cOKTCMX2
         IuCA==
X-Gm-Message-State: AOAM532/c9YDdPmKD6NGiELOy3KK2YuhX153/wNgo38ak2KQwVl24Mva
        jhblhkGmVqzRMEuixBbueGzyf7sD1Yp5MrvioT066iMOCmfLRLiXIPW0zsbLowV/kD/lAj0slpH
        td8D8RjoZjkSOUttfxfqcBlXCbtXh0sFHezWzaA==
X-Received: by 2002:a05:6402:34d5:: with SMTP id w21mr87967edc.14.1618432442540;
        Wed, 14 Apr 2021 13:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgIg2g0mP+FUvTRFflQtwAfKDR1XJ2BSwJmU+aJUp/4sLcSAVyFpDY3szKBQWx2xkzpd2sKg==
X-Received: by 2002:a05:6402:34d5:: with SMTP id w21mr87946edc.14.1618432442372;
        Wed, 14 Apr 2021 13:34:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id q6sm372209ejt.51.2021.04.14.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 13:34:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 2/3] spi: s3c64xx: correct kerneldoc of s3c64xx_spi_port_config
Date:   Wed, 14 Apr 2021 22:33:42 +0200
Message-Id: <20210414203343.203119-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
References: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Correct the name of s3c64xx_spi_port_config structure in kerneldoc:

  drivers/spi/spi-s3c64xx.c:154: warning:
    expecting prototype for struct s3c64xx_spi_info. Prototype was for struct s3c64xx_spi_port_config instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c6d7641ea342..eac3c300f806 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -128,7 +128,7 @@ struct s3c64xx_spi_dma_data {
 };
 
 /**
- * struct s3c64xx_spi_info - SPI Controller hardware info
+ * struct s3c64xx_spi_port_config - SPI Controller hardware info
  * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
-- 
2.25.1

