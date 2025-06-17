Return-Path: <linux-spi+bounces-8613-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D86ADBF52
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 04:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50550173A3D
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245F2367D6;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EReKNq64"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6B1ADC97;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750128523; cv=none; b=jMvtJZAs/30nY64G349SRcTKUAHzMIrrKUJKjh8ElPaDZZIQZSoqcD88HupgQZ7NfAcS/82giHxZ/CiCJx3KWS8rOKUs8nC/9d1n9pN+womUojhg266zg7nr8gtGK1C4O+/akP0tTrLVczoxIlVpcdFM3MSQKnFcaAgiEMu0FTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750128523; c=relaxed/simple;
	bh=ZG2hqHecU73ektMlHLBv3zCPSuuwC64rbg9ypuyirdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RsO9AWY3iJBGu2N+fPyTmQKO/0Fft6n9RAYAKoTlxt8mXMwBuNGD8ILXPYt1cPlxUzMU3cyU88meXSPKiikiFFI7YpkohSH1Sj3pOkZxEnTihIvbmi9WOQhguUVVU7LukFg7QLtipEUYa29ZS2y8L0tmaKrQv4XVpwYPLHQteps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EReKNq64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36336C4CEF1;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750128523;
	bh=ZG2hqHecU73ektMlHLBv3zCPSuuwC64rbg9ypuyirdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EReKNq648SivlYGzwdlRtSrmHWl0K2gZc3s5WJEibhAfS7I0D6u5KRqp59IfnsTVX
	 3c4X5azS7TUzEMEInvQgkusPMbus9RrzryFmqXYbvMBZFryb+rWqnZ/QkeRTzPrw2/
	 9cTi4bR/Kuc6u/ubQzJ5nq6bRRhw3mVNhn0YHAxplr7CLovIzYQMtVHg1sHN/YzZJC
	 TXSybiRzwVbYvH//jw968u6ieQlCthlGB0uzFt6NcSOX0760qMvJnd145Q6sFftE5P
	 KmNQt5cQA1UU4px1apATPzEh1NgbU0YyhVt0PppH8JI34W0d9GihgxKGnKcSpHx2WU
	 kKaONSdyyiu6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A008C7115D;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 17 Jun 2025 10:48:38 +0800
Subject: [PATCH v2 3/3] MAINTAINERS: Add an entry for Amlogic spi driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-spisg-v2-3-51a605a84bd5@amlogic.com>
References: <20250617-spisg-v2-0-51a605a84bd5@amlogic.com>
In-Reply-To: <20250617-spisg-v2-0-51a605a84bd5@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750128521; l=878;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=d96hwpa3CUOhnffR2RHeVgOJAkVgtVaxxsoYbBLIdso=;
 b=ORsQ/czyJY37J1oUnOnXP5qC0bptxpYsGP5QirHbnCW/vE7BXujrXyQU8GKkYQVEQl/tz+Sr3
 fNYOjkPkFa+Agqf0gOSYybwoBLFy27wI5PaELTnM1wM7mV8HHFLMlBV
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



