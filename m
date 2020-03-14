Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415611856DD
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 02:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCOBaX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 21:30:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33936 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCOBaV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 21:30:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id x3so10619014wmj.1;
        Sat, 14 Mar 2020 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBPKD7LpU3yqMiH8MVzfGEsgDmj4SrKt4IrZ9Xh2cD4=;
        b=Hvu9wNtERwqWL9oTqlv0Mt0p+j+G7ms1qpFerKoFgE4QFNqSPNzNPYHEToTRVI0q+1
         3rL36OWzXWhyeiTllCadGwccizkgzkUVIzs4l81DnDHmMNyz5Ci1eTzjWWunyqDMNjhS
         l/tDTSlPCI0tI39EOrdKfTwsZzdwmfArskef/EVRf3e2yID1R4rkHyJzqO2XPYAsPFYa
         XUSSTeDwWQb5tb2s6XciBN0NS9+H7gJqgqmV92guWC/E8yF+gxzqhZbz9H5mhDLP5pb4
         KWgWpfi+tsjUZngGfETxntwka9lTMu0hsO0QCfuBFQcRZfEwwao8DVyC29Qb25BOKWW8
         Ks7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBPKD7LpU3yqMiH8MVzfGEsgDmj4SrKt4IrZ9Xh2cD4=;
        b=MtuvJzHbcupV0XLc4JYOPfjtVSGX62tVHV96zpWVfd5VyQQhBhN0VCubzfS06S5Kx8
         V+3wws8qfr+5TJABMiUrZPrJP+NDOynYA8FCFgvk9Sw3TePJnwJqQlOczt2fha3LIThP
         2daksCL6qD/sOuOewc5lRd3yKsRDajXDL4Ps5NKKNL3ELq+FN93vcd5SPQ7w+ga1l7ld
         hsP1o9MrJiCTkEpi13GUtiSnLQCeqQR7l4geJWvCbZww0vc6EJQUJvjeo0uEbx3vSo6N
         q1kMAcYxdXrfqH5MT1kmodWDH114A1rnjD+pkMDQzsYgCVEzU0Dyt3F2chrNdMIYkAfY
         EkwA==
X-Gm-Message-State: ANhLgQ0op2xONHXeXYNrTBm/KG6IjJ/AwxWfRUV9pliY+HJNmwe5W9zm
        q1enCbh4jqIRHfeQx61+v6CR9orrM3Y=
X-Google-Smtp-Source: ADFU+vvbbydBra6U/4TidOrG8bvR2ZNiPt2/6iHMVjTXnibkGLn6+r72iDETXFJiDWgGUdwBkgmYIA==
X-Received: by 2002:a1c:6387:: with SMTP id x129mr18412016wmb.58.1584225851584;
        Sat, 14 Mar 2020 15:44:11 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:44:11 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 11/12] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
Date:   Sun, 15 Mar 2020 00:43:39 +0200
Message-Id: <20200314224340.1544-12-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
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

