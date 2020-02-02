Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8368914FD27
	for <lists+linux-spi@lfdr.de>; Sun,  2 Feb 2020 14:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgBBNAM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Feb 2020 08:00:12 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39857 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgBBNAM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Feb 2020 08:00:12 -0500
Received: by mail-yw1-f66.google.com with SMTP id h126so10505018ywc.6;
        Sun, 02 Feb 2020 05:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SsuOPfBklrufoFfToRN135Zc2rs5UCZymJ1rqf8A5fk=;
        b=ijQUUDtGpKwfUbhvL5SVvpt+vqVbACJ6PiX35Y/j3JCg7NaDX+nNFSzWxCY9E/N1as
         KJIQssRUYrJ5ld+sdSLiWQT9E2gNxGNdFY/oX0piRs9BzNuBEK/HbIbQKIjNgviAQnq9
         mIwSnp/k7mxRI5y1lQ4VZyUsZdxrL65GNXGr5NXT/beG5LN/rl/Un2kFCUF4RqpQMCJ3
         hNqY4MRMggzNmJ5mwJqGINLoxEJWLQO70fK6nhvoDmmskdGFHYtIE9nS/HD6aXZvm6k1
         QGoty3d4PEiK/vAk9l/jlWPHACltCHxjsjYehOde4gXI1v3qJwEgchSPbFBAZIN7TZwS
         vUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsuOPfBklrufoFfToRN135Zc2rs5UCZymJ1rqf8A5fk=;
        b=DhOQmaZc1c+JH2t7pCvrWS1fUwQxsbfk+ET4rCclULluzs8+qwd3B/DVwq8ToYUVKv
         RxrkBh0HnBUfnLIzc9uxO89RM+PTgU/dFjCMtyvOcoiQG/quXRA1EYCUvXVrZLsiRUrO
         Rhv9xihD+Mejl6KhxiDXveQjij0U3PnMRgJC03xfB1fbWE0cw5ErBv1rWw0Nio4gVJgi
         uII/OqY2rJex6oXNo/r4jiz6bCDWZ9tkvc5b4ECIxCgiLxsGxHJFP36uzowdNbpdJWxm
         c2LgUW1m85OmZBK4mC/slRAA66cIs8HY2aL6R3fs/55umjB3i581nCgUbCRN74TV0WO5
         3MCg==
X-Gm-Message-State: APjAAAV2ocWocHneCi+Flaeu3lmSa7tJLIkXZuTCZG+uxyhheMOFueSE
        LJ4sb1tvCnkBcrAT98P0lSyjDnnv0NE=
X-Google-Smtp-Source: APXvYqxcps2+b1RjCFnMPuOPzXi0K2uJFw8vIjvBLVbqj1s91p0IDLSQuX06wGYKgxezMcLqCo3DQw==
X-Received: by 2002:a0d:e802:: with SMTP id r2mr15745234ywe.471.1580648410303;
        Sun, 02 Feb 2020 05:00:10 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id m137sm7090013ywd.108.2020.02.02.05.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 05:00:09 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Han Xu <han.xu@nxp.com>,
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
Subject: [PATCH V2 5/5] arm64: dts: enable fspi in imx8mm dts
Date:   Sun,  2 Feb 2020 06:59:50 -0600
Message-Id: <20200202125950.1825013-5-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202125950.1825013-1-aford173@gmail.com>
References: <20200202125950.1825013-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Pull in upstream patch from NXP repo to:
enable fspi in imx8mm DT file

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2: Reorder s-o-b lines to give credit in proper order.

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 1e5e11592f7b..679769fe6cab 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -558,7 +558,21 @@ aips3: bus@30800000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x30800000 0x30800000 0x400000>;
+			ranges = <0x30800000 0x30800000 0x400000>,
+				 <0x8000000 0x8000000 0x10000000>;
+
+			flexspi: spi@30bb0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_QSPI_ROOT>,
+					 <&clk IMX8MM_CLK_QSPI_ROOT>;
+				clock-names = "fspi", "fspi_en";
+				status = "disabled";
+			};
 
 			ecspi1: spi@30820000 {
 				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
-- 
2.24.0

