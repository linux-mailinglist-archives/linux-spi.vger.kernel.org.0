Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3066819379
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 22:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfEIUgO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 16:36:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43907 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfEIUgO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 16:36:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so1684938plp.10;
        Thu, 09 May 2019 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P54plBXS3RTIB7poB2qEfvlIATtsECBcJgQ25eYeFIc=;
        b=ZYPloAXxqHRrCxoohcw65BioipAqRuQrBEsHP5zQolytgVoK3kyzeXR5TYSk7up89n
         dKNjVKCdWUM0zJeH63EO0wN6sORKc+8qzrYna/VtoV+yIbUc0on+xaF1CYl5TFLz7aPA
         pDUGW9LdiJBYt4W1gY3JPh7odvxFlIzWctcxQxx4hEldLzPHO/rWUnsS9oOcTxe++k0x
         QeMhEmb+bycJ9exO2io3euQazCY7Ls5bMONAu2aytstK5nw6Myh9SmJSdrQ9nE3+n3OA
         1jiyHWNjuPH5lDisxCWo+c3THY/Se8g9nDkJdza7xFBnrA9x3tADOH/jFR4GlVXu2Em4
         Bzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P54plBXS3RTIB7poB2qEfvlIATtsECBcJgQ25eYeFIc=;
        b=tV2+1I6VxSGLafAA8QF9GWXUZdu+e26/S81ur70pyXsrKkyJZvs3d/p0FW+K64XUGe
         3mi4zcH5vBYVhkD4WrTh7VIOLcGzqNvAeSEB5EvXscAWTabh1G3s73fvf1chP2uxEx3Z
         JczexiOg+/LfcOgvyG8tO4AcLMgdrfBUVlocjoEJILtE2V4bEDbmA/mesWBsJY1DvaAZ
         ESjGtkWRiOo/9TKo0kC2Vm9nh8N9shKwHhTwTZJlNx0/TxMytNKcvLg3YfyohK9yxdTA
         abxVUETETjfDiq4DbZ/ucpjUgSa4QsnzJP92LKuwKw60QbHXlNmUc4+dneClUuIZGDUE
         l8gA==
X-Gm-Message-State: APjAAAVZYTVshARr7rZBP9H5MM9icuEiDlgUxYrIjAvInureeLJqwi3J
        sBvD3yQVmwFQKgINa/XsaQ8=
X-Google-Smtp-Source: APXvYqwJxmjpl8NhI+fEGPmLJ6p2uxJfE6/EhZKp/0jQpKKXGkfrTTUPm/DSSStZMsXW4Eu7F1od/Q==
X-Received: by 2002:a17:902:bd91:: with SMTP id q17mr8019530pls.13.1557434173644;
        Thu, 09 May 2019 13:36:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id h74sm4779779pfj.5.2019.05.09.13.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:36:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com, wahrenst@gmx.net,
        bcm-kernel-feedback-list@Broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: Allow selecting BCM2835 SPI controllers on ARCH_BRCMSTB
Date:   Thu,  9 May 2019 13:36:00 -0700
Message-Id: <20190509203600.6867-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ARCH_BRCMSTB platforms have the BCM2835 SPI controllers (normal and
auxiliary), allow selecting the two drivers on such platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/spi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 0fba8f400c59..3ee152feee2b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -119,7 +119,7 @@ config SPI_AXI_SPI_ENGINE
 config SPI_BCM2835
 	tristate "BCM2835 SPI controller"
 	depends on GPIOLIB
-	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI master.
 
@@ -130,7 +130,7 @@ config SPI_BCM2835
 
 config SPI_BCM2835AUX
 	tristate "BCM2835 SPI auxiliary controller"
-	depends on (ARCH_BCM2835 && GPIOLIB) || COMPILE_TEST
+	depends on ((ARCH_BCM2835 || ARCH_BRCMSTB) && GPIOLIB) || COMPILE_TEST
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI aux master.
 
-- 
2.17.1

