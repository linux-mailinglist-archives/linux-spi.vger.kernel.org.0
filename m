Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACD13FCC4
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 00:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbgAPXMM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 18:12:12 -0500
Received: from foss.arm.com ([217.140.110.172]:34078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgAPXMM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jan 2020 18:12:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9BF11FB;
        Thu, 16 Jan 2020 15:12:11 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 208A63F68E;
        Thu, 16 Jan 2020 15:12:10 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: spi: sunxi: Document new compatible strings
Date:   Thu, 16 Jan 2020 23:11:48 +0000
Message-Id: <20200116231148.1490-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200116231148.1490-1-andre.przywara@arm.com>
References: <20200116231148.1490-1-andre.przywara@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Allwinner H6 SPI controller has advanced features over the H3
version, but remains compatible with it.
Document the usual "specific", "fallback" compatible string pair.
Also add the R40 version while at it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml      | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index f36c46d236d7..c8ccbc2fd1e3 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -18,9 +18,14 @@ properties:
   "#size-cells": true
 
   compatible:
-    enum:
-      - allwinner,sun6i-a31-spi
-      - allwinner,sun8i-h3-spi
+    oneOf:
+      - const: allwinner,sun6i-a31-spi
+      - const: allwinner,sun8i-h3-spi
+      - items:
+        - enum:
+          - allwinner,sun8i-r40-spi
+          - allwinner,sun50i-h6-spi
+        - const: allwinner,sun8i-h3-spi
 
   reg:
     maxItems: 1
-- 
2.14.5

