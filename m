Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20F17FD28
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 14:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgCJN0X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 09:26:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34479 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgCJM4A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 08:56:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id x3so713093wmj.1;
        Tue, 10 Mar 2020 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VLDdKHutiGZ5j/da9RiNBF1z620DpQjrWhoi+wnkAks=;
        b=tzw71jBuQlPaAugyIpg+S02LfWWCTiFq0XgGRWZx7NPKF9FtLWjmcvM7i5C4Iihx+I
         qSLHI7G9ZEAJz/8ASDM+Xwyyxy+a3IS2QU/w1w5k+uLIGQw5sVIdY86jhXEb2tdlLCb5
         T4lJNZBEc5z7mul3FNPQTXgmbkVHEr6DFIiKx2ORp8QtsPicfaODYIeV2y4MveSls6Qx
         Z+xakFeYyp1SCbOtkiVIZoorO7npSJfO3Qs4Qdz5TKT21SxPzdjlAgZbf5MllaPdj/85
         UsAhZAv6QUIZoaeKk2by6RRCLpC3AV0cG7kH0/7hkVt3tLVSv2Vc40uT0+R4ly/5Y1zU
         spvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VLDdKHutiGZ5j/da9RiNBF1z620DpQjrWhoi+wnkAks=;
        b=SYMopCPpv3HraPE4FXIZKn5PfTvOAT+gH3LHXjsOQkP0oVMSAv97zuSmoNa69NCnyO
         HHPKg38CRIQ6Yj2ErK0YcRDZ6gWe96axb7H1H12vIzbiQKMuDOHoG1MGjW+DSi/iiEko
         zOE/ZfDMYFSqc/6h5qAejflya3xdbaIcmbw2KQJK4WYT9vQMI2E4ouH0eXCR/7Q1mff+
         1lDLWpuC10ZXF+O80Zsyqa0SPYXaQsx+jm8kuEd+qaT6NcMJW+Ba35mFtJq4snfZOLtd
         QhKn6ACRiLxg8RcYWdukfEZn76wP9NxG8UA4C6JbyLNhnsx7Y31uRyFyDftnlxze4oJj
         qQYg==
X-Gm-Message-State: ANhLgQ0w0QB5LIUu5VOWtYKg7P5QLmMYxZvciuOyt+woxRRxBVZ0eNzO
        KUuegBu/pQ/QqrPCHVmwUsk=
X-Google-Smtp-Source: ADFU+vte0i3R1bbs4utymUqUI2PnS8WJx/xlpXtoYNvKWWQaBO6W5FtTYMK9O7MZL8PXPbRYf+7XOw==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr2194107wmb.154.1583844959124;
        Tue, 10 Mar 2020 05:55:59 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id t81sm4018594wmb.15.2020.03.10.05.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:55:58 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 6/7] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
Date:   Tue, 10 Mar 2020 14:55:41 +0200
Message-Id: <20200310125542.5939-7-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310125542.5939-1-olteanv@gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
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

