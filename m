Return-Path: <linux-spi+bounces-8363-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E9ACD8B5
	for <lists+linux-spi@lfdr.de>; Wed,  4 Jun 2025 09:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86288167708
	for <lists+linux-spi@lfdr.de>; Wed,  4 Jun 2025 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35F22FDFF;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDluHRf2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E221B8F6;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022853; cv=none; b=Jh2hau3xRtj2se6XvHEKR1getpVGJdi1PVJiACMwV8BbgF3TaGyMRcTQthDqOOdXnPPYXlXusDrEzE7WCFdMeLjO/hiYUaAMrJj3Je2AKBuqVuwaaZ3U8flSefLmTgE7iyf0D+flDFBbYlLmMCDc+cYEMJCsX/mj/QsFqlETpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022853; c=relaxed/simple;
	bh=vHqBtRLv8H0LKoVMxIP6SYKoQOs/9V+tdbYZDQwMuos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ng0srQZpSKml7N3HJIAsaXaBRTBz3jBtmAXsP78K7c+Tuy6SigjsCo2fNJUEwDL4fy5E7S2Yp256zW5q2U1+3hBnQf9jMvhsgHu8Hn7pggjIpRQVVgK0VkIAkw2cduG5u7etAMrzn8M4n6TRnSIkWtli/PVmRW6o8h0746psyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDluHRf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67E72C4CEF0;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022853;
	bh=vHqBtRLv8H0LKoVMxIP6SYKoQOs/9V+tdbYZDQwMuos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hDluHRf22qyArZZ0Bf4LaeVN5YWL2ILBxAe8nesypxE/FSnVq5LJDAXDUW2M5OosV
	 M5w7cOhYZ8MU/GQ5nVnyLbPXuqZYI3FC9Z3elvWKE62v2i775IZm47Ma0ZR6H/cpOO
	 c2jNBBxDtIQrsDIoCB7IFy3iPnb2AnkoHeoOcaUTDDx6pRrkVYdFCN4y7eWeJcGA+n
	 2HoAZ8c2jvK69e1Vbh8TwiFAknDBEaIVRCQsKbcyfd0Mfofv/lkQyBL6HDWC5FuTYt
	 NVKGSBXwa1jVMD96nU0beturM3usQWcKrAzIkJe+rXryO/OeSyBzd62KFp0V5Jwyy0
	 IoRnkCFQvDf+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC24C61CE7;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 04 Jun 2025 15:40:53 +0800
Subject: [PATCH 3/3] MAINTAINERS: Add an entry for Amlogic spi driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-spisg-v1-3-5893dbe9d953@amlogic.com>
References: <20250604-spisg-v1-0-5893dbe9d953@amlogic.com>
In-Reply-To: <20250604-spisg-v1-0-5893dbe9d953@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749022851; l=878;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=r4XosHXySa02DQkB3mCCJMHyJ40Hjw6wxKehQsmElKk=;
 b=V4rmS3CzffbGaQiEdobEEU7Z8PraHYH4CYYX3P8e/1YeEZXDgPrue6bxH7exz0FzZ2U8tUDPi
 BOhs5J0HjqVDceFzwk6dNAeM2qJD80EpRdu0UaiwOkr2m42wrmlSQZk
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
index ff4de47dbd55..8ed6da015668 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1271,6 +1271,15 @@ S:	Maintained
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



