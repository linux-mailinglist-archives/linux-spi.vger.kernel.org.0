Return-Path: <linux-spi+bounces-6157-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E719FBBD9
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 11:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826AF16C44F
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CFD1B4123;
	Tue, 24 Dec 2024 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aIC4AIcW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m3277.qiye.163.com (mail-m3277.qiye.163.com [220.197.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56017C220;
	Tue, 24 Dec 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034094; cv=none; b=QIEb83L4tVBtMeIf1DbkNQZ2/w7gFSPnGtKnUoUcbVEPIs1/4fip6DfKqLPDAGnS85LDmFczMd3JPcC5El+n2z7PU+ABiT2OoEa2EgTJXyBZxUA4JYZQl4XPmWJ591OL7OSwPm90PjdcDfhBPTfaYdboyd2jampDeimDkiqisoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034094; c=relaxed/simple;
	bh=NegVq0gVVmJ4TG/f+ZAU4nDfTp6uIPSBqRmjVKo0FmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VY1msJdrNlsa0zHR9EDCAAwSUuQPKnMN4u4nElDmXn0yE1bu0FJd2A9pg2I8ApyCON4YGyHMS9fjw1AFQL5CNOM6MlQ2XvLQ6ErQhPjutl9/KWYMn1R3VdYm+hKF3BL/zeGpPNNsjhoyNN2TKzjTIC6GMBX6y9djDRpKKEU6Gbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aIC4AIcW; arc=none smtp.client-ip=220.197.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aad4f1b;
	Tue, 24 Dec 2024 17:49:35 +0800 (GMT+08:00)
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
Subject: [PATCH v2 08/17] dt-bindings: spi: Add rockchip,rk3562-spi compatible
Date: Tue, 24 Dec 2024 17:49:11 +0800
Message-Id: <20241224094920.3821861-9-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224094920.3821861-1-kever.yang@rock-chips.com>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0JDTlYaT0pJTE9LSkkdQ0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	5VSktLVUpCS0tZBg++
X-HM-Tid: 0a93f812647d03afkunm6aad4f1b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46Nxw5DjITPkodS1EvLCo1
	NQMaCw9VSlVKTEhOS0hITExNT01KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDT0o3Bg++
DKIM-Signature:a=rsa-sha256;
	b=aIC4AIcWKqKoT7LNOzi3cjWVG65DmdskHtqwrE28ZQDWJltkEJs9GEM8YYIm/lHy6ezEtwUeZSGqS9x8XL/4bkC4F6pYHknE00uMA3alZaocRHp07Iqg93Yf5VPrlx4Fwe20YQkfz6soDVs5O5K7ryO9OYSnuv4IrLrqGF2AiO0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=IOM1U89s1aYg720JAUn/jQO6iCYKE+w0kQFvGel09Ys=;
	h=date:mime-version:subject:message-id:from;

Add rockchip,rk3562-spi compatible for rk3562.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

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


