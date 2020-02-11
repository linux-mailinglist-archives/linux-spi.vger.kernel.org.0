Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75183158F42
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgBKMyW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 07:54:22 -0500
Received: from inva020.nxp.com ([92.121.34.13]:49054 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgBKMyV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 Feb 2020 07:54:21 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B62711A3557;
        Tue, 11 Feb 2020 13:54:20 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 344C91A1CD7;
        Tue, 11 Feb 2020 13:54:05 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 12F8B402E0;
        Tue, 11 Feb 2020 20:53:52 +0800 (SGT)
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
Subject: [PATCH V3 4/4] dt-bindings: arm: imx: Add the i.MX8MP EVK board
Date:   Tue, 11 Feb 2020 20:48:27 +0800
Message-Id: <1581425307-18567-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
References: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add board binding for i.MX8MP EVK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No change.
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c5b0270..b8c8c72b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -324,6 +324,12 @@ properties:
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
           - const: fsl,imx8mn
 
+      - description: i.MX8MP based Boards
+        items:
+          - enum:
+              - fsl,imx8mp-evk            # i.MX8MP EVK Board
+          - const: fsl,imx8mp
+
       - description: i.MX8MQ based Boards
         items:
           - enum:
-- 
2.7.4

