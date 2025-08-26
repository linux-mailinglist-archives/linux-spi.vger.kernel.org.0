Return-Path: <linux-spi+bounces-9661-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29AFB35165
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 04:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5621B2812C
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8E21C18C;
	Tue, 26 Aug 2025 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBsPDiJx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027441FC3;
	Tue, 26 Aug 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174212; cv=none; b=Jo2ZtDWQRa0+zlX8wHOPTXUFl/gk3zXrDMF5pujN9NUCgXIQnbZ1M6DKqkeAEe7UtmynUaf86mh9LwvAIMtkLTM739OF28FhXN8mxSs/VXjw8t1t29jr3m4SC0oRZD25WHCNrZBMbtTkdMqEgCFmC1a9UjMlBCGXHuHumfNTpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174212; c=relaxed/simple;
	bh=SGZ/ztM0Jh+alQljhSybFcNPM0P2ohWIF7g13dEMIfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIIoLmVGojzq0ldyOysK6xeDHyQO/y0WRsCQVyBTjLmR7O6wRZfCfne+B8ieFLzm2SjWeUSjPEZKdtKK+cdj6ka/qJ4w/onRGmaCtZ/YYkucGnbc1LRquLql4OdJHrfSEfb6PCGr0v/ifkTrtwhpAB0hmwA3JfJA8NBxFSj0fC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBsPDiJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C03B2C116C6;
	Tue, 26 Aug 2025 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756174211;
	bh=SGZ/ztM0Jh+alQljhSybFcNPM0P2ohWIF7g13dEMIfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gBsPDiJxWlVTxSlPPyOzJGBFOJCYvdKxI3nxjuw0wsncTAsVoSJkfdUqzT2QU7ZIR
	 JK9tieT+WDIVzBbvcz5k79/Ckdy2M+vF5cjQvlQCTYSdZVVM2DiurrKGgCsWKm2zgM
	 ueMgpHI5IUAqTB52ReAL+IZPbi13uhtYtQFhftCeDJtTzW+t66pg2t6+fnO/YDKdCB
	 nocNhoLYytZa9dtgdZdD38rHUyAA2cBS+9fOvuNv1HLhyFvC0h6YFOHozNy/zWrAzt
	 /at99GL8TH9FrxtBk890P04o8di1o/8o9hmpQx8yOWVfkLcPIt2UJnRdDRGOBgMf0I
	 fH/ztx0UfiG/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244ECA0FF0;
	Tue, 26 Aug 2025 02:10:11 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 26 Aug 2025 10:10:11 +0800
Subject: [PATCH v3 3/3] MAINTAINERS: Add an entry for Amlogic spifc driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-spifc-v3-3-7e926041d7f6@amlogic.com>
References: <20250826-spifc-v3-0-7e926041d7f6@amlogic.com>
In-Reply-To: <20250826-spifc-v3-0-7e926041d7f6@amlogic.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756174209; l=935;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=waH2I+tfwvOLzp50Qi+Yg091qChCxHO4Mz5PuoGKYLg=;
 b=AcnIrZbm6qa02/aYZRtVsPpa0XzMDC5dawGzxQDAwJwIgGhFMG6BoPxwimZ/3Tc7Be9adibR1
 sS20D001NYHCxos6YdqK1JOG3P1iJSoOLR63lKw7JV7NmfzEqFwSn8p
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add Amlogic spi flash controller entry to MAINTAINERS
to clarify the maintainers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1c081f9c567..9f1f337e9b6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1306,6 +1306,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/rtc/amlogic,a4-rtc.yaml
 F:	drivers/rtc/rtc-amlogic-a4.c
 
+AMLOGIC SPIFC DRIVER
+M:	Liang Yang <liang.yang@amlogic.com>
+M:	Feng Chen <feng.chen@amlogic.com>
+M:	Xianwei Zhao <xianwei.zhao@amlogic.com>
+L:	linux-amlogic@lists.infradead.org
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
+F:	drivers/spi/spi-amlogic-spifc-a4.c
+
 AMLOGIC SPISG DRIVER
 M:	Sunny Luo <sunny.luo@amlogic.com>
 M:	Xianwei Zhao <xianwei.zhao@amlogic.com>

-- 
2.37.1



