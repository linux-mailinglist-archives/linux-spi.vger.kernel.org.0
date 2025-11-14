Return-Path: <linux-spi+bounces-11194-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5590C5C858
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 11:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0AE34FAB8D
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4430E856;
	Fri, 14 Nov 2025 10:10:56 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912230C612;
	Fri, 14 Nov 2025 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115056; cv=none; b=sBsnN394/Fa4Ak4tg6Zz5dB/Nr4UVMXCp9iVw4i6XszPAvzRC358MaRE9ac+55KjfLlHUGjYch5X/xgaEfknR8T0z7F8iXCpI/jWjZPjD7HvlGG5ruNb8sDQtWGOjlOlrmq1r0EextvwK1aQS8ipNdRrgvmuFeb5fGw80ZN2msE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115056; c=relaxed/simple;
	bh=KMnliyZQCR7HQD6k1yLADQalxUxMfja7aEXAPjdWxso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAEywz0SW0j3twIKV1jXw/E3mHlpwn/c1JogYGJ8sTGSyS7/e1yfm6phI5Q0HqE1SJpygfJ4rwWGSavS0/ZZnUHh8nHQB3WvxrKqC/i8ddYOOmQ7oGVexTgZlTRKkU4t25BZfdef9qRO8P7qnS2qpZCU4/kr/uiCb94XB4NQs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 14 Nov
 2025 18:10:42 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 14 Nov 2025 18:10:42 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<clg@redhat.com>, <broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <BMC-SW@aspeedtech.com>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/4] dt-bindings: spi: aspeed,ast2600-fmc: Add AST2700 SoC support
Date: Fri, 14 Nov 2025 18:10:39 +0800
Message-ID: <20251114101042.1520997-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114101042.1520997-1-chin-ting_kuo@aspeedtech.com>
References: <20251114101042.1520997-1-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add AST2700 to the list of supported SoCs in the ASPEED FMC/SPI bindings.
AST2700 FMC/SPI controllers are not compatible with AST2600 due to the
following hardware differences:

- Address decoding unit uses 64KB granularity (AST2600 uses 1MB).
- Segment register semantics are changed.
    AST2600: start <= range <= end
    AST2700: start <= range < end
- Hardware limitations in AST2600 address decoding registers have been
  resolved in AST2700, so extra callback function used for bug fixup
  is no longer required.

These differences require distinct compatible strings for AST2700.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
index 57d932af4506..80e542624cc6 100644
--- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 description: |
   This binding describes the Aspeed Static Memory Controllers (FMC and
-  SPI) of the AST2400, AST2500 and AST2600 SOCs.
+  SPI) of the AST2400, AST2500, AST2600 and AST2700 SOCs.
 
 allOf:
   - $ref: spi-controller.yaml#
@@ -20,6 +20,8 @@ allOf:
 properties:
   compatible:
     enum:
+      - aspeed,ast2700-fmc
+      - aspeed,ast2700-spi
       - aspeed,ast2600-fmc
       - aspeed,ast2600-spi
       - aspeed,ast2500-fmc
-- 
2.34.1


