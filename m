Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A817F95C
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 13:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgCJM4E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 08:56:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36291 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgCJM4E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 08:56:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id s5so11822830wrg.3;
        Tue, 10 Mar 2020 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2LDQl7IwXLsgWdbG7WRtsJmahe9ELOlGpRrYf324SYo=;
        b=lxNhQrpbCvDIY90uCxn9ackV2e5ym09lQFAFBY/o3J5La4Tr6bltCGO/l/M7GJn1WV
         aeItkqxWusoI6rOx54r6UQC485PvfypqIBMsNOoW8n5H5WTG0UJpAlqbFCnEVgTYhCur
         z8fDmilP6rK66SETC+po7FWPDW/GYEHpTKcs2izqvPn6O8lwK8kzez76IoH2f4SbK9/w
         sm5DayClua4cPshUqiX8c1/umPhaNj4BDT7a+OoPNHA+4K3OJHd/pO9CAo+TunJ4tIm4
         jEx8X0ne+dbXriVX+KLv98Psb2qUD2fKR0Q83bsz4MFGkl2780r81D8DRKnZxLFnNbU5
         vW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2LDQl7IwXLsgWdbG7WRtsJmahe9ELOlGpRrYf324SYo=;
        b=oFEJVge6RdpJMi1UsfO4yehrPn0MAb21xIKCLNaap+IP3x6JkUsM9dNldgq7D23Vdd
         BQ5w/Zkw6Ncmv9UgEe1WajIga4lum3vDIiXT/vyAdMUEhFoUtx0zbk3HNMJl0QmyEuiS
         +qgskGMkb0PSulJWRRWp++qd7aOtyCJXl29UNtC7EaRyyZv+WgyjO454+O7NGBHopoYg
         syL8RNJUCZNDav9jnPMhY8nilLXYgcLUtLE0tXyT88wqgaDzxpVY4kNcyO1I7HxhNsAd
         vAc8BmuU6yB3uXX+YaN3MKycwV/9XBTUiHPOG/DhZN5402xXayS9wr4l7n1vtk/I9MIw
         d7KA==
X-Gm-Message-State: ANhLgQ2ayejHh61bKOEft+GHPi6Vo7mSy4rNWTPhV/jeHD/zCDWdogrH
        adQ4ABCQQxEfqsmf7kXTWAU=
X-Google-Smtp-Source: ADFU+vttnPba9hD6mVrnvClOOK8HMD0cDCtk1Jsgf9RHvW5Hvh+3+czQ4K4PfLPn248oQkZAfW2vjw==
X-Received: by 2002:a5d:4c4a:: with SMTP id n10mr28574797wrt.116.1583844960527;
        Tue, 10 Mar 2020 05:56:00 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id t81sm4018594wmb.15.2020.03.10.05.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:56:00 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 7/7] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
Date:   Tue, 10 Mar 2020 14:55:42 +0200
Message-Id: <20200310125542.5939-8-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310125542.5939-1-olteanv@gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
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
Changes in v3:
None.

Changes in v2:
Change compatible string for spidev node.

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index bb7ba3bcbe56..13555ed52b89 100644
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
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <20000000>;
+		fsl,spi-cs-sck-delay = <100>;
+		fsl,spi-sck-cs-delay = <100>;
+		reg = <0>;
+	};
+};
+
 &esdhc {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
-- 
2.17.1

