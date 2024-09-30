Return-Path: <linux-spi+bounces-5043-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A9989ED9
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 11:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00D21C21A12
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A299F18E02A;
	Mon, 30 Sep 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lXOB/Ep5"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2817218A6BC;
	Mon, 30 Sep 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690148; cv=none; b=BxoGj6kImgUJkh8Bg83aoyqwhn7wGbsCHnN2czvyQDLS0906nLYM440QwNY4QMW66TXjY6E6n51cX9JQijJ+yOjsuC8Sl+drb/E41TN2Yw70Koe/plUlFCjZG9uNu+V8juEYFdoVBvTfk1q1Lis7MMj37KY3FHJu5v3zPBqqpDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690148; c=relaxed/simple;
	bh=HIJw5zliYUVkGzj0EIZ2JL0qFEk3m0cp+8xSuU/025g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYnxyqgYg61C6ECwCBgnICn6lvhrooBC3vI8NGM30+/dTTBVjvjHEm1dNa7EDxP7S9Cc+ALzpVwQUv5kInL1S+l5WBswmBGJT0mA+VlQF10t7JqdQ4mDWzcxsRZwzsCWxgMOrnVcE7NuWPbFzPgojndWYSDXJoBKL7XU+wQFBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lXOB/Ep5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690148; x=1759226148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HIJw5zliYUVkGzj0EIZ2JL0qFEk3m0cp+8xSuU/025g=;
  b=lXOB/Ep5iUPIgI70CcV/JPVbkm53i5ZxNqQqjW4LrtQT0QZG8wds0sOX
   e3448ltmlPmGtKvwsS58t+latB5HVuVFpwDkXnc+tM+ER0m4hERRFJXmV
   Fo1KWDUEMcX58tnkqug7fsNRTjgmWUQfW7ykeMTxa1FJn/xrlfSLtYQtq
   AuHJvnIuohbz5wMFGS2huDLa3mbyIToA1XGYSDNXt31E/XW+PiHvqfb36
   hVKAbpW6A1iZ37P/JmWiLw2DwPN8CEiQzDYPKMXNJ9fI2meExOVoXGJR/
   2CH5ThcJUmXmVcRtCFIiGibRBJkuq/sS5arr7p0KsTtJ9t4cVmUQYFosi
   Q==;
X-CSE-ConnectionGUID: VDfGPtv3TTmpuSmsWgS4Xg==
X-CSE-MsgGUID: 2IWO0GoCT4mCcKJ5443kyg==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="263420159"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:07 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:05 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 04/20] dt-bindings: spi: add PIC64GX SPI/QSPI compatibility to MPFS SPI/QSPI bindings
Date: Mon, 30 Sep 2024 10:54:33 +0100
Message-ID: <20240930095449.1813195-5-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX SPI/QSPI are compatible with MPFS SPI/QSPI, just use
fallback mechanism

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../devicetree/bindings/spi/microchip,mpfs-spi.yaml        | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index ffa8d1b48f8b..62a568bdbfa0 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -17,9 +17,14 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: microchip,mpfs-qspi
+          - enum:
+              - microchip,mpfs-qspi
+              - microchip,pic64gx-qspi
           - const: microchip,coreqspi-rtl-v2
       - const: microchip,coreqspi-rtl-v2 # FPGA QSPI
+      - items:
+          - const: microchip,pic64gx-spi
+          - const: microchip,mpfs-spi
       - const: microchip,mpfs-spi
 
   reg:
-- 
2.30.2


