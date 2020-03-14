Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3365C18593B
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 03:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgCOCle (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 22:41:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39766 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgCOCle (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 22:41:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id f7so14299356wml.4;
        Sat, 14 Mar 2020 19:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+cFH/KTkYwb8Oxu2WFx0ksQZ4BT4hgzNZrfPLfoH9sE=;
        b=N5TanJlLuNd057zayBCmJgpNLKm6hhcE2hEfL46v3y94eVwg6MRoVzqwFk2CgcDuWN
         Z29KiKjKBvDPW8JKlZ58HpDUK4U/UK1hY2qn/TbNzmmB+cly/PF4ZkZS44H2XZJ06zve
         YINhPLKxnNOQo8QRVXAV0rgtaL20TiiRUSVh62hnTtsWrbTRcnMfOFOg462BtJdcrSuu
         44K4rDGO4OOq3+GoOgKIggKz6tQSaCpcqHIKWJ3brOussdbTgR8qlSJ7xVzr3CUBOXjH
         JeY1eXvBAQhqFr08L18EzLDzd4nn3rxocgh1am4bQBVIVrJo7jL2UZReOb5/ZUf0nwpi
         3ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+cFH/KTkYwb8Oxu2WFx0ksQZ4BT4hgzNZrfPLfoH9sE=;
        b=n1LihdweoXD/u6mxEgCbFUNi2OhIHObz9NbTJCoBYPHCQHutI4fuT3vEmbkhvzRuhl
         YnSaG74f4aKOdxTXqzw66fScOSfb4liQAPnh3uWAlOlaW0UqbCIi49fJkvZntfkCPNbG
         S2RISq9rGgzTFLRF2Ffzv0ZmroGwhfWYOJrXq7PP6lXYhDxCLWCqhYJIbRPQ0gpZUMG6
         CsdwMbuce7pW/qrJTb/6fFDqr7tXCt2y6Q1+mbX5V/DqaUN3EiDUtQ6qf0immpBAAh+8
         vDgHD6MNIto/4cOZbUN/iB6XpjkO6JxhgaPj15k5cHGnkUlHaDtD3WKSWWEf9fZ58MM1
         l0BA==
X-Gm-Message-State: ANhLgQ2MiwshJ2yBWzF3NSB7/1MfKZ9qQmJUKRbaHTSvKfOUil9BHTli
        0/L38PjlEJ3uVFxeanccTroHTgdbDv4=
X-Google-Smtp-Source: ADFU+vsXI2K+vPYStFsw/mm8L5Y8sQANb6LojFU12k3vnOmVW9BiH2h9eh7B6ics8Sf7yPNmSkSFqQ==
X-Received: by 2002:a1c:2ed2:: with SMTP id u201mr17997718wmu.3.1584225852908;
        Sat, 14 Mar 2020 15:44:12 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:44:12 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 12/12] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
Date:   Sun, 15 Mar 2020 00:43:40 +0200
Message-Id: <20200314224340.1544-13-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
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

