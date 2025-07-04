Return-Path: <linux-spi+bounces-9037-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C577DAF85DA
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 04:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505305674D4
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 02:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91A1E2614;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDxVUCp4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3B1E1DEE;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751597974; cv=none; b=U1i+oVMDoVdVuZC8jR1dYqxUPqnv3ydXrOgrFzh/jeZCDpCfHiQsIvQj8qxk/nLgnKM/uertYPcH7t8IGijoPzAk9FpWoYlyPVENCwsdXyupAAxY5Gauzyb0GdHxfXgePQq74idAeZbXNFbN1LRZsFpmj4L4Pgre1G5uy9/O1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751597974; c=relaxed/simple;
	bh=ZG2hqHecU73ektMlHLBv3zCPSuuwC64rbg9ypuyirdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrHYzAyLlQv536YDIszn+7nbaeFxiA+S75KrEDsEzaQz8jBiCvrq3lUAEW02YI4Fp+GcYuR9b1YcC1dBiSYizABzfhnndPyWaCx5CQMT/dQ4c3++DiBl494o75YDDJW8bW3QFuiECyOyGJFMu70bsrWvSW/iirl5Ur949QyVYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDxVUCp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A436C4CEF3;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751597974;
	bh=ZG2hqHecU73ektMlHLBv3zCPSuuwC64rbg9ypuyirdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HDxVUCp4WUbotADP5rpIAYC5zuz8EpkoIJHkFNj7oN6fLLPmTUEenN7h9IGtGfoBj
	 TSrl/puosF+sDmhwmGAOEPtdLGw40quiqUw9nmo4YgYW5zSkYYUol4Xz8XTc64ONc9
	 JbAVlzkA4rSqwmATd49BTUrfxfsD5cGibSxEHMWjJEnL7y3BdtJ+S0AUR8BbPTvO92
	 d3AtpDu2+/3JiS2psB7pVKnSSBGME6tdnnn/bYb/B8kN8I6UalV2Rm9C5CB0HB8NBb
	 ILrF5597EUnHYg4EEbG3c8jMLRU94B3e7c9B0aWXG/LcxP28GMdMvTsS0tBD77hlLP
	 rP/VRDppvzGcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6C3C83F0B;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 04 Jul 2025 10:59:34 +0800
Subject: [PATCH v4 3/3] MAINTAINERS: Add an entry for Amlogic spi driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-spisg-v4-3-6b731dfbe610@amlogic.com>
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
In-Reply-To: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751597972; l=878;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=d96hwpa3CUOhnffR2RHeVgOJAkVgtVaxxsoYbBLIdso=;
 b=+8h8P8IdiJPKnWksejSX3yPRXBFoA8MScmaDW4dmic5n0o28kTiuaTOuwDCflRzs3OYkVzUIn
 yVTF+KHQyItDT3WjibIfeegX89Ma8wTtsaL+x096XdoK1z9bzjmPcqG
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



