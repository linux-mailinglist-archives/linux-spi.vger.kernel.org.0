Return-Path: <linux-spi+bounces-3990-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD593C1A0
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 14:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E30282459
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 12:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383919AA75;
	Thu, 25 Jul 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YTBV4SFE"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A182199E90;
	Thu, 25 Jul 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909809; cv=none; b=gEXLfWjegeDPPOPQ82/DxS9pAwnwnXMTCd1HpIfiIMAhmGVXLO2ZM2yWQ9k48dL6aBdJNrF8eFiDtKwiMd9L/YKL51bUaNKcU/hz3maTgOE1RRqLyJG8SeDozl1QeYDgnhY38Nmse+3Q15vVXRK51wMORQSaFJFGpZ6w5IYvPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909809; c=relaxed/simple;
	bh=6HsXb7M+wbgz7I/sJCXA/59Pc0L4VBtPFzakf38tsso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDJgYKKI08K3yFalo6uzkeCsFTqjhhTDyK1fM9P9101KmHc2NIhKzYBbYBYbtoPyWfRHtjl5Ae+U7ivfohb9NwjWv7Q0/UKn6jJeyzby+Y2YzbmtxKuEcwqXIV9X8fho/NhP29kvXtf00BxlcJIiGw4Ibp1IlpTDRSR2Iw76Dxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YTBV4SFE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909807; x=1753445807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6HsXb7M+wbgz7I/sJCXA/59Pc0L4VBtPFzakf38tsso=;
  b=YTBV4SFE2Cp6K/hTOzJg3ImZDDcN98rfBLEwHg8opRzCjWzoTCc5SQR2
   Lx+d1fwqvdnRjMicWihDnig5+bM8suiLaqr4+kauLhf2X4Y651CIVa1E6
   fNqr3/tWkQarPiKd3+nzbhSWDqnDcRDuRXt+Xk4IZddnBFTQHSCeGahKJ
   EFmLMkdq+JcrU7YV7J626GkmaE/gRS99jVdrARoSqTuEz6wY7Al7/48WE
   GrAxhvYxdmyAIF2FWyLaYbvNf9+2JwxrAUjJsJo9vfRNsuOKSX5vph9Ln
   8dgH/Qyu6u7ZyM7QC8mPLDnPPvavT/O621w5ZAh5hdJI9z1KrMvioeYqE
   w==;
X-CSE-ConnectionGUID: 73d5wsqqRUGsXcUpyIWy1Q==
X-CSE-MsgGUID: AXpXTgm9Q0S7uDZD5lGWEg==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="260575366"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:16:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:16:25 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:23 -0700
From: <pierre-henry.moussay@microchip.com>
To: Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/17] dt-bindings: spi: add PIC64GX SPI/QSPI compatibility to MPFS SPI/QSPI bindings
Date: Thu, 25 Jul 2024 13:15:56 +0100
Message-ID: <20240725121609.13101-5-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX SPI/QSPI are compatible with MPFS SPI/QSPI driver, we just use
fallback mechanism

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../devicetree/bindings/spi/microchip,mpfs-spi.yaml        | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index 74a817cc7d94..4c9a7f1ade50 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -20,9 +20,14 @@ properties:
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


