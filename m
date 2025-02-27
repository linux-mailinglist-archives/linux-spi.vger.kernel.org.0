Return-Path: <linux-spi+bounces-6967-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF5A47CA6
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 12:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479C818917B2
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F95022A1CF;
	Thu, 27 Feb 2025 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DOAbFn9M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m1973184.qiye.163.com (mail-m1973184.qiye.163.com [220.197.31.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A77C22D4DA;
	Thu, 27 Feb 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657302; cv=none; b=PCFqjtKaUg8B7NhwNJ6M0nXUTgwmOItdqtL9m/rwNu9g/295rYoRctjewKxqdkwq+OCnCvc8L8YnJOmw4kuoU8UaLPjP1J62VdHhJjakfNuI0V7MGp3vwpswgqpeynV8JPVuPU14p4IMfdlNKxNfpSr+y9Hio7QezPDbiLVy0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657302; c=relaxed/simple;
	bh=UWURrxZ33j+AqgiPMMPa/EMl2Wk+bi8/aglg450KK2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GeZQpC5HrtZBbDjTUBQpIPX5hJ7qyvO3pRNQYuL4FhqHCA+Vl+0qq+K445voydOtXQNgAOFygg+QdKLdm5tvL+DHprlSdJ5GwF85pKqL2Ub70LQ5nhNHs1Rc79SVV0+qREF4LnYSo3fr7B0Sy4TIKytQ/xNzWhipRTwZ0RbY56c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DOAbFn9M; arc=none smtp.client-ip=220.197.31.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97e2;
	Thu, 27 Feb 2025 19:19:30 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 07/15] dt-bindings: spi: Add rk3562 support
Date: Thu, 27 Feb 2025 19:19:05 +0800
Message-Id: <20250227111913.2344207-8-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhIT1YfTBodS0NPQ01JS0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954722159003afkunmc65f97e2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6PAw*CjIKGQ0tKE01Hkgf
	ARRPCU9VSlVKTE9LTU5OSkxJSEJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSUM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=DOAbFn9M5o1IV9Yu9Q02apCDV2ADSalVWWdsOg5MVr6Ns8Oo0N2epomyg+4kItakRitsJZQ4P/T9Xl8fs207SDj/dZFIb2p0Kz0teE0oFMONSsB6FIxe22VCgU8xihuPoisWuQ5OIxFJVABbnIBs9g4vfXdiJK6VML8CfzC+vJw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=EOKs8tqnCG99yPunkTUq+kwZqmICAGDoA2oOc3/s2ko=;
	h=date:mime-version:subject:message-id:from;

Add rockchip,rk3562-spi compatible for rk3562.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v3:
- Collect review tag

Changes in v2: None

 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 46d9d6ee0923..104f5ffdd04e 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -34,6 +34,7 @@ properties:
               - rockchip,rk3328-spi
               - rockchip,rk3368-spi
               - rockchip,rk3399-spi
+              - rockchip,rk3562-spi
               - rockchip,rk3568-spi
               - rockchip,rk3576-spi
               - rockchip,rk3588-spi
-- 
2.25.1


