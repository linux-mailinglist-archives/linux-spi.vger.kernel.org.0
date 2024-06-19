Return-Path: <linux-spi+bounces-3476-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EFC90F009
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 16:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD6A1C22217
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68F112B7F;
	Wed, 19 Jun 2024 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hftA4bA1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4ED125C1;
	Wed, 19 Jun 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806648; cv=none; b=cFC0TOXk9CdylH6/DUnwwC3TNBLWjrNcB2cma9/Xk8TcGCJ16hjs+UyZx3pWBh3EJOQQiMxet+U76E8Ww+o33HnTwHnvQEgH83RCe93znnf2cUXX8Z3INX9xdrHfaY3Mc67+twcxFmn+bXa5XFI7SnvwAjWDZAfkBc1MM+lyd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806648; c=relaxed/simple;
	bh=cHicvuNsB6FBsP+p24Oei7cf3LE105dI1jDELbVa/L8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRxa3gCySGYUkTf1exGYIJ8rZEWnhU0zBdliaAEZyIcIQY26iQ0DUHWL2XbZt7eK5xp6mmUku7SfVyJ6sJpVyS0Gt5DmOrjjUK9NnUdjJHmOcK5/Fqf3O3foQ1Px2syW7BClYDhq7BOkyv6EzTMV993+ukHmSSRc45kmJaP7o0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hftA4bA1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9l8ie011743;
	Wed, 19 Jun 2024 07:17:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	HWv3FV88gHLyPrpIGGB1AAf2zkoSjgvgaCyZbzsiAY=; b=hftA4bA1qkvWHcHxj
	HAvyT6I5rx7SFaZ9r8gk6Csww0W5nMSaUyQ5Bfbacn0w5BueiSoc14rlPtvq8iiF
	2IqeUbEGXbTrPUw1oBfJL5T3PIfP9FCboVn8FKCKmntLXin/xnFpAGQzkau4zXtN
	nQJ6PXBhfYuUR47473rdHR4QKRzawgPYZtfL84662J6muRUzAvz+BbPtrrTY7qbR
	y2BKAxog2hRuf5GmskorLfBInC8TqWw0hZni5QpelJmBDkXsS1K0Zxjy01GO9ZaE
	hi4uh3BbfyxYvKfyE+SSjdJ6FbfVEoG2EuCBXi2JNpdYRVMuyzdBdsCuwS0rpXFc
	lNv+Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yuw0jrudr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 07:17:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:20 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 91B5A3F7086;
	Wed, 19 Jun 2024 07:17:20 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/9] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
Date: Wed, 19 Jun 2024 07:17:07 -0700
Message-ID: <20240619141716.1785467-2-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619141716.1785467-1-wsadowski@marvell.com>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _EifKludXePhvf18yQ58BHnSt7YQD7mN
X-Proofpoint-ORIG-GUID: _EifKludXePhvf18yQ58BHnSt7YQD7mN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

Add new bindings for the v2 Marvell xSPI overlay: marvell,cn10-xspi-nor
compatible string. This new compatible string distinguishes between the
original and modified xSPI block.

Also add an optional base for the xfer register set with an additional
reg field to allocate the xSPI Marvell overlay XFER block.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml    | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index eb0f92468185..38a5795589de 100644
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
+      - const: xfer
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


