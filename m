Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2571F92E0
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgFOJJ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbgFOJJt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 05:09:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F9CC05BD1E;
        Mon, 15 Jun 2020 02:09:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so16241359wrw.9;
        Mon, 15 Jun 2020 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1afpgiZSkCxScwIQYbqgkLwgpZTvEZ/sJp0E5CNcZ5k=;
        b=cSmicChqdnE/e5/HZWkV5Ec8+/awIFZcgGpkuyXPE8uc+KtRLP0YySLje0t5aSUxVZ
         XW/9637BuD4zITAyTfIPHOIE20qGjB0fNrTBimoAJz28OMhRq94sfJwbr4CSARuVQio7
         VLVv6HjVjYLAreZ8NOXbHp44wxRq68NNLMWlYLnk2krkN4exeCL6mOkR3cDQOVT+4LIh
         A/Rfr0fERe4PiFozP9SE/bjOcMDmX8moj8HP0p3qklDEa9T565a1gu/avyBec7fCaNzp
         vhAI+FfWDJ50ESVxF/wMAYraTG5be3VsH20+8me+VWu7d5SxwrF8HlL8bBLA+UYklj2W
         6NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1afpgiZSkCxScwIQYbqgkLwgpZTvEZ/sJp0E5CNcZ5k=;
        b=NzmMWZcPdQdTzuFCMc83SfzzCaqeFPXq1+TAa6ANfGB6EueN8K+0jlHM/hwpx4DEYB
         Wb3bTVAc8kfVEm0z413T3skmMDaLOqeel6XoMYdqVtAfR/JEoRBVnYMSWaBNe+evprAE
         PJnYxofl+B+p2kDKNN/kwabyXqlehd5OiCrIU2MKAkyDbigjl4Z89jVVxB6gVgpwdKkO
         9EJY7FgIu2G0uLsIHZFfJBpyOmeaUMBoViqTTp8viBu1dmwwjiCla7Ol7MF3qDoVFHuD
         ibEE81p4D2eJQSqMFNPBy+PN0kMbA6n4fAWGNMJvZv9heQIAfOxgZJSalrJtJ9H5FVjD
         +7XA==
X-Gm-Message-State: AOAM533UA9bgqHNWRJm85M4TK+wqaeHc6/E3BkM0tBslFEjPWXlbechS
        wtkiI6+CxfNTTI0fe43V9wE=
X-Google-Smtp-Source: ABdhPJyp/2xEDiDre/+ebYIfeT5x+ZslI9jh9sWzEs31ZYpZ305FIggGes5hxs4301Map+pqWXX70g==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr27924127wrw.343.1592212187536;
        Mon, 15 Jun 2020 02:09:47 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id z7sm23109370wrt.6.2020.06.15.02.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:09:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 2/4] spi: bcm63xx-spi: allow building for BMIPS
Date:   Mon, 15 Jun 2020 11:09:41 +0200
Message-Id: <20200615090943.2936839-3-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615090943.2936839-1-noltari@gmail.com>
References: <20200615080309.2897694-1-noltari@gmail.com>
 <20200615090943.2936839-1-noltari@gmail.com>
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
---
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

