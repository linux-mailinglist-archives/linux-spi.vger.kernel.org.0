Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 739AC17EAD2
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 22:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCIVIw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 17:08:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42910 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCIVIw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 17:08:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so13021448wrm.9;
        Mon, 09 Mar 2020 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3+pDepDyRd9WIgsrKAnVdJt5zeWPjx4zXJajcwJEkC8=;
        b=YYjBZ90UQunn2F8G3mVjPWqz4msh8jVIw2W+YsV4erRhiDx3EgaPVm47CrxFLKX5iD
         fdZdCIOv4SBPx8tdJKJt7Bc69XMYFF/UJbBbTgVcbH6Qif20OGc2A/SsfX230CVAMMaZ
         SjJgnG1FpYfPyp+n3i3ExSQqaAwZJD9uLwIxnT6ogwxmyZLUBrD1zOzM8cht/JeTEHje
         2uKeION61n0HiUQbW5ChJ8gZOPrL6uqPRTiitJRH0F6GR9ITVTxhL+WI2zD/Ye7xNAMQ
         +VMXSNUvYOA83qwBdhHDx/loaeify5KtNI2xsTVcMFVR5Jb/BoInCMl4VGQX8i9hZrS3
         ApqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3+pDepDyRd9WIgsrKAnVdJt5zeWPjx4zXJajcwJEkC8=;
        b=mmffplLlc+g4JwLMMSKXQBWf5ecCMEXwI7Ijq3ypdzPfoenzbEcYziC5WvuLhUrHVo
         Y7CWtniVQy8LuqQBaQVPizV7kjzl69P1JbhgW4u8kRKMqhhSotddOlzavXueEwnByWSG
         46u/mBheET+1VSwEHcw2AoMQNgIIKFUvnQNR+da4VkdErgCfB0zAlBDPtDjy7O4Egs1L
         M9cu5kqPiF4IkazJDjZ7qCQNMKlYOLRruZ1y1kS9lEOborT2HScJH5o+jQKMDPt1KZL7
         s6Nr0Bsgc72u2XwlKmsnpEev2Kf3ZE6noB9Iyq+/Fpcot+DfBQkiSePsOjmPxiTX1Wbn
         SD+g==
X-Gm-Message-State: ANhLgQ272zccZxfy8ovsMCLTtVWkGl3219ms7nQZmoqESzMceFBdxER5
        1TJEe3gId8fAp67cIthaUhc=
X-Google-Smtp-Source: ADFU+vuLGgm5z604QlSI/vPeJh9b9W6r9PDuFcm3SzqgCTn7hktSoOptMylhwduYM0hpwRj6iiyR6w==
X-Received: by 2002:a05:6000:44:: with SMTP id k4mr8141644wrx.205.1583788130125;
        Mon, 09 Mar 2020 14:08:50 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id j205sm1016275wma.42.2020.03.09.14.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:08:49 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v2 5/6] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
Date:   Mon,  9 Mar 2020 23:07:54 +0200
Message-Id: <20200309210755.6759-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309210755.6759-1-olteanv@gmail.com>
References: <20200309210755.6759-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

LS1028A has a functional connection to the eDMA module. Even if the
spi-fsl-dspi.c driver is not using DMA for LS1028A now, define the slots
in the DMAMUX for connecting the eDMA channels to the 3 DSPI
controllers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
None.

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 515e0a1b934f..18155273a46e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -298,6 +298,8 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 0 62>, <&edma0 0 60>;
+			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
 			little-endian;
 			status = "disabled";
@@ -311,6 +313,8 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 0 58>, <&edma0 0 56>;
+			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
 			little-endian;
 			status = "disabled";
@@ -324,6 +328,8 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 0 54>, <&edma0 0 2>;
+			dma-names = "tx", "rx";
 			spi-num-chipselects = <3>;
 			little-endian;
 			status = "disabled";
-- 
2.17.1

