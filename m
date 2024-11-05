Return-Path: <linux-spi+bounces-5623-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE539BC7B4
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 09:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469B1B21ADC
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB651FF037;
	Tue,  5 Nov 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXJKWaiN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41141FEFD3;
	Tue,  5 Nov 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794125; cv=none; b=sv41ocVJmcrhPUI7N7QToNKp6E6NusASaoD/IL0GdU95B0U2hpzSxrd7rMpW5njdmh/zaEV6uUGukDSZy/gK/lXIZldlkqko+LLVXcXzmuLOoSoeE42AiTwUSl0RlzeeVn3p5YytJkIXRpOEP15/yfn9opTtgXblVUKhtIpRnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794125; c=relaxed/simple;
	bh=7vrEPIQ4bAMycnZ9O2SmDP1fd541LGxGZlIiiqJbkww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddwr8sK1O/cPzKxvBIR/Duasknd/X4L9sW0duXD0tlQjZNqCbnj43K7f7MtJDGdMK8TbODGO6+7WnEHr6GOYh9Piu9WS3aZLFx/QKF/EV6FdP6P79fPU4Jh6REFSYraaoLlzbwHq35/MakIP0v8r0I++GzcokGN1dfw8xoA4GnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXJKWaiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C85FC4CED8;
	Tue,  5 Nov 2024 08:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730794124;
	bh=7vrEPIQ4bAMycnZ9O2SmDP1fd541LGxGZlIiiqJbkww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EXJKWaiN0dASunE4sN2Z3dbApj+7FllFgmmuaB0CbjEf1aYHt9DEH7sbHkm0Nnhob
	 fG0L0hsDkhJF6k+jkrv0Y/6Jmgjvig9t4r0pLy92vfs0bnOM9LMtizCb3xg/gtJPJC
	 BlgPIllKjVmMe+BkIyN+UmmEOA/L2+FaSMpILAuD0f+3ojrPYzYNCtTIMTdzdROO9u
	 ahSc215X4I4GLqQtNoFRwKTzyrCT3nPenYwnI0D7fOfGbSrPkVLTogg8G0AcZB5On1
	 FQbZFSD5rL3FOr6LIbTYRFSdD2rvdsr/4mkftJE+Tf1+qj4jOONAjhBA6PzOb+yYM8
	 DF4+AJb6ucUuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED2AD12667;
	Tue,  5 Nov 2024 08:08:44 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Tue, 05 Nov 2024 09:08:31 +0100
Subject: [PATCH v4 3/3] MAINTAINERS: Add apple-spi driver & binding files
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-asahi-spi-v4-3-d9734f089fc9@jannau.net>
References: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net>
In-Reply-To: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net>
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
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnTNS108395K5IUrH/g/VV7tzRLHX6bnBC9+Nbq/7JzAu
 X3pJQ3lHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACYSy8fI8Lv23gIeRveQYJkH
 wa/kZ+YocU3de2RWgcBSdevGhcdKcxgZjqT5Hu6+cPjvHmPbfwZ23+zKTO8VbnjUYCcozq/yaos
 5KwA=
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



