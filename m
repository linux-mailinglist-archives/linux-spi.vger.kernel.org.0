Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B5895FA2
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfHTNOb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:31 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:40528 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbfHTNOa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:30 -0400
Received: by mail-ed1-f97.google.com with SMTP id h8so6281005edv.7
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=ddlRjYGFuPCRLL+HMlf2aoDenNuiOTzQL3nZr4Qfrhs=;
        b=gCU+ZKtMDcyC2+pK1KMgf+jSxFI5x2I0+QkyocuMKnh2iobyENhUKp+HEFRxFAtGwI
         HmyO4fVRaa2CPwQnRu7uwRn2gPnQnVd1QVTUqiGdX31qXuh8zS0AY12VhA6JEybYok2U
         QUkrPqPyFbZ48uy1oQRrVABPNKpAzMwDms+zvbansTKhFno9MXH+Nc3wvP5GNio+67bx
         /J6+VtQVTc3DufRbgJ9p7Xve1MROgArviVMoIzkw2eJUQiZ3Os7pSTKnqKdSlLIowpvO
         l10WFm96PRxPsz7gT8oAEMZGYBJg9N24vlrWBPE4CcYvH0GJE1k2Pfp+t5ZVHELLwkd1
         F8LA==
X-Gm-Message-State: APjAAAXnKg1a5+TrlneaNxJUxHplxpwKPIMXfNDm+1SVUtdLtqjYNfGN
        zf6Hr0+suhHZSoDT/x3GzWzpUCJKjAJK666EO1rnHD2b7Fud39wowQoC+45ceprLNg==
X-Google-Smtp-Source: APXvYqyu7PTuS5YVUZ1szpWjWqSgBpjBcDLzHr+NOCrXqqgD3DBu5BhOWspQv/0OeTB8SmWRHgdX0wXl+O02
X-Received: by 2002:a17:906:bcf5:: with SMTP id op21mr26065164ejb.190.1566306868907;
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id me6sm117662ejb.79.2019.08.20.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03y0-0002MF-Kx; Tue, 20 Aug 2019 13:14:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0332C2743150; Tue, 20 Aug 2019 14:14:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Remove unused defines and includes" to the spi tree
In-Reply-To: <20190818180115.31114-3-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131428.0332C2743150@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:27 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Remove unused defines and includes

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 5782a17fe528ce596eb5de66777a73b16f4f1549 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:03 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Remove unused defines and includes

This is a cosmetic patch.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-3-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0adfff9cedd1..358b381839fb 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -9,24 +9,14 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/err.h>
-#include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/math64.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/sched.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-fsl-dspi.h>
-#include <linux/spi/spi_bitbang.h>
-#include <linux/time.h>
 
 #define DRIVER_NAME			"fsl-dspi"
 
@@ -80,21 +70,14 @@
 
 #define SPI_PUSHR			0x34
 #define SPI_PUSHR_CMD_CONT		(1 << 15)
-#define SPI_PUSHR_CONT			(SPI_PUSHR_CMD_CONT << 16)
 #define SPI_PUSHR_CMD_CTAS(x)		(((x) & 0x0003) << 12)
-#define SPI_PUSHR_CTAS(x)		(SPI_PUSHR_CMD_CTAS(x) << 16)
 #define SPI_PUSHR_CMD_EOQ		(1 << 11)
-#define SPI_PUSHR_EOQ			(SPI_PUSHR_CMD_EOQ << 16)
 #define SPI_PUSHR_CMD_CTCNT		(1 << 10)
-#define SPI_PUSHR_CTCNT			(SPI_PUSHR_CMD_CTCNT << 16)
 #define SPI_PUSHR_CMD_PCS(x)		((1 << x) & 0x003f)
-#define SPI_PUSHR_PCS(x)		(SPI_PUSHR_CMD_PCS(x) << 16)
-#define SPI_PUSHR_TXDATA(x)		((x) & 0x0000ffff)
 
 #define SPI_PUSHR_SLAVE			0x34
 
 #define SPI_POPR			0x38
-#define SPI_POPR_RXDATA(x)		((x) & 0x0000ffff)
 
 #define SPI_TXFR0			0x3c
 #define SPI_TXFR1			0x40
@@ -112,21 +95,12 @@
 #define SPI_SREX			0x13c
 
 #define SPI_FRAME_BITS(bits)		SPI_CTAR_FMSZ((bits) - 1)
-#define SPI_FRAME_BITS_MASK		SPI_CTAR_FMSZ(0xf)
-#define SPI_FRAME_BITS_16		SPI_CTAR_FMSZ(0xf)
-#define SPI_FRAME_BITS_8		SPI_CTAR_FMSZ(0x7)
-
 #define SPI_FRAME_EBITS(bits)		SPI_CTARE_FMSZE(((bits) - 1) >> 4)
-#define SPI_FRAME_EBITS_MASK		SPI_CTARE_FMSZE(1)
 
 /* Register offsets for regmap_pushr */
 #define PUSHR_CMD			0x0
 #define PUSHR_TX			0x2
 
-#define SPI_CS_INIT			0x01
-#define SPI_CS_ASSERT			0x02
-#define SPI_CS_DROP			0x04
-
 #define DMA_COMPLETION_TIMEOUT		msecs_to_jiffies(3000)
 
 struct chip_data {
-- 
2.20.1

