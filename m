Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0F8B568
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2019 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfHMKX0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Aug 2019 06:23:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33966 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfHMKX0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Aug 2019 06:23:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A1C61200154;
        Tue, 13 Aug 2019 12:23:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C1DD3200783;
        Tue, 13 Aug 2019 12:23:20 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8636B402F0;
        Tue, 13 Aug 2019 18:23:15 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-next@vger.kernel.org, Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: [Patch v4 3/3] dt-bindings: Enhance binding to extend example for flash entry
Date:   Tue, 13 Aug 2019 15:53:11 +0530
Message-Id: <1565691791-26167-3-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add example for adding flash entry on various boards' dts
using flash manufacture spansion/cypress.

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
---
v4:
-Add new patch to series.
v3:
Not present
v2:
Not present
 
 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index 2c2a3e9..7ba0472 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -35,7 +35,11 @@ qspi0: quadspi@40044000 {
 	clock-names = "qspi_en", "qspi";
 
 	flash0: s25fl128s@0 {
-		....
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s", "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
 	};
 };
 
-- 
2.7.4

