Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBCC18D3E4
	for <lists+linux-spi@lfdr.de>; Fri, 20 Mar 2020 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCTQOB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Mar 2020 12:14:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34943 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCTQN7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Mar 2020 12:13:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so6995357wmi.0;
        Fri, 20 Mar 2020 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3tKnuzyIhGtfcJxu/aubezG0WoRFs1qYucKlMVKdm1I=;
        b=Ohj4WaIv5m7gBD3qRTznJYM59oveqQkvjuoASbLUS2YbMvla73uIZfJhHTyBhuxrjy
         XTDUNQr9NsQZp0rCDUk7LvgvfCgkqZesw0nOOYa5K0czGIX1n9GBNJHvE1FkQJQCtDXU
         hoQmAqAPsKyPwZarevDYV2XGJTFbdBA2XxCODcvvWQ57ofd1Zpq57oCPGEQSXIInyWF0
         c7i7ETuuawR6Sek9yzO0K+lyOKgdZ+YOBEq5Yug3Zqxdog3HHsKCRkC9/arG7j7KPQJV
         KrZvAOO1HtOacOvL6qbwaWhQxEOeKrxJwEDKNM5hTF28P9rCdPdIKJnxRE8Eir4iCwCY
         x3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3tKnuzyIhGtfcJxu/aubezG0WoRFs1qYucKlMVKdm1I=;
        b=K2HgV9KLw5CyS/4ftp+thXb0hG37zVB6wbC63XymSfn/7/cCKfswX4w7Cn2f7Mf5cc
         x03MGrLhLEzE3aP3XzrrzAcZkoIDjfRqwQAdpys5jhKisHoLu1fCvTOG2G/YFa03zBjJ
         5r+upF7SjkJAm1gwE00IJkkfvxu3oXPTWanGI2UlHoL33RlNyYUcjGN5Ndwj2ZvU0fTV
         3GQkQk9MHEd2o56ialAnD8Y4l/MteQ8OphObOT1Q296LLPe6NeRp1FVXWXHNtHY8pFX1
         wkS0lcjDedJODhDDGopAKWPj6X6ej9bvIAzhMDm7K1rH7DCOs3t2GOSalYMEtP97w9Zh
         wt5g==
X-Gm-Message-State: ANhLgQ09u995gkB16g+P3cFRxEB036uMqLp4ipjeFaAAXko6kXX5D6K+
        KJ/qjPcfuLJoGCTRqc6Fv4c=
X-Google-Smtp-Source: ADFU+vsrKrr2e57uWV5YuiO36+J0taf8dQgtGCBEGWN9JOBE0tIXL83Nue56sM5mhc3UF4v1h1pEaQ==
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr10114381wml.38.1584720836497;
        Fri, 20 Mar 2020 09:13:56 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id r3sm9121154wrm.35.2020.03.20.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:13:56 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH devicetree 1/2] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
Date:   Fri, 20 Mar 2020 18:13:45 +0200
Message-Id: <20200320161346.14155-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320161346.14155-1-olteanv@gmail.com>
References: <20200320161346.14155-1-olteanv@gmail.com>
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

