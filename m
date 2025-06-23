Return-Path: <linux-spi+bounces-8715-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B5AE3911
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 10:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DA2188C19F
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14389235360;
	Mon, 23 Jun 2025 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAuG8w8z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4590233D9E;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668809; cv=none; b=MTCSv/YW3R7K1vYlp3AR6UUdIQ+gdADBKZo700J3Ew973bEFE90rlW2p5pu5NBLASFGNOXr8D2p7bQnbRFBIEabEhtBDaLFuHzVAWNQD30EzQIbyuOS78gtUey2V0SoSvTlrild3Ps3uCexRqnQIOvSXR/6Jm4B4pzQ4VJPmq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668809; c=relaxed/simple;
	bh=ZG2hqHecU73ektMlHLBv3zCPSuuwC64rbg9ypuyirdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJVRUEzghq1UGNj5UcaiWvVtygr3t2+n2fr8+qP3CHwRWTraHt8xHi8LT60tnS6PGf26HiGJ3wg+s/1kT5e8oIMGMo9ZkhBGl6N017nEJBu4GRqd0X0oTMRUV/jjB3hx2zg8OjheZUo+SBoXfMAtv/+v64N6/tbcIuuF3uTsMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAuG8w8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 759C6C4CEF4;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750668809;
	bh=ZG2hqHecU73ektMlHLBv3zCPSuuwC64rbg9ypuyirdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lAuG8w8zsWKuOyp8AmaMM6+OqHC3KhZcUdoPMvWc3KrgHgyp6cAdpGlSpU1VbZXib
	 DEVSzbNkEjnQk0CsiLXK9EgS2eVsNkUmp+zF2cDsda16uuJaEXutduV8PfttNMlXYh
	 OD9fhrqDb5ZA4LFKySzSISuVfN6Kxf8VLLLndbppiWIYhuUCeIRjyP8v3zf0wTP0xn
	 p3rzaRYq7xrgehcNtTulZuvo5XaLIxhbUKFhImuNU/BXQl7tfO/bu8Y/NGxiet1zLv
	 VrwNDmvR39i+bmwlbvJB2c0IZpLW01zeTJ/I+TJjtPT2P+sGjHpfi0F9D1DoW6kho2
	 Zp93oNFGtoH6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625F7C7EE32;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 23 Jun 2025 16:53:29 +0800
Subject: [PATCH v3 3/3] MAINTAINERS: Add an entry for Amlogic spi driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-spisg-v3-3-c731f57e289c@amlogic.com>
References: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
In-Reply-To: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750668807; l=878;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=d96hwpa3CUOhnffR2RHeVgOJAkVgtVaxxsoYbBLIdso=;
 b=4zDUnHtNAHIpCUEIX5b7lnyH7hDVO3RkXJbLgp3LOzeCh7QDJ7oOGgR1lSeDrgJ5LEixoYhJ/
 iejxfCgZwUTAB5p3k9Iw3EToazbUDOq0B1r4pAqNnHkEnGdhash8RKP
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



