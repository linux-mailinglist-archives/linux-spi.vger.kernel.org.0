Return-Path: <linux-spi+bounces-9056-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9475FAF9803
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB0F5C069A
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811252DC339;
	Fri,  4 Jul 2025 16:21:05 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAD32D9487;
	Fri,  4 Jul 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646065; cv=none; b=C6RTIzGFzkq7xj2yTpBWupQCxK3MAZNizqHO50uMBGt8XrK6U+cAj/TNKEWrPexipgynsH97TfXozpp/xwK6NWwnxRZv+CsiMNhpwd26AwmHTVmhiCVfXMM29YAhFx6FDaoWUrRDyK2hegHvY/iW5qzQD7UKRxPeYjUAbaoBzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646065; c=relaxed/simple;
	bh=CIDS4XGH+4cb5LLUPPoJh/Iq1GZ1TrpGst48kw15a8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrahMbp8bTlkUenCC3l5+bRh8W0Lry6Oqitye27tlcv9jijiMZRNgGZgsQxuZOfZd6NRXyVqFHvEexvyV+5JsVywL3GELjhT8UX0fYX6yXMRsrnQNagxtNIzOS1G9UBxqz4VZ5TTc/BroCoNC+Y94F71+wj9phQSllqJ20nUpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: QbHu6frQQd2iQMDJh4Z0QQ==
X-CSE-MsgGUID: tRZFKmlsSDSimj/84SskUQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jul 2025 01:20:58 +0900
Received: from mulinux.home (unknown [10.26.240.6])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 26D35401DDFD;
	Sat,  5 Jul 2025 01:20:53 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/3] MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
Date: Fri,  4 Jul 2025 17:20:36 +0100
Message-Id: <20250704162036.468765-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704162036.468765-1-fabrizio.castro.jz@renesas.com>
References: <20250704162036.468765-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the MAINTAINERS entries for the Renesas RZ/V2H(P) RSPI
driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v1->v2:
* Collected tags.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d9b940ee8ee..f467e6900c09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21219,6 +21219,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
 
+RENESAS RZ/V2H(P) RSPI DRIVER
+M:	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+L:	linux-spi@vger.kernel.org
+L:	linux-renesas-soc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+F:	drivers/spi/spi-rzv2h-rspi.c
+
 RENESAS RZ/V2H(P) USB2PHY PORT RESET DRIVER
 M:	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
 M:	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
-- 
2.34.1


