Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0835B17E2D7
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCIO44 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 10:56:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54505 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgCIO4v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 10:56:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id n8so6263484wmc.4;
        Mon, 09 Mar 2020 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F5xGOMrKR7nRaer20Yd2rHcTxjWiG6/1ok5vvsb80V0=;
        b=LnxcutiSyt+4+ax/l6fYQlvScEOAtPeUZkg3WDm8wUksnP5MaicBF902dwohEJK5Tg
         caDF2VoLkiIS30mVAB8BnrEc1gyN/vUFh4KR9oWJh1/Sw8WnyMz8lDHMbWo7xeE/qppX
         daYFMwtZn5+/f0ajspbn2j4Spg8xfrgZCXTE+pAAJwsY9e1LILEDszN2TTzBd/QQgVal
         QlFGnVHg1nFHBV3ldUhy1bXJAaeRi2XKKqE31DV0CCUZe7CmvQtP9euNzV+k+bVdjQBJ
         KifFwRGDwXsFnV3Y+Kptal7+pnrwnbxopbtXM5aNB+OH3d+l7ZhESOdRflRV7chgivrX
         speA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F5xGOMrKR7nRaer20Yd2rHcTxjWiG6/1ok5vvsb80V0=;
        b=R15YAIwd6syBODkNwIAtJ/JeTTOOYQ2T+1YQjVeX0U1r9+DC6oV7DzwVNZncMTYh1E
         W6PFfZRiBqNGcIMVof63PFMSPvyCe7K7AU1GNkte8XSLQr2zG60ZHqxBkD6nPGs3jzl0
         D7uqfCeT8PFykMjBvu89DkX8eYFfWQV5oxOxYsavFi+HXZmOZX5VolC6rWK9iNlnX7v6
         GGLn0Qm3BZhbFOyu9JTez8nnj3S251zitvosTFld5s7UVjJ9n99Hl8Aq/nrrR2r0akdk
         CRMU5NIcTLnBfslqXSXb38zfw9Da85Q0XRS3uwu3pQmUtjgVyqINbc1ee+o9LcY6306R
         vkYQ==
X-Gm-Message-State: ANhLgQ3Kmo+Yucalk5uDZZNGwC4NYInIAJqWnfg9ouy8Ki372HqicwrA
        x6gFPFjfRxVuzlGJ9KJ7LSI=
X-Google-Smtp-Source: ADFU+vvdcC9S2BjzcTV5FyFgh74913dDChlPyTA7kO1hx1my1611by5thvJ2klLYkuyY/hdwQz3x/A==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr19526931wmg.136.1583765808589;
        Mon, 09 Mar 2020 07:56:48 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id w22sm26905374wmk.34.2020.03.09.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:56:47 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH 6/6] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
Date:   Mon,  9 Mar 2020 16:56:24 +0200
Message-Id: <20200309145624.10026-7-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309145624.10026-1-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

For debugging, it is useful to have access to the DSPI controller
signals. On the reference design board, these are exported to either the
mikroBUS1 or mikroBUS2 connector (according to the CPLD register
BRDCFG3[SPI3]).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index bb7ba3bcbe56..43f403b30dae 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -83,6 +83,20 @@
 	};
 };
 
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+
+	/* mikroBUS1 */
+	spidev@0 {
+		compatible = "spidev";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		fsl,spi-cs-sck-delay = <100>;
+		fsl,spi-sck-cs-delay = <100>;
+	};
+};
+
 &esdhc {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
-- 
2.17.1

