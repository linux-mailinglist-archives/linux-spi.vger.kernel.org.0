Return-Path: <linux-spi+bounces-11690-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A5C97AED
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D940A4E20F5
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09931B133;
	Mon,  1 Dec 2025 13:44:14 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59D3148C1;
	Mon,  1 Dec 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596654; cv=none; b=fb7xeE95WLt77AiwNZj9cI2esxQY/1m8ARiWh7QyrRQ/zTtaAxLOzs/zHJ1lTR0x7OcaIwKKFKOL/3MRmXugtFrqfEkH9pwAsBRAAnj46yQPBtUZW+Bpf1D6EffSWHBS43p+63ktT1YY88zOVaV4PwK0h8+ZjXgnSrKoH3nn1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596654; c=relaxed/simple;
	bh=RT642P3T6QJLHh/S5u6G+FvY6/THA58lYQNMLhF30/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=If9z2lR/G807qhqNRGeELAD4sVvHHbBay9cMto4ZTfP7Qay0VPKoPtYN9RaLqcwtc236/M6eSeOwQo74MWdtJDdFhxLmBsFksgypVDtBVX8Rghnjerb88do8u0xzZoEzX/qjbi0E3hmST7LRYhZu4mx99vRWRuWtT6i91UQwW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: rPLdHsXoR3eVDngQlXKihg==
X-CSE-MsgGUID: n41JDCjoST6UapzbjU/m1A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 22:44:10 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8C9944215A4E;
	Mon,  1 Dec 2025 22:44:06 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 10/13] dt-bindings: spi: renesas,rzv2h-rspi: document optional support for DMA
Date: Mon,  1 Dec 2025 15:42:26 +0200
Message-ID: <20251201134229.600817-11-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IP supports using DMA for reading and writing data from the FIFO,
document it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../devicetree/bindings/spi/renesas,rzv2h-rspi.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index 069557a587b5..a588b112e11e 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -57,6 +57,14 @@ properties:
       - const: presetn
       - const: tresetn
 
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
   power-domains:
     maxItems: 1
 
-- 
2.52.0


