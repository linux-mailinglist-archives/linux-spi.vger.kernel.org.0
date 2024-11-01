Return-Path: <linux-spi+bounces-5583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A29B931B
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 15:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E561C21C27
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569721A7265;
	Fri,  1 Nov 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/8qkiaO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205FF1A3031;
	Fri,  1 Nov 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471119; cv=none; b=Q1sFB4SEQVi3EHMRuiTUTiHkXVLkR9t3R+A2GItQ8EDwqNOKlPVwpMDAgPaeU76zlzrHKScfiXNvfgmAeP/9cc6EJmbmyd3f8dsz5kvMS8tshh3tDGJpX8V3KX4gQUB8LvddpVhnbwhq68Sa4z55W/JB6sBCF4gUnwWTaRwHivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471119; c=relaxed/simple;
	bh=7vrEPIQ4bAMycnZ9O2SmDP1fd541LGxGZlIiiqJbkww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bPp4hz0atPn+Sli9UhpEugOZEPhGt8vr0YMja3Gic/vvu9q4pa0zIT8oQAVFDZaRBW0MvgaYXOg2QXs8SetdglRdVAVPCZZ7J1M1vwuF5x9nmsEwiGSJFP/TbZBG4CzwskzoW5vTzlLMUM5g9/Dfaz0FRGH53s25NCSyn8ReYfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/8qkiaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB8B6C4CED8;
	Fri,  1 Nov 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730471118;
	bh=7vrEPIQ4bAMycnZ9O2SmDP1fd541LGxGZlIiiqJbkww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b/8qkiaOffx0IirFn8jZgYKZXIUobR4UZ8A0xFNEVLIpSzpuGrqezzvaUTmOcvZNK
	 oxMPvlPg5VFiG0Pt8/0dDHRllyR6WaAanyb1+nBZ66PQ79gCAVsn1wakw32dSc+HW4
	 7KELuhWKIUZBv7Y4i4AItAOvHgjVzjvwyOCYYKO5bx+hZDyRMkr9H1H/iV42ASfj5A
	 6FqioZguuabaomlgZAD9GcVHoOrqvhMveAelGzGdtpFHtd9eDZr+UIkyadO+KhOOY6
	 EZoP25wuFEv7Uu3DP4DqrSOxa9E7j1i2WB3jdoNfMWCK264cw8EMHiLL2OxGH0NnSQ
	 i7701mJAY63tA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9574EE6F063;
	Fri,  1 Nov 2024 14:25:18 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Fri, 01 Nov 2024 15:25:05 +0100
Subject: [PATCH v2 3/3] MAINTAINERS: Add apple-spi driver & binding files
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-asahi-spi-v2-3-763a8a84d834@jannau.net>
References: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
In-Reply-To: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=wbyAeXiak8ymhiqSGZePVuZ0IdBpI3guim8H/E8/EiU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnSVJ2cO5nswZ9Wq7uuQuBKUHqDHVLRqzn3RBfuYhYR9x
 GdLmFR0lLIwiHExyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmIjELEaGVat5HtlL5F456etw
 xI/xsAf//aAky1lcQkbzNZX539R/Z/hnLyJ0evtEEa4eJVZT+8CAuBnT/bcsX1P5J3dv2PJZx13
 5AA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Hector Martin <marcan@marcan.st>

This Apple SPI controller is present on Apple ARM SoCs (t8103/t6000).

Splitting this change from the binding/driver commits to avoid merge
conflicts with other things touching this section, as usual.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc40a9d9b8cd10e2e00caa5a5881381cd40c0d9a..552febcb12a95766ff502960782941d9d016d5e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2068,6 +2068,7 @@ F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/bluetooth/hci_bcm4377.c
@@ -2085,6 +2086,7 @@ F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
 F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
+F:	drivers/spi/spi-apple.c
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 F:	include/dt-bindings/pinctrl/apple.h

-- 
2.47.0



