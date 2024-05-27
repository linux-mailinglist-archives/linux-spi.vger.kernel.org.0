Return-Path: <linux-spi+bounces-3101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C68CFBC4
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57009B213A9
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB0A13A3EC;
	Mon, 27 May 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WfNY0ApR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA3213541E;
	Mon, 27 May 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799351; cv=none; b=Ii36hAAxO0hwv0DLJJpQprMaZpAaVeKiOMB8Q1SRwLrk8D/gDoPPEZ2qilduZoNPru/wzNtPiPrM6EA35HIk9C3e5uXJlzr3kPPNFVKLjE/aGp94/WahPkCVZwDRKcQ6ZBc8aMZQOsXfQD4abo5Z13f8ris+mDcnuS1CPVKnInY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799351; c=relaxed/simple;
	bh=MEC8DhGx+n9oHyT7ncEyNxtWVU7c0S5Lz0CbsA1h1vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KL8JPOmnEj7/ERb0KiBrTDbHpEXjTukDlmasRHtKf2MhHAVEItH+eUNbzQJc5M+xprC2WqJ1d+SR8VsejBP7IJ9+Rue5mVxdjg1A9SRLZkWpMi9mhgvyHJCRxf7L+X4CxRRg8cf8FLB3iy6Xhs4yasfg7CXuQQ//WXP3EE2h2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WfNY0ApR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R5fcOT027334;
	Mon, 27 May 2024 01:42:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
	4NniPYHRnjizyN4mArusAzASr3/+o+1q8EEDOpoHgk=; b=WfNY0ApRik9tnIact
	C4EYncCuR73bZSddsuKyBN0fod+CGicMDlePy9SPy1nhl1bkD9s1RktnMgRXsA/J
	PdM0t80PS+8uRgC0+EI1jcYjW7pvgh5DuChB28D4bkZXJuaLIikd0FdK4yRRvmZ/
	IbZ2UCseJlFe2rgbcWiLg6QFzMJP+s7w+hOWE+akX444b8WGxWKBnDr4PEei5cTW
	lFb0Wf+0w1D7opnnbv/byKJIhlV1g6s0pMgjM85nBTWoFmkuf7fjgIyEqDfxJ0U1
	BlcoHSmlsDm5ZI9cR2QLyJY+egHF1uWuAGYPE9R3t0VrM69RsAtxXqn0tqXp5Ps8
	wQFeA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ycm8grk6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 01:42:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 27 May 2024 01:42:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 27 May 2024 01:42:24 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 045B83F7062;
	Mon, 27 May 2024 01:42:23 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v5 2/5] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
Date: Mon, 27 May 2024 01:42:13 -0700
Message-ID: <20240527084216.667380-4-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527084216.667380-1-wsadowski@marvell.com>
References: <20240527084216.667380-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: te9JovhAZtERQf6nn7P7En-9eiO8wWoD
X-Proofpoint-ORIG-GUID: te9JovhAZtERQf6nn7P7En-9eiO8wWoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

Add new bindings for the v2 Marvell xSPI overlay: marvell,cn10-xspi-nor
compatible string. This new compatible string distinguishes between the
original and modified xSPI block.

Also add an optional base for the xfer register set with an additional
reg field to allocate the xSPI Marvell overlay XFER block.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml    | 38 +++++++++++++++----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index eb0f92468185..d6b8b2a2ecf5 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -15,33 +15,57 @@ description: |
   single, dual, quad or octal wire transmission modes for
   read/write access to slaves such as SPI-NOR flash.
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
-    const: cdns,xspi-nor
+    enum:
+      - cdns,xspi-nor
+      - marvell,cn10-xspi-nor
+
+  interrupts:
+    maxItems: 1
 
   reg:
     items:
       - description: address and length of the controller register set
       - description: address and length of the Slave DMA data port
       - description: address and length of the auxiliary registers
+      - description: address and length of the xfer registers
+    minItems: 3
 
   reg-names:
     items:
       - const: io
       - const: sdma
       - const: aux
-
-  interrupts:
-    maxItems: 1
+      - const: xferbase
+    minItems: 3
 
 required:
   - compatible
   - reg
   - interrupts
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - marvell,cn10-xspi-nor
+    then:
+      properties:
+        reg:
+          minItems: 4
+        reg-names:
+          minItems: 4
+    else:
+      properties:
+        reg:
+          maxItems: 3
+        reg-names:
+          maxItems: 3
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


