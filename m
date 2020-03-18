Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC91892AE
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCRARZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32894 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgCRARZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id r7so1068369wmg.0;
        Tue, 17 Mar 2020 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KAXWu0UANDOVatXihProEuzz/73Lcoq083Tlz6zFj1c=;
        b=YYUwe03PUuNG50h89cb3aEGYaLRC8phyef/6VGQ9Nh1CTR05B+SJ3fswY+FiI5ccia
         fQYToImXXpkKNToZD30gpK8F357fG9i9sF91tYjq6qeIPK8iXNbfgvfRJTSXqT29HbGo
         oZu+VVnsOcwnK7nFxmGOhKXLTZkYXyc0wYZUKVxOBpRe72djfsvbs+5KfHWekD8EzK5K
         b4I0Lpo3oeg9QG1LxsVRKEGLbMrIZIVaZbfL/rSKB1YkOfbpRU6Bl2tyzdQzffa3UtFQ
         JA3zLOcGpR7T8/SUvned7VSNFtmV8sUmEkMwmu/ClI+Bd3tSPHWpI2qrrrEms5qMx7XG
         2log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KAXWu0UANDOVatXihProEuzz/73Lcoq083Tlz6zFj1c=;
        b=CkYyBWiE4855o+r6yWSBQ4/WY2hzzrZYFN8aul1W2P8CtP5qoGFknbv4mhNP3KEUNO
         rTwMop/7wZPiO6wENPRlKWB6XCnUV3y8Lx3kfGhvSP61chrRkPPk72XaHBEmEYoLn4ny
         TbsAk/pTK0K+JkYgEy18r1EzprZcDJjm93vinIBg9OUgIE6UVvaOMwM3SPxlTrW1nlyx
         I8NDra4KIAU6YfriTAoJn1iA1H3HsodVMqC4OdeOJjJNJvh3vljx/47ZGuYeaQqf81lx
         ieeKY0AxXP9It3YnUx4lFw26M1Whkgda5qNJNO0XsfH++AkXSyhxoOCrLyxsfBw5QVRd
         0IYg==
X-Gm-Message-State: ANhLgQ2CE7eLf3yiawH231fn7ep+Sp+jIN4uCrib0XSQ1mZs98gtds98
        oufDkhY0qWQWBNr/AJEUQsY=
X-Google-Smtp-Source: ADFU+vsKo9J+cypNb8ARLgt7IQtM0UosmL8XHUoariuqjuXHG+bgJ7JdHUk/RH4KYx7B5E8osBOsjQ==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr1543969wmh.65.1584490643264;
        Tue, 17 Mar 2020 17:17:23 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:22 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 12/12] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
Date:   Wed, 18 Mar 2020 02:16:03 +0200
Message-Id: <20200318001603.9650-13-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
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
Changes in v5:
None.

Changes in v4:
None.

Changes in v3:
None.

Changes in v2:
Change compatible string for spidev node.

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 6d05b76c2c7a..0d27b5667b8c 100644
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

