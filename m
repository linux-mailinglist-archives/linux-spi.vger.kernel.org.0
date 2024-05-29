Return-Path: <linux-spi+bounces-3137-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09C8D40F1
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 00:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6EA1F23764
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 22:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0621C9EC4;
	Wed, 29 May 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XrpUyjeY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E781667EB;
	Wed, 29 May 2024 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020039; cv=none; b=kuBU/Ht1TVvmHwB1GxfVW1oLXKavBnbHkebdHePcyXso9esu9YT6gLozy9DHQ9phzmABF8LSL73Hw+W3G5V5zsLt/ZXsy51vU9xYAIZvTEfvxL90g8Y3ot1JH1riiJAW+v5Cyb8U21SEEKXZRhRJ17C+7jpJw2H8OuJPmPN+x9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020039; c=relaxed/simple;
	bh=BxOZNoJlz29HO8/YfLbPXMpM+KfhZfw+epg0zIGopN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEJDm7ZINpOIuVFy0GNHLmKK1COrLIaUkv0lHJv3zmyaGTNc5gtqjnvytHAg3TojcrZyvHbwAAjolZY9iFPYdPXltewlc7GosWYomMjJ3DdYi0Uq8yKoHPtrGyDOVrGMY/FkhdwaDBcyES580nVPggBwtV+6FKzemfRT2T4IlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XrpUyjeY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TIdMZ5015558;
	Wed, 29 May 2024 15:00:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	pk/X75yGmNLyRTKGore1BJYDGr66lspCD+xmIUCbRA=; b=XrpUyjeYu/2hKuFXM
	/FnfFjet6VO4SJ1HR7sGnoOt8WeS53Mzbou231MXMJJ01XZlma7qf+lHf5G9uxuU
	pueIfS3vAtROxNGJGV62jzQ8Vgw2V3CpaG6EF0yqyPSYkuMzCsEpvJWF3cZpzsUq
	mgPlt04zWQo/VKqa5yhOcs51aP7vAV80JEsjheSmc99NlR8x4r0QZIfhnwUUZJBY
	jQcawkFyM8wGPhl+f/Jo79o83OYtqTacZ1QsFr3iSb8FoHU3bcQ8or7FtpViigM3
	32l0bSLY3ur7AF0VZQlO6lmlA2td+2ENrW+GoVhFvWZ+0bySQxJeNjwhD+XgByvv
	BtQlQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ye1r12k8j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 15:00:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 29 May 2024 15:00:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 29 May 2024 15:00:30 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id F15C75B6951;
	Wed, 29 May 2024 15:00:29 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v7 1/4] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
Date: Wed, 29 May 2024 15:00:23 -0700
Message-ID: <20240529220026.1644986-2-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529220026.1644986-1-wsadowski@marvell.com>
References: <20240529220026.1644986-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BFEQhuVY2sFJqhRktJbFmVYoZP7LtgmF
X-Proofpoint-GUID: BFEQhuVY2sFJqhRktJbFmVYoZP7LtgmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01

Add new bindings for the v2 Marvell xSPI overlay: marvell,cn10-xspi-nor
compatible string. This new compatible string distinguishes between the
original and modified xSPI block.

Also add an optional base for the xfer register set with an additional
reg field to allocate the xSPI Marvell overlay XFER block.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml    | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index eb0f92468185..49c6a2c82fc4 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -15,24 +15,27 @@ description: |
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
+      - const: xferbase
+    minItems: 3
 
   interrupts:
     maxItems: 1
@@ -42,6 +45,27 @@ required:
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


