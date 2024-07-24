Return-Path: <linux-spi+bounces-3977-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B6093B421
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 17:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC85282F1C
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669815B153;
	Wed, 24 Jul 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JgJEmyUk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683C18040;
	Wed, 24 Jul 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836093; cv=none; b=EIp33ryg9gNo3TlCnSib7a/Eh0eWangcU492A1TD2otepmlHygXQXs7qYkFDJlATY7XUjZD8K2oVh0BzDYNgM8t/aocUcmp8CS+7Ci5/jDUChpPtgkXSg9YRtuk877xosO3oJzqE6PjX6wwuK2I2T2DWC22+leZYnh6Nj2fGt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836093; c=relaxed/simple;
	bh=cHicvuNsB6FBsP+p24Oei7cf3LE105dI1jDELbVa/L8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZSMvmkhK6fKSxVSMfQkHBsi7SJX1VlAonpIg5fYu5rvsXmogiD3BkR11BomMEMhhQSo4OF4L/bE1WeBtps5O51e26p5QN174K1pnA97QRZUs3VSNIOKfuoCuy53W/QOnztgT26JoJPb/qXQdW+lbSqn70mWU41dGSCJu5xmWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JgJEmyUk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OEGNFM001424;
	Wed, 24 Jul 2024 08:47:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	HWv3FV88gHLyPrpIGGB1AAf2zkoSjgvgaCyZbzsiAY=; b=JgJEmyUkcMf4uFYWJ
	CP9ZJz4l50S8psnDf1Ywacrp+t1sOgX9V63GlRjj2SPxz/S+nLxUUEkrResit2iv
	+1ZeydgT4SI8cmRaL2xZwgd/DoFsIAzlJieNnvvq40/m/vzQRbvOmYIOPLUfpzZE
	nVe3qBFZq1Ju2/Rpbtxd6qEBIHrQd7/Fhyz/6SvmpjPlRIlJCNlvujDkBhFoVADk
	3tNFSyMxdH6T40ygUI+IeP8BqSToVwOt4O1sXDA9iQyMTVTkhgIPXLgfjhax06yD
	O5sxIkmbbUtILJuzPWPzLwFxMoiITRdq+FvHQH7mc/fY70VSfJ6oP0zwdk3p/iE9
	OvuyA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40k0yh1d6c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 08:47:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Jul 2024 08:47:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 24 Jul 2024 08:47:55 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 9A6F53F7070;
	Wed, 24 Jul 2024 08:47:54 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 1/9] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
Date: Wed, 24 Jul 2024 08:47:31 -0700
Message-ID: <20240724154739.582367-2-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724154739.582367-1-wsadowski@marvell.com>
References: <20240724154739.582367-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ln3N707ACDP5VoyhKFRlOAQj7_pcC5JX
X-Proofpoint-ORIG-GUID: Ln3N707ACDP5VoyhKFRlOAQj7_pcC5JX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01

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


