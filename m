Return-Path: <linux-spi+bounces-8445-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC60AD5334
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 13:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BB116F1FB
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 11:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638B42E6110;
	Wed, 11 Jun 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EfKn4yvZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7B184;
	Wed, 11 Jun 2025 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640082; cv=none; b=UuuaCxXCDSJfrndgDTrrCyc4Qc3xjX6hiYS+MpXWI2TuCHvdqSvtm/GpVb9Qy3DP96h5xji5+/LO/iiyUlZMG5ymQyTc+njOE2Xxy8/X7GgFV+XokqOruHYdN64bq3CA587dqpp2QHAHxhTjU7ZcXQlTcILGx6O9HSMVTHcb8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640082; c=relaxed/simple;
	bh=kyPztV/dUohnVXnMILrNtW2ZYQ3QNi1+1ODBhm3jYCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUHm9Yu7FV8EI7jUIMhd1QjZkHYkAHsJ2SYSxZvCOGnJd3VpEShzcZtxx6WS+yYNxmI24mUKGQrroN7WdtVxWTxeqxzH+0/TEFAajqUOxZoY6XU59hsuDb4cAIGfTN0tG+1Qgrhs2svypz9D2hw4+aCQhxSVItczgCoEB3dnMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EfKn4yvZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749640078;
	bh=kyPztV/dUohnVXnMILrNtW2ZYQ3QNi1+1ODBhm3jYCc=;
	h=From:To:Cc:Subject:Date:From;
	b=EfKn4yvZ2xiYkcfRUyca9I+haRGZ0RPkmqlmXhkv0WIBtQvnjakPbgRq0y0Dqao3S
	 Ve5TQEt0PtOlNxDoJi4q2CuL7BvuWhC+23Co+G56ml1hgu/hnKtPbjKQhzhWFQjs4a
	 kkDjY2Tb0hBnJBdPbO6fDtBGHxy3hCeGOofOx1o0QMp4LrRdfLSiEf4lhCorxtKnQ/
	 4/919hziMF7nF5KyzwCy6njFsbHI09Azk4ciOhNtifuf+8ddTknGE1YxnCEU9gF983
	 E2YpxqvuTN0IMdfiPw43znf5tI/zZ8AdtsMOaG7pOjJq8xAZpF4HblxuJQ7P1SXE3h
	 s9EECyYHmLOMQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6F92917E0536;
	Wed, 11 Jun 2025 13:07:57 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	leilk.liu@mediatek.com,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 1/2] spi: dt-bindings: mediatek,spi-mt65xx: Add support for MT6991/MT8196 SPI
Date: Wed, 11 Jun 2025 13:07:46 +0200
Message-ID: <20250611110747.458090-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the SPI IPM controller found on MediaTek's MT6991
(Dimensity) and MT8196 (Kompanio) SoCs, with both having the same
controller IP, hence being fully compatible with each other.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index ed17815263a8..3bf3eb1f8728 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -39,6 +39,10 @@ properties:
               - mediatek,mt7988-spi-single
               - mediatek,mt8188-spi-ipm
           - const: mediatek,spi-ipm
+      - items:
+          - enum:
+              - mediatek,mt8196-spi
+          - const: mediatek,mt6991-spi
       - items:
           - enum:
               - mediatek,mt2701-spi
@@ -46,6 +50,7 @@ properties:
               - mediatek,mt6589-spi
               - mediatek,mt6765-spi
               - mediatek,mt6893-spi
+              - mediatek,mt6991-spi
               - mediatek,mt7622-spi
               - mediatek,mt8135-spi
               - mediatek,mt8173-spi
-- 
2.49.0


