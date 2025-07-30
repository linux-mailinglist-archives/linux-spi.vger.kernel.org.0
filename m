Return-Path: <linux-spi+bounces-9217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0908B1587C
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 07:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED753B236B
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 05:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941C1E47AE;
	Wed, 30 Jul 2025 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uL6CkH8M"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CE614F90;
	Wed, 30 Jul 2025 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753853858; cv=none; b=GHvFu3ula1PeGaoi/JMNJYYhilmt2vgRkH9gzmNJxY2VVjZsov6bCNKIQOus0qJmq6zWkAjWfa6TxCsFhcTaezQTm7xL6qMvDs+6GZj3fGDIgDyImYr0Mcfn8YeOHf85oBfdIPOv5w05rsEV9AafUiRCNVCAYwivvAj7FuvTtrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753853858; c=relaxed/simple;
	bh=rWUE7qFB8LKVOaKtzg/sWlFkmdVQ/vjyCvDn33LZlZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GLU7OPujNePKQe48VMoDSuXV1eUqCQ6IVnovzi5k2yyTCzyo+8uIVyHVoQ7pvMgJPBAmTNUw7NvnOU9gFhlD1EnJKgeRRI01Xl4Cpip3utznEBz6zfG9PQ5Lsm6rpuvXyw/n4DeiIzLjluyHH0PW+eFXP5XJKK1UG8dJCxikUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uL6CkH8M; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753853857; x=1785389857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rWUE7qFB8LKVOaKtzg/sWlFkmdVQ/vjyCvDn33LZlZY=;
  b=uL6CkH8Mj2EKLznsp6NE5zo90ZJkVx4qVec33zyl6pvpdCtDc7TaZCh7
   kmsc6fu+kgz098iFIv2tOJeG+mbtP5s/KIAvUM9zCOgDCiKLkwdaCCT9p
   sdnXNS5s1X4roVKWM2a38L8o/LDD6Ussk823pLBR+TGdivAmqPpcnC6Lz
   m4yQBcTDmVy3WkiAtsg+qHqnkFHkCe4HsguyGRiFGl3TrdDA2hpf9xjbK
   gA9MP9efISFIWQTp92JFlQMSPlkyn3O4E+fMDfbaVPMssPTxmBzmki9cU
   RawzBnPJ1oj3/vhS6+Z0BuxWiBxdFBJ9oIp+U/tIT0SX2ulai2LhkjndL
   Q==;
X-CSE-ConnectionGUID: s7MsNy9gTXqx+DUz3G6LIg==
X-CSE-MsgGUID: yzQRLX74Ri6H1tniLANesQ==
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="45191543"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2025 22:37:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 29 Jul 2025 22:37:30 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 29 Jul 2025 22:37:25 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<tudor.ambarus@linaro.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH 2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add support for optional 'spi_gclk' clock
Date: Wed, 30 Jul 2025 11:07:20 +0530
Message-ID: <20250730053720.262118-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the Atmel SPI DT binding to support an optional programmable
SPI generic clock 'spi_gclk', in addition to the required 'spi_clk'.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index d29772994cf5..11885d0cc209 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -31,11 +31,16 @@ properties:
     maxItems: 1
 
   clock-names:
-    contains:
-      const: spi_clk
+    items:
+      - const: spi_clk
+      - const: spi_gclk
+    minItems: 1
 
   clocks:
-    maxItems: 1
+    items:
+      - description: Peripheral Bus clock
+      - description: Programmable Generic clock
+    minItems: 1
 
   dmas:
     items:
-- 
2.25.1


