Return-Path: <linux-spi+bounces-9949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E24B4A123
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 07:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DEA1BC40E0
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 05:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560A2EFD81;
	Tue,  9 Sep 2025 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI4Zf0dj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34A2EBB89;
	Tue,  9 Sep 2025 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394809; cv=none; b=EcTsVmEyJz79OGCFf+0gK2EsHbL2aw4hhrd5HwavPT4/jCPGOsx0lM1CUuu6C8rZrBHXMzGJ6w3vN+jnJl9SiQnGxkBPSqlgW4ARLjvYWrx0Fx/OnXzfZsU8ENQr69fkeN2ABPQVkrKXMO8CVk8OAh9xs9eTeRejD3GbJLLedsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394809; c=relaxed/simple;
	bh=SGZ/ztM0Jh+alQljhSybFcNPM0P2ohWIF7g13dEMIfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PL7YIHCzw5aX1yGSe0CVTeeWQBXYAKCPMI/EdOHYwwdyFzWNt/IMUnCFzaAexedxjHqv1wDBpBMiXBRWD5Aa2pPyx6zjxMePKG/BcU7H6UCGnHxcAMHNWNXnUyWskp+tvkAhgwo+LLszlx3jYIAd6ryTPVSx00AxqDCn+ADFOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI4Zf0dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BDDCC4CEFA;
	Tue,  9 Sep 2025 05:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757394808;
	bh=SGZ/ztM0Jh+alQljhSybFcNPM0P2ohWIF7g13dEMIfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dI4Zf0djRGUzhZARefAwKIccV5x483YOyw7kTzNSL2BMl22vQ7IhbZAbxYyI2If2s
	 7jhjBzmswc+FSX2pUCjkIKaF4cjG7TUqHcwZ3ebhAGaj2lQSdgWP2dr5YD7FoaIWJp
	 b2cK3E0wn8yFoRz19Df4ce0o6PhizVBgGO2bYLraVOam4vuOko0Ba/CU1me8wexikW
	 JShNDa96LLuRBaS2QLYjIkVLTVDDAsrxjZrrRn6bIZswCtyG8tJ2xUVMkJYu1U1+6m
	 b8hkLlJN4D1D2c2DcOct2ODbpQIaDSVzGV0dA6SMaIADnbJSO+1lIiTlt3BgGgsxi0
	 kKB4m3yfnloTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C34ECAC589;
	Tue,  9 Sep 2025 05:13:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 09 Sep 2025 13:13:27 +0800
Subject: [PATCH v5 3/3] MAINTAINERS: Add an entry for Amlogic spifc driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-spifc-v5-3-962bc147d17f@amlogic.com>
References: <20250909-spifc-v5-0-962bc147d17f@amlogic.com>
In-Reply-To: <20250909-spifc-v5-0-962bc147d17f@amlogic.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757394806; l=935;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=waH2I+tfwvOLzp50Qi+Yg091qChCxHO4Mz5PuoGKYLg=;
 b=S64wUFqJJpT241VMBS0RwVymct4c6ZoWfnA+7yst3Hw+DTQwpG0Gg6gxop0AicDzYXuLx/Jjh
 1SRAdVB7Ai+DuMLmPPHpmc5OWBVpwrnsCyfWR8E6C/ZgYdll7/yrOnO
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



