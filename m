Return-Path: <linux-spi+bounces-9213-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4ADB14FB0
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 16:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD9D18A2A51
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C6B26B2B3;
	Tue, 29 Jul 2025 14:56:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1373A933;
	Tue, 29 Jul 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800989; cv=none; b=AeCQJsEFbECJmVm/tCDAbz470fj7jVapQzY7gr3fccMqS8ZYf9KbAqGSTaXjkMoyQyZMXibfyN9gtLqX4cgvUAW8n3RuA3x4CyLTs30G5/mLMTMn7+nQ8wOJVrzUYKdmfRDctp4jZZW2WLAlQvUUj05YLRcOX32ZL3Yqx4B7v2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800989; c=relaxed/simple;
	bh=8+O6KhD5Wb7k3PTjmdnF3TYGn5aHFsHdT0MmJTGWu8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k5D0BplyNHe1F+2nzXr0amRkSPBp6gWzXUq2kwToMRarOPrfIenaVNIMvzEQ3dzqAXv/AvH8OcrWqjDj6O/cbbJxaXC/kNcpgG+gyh+D1bl+Yp4qAXu2Hwa4dILoGKCzgG1XKzAhII0VcpkmuNKdBrsefWGXFM5ZK4E3EkYByGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: bCAPPkJDR5ml7u2940LjPA==
X-CSE-MsgGUID: FbYzCHsVRB65otpuALYYxw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Jul 2025 23:51:17 +0900
Received: from mulinux.home (unknown [10.24.0.171])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 51EBF400C735;
	Tue, 29 Jul 2025 23:51:13 +0900 (JST)
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
Subject: [PATCH v3] MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
Date: Tue, 29 Jul 2025 15:51:10 +0100
Message-Id: <20250729145110.37258-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
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
v2->v3:
* Rebased.
v1->v2:
* Collected tags.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index addb26082fa0..b1c081f9c567 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21208,6 +21208,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
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


