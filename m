Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A98F495FA0
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfHTNOb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:31 -0400
Received: from mail-wr1-f98.google.com ([209.85.221.98]:33177 "EHLO
        mail-wr1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbfHTNOa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:30 -0400
Received: by mail-wr1-f98.google.com with SMTP id u16so12363252wrr.0
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=tghGK/IpypiS95FEbFLX9SDLqBUwGKtyO3Shfplc7JM=;
        b=AeJpurPDy9BhpWvKvpjcYZxbAGVEoJcg/MbDNmmH1s2sFffGZf8C+VVEpd0kLfj5Zn
         QLsL5nfcpM5IJ/J7f2bX7iNOWIqYZWB9OOy6ou/8Hv5NNmDoT0MN7G/ZvaBDg4oX7xIW
         8K+tQd5ABTo9K1GP0hpGuRfGiw4IQ07mi40EmMxLdZAROaZjovB4XBtTuctkWXLyuJx/
         LeR65rAh9QtiloRyOmtIWWqiGRC5NYnawfn6qRU6/ns1CEBxARPXNz8cukKCfyTOVJEY
         vo1LfF3N8DKTW+4RetpNZNScH3CfVq/JAVVwCBq8X2YyJMGMyQQ/+IENz23p+BPz9WsT
         +Mfw==
X-Gm-Message-State: APjAAAWhDOR6OgJyMOX/hWr/M+/rneVVIJS9bn3SQGxZLcxk4m0/s8ah
        OySIGCyezDaMjMaw++R57GBwf4VTYLNaIYJcq/3lVQN9tCmS/0Oqie90YF762z8InA==
X-Google-Smtp-Source: APXvYqw3pE7zcjTKlIyQft0ik3raqTrTVYVcQRJtwytSJdjm71YXvLlwm0l+rz4t3AmUhY3YJu7teSKdOibW
X-Received: by 2002:adf:fa42:: with SMTP id y2mr34557284wrr.170.1566306868408;
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id i17sm320262wrn.5.2019.08.20.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03y0-0002MA-3V; Tue, 20 Aug 2019 13:14:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 995D42742ABD; Tue, 20 Aug 2019 14:14:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Demistify magic value in SPI_SR_CLEAR" to the spi tree
In-Reply-To: <20190818180115.31114-5-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131427.995D42742ABD@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:27 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Demistify magic value in SPI_SR_CLEAR

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

From 9e6f784e66cb865de25a1f5fd1706a45d9e298a7 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:05 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Demistify magic value in SPI_SR_CLEAR

This patch adds the field definitions for the SPI_SR register. The SPI
status register is write-1-to-clear and this value is written at init
time.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-5-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 179a9818619f..923ee414d1ae 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -57,7 +57,19 @@
 #define SPI_SR				0x2c
 #define SPI_SR_TCFQF			BIT(31)
 #define SPI_SR_EOQF			BIT(28)
-#define SPI_SR_CLEAR			0x9aaf0000
+#define SPI_SR_TFUF			BIT(27)
+#define SPI_SR_TFFF			BIT(25)
+#define SPI_SR_CMDTCF			BIT(23)
+#define SPI_SR_SPEF			BIT(21)
+#define SPI_SR_RFOF			BIT(19)
+#define SPI_SR_TFIWF			BIT(18)
+#define SPI_SR_RFDF			BIT(17)
+#define SPI_SR_CMDFFF			BIT(16)
+#define SPI_SR_CLEAR			(SPI_SR_TCFQF | SPI_SR_EOQF | \
+					SPI_SR_TFUF | SPI_SR_TFFF | \
+					SPI_SR_CMDTCF | SPI_SR_SPEF | \
+					SPI_SR_RFOF | SPI_SR_TFIWF | \
+					SPI_SR_RFDF | SPI_SR_CMDFFF)
 
 #define SPI_RSER_TFFFE			BIT(25)
 #define SPI_RSER_TFFFD			BIT(24)
-- 
2.20.1

