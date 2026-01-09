Return-Path: <linux-spi+bounces-12235-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D04BD07A73
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 08:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F44300C6C8
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 07:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB42F2ED866;
	Fri,  9 Jan 2026 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="hvo3e7gh";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="hvo3e7gh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8F76026;
	Fri,  9 Jan 2026 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767945050; cv=none; b=H9kezK2otcYdRJ1+dLCS1pTDZzs7lvj/EGipycXqeBL7Yd+J1nhHS88bh/ae/VPAbQ77q8GxUCK4XdKKQ4A4BjeQtVXE3Ojos1gz9kzCHiyCmstEdHp4IQrgKDMUnmE5tURoGD5B/IBJiRSd96Z5bSZn2rV1TcHnqYxS6S3ht1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767945050; c=relaxed/simple;
	bh=eYuw2YRq8s3GUWScDfIIZ1j2Fv/VH08rVqcHOcv0Yrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYoWFr9lthdVEma2pLZa1trJDHx5/2nCWhb1FDi/mSrjOOUHReI1cdVnfw/I9ODchkcDQL8QMnIk+Z8ykAeBmWB84xRdFh4Zlbtugl1PDE56kASyCNPRZG64sueJ2M7H3yZMfvbhPrmJEwBq3IdCysRYoPDxnSchs97NrjUCIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=hvo3e7gh; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=hvo3e7gh; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1767945042; bh=eYuw2YRq8s3GUWScDfIIZ1j2Fv/VH08rVqcHOcv0Yrc=;
	h=From:To:Cc:Subject:Date:From;
	b=hvo3e7ghj1xWP6xeBVJzakCLz+USuZ1PMXOgL5sMtZ0qUhd6TptPjjlKzo2yYEt3U
	 V8TfY/Xo+Ut+wEVEdoMG7Cpf2RSM3S+7nZ83STeHaaZqsWg/oiHda+ACPOT7REPyUK
	 Mf8+/ChzFEPAnEg5qncWzKsUVUMnfFmmjwE2ORItC7ouTKRLZ8HN5ukXf5tKh4WB/g
	 71jGgDSmfaXqpO9NJU9v0r0X+2upERg4vy7ixDsTVVL61B0znC7tKI+te7wTw+3tGZ
	 qZt3ftAFqjfIZJllpeC/vOg7RJwi0sRn8Yp8bCYZxFk0kzASnoj6PZsvnM29MTxY8/
	 oyyC2nsJj9ixA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 4F4DA3EB34F;
	Fri,  9 Jan 2026 07:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1767945042; bh=eYuw2YRq8s3GUWScDfIIZ1j2Fv/VH08rVqcHOcv0Yrc=;
	h=From:To:Cc:Subject:Date:From;
	b=hvo3e7ghj1xWP6xeBVJzakCLz+USuZ1PMXOgL5sMtZ0qUhd6TptPjjlKzo2yYEt3U
	 V8TfY/Xo+Ut+wEVEdoMG7Cpf2RSM3S+7nZ83STeHaaZqsWg/oiHda+ACPOT7REPyUK
	 Mf8+/ChzFEPAnEg5qncWzKsUVUMnfFmmjwE2ORItC7ouTKRLZ8HN5ukXf5tKh4WB/g
	 71jGgDSmfaXqpO9NJU9v0r0X+2upERg4vy7ixDsTVVL61B0znC7tKI+te7wTw+3tGZ
	 qZt3ftAFqjfIZJllpeC/vOg7RJwi0sRn8Yp8bCYZxFk0kzASnoj6PZsvnM29MTxY8/
	 oyyC2nsJj9ixA==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id AA8CA3EAC0F;
	Fri,  9 Jan 2026 07:50:41 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: dt-bindings: nxp,lpc3220-spi: Add DMA specific properties
Date: Fri,  9 Jan 2026 09:50:32 +0200
Message-ID: <20260109075032.3287109-1-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260109_075042_341297_1E0E71A6 
X-CRM114-Status: UNSURE (   8.75  )
X-CRM114-Notice: Please train this message. 

NXP LPC32xx SPI controllers supports DMA operations over rx-tx channel,
which is muxed with SSP SPI controller DMA.

For additional reference see Table 69 in NXP LPC32xx User Manual.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 .../devicetree/bindings/spi/nxp,lpc3220-spi.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml b/Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml
index d5f780912f21..789e26e40927 100644
--- a/Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml
@@ -20,6 +20,12 @@ properties:
   clocks:
     maxItems: 1
 
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx-tx
+
 allOf:
   - $ref: spi-controller.yaml#
 
@@ -38,6 +44,8 @@ examples:
         compatible = "nxp,lpc3220-spi";
         reg = <0x20088000 0x1000>;
         clocks = <&clk LPC32XX_CLK_SPI1>;
+        dmas = <&dmamux 11 1 0>;
+        dma-names = "rx-tx";
         #address-cells = <1>;
         #size-cells = <0>;
     };
-- 
2.43.0


