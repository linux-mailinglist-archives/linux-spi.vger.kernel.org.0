Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5B1FA96B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 09:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgFPHCm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 03:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgFPHCa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 03:02:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEF8C05BD43;
        Tue, 16 Jun 2020 00:02:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so19554020wro.1;
        Tue, 16 Jun 2020 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxEmWLfwHZP4Be2phdSbnhWMdtzjaR50DcbRvIkPnIU=;
        b=sLbReXaGDklVC/wmWctEFgs5Myd1hGZTKnfLn1uS976ohunN6Cl+0+lu8WOXyp2oDX
         twQjvyJQxLq8odtcTB3+FZFOHlWVO8VfgszE8GcRALNyJigwekf/QImno1yYn9xvEa0P
         0TTJTF8pgre0wCBDac6pg59WDry8+EET0q5XyvalQCL6AyrxYB4KgJRrrLCw7yfZczsQ
         0iRGjIB1637r6vtiwulMaHJenCBmMiXR3t2si280FE1yqfEWlI7o7+GQlR6TxZQ8Wgi1
         WAL0DcUr6vH+UkHjQWvR39+7847ksKHnX2JqKSzH4+9OvDx4yAdz2CbW6ql/EeXZRknq
         Ru2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxEmWLfwHZP4Be2phdSbnhWMdtzjaR50DcbRvIkPnIU=;
        b=Rj4v7zBjgNT9KZPNrIOll11MCeYH95g6mJYlKaYMiulPyXF/kmuEw3w4g7TEfKAMKP
         tf0UKR3Foig9AgcfxqyhgULtdTWF6ArYBVw5xgWuZ4pTCH2Srvo1kyW9hjTDl9yXmp0Q
         fEr0ZYOS4YIm8laBUd51Fx6A8/hya2yweX5Dxslm6lNH6NC2Yayvev5+X8sjK9zjKqJg
         FpPy+/BEuZFZmKm4w3YXW8RAoxPo0pWbbb6RggA8Ce6kYuWmC6MvXD8w35Gujrl0fjm3
         b7wYdX3bTCVhDS11zao3kUuk3MfQ+Yigzpoy3kyoS2iUDj88BLm3YfMruMitz9icZ8al
         c5og==
X-Gm-Message-State: AOAM531RvhvCU/KtkZ63SerUQx+LdAdY3YXZBbcTZSqT8clwBrxVruVz
        XeApzzZxCjkiZl+Adakwa32kQhLbTvk=
X-Google-Smtp-Source: ABdhPJwDoaIXDyUzm7CintArNzHEB1nNJOCinL8DV2eNUbdJR0tdiWp7yguJ9LQxGl5k9phf2M3Kjg==
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr1417776wru.3.1592290948741;
        Tue, 16 Jun 2020 00:02:28 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id a81sm2792897wmd.25.2020.06.16.00.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:02:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 2/4] spi: bcm63xx-spi: allow building for BMIPS
Date:   Tue, 16 Jun 2020 09:02:21 +0200
Message-Id: <20200616070223.3401282-3-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616070223.3401282-1-noltari@gmail.com>
References: <20200616070223.3401282-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

bcm63xx-spi controller is present on several BMIPS SoCs (BCM6358, BCM6362,
BCM6368 and BCM63268).

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v3: no changes
 v2: no changes

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8f1f8fca79e3..a9896e388355 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -149,7 +149,7 @@ config SPI_BCM2835AUX
 
 config SPI_BCM63XX
 	tristate "Broadcom BCM63xx SPI controller"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
 	help
 	  Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
 
-- 
2.27.0

