Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B01892B1
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgCRARn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36919 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCRARZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so1340804wme.2;
        Tue, 17 Mar 2020 17:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+CKolpVnm8hPQhvF+U00QiMPywL83J4L7WoEEVZs7Y4=;
        b=YAxGVZFKelCPAISTEeyY4J0MmWrW07hpzp9IU8uQKMN4Aa7OsMiziNbrQWK1ajVUi+
         +5HaKrqbgiFl2JxHpv+Ocj7PKxV6+HSst48MNughMD/Cg+gi132mgfm2gf4bvgVN7y0F
         Dn3U0KqLKcxm71AmfHoXnisFON5LYrIWqCD51WegBUpIpVvbsY2gHipfy++OhQ80exiI
         NYgcq95rQwRysBu7tnSwE6+qF2uiBSS+C2RQfqBs/9cmV5jyKFqhamRqQdtCfFp8nhR8
         TASfCtSfJPQ/pAUl9By8bxbifcPv0tlZa3SAVvUgwBl6rGdm3GxmrRqzTVAJTDwQZKRT
         NPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+CKolpVnm8hPQhvF+U00QiMPywL83J4L7WoEEVZs7Y4=;
        b=j51szrA/dyuH+zOUPQ4qAVn5umL8lxL/NYGzrTl+YQf4CdUIqnoMFO27r7Hyd0XDWB
         PQId7Tmi55IPdYf8qCC11PLqMvwxQWxTWpQnjKzF0lzb7rPZZJ8b5Ubs86O8Y5fKHX0W
         Xe+CHgqM0YxkayQ2zqnAN4yxG90qFNtLEhkSN2ugYOfzMR6lBHoL5iHJbf5Jjzf7bxrT
         g/DJc+liSDrSA6YuzjLB0Y6MSN/HHIHmV4aI0LeC09l+kqy9bc/Ik7b3YStBmEWJnVF2
         OHotwqq0Hmj+OBFAYTHxHfPJJbwwiiLCjEPIpbSzbM3CT6meGNF1AT0FE0f59pC+w4Xc
         pH8Q==
X-Gm-Message-State: ANhLgQ3vNPpPGacVp83kPr1ANmeRZ9F22fSeH4SP3dYJh78CkzHd8qUx
        1SUMJalAHLUOYYVnYFMmwPk=
X-Google-Smtp-Source: ADFU+vvywxHGNmBFE/MLWUrifPTd+P13bsgmQ+bsVntWw9X6dBtFt8DNpz0JU2lOTRvskN/Xq80jKA==
X-Received: by 2002:a05:600c:2713:: with SMTP id 19mr1663760wmm.180.1584490641895;
        Tue, 17 Mar 2020 17:17:21 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:21 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 11/12] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
Date:   Wed, 18 Mar 2020 02:16:02 +0200
Message-Id: <20200318001603.9650-12-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
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
Changes in v5:
None.

Changes in v4:
None.

Changes in v3:
None.

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

