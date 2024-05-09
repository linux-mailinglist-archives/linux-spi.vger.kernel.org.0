Return-Path: <linux-spi+bounces-2793-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FC8C08D3
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 03:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975BC1F216EE
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 01:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C7513A86E;
	Thu,  9 May 2024 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I1wJ3XVH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89413A245;
	Thu,  9 May 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216759; cv=none; b=dPuxqnpJPJsfu6LhELfHdayAeB6OdEeYvx25BuFeRoEQSd8ucx9Zqsob5XuHZIonZxkwzT6f6Sf9/v95yv08sE+UGEv2Y3nQf4OsmjwGt0G5+mfF6J9ETfxaxEH1p0L0MpcM3UhgCUTHUpLESF6I1PI3yiMdJjDvT8/zJRtkPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216759; c=relaxed/simple;
	bh=3cjIh4Qli7FDvvsXvXXKGmJLQUnXaVa2tNXzrfhqq7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdVPaqcRQ4t1+hU9TCfh5CNTO9etnHYigFJZUFDJDRj6RVPzNGJhk8k4HkknEkgvhBfkh6cmXfKrNbfSmwJSVvGwbJisXcXKr1eilgPbap8xPdrDVuHaCK7cvT67DiUZi2BIe2ku6sMTP4TpquanBzo9s3LfsJidwId1jcm0XCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I1wJ3XVH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448NOrIr003000;
	Wed, 8 May 2024 18:05:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=ob9Itpg/VSR86N6iOe+rkwH5s23snAxD1GlheD9Sn9U=; b=I1w
	J3XVHVqzrk1YQIvES/crW3FDnhc2a1sbdUMX+kTu1CL0cI6LAkEXIGxfSQ7vKgnv
	Pm808HHusWDN/kp93ZOcQQEeHPsv7K42TjATafisvsE8B7PmRGJH2O1hCXbRKoIX
	Nvp/Cphe/5r2VVguXQgSAlXSld0v/YkeWS+m7RJP7efVoKM6gKegzawp/rM7GbWT
	Ao54Rf2RBicqHWX4C8PvsHSTmB3zE8fdhdbZlDdRtIO7tqnrX/OqYDZhQJpB12q1
	sKjRRPg8Kq68aYGHFqbcKFMtUj0WpSLqeZBgEcy5TL76FzrYp5Vowu7KXLPoF1Ph
	UKKbsT+PQnHVTyvgIBw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y0b2d2g18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 18:05:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 8 May 2024 18:05:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 18:05:52 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id E15315B694B;
	Wed,  8 May 2024 18:05:51 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v4 2/5] dt-bindings: spi: cadence: Add MRVL overlay bindings documentation for Cadence XSPI
Date: Wed, 8 May 2024 18:05:20 -0700
Message-ID: <20240509010523.3152264-3-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509010523.3152264-1-wsadowski@marvell.com>
References: <20240509010523.3152264-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QuAmY8kxl0SC-Ls4mKs8vjDTnhBK9iYt
X-Proofpoint-ORIG-GUID: QuAmY8kxl0SC-Ls4mKs8vjDTnhBK9iYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_10,2024-05-08_01,2023-05-22_02

Add new bindings for v2 Marvell xSPI overlay:
mrvl,xspi-nor  compatible string
New compatible string to distinguish between orginal and modified xSPI
block

PHY configuration registers
Allow to change orginal xSPI PHY configuration values. If not set, and
Marvell overlay is enabled, safe defaults will be written into xSPI PHY

Optional base for xfer register set
Additional reg field to allocate xSPI Marvell overlay XFER block

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml    | 78 +++++++++++++++----
 1 file changed, 65 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index eb0f92468185..094f8b7ffc49 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -17,22 +17,43 @@ description: |
 
 allOf:
   - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,cn10-xspi-nor
+    then:
+      properties:
+        reg-names:
+          items:
+            - const: io
+            - const: sdma
+            - const: aux
+            - const: xferbase
+        reg:
+          items:
+            - description: address and length of the controller register set
+            - description: address and length of the Slave DMA data port
+            - description: address and length of the auxiliary registers
+            - description: address and length of the xfer registers
+    else:
+      properties:
+        reg-names:
+          items:
+            - const: io
+            - const: sdma
+            - const: aux
+        reg:
+          items:
+            - description: address and length of the controller register set
+            - description: address and length of the Slave DMA data port
+            - description: address and length of the auxiliary registers
 
 properties:
   compatible:
-    const: cdns,xspi-nor
-
-  reg:
-    items:
-      - description: address and length of the controller register set
-      - description: address and length of the Slave DMA data port
-      - description: address and length of the auxiliary registers
-
-  reg-names:
-    items:
-      - const: io
-      - const: sdma
-      - const: aux
+    enum:
+      - cdns,xspi-nor
+      - marvell,cn10-xspi-nor
 
   interrupts:
     maxItems: 1
@@ -68,6 +89,37 @@ examples:
                 reg = <0>;
             };
 
+            flash@1 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <75000000>;
+                reg = <1>;
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@d0010000 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "marvell,cn10-xspi-nor";
+            reg = <0x0 0xa0010000 0x0 0x1040>,
+                  <0x0 0xb0000000 0x0 0x1000>,
+                  <0x0 0xa0020000 0x0 0x100>,
+                  <0x0 0xa0090000 0x0 0x100>;
+            reg-names = "io", "sdma", "aux", "xferbase";
+            interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-parent = <&gic>;
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <75000000>;
+                reg = <0>;
+            };
+
             flash@1 {
                 compatible = "jedec,spi-nor";
                 spi-max-frequency = <75000000>;
-- 
2.43.0


