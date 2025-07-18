Return-Path: <linux-spi+bounces-9124-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D531B09968
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jul 2025 03:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E9F4A653F
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jul 2025 01:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BB319E971;
	Fri, 18 Jul 2025 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNgOm7vQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34C191F91;
	Fri, 18 Jul 2025 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803540; cv=none; b=FV0aqhq6ol0Cot8Mmz20Um981p9p1g9LcxgKyt0SXkz6BHlPtq111ZednYDbTSPvYlHtCDBtTmVCpWsfHpbVd1ANmQrzOZOfNEKe6fWXVsUuPVGcYoQXK2H8bfYvKPssse4mmxk87TT2OWKQCk+7HmHH6j58Uif2MaHeaA1Gfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803540; c=relaxed/simple;
	bh=ZG2hqHecU73ektMlHLBv3zCPSuuwC64rbg9ypuyirdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sT/lVhLRQe28XBMnH9E5m7yV1A1haZ1pbhc06irwF5Abs2tL+4LxoGr/N7nzDlElQJ+LWH7xTRWTR6sldsyp+az4Vrym+wL1t9qEQodOU1N40LiU7wTWnRZcEoPCoDiFYycJOLoKOfmuJClTwKfUWXU88aSxcOzssgC2YuLLvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNgOm7vQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4649C4CEF6;
	Fri, 18 Jul 2025 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752803539;
	bh=ZG2hqHecU73ektMlHLBv3zCPSuuwC64rbg9ypuyirdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JNgOm7vQMqRlMkKtlGoG2rxdtaAHX9lqcxZI2kfqcy6zMusbe9r3y0JeItkgnfRTn
	 eEb66hHB4ylYCHIKeLnism6UAHg5XYuQ5WPgABNNhzxCsY1/6MUtJIiXHo1zslq8OG
	 y5KlH7YcrnQ9d1YYMWPRgSlL3hhrPJKbmrZGhA3YTRmZ/PzwVmucoUL7PXrWx5ngOt
	 7K+8SnFXCHJP+lp232RLUcT5Oh0yRD6TVD+aRPwRfeozvpzXeqsUnvJr4KaNt3tBAk
	 GjrxMlhO+AzWB75+bYpGLZaNRgg6lI80iEPXpPACbUzBiH1/xzPXFKZVT0jwtcNikL
	 NOy4POrT1Vo/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CBCC83F1A;
	Fri, 18 Jul 2025 01:52:19 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 18 Jul 2025 09:52:18 +0800
Subject: [PATCH v5 3/3] MAINTAINERS: Add an entry for Amlogic spi driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-spisg-v5-3-b8f0f1eb93a2@amlogic.com>
References: <20250718-spisg-v5-0-b8f0f1eb93a2@amlogic.com>
In-Reply-To: <20250718-spisg-v5-0-b8f0f1eb93a2@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752803537; l=878;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=d96hwpa3CUOhnffR2RHeVgOJAkVgtVaxxsoYbBLIdso=;
 b=wIO4Nvl9SJ9G6w63S2Qsm2HFkMy6Cc1zIelD4Mo/R+YrpDo73uUsGMmRIhKoUwzOiUN5FSuOj
 AduBJFto1h+Cy+N9Vri6FycrGoemxypZwHeCY41BYJY+zzHFs0OfQkq
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add Amlogic spi entry to MAINTAINERS to clarify the maintainers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..8225df5ede74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1307,6 +1307,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/rtc/amlogic,a4-rtc.yaml
 F:	drivers/rtc/rtc-amlogic-a4.c
 
+AMLOGIC SPISG DRIVER
+M:	Sunny Luo <sunny.luo@amlogic.com>
+M:	Xianwei Zhao <xianwei.zhao@amlogic.com>
+L:	linux-amlogic@lists.infradead.org
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
+F:	drivers/spi/spi-amlogic-spisg.c
+
 AMPHENOL CHIPCAP 2 DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 L:	linux-hwmon@vger.kernel.org

-- 
2.37.1



