Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB3B7D7D4
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 10:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfHAIko (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 04:40:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60322 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfHAIko (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Aug 2019 04:40:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 33B701A0B33;
        Thu,  1 Aug 2019 10:40:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CBA511A0B3E;
        Thu,  1 Aug 2019 10:40:36 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F3A5D402C9;
        Thu,  1 Aug 2019 16:40:29 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 1/3] dt-bindings: fsl: dspi: Add fsl,ls1088a-dspi compatible string
Date:   Thu,  1 Aug 2019 16:31:03 +0800
Message-Id: <20190801083105.30102-1-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

new compatible string: "fsl,ls1088a-dspi".

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index dcc7eaa..162e024 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -6,6 +6,7 @@ Required properties:
 		or
 		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
 		"fsl,ls1012a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
+		"fsl,ls1088a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain SPI controller interrupt
 - clocks: from common clock binding: handle to dspi clock.
-- 
2.9.5

