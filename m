Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0014FD24
	for <lists+linux-spi@lfdr.de>; Sun,  2 Feb 2020 14:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgBBNAJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Feb 2020 08:00:09 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39848 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgBBNAI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Feb 2020 08:00:08 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so10504865ywc.6;
        Sun, 02 Feb 2020 05:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfOxBTJAq7rO8Qs/IIR9mdFaCWzDGndxM56W0qKFsAU=;
        b=a75vYtUh5Rw+ngxoxAmQkogk5nJe9heNo+fnZRxSSEHgH73eFaWIHF5reUhTDOHEJQ
         aRnxGC4WbMoY4/UwuR6aHmk/dk9ay+DE550KAn/PzvUVIbz5RZeqjP+bime+eCCYGwpj
         9Uvc6jHxEitN19jr219aKiZ519i/0Z3Utm4dj0rGiifnKtweBFniXv5J7SjkNJ0VdIsL
         pC1NZBPL6txaNR9fPe1VSSIhYAxbyEiIxAi/s9CONTP9MMSwfFPXd5r1MrsLPxmZNhQ6
         0NRKahUUTnwHIrCsrt+FYHYL+pEGPIYvcK/6KPwna0hBExEQtbmNST7r/lRId4b2kBI5
         3veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfOxBTJAq7rO8Qs/IIR9mdFaCWzDGndxM56W0qKFsAU=;
        b=gGTHRn23QbUKjUhCZgMBE2l+lQYLuB5TLYrUBzugluXS5u3JYFKAZxN3YwS/JQZLKr
         CKDD4M/aSV/v2KifY4NGR6vtfkWY8FsUsLG/RFiefKA1bHWUV04WqSOTzO6G7/Z1mrWC
         t1TPrzYrRW7DbURmTWtReXRTeSfWtHHtMcKIiG2pYjssVQqECg+HTsCGSjJxvgFwEEhr
         4SyU8tGIr0So2cTKhYjM7At6d47Rn49XFBSQhc4i17Y1PB1W5j0rUDJC8G8TdYhJBHAP
         e429b9qIGrx/PXfFb7TObnFQ06nZcvY6htnab238k1TcxYRGfdu8N7LoQ+mndPZh9ppa
         9YCg==
X-Gm-Message-State: APjAAAUZb3BZxCTSgYb6hy64YEKhceZofo1U45nb/ZLsp72lEadpdIDC
        +x+Owz6CLfk42uZPAfkowSA5yQ48azs=
X-Google-Smtp-Source: APXvYqwDc7mA8g8RNuZ15bUqAjJpKzEa7MvRr95zljOsGFKvcY0P40xqocrFDYmUh+HokkR8uI2csQ==
X-Received: by 2002:a81:39c4:: with SMTP id g187mr14378569ywa.42.1580648406315;
        Sun, 02 Feb 2020 05:00:06 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id m137sm7090013ywd.108.2020.02.02.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 05:00:05 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Han Xu <han.xu@nxp.com>, Adam Ford <aford173@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 3/5] spi: spi-nxp-fspi: Enable the Octal Mode in MCR0
Date:   Sun,  2 Feb 2020 06:59:48 -0600
Message-Id: <20200202125950.1825013-3-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202125950.1825013-1-aford173@gmail.com>
References: <20200202125950.1825013-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Apply patch from NXP upstream repo to
Enable the octal combination mode in MCR0

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2: Reorder s-o-b lines to give credit in proper order.

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 23abf5ae318e..019f40e2917c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -913,8 +913,9 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_DLLBCR_OVRDEN, base + FSPI_DLLBCR);
 
 	/* enable module */
-	fspi_writel(f, FSPI_MCR0_AHB_TIMEOUT(0xFF) | FSPI_MCR0_IP_TIMEOUT(0xFF),
-		 base + FSPI_MCR0);
+	fspi_writel(f, FSPI_MCR0_AHB_TIMEOUT(0xFF) |
+		    FSPI_MCR0_IP_TIMEOUT(0xFF) | (u32) FSPI_MCR0_OCTCOMB_EN,
+		    base + FSPI_MCR0);
 
 	/*
 	 * Disable same device enable bit and configure all slave devices
-- 
2.24.0

