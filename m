Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82155158F34
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 13:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgBKMyR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 07:54:17 -0500
Received: from inva020.nxp.com ([92.121.34.13]:48932 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgBKMyQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 Feb 2020 07:54:16 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F6831A355E;
        Tue, 11 Feb 2020 13:54:14 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A20C1A354D;
        Tue, 11 Feb 2020 13:53:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CB51F40297;
        Tue, 11 Feb 2020 20:53:45 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, andrew.smirnov@gmail.com,
        manivannan.sadhasivam@linaro.org, marcel.ziswiler@toradex.com,
        rjones@gateworks.com, sebastien.szymanski@armadeus.com,
        aisheng.dong@nxp.com, gary.bisson@boundarydevices.com,
        angus@akkea.ca, pramod.kumar_1@nxp.com, rabeeh@solid-run.com,
        cosmin.stoica@nxp.com, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 1/4] dt-bindings: spi: imx: Add i.MX8MM/i.MX8MN/i.MX8MP compatible
Date:   Tue, 11 Feb 2020 20:48:24 +0800
Message-Id: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible for imx8mm/imx8mn/imx8mp.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since V2:
	- fix typo in commit message, compatbile -> compatible.
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 2d32641..33bc58f 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -10,7 +10,10 @@ Required properties:
   - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
   - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
-  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8M
+  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
+  - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
+  - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
+  - "fsl,imx8mp-ecspi" for SPI compatible with the one integrated on i.MX8MP
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain CSPI/eCSPI interrupt
 - clocks : Clock specifiers for both ipg and per clocks.
-- 
2.7.4

