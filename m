Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA391FA96A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 09:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgFPHCl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 03:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgFPHCc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 03:02:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20CC03E97C;
        Tue, 16 Jun 2020 00:02:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so19502701wrr.10;
        Tue, 16 Jun 2020 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/D6+64ZUdejGJRJMqoRU2x61DrD8mP7AccKlTwbucWk=;
        b=bD+zdCSQk7z5kAoShY/7lCz6ss5FR4L8vQ+PeKjYftWneGl8MwS4iSnkV6zsB2zMeJ
         lXdH4Gaus8NSoD/I/o5/ozLjil4vnSu1jH6d30fdxDgMUDCwth18iC9Q47oqKpISf7jU
         UMAKjGGSYaL/lMBSVnt8ChLimgmN0Zoew0mWrdTs4tFk+QQmrxWBjyQshkxOPVUdHIJJ
         sj97C1l0gSCquhlAjn28m7VaTXcCD72NDmZmvfDbMQl014A28RKWjWH4b0vyx5I8bYXt
         3jUIm4oF3IQuKb32U9YGOVDM0dG1DIMoaIDcDighByeaLdCb6GaU+eIwIBp69dcHE0J2
         iJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/D6+64ZUdejGJRJMqoRU2x61DrD8mP7AccKlTwbucWk=;
        b=MAgwphFX8KUP4cm5TQVla44Lp5xNcfgxyPmd8YSOsqzW+hqNMCNcF4zAJJPIp4Ed01
         7U1jRJnwhcXx2edA5ecBXCSQKUe2ZE5W9qAWKCgq73BuhfRuQu7PRONnKgj/Pd007NxQ
         sCmxCBTt8QPoOrxAdEaQhOxfJxQkpIpeDJw1fcqCgWrolBAeW3yh5Ft/1oKNp+js4o9s
         3hjqD9B8XcXLe5YIZL6/tXTLlrBMUqn510dO6wJgPVIJV46A/Bvysnv067wR5mcWj2Hf
         97tNZ3mbOt6npTw84P/XyIYx3E3zbabGYlXUzGcy4EbJvjj19g5Byp81u0cplbrAIWbL
         VqPA==
X-Gm-Message-State: AOAM532KYcKN2PJPzPSVEQXx5PPhMkWfCpbWmar/jLRNT7FMVmQ0JFUZ
        diuVcLGwP3izIuTwHO+4rls=
X-Google-Smtp-Source: ABdhPJzi/n7XU1cdxDdzEwN8TxfBEhzsT4SjTrAg4SkW/x5lg2I5SoFzXpF/64QNnsy7GYYj3hzgKw==
X-Received: by 2002:a5d:4d89:: with SMTP id b9mr1542617wru.210.1592290951143;
        Tue, 16 Jun 2020 00:02:31 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id a81sm2792897wmd.25.2020.06.16.00.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:02:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 4/4] spi: bcm63xx-hsspi: allow building for BMIPS
Date:   Tue, 16 Jun 2020 09:02:23 +0200
Message-Id: <20200616070223.3401282-5-noltari@gmail.com>
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

bcm63xx-hsspi controller is present on several BMIPS SoCs (BCM6318, BCM6328,
BCM6362 and BCM63268).

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v3: no changes
 v2: no changes

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a9896e388355..500774fe1351 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -155,7 +155,7 @@ config SPI_BCM63XX
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
-	depends on BCM63XX || ARCH_BCM_63XX || COMPILE_TEST
+	depends on BCM63XX || BMIPS_GENERIC || ARCH_BCM_63XX || COMPILE_TEST
 	help
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCM63XX SoCs.
-- 
2.27.0

