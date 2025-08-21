Return-Path: <linux-spi+bounces-9573-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F237B2ED87
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 07:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859EC3A83AF
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 05:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8052BF017;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOqPJWHo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3111270572;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753440; cv=none; b=PXmuWi67C1A3Vza8WFb54h5EyQZGy6/WyZ7FDaV5PwRihOgvWqaHI+I9BHeWbt/JJnc+T/Ocka0lHU7bDEll92+2AZ6D8Gntu7P5sG+V8YtmmYYXR53KudupsNgGx57lnylJc6L6lhPQlxteQxQCeRb/kZOPUOC4wdAcxNDMq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753440; c=relaxed/simple;
	bh=SGZ/ztM0Jh+alQljhSybFcNPM0P2ohWIF7g13dEMIfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsWREmp1K6QAWOyreLcHUt/Hp8izWMis1PtC5MgaCVOqSeNWYlVTYfgsR0LtR4HnuCpgD9lbZrj3afh+OmqOR7g2Pola7J0lTFJwNbcnDcdl2aEBRBjT2S7omqF3p0wDf2r+w/UcSwXnP7zRTxglenxwvCN+my392YO17P8V6GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOqPJWHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6762BC116B1;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755753440;
	bh=SGZ/ztM0Jh+alQljhSybFcNPM0P2ohWIF7g13dEMIfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fOqPJWHoWnZk7EJtNc+gOUDfUA6OajCqfX5gEfr7lKle9ozbWYfs8XsaRHzsiRSSL
	 FeUsPH1X0qqnIOlwhYT3MTfC6cUh/j13SnVjH3so6QNdwNceSQTD0xmvY16xb//zJP
	 Qvw0XEJsiCER70Qn/0nyCN5ZfZJ7t/VLMcv+IN1rE9+drlLzKbJCcVjwA3iOBKiGXS
	 ro9JZZAA3bGq4GGuEfD/8gW4y1lbx5cr6Lv+EiUNYH+/moYV2WtGAjo4eiBK0jStO9
	 +bL+RLZvcZcldQIAFljfPpKbdP3/xh+rYO1FKkf8MErO1kiydBnPgJIhk2irh7tgpg
	 UlpCmuzQU9Xzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB82CA0FE0;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 21 Aug 2025 13:17:17 +0800
Subject: [PATCH v2 3/3] MAINTAINERS: Add an entry for Amlogic spifc driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-spifc-v2-3-b119f64b5c09@amlogic.com>
References: <20250821-spifc-v2-0-b119f64b5c09@amlogic.com>
In-Reply-To: <20250821-spifc-v2-0-b119f64b5c09@amlogic.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755753436; l=935;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=waH2I+tfwvOLzp50Qi+Yg091qChCxHO4Mz5PuoGKYLg=;
 b=KAFa60+6MQk6r4CLggQRiBeApIJPazVc2fxGrAnW9/Lxt8/r8EmIMKkkNgyipVV5xFhcgy6II
 Bif1p7n2ADSC+ZjxQt5N4JV7Cpav1+yA+SvN1OpiW6VVgFYhz4MH3sd
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



