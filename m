Return-Path: <linux-spi+bounces-9763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A35B3B258
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 07:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CA67B29D5
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 05:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF4D2185B8;
	Fri, 29 Aug 2025 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPZqy6+Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B720F08E;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444580; cv=none; b=lQOGx70wxZ1N+E/Dis3vYT21WQ4m3il/N5tZDHZKcd4WvKpN1/Mp746CVTKRhZy91HSFcaxw0b/8pE9w1AacG04MXvvInZfIQQA5as+9A3XeKljvh9wD989DaEdUb2HeUGKiU8/6wjJvKHpdms14xJ3zr+PaXce8eMCuRb04Jq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444580; c=relaxed/simple;
	bh=SGZ/ztM0Jh+alQljhSybFcNPM0P2ohWIF7g13dEMIfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFbo19lDU4h1V3ulHiBFMQNWaRWocdOxmWulFVitIaqmnO7V73ct/hVsgEd/gOyjk0qnl/hVVy260PkRqsZSc919oF72q9yVlvLEDQKfO6d5uYC7QP3p6mseiTl5IULSuCmr69fNV9XwdDEawvzsbM3ep+IciCw9VEQP57cQq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPZqy6+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E8EEC4AF09;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756444580;
	bh=SGZ/ztM0Jh+alQljhSybFcNPM0P2ohWIF7g13dEMIfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TPZqy6+QmXsYc/+CGukthovVe8FlDnC7irWBe17LoP+rAMXz1lrmX3uZvumG++MhT
	 t2eEx6uEYXJzOPx90D5vhSMkbNHtbec5foMKo719UYeiSgRSfQueOpL9cu1LSK6i0Z
	 0IdUQcT+CKW4psslIUfAD3e68Rn5skU8032LlKsM05nDQ895obccHSjDAs7kZJUroK
	 Kc3CABsPRg/+d0bW/XLoicXsdhq+1xZeVw5MikK0HSv20EVPoDgU6mCk/a5plCyZyD
	 VuvrRcE29kaNnUQas/rsPBQPu6V7vA0OP9JuRc65VAQUAt0zRJBgwaauTNxLYaQwWg
	 ow1slnfKv6HvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA63C8303F;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 29 Aug 2025 13:16:15 +0800
Subject: [PATCH v4 3/3] MAINTAINERS: Add an entry for Amlogic spifc driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-spifc-v4-3-1e57fd39f584@amlogic.com>
References: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
In-Reply-To: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756444578; l=935;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=waH2I+tfwvOLzp50Qi+Yg091qChCxHO4Mz5PuoGKYLg=;
 b=qPzTb7RTVjnIOz8LAOv7eRTOVyg8cqtn52vtIbh35of0wr0uJPfoPQJeDyBGeSUU48JdG0wls
 PCAGKx2PLDpD0T13JcFXzCK/EWbyhwgvV1HEiNPEZzA9bXQaspVAed6
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



