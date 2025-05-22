Return-Path: <linux-spi+bounces-8244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D80AC0ECE
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F829E2EEF
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F3B28C875;
	Thu, 22 May 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5AH8kMw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7155228C5DE
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925563; cv=none; b=g5yba/uT9/RMZZtqD4yvXoK1GC+CwZLs+Da6IGqdJAOp2br9HNDBTSHHyBiYEqrwEL6aAqcagUHxqp15IRy3+C+ma0luzzqhhwbc7ZZfQb8X/8T+8RGV8Ehnfqugdc0gkB9/aNljq5K4Ts1aFAdaBl8Zjn8lebiT8Y5rT1k7vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925563; c=relaxed/simple;
	bh=tdIGdyYQ20MkL5rp4ZKUkrznRFJ9rMy7wxoT6sn8RP4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=arUjtSP1SroSh2Mp7+kqbVdok6MDOY7FZkVrHCfraTSe6eo91GNzPDQhwQUTxrIZoBLhVtrIpzE+Kj2skE63xDZkqpdilHyB9NNRCUQDFvE+SmF+7L9q47F8XFMMlWMyFewhW5yY1cWbnHWDOGr8LTJmpiwh7USCWzlu8OZrAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i5AH8kMw; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so67874425e9.1
        for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925559; x=1748530359; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VEeX4pHU5dbnP7BXmwT5H8fSOKMWm7ham8iEEngBq2c=;
        b=i5AH8kMwkl9dlsOMchu+w6bP/rKe9y9aujCYrvb+YSBCBA/39dE/JYJx2t9jo+nC+8
         E0bzyABESMThdygMzuagKiBUJ29vHewmuNe0YoMo1WkAte03WQD7HzqE2bgxK+KoQ+wB
         vpI+d3ACNhipJw2expDepLaL5McDf/vUMeDLpZAiXUmhzl5dr4GzbT2XKROGO/u3lc8Z
         ZhYbFQpVlNuFwHLtkTkUTlo+v2Vk68EulLh5eYIL1mAhxEqt+yI1i+wHFj0GsOUJdeeN
         FCMutJXGkMfaMY05d4xuLjx6qI81OERi6G1vf3IK8MHZdOCIvDa1DvcpL3p3YrxK+ZWJ
         JsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925559; x=1748530359;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEeX4pHU5dbnP7BXmwT5H8fSOKMWm7ham8iEEngBq2c=;
        b=Jqekbrcd4qxHm7p/agFPbsi8IJgwDPtO4EmAmYErRjEFSONDjG4Pqi9qDeNQqcY/H4
         ZJnBXLoNZdZ9kBBRuUOK3+6oh6gxZor7J7SW175YGdDBk0WX6bBDHd2Gb34BdsluKPJ0
         vzUh1VxOgCB5D4Ttc26co6sZORoAyTeauAQrr8zuGUwxgMVnxqmoLn3GBT7jzrWYVQzo
         90j/MVaCqgFCg3vuqhsRugVwFaUcG+C+ELlJ2tsZCSDR1rkv1IsYLI7TMtNgPlkiduee
         KWrDpq+HD7un0MdKCLS7dbnm4aDbbNENS7xlZ4lUSy9s0ZX31PH9cTzn72likqho2V1w
         pZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnvXT8e6tsECwYS3a0t3ws+DPes0YGMhCwGO4Txoh4afCj8rN96kIxgIUd6l0JysQ1xVU1QIx6QgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/coKDcOZCnDpp9dt1gBDC4WMI4tKTujBwIS0hieyFaW3S+ImW
	G+jTQY1eNKaz2KHaTAolT5aM5vFwNbDmUl38M5mh31lbyUhyJy5qNz1qwXiOHDzuVTE=
X-Gm-Gg: ASbGnctW848KOAMSg3D9FAH2qd05uqJgjm/Y613hOdleKU0v3a6MRxtu4v7B/ohpCLj
	MtbveWPRz4izXbXWlxosRlaeJ2sHXZ7p6F8BysRqD3rT/yECB4oQaRP5feUDDGMHYtkyn1zCGx2
	U8+kogox2hK8xeRApqIvvnCsmZK5jlPoCJR6u7qf7pPVidj8Pn9mmegnisxHm6+WbbLZ9js1emJ
	bSHXifCFQk1H8sJ6trkigsvEo4bQcsf/W8kc9PneDLH9t+iw/I7m+KHj2gjswPYADxg3nv6nIHd
	FYyl1ymGSE8cgvVjuPNQw+mWXGSOWzRvkDttq/rZrSR6/zGzvzdGHyyjVsMP
X-Google-Smtp-Source: AGHT+IGuO6Y6d+kCxwoNrEY38IpkexCj4wL5pVJUa3/XxA+mRVZ8kHkKd9XIST6kB9JCbxHGl+gsxw==
X-Received: by 2002:a05:600c:3114:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-442fd64e335mr299932885e9.17.1747925558639;
        Thu, 22 May 2025 07:52:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm104965555e9.27.2025.05.22.07.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:52:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 00/14] spi: spi-fsl-dspi: DSPI support for NXP S32G
 platforms
Date: Thu, 22 May 2025 15:51:29 +0100
Message-Id: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPE5L2gC/13MQQ6CMBCF4auQWTumnaYLXHkPw6LCFMZo27SEY
 Ah3t+LO5f+S921QOAsXuDQbZF6kSAw16NRAP7kwMspQG0iRVYYsPtyLC4Y1YUmCvfOaSbUtGQ3
 1kzJ7WQ/v1tWepMwxvw9+0d/1J1nV/kmLRoWG7r4fyLPT+vqU4HI8xzxCt+/7B7lZF6qrAAAA
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chao Fu <B44548@freescale.com>, 
 Xiubo Li <Li.Xiubo@freescale.com>, Lukasz Majewski <lukma@denx.de>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Xulin Sun <xulin.sun@windriver.com>, James Clark <james.clark@linaro.org>, 
 Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>, 
 Marius Trifu <marius.trifu@nxp.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>, 
 Andra-Teodora Ilie <andra.ilie@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>, Dan Nica <dan.nica@nxp.com>, 
 Larisa Grigore <Larisa.Grigore@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
X-Mailer: b4 0.14.0

DT and driver changes for DSPI on S32G platforms. First 3 commits are
fixes for various edge cases which also apply to other platforms.
Remaining commits add new S32G registers and device settings, some S32G
specific fixes and then finally add the DT compatibles and binding docs.

Tested in both host and target mode on S32G-VNP-RDB3 by transferring to
an external device over spi1 using spidev_test.c

---
Changes in v2:
- Add trailing commas to lists
- Line length fixes
- DT coding style changes
- Remove fake "rohm,dh2228fv" device for testing
- Improve some commit messages
- Put all fixes commits first and add fixes: tags
- Link to v1: https://lore.kernel.org/r/20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org

---
Andra-Teodora Ilie (1):
      spi: spi-fsl-dspi: Enable modified transfer protocol on S32G

Bogdan-Gabriel Roman (1):
      spi: spi-fsl-dspi: Halt the module after a new message transfer

Ciprian Marian Costea (2):
      dt-bindings: spi: dspi: Add S32G support
      spi: spi-fsl-dspi: Enable support for S32G platforms

James Clark (2):
      spi: spi-fsl-dspi: Re-use one volatile regmap for both device types
      spi: spi-fsl-dspi: Define regmaps per device

Larisa Grigore (7):
      spi: spi-fsl-dspi: restrict register range for regmap access
      spi: spi-fsl-dspi: Reset SR flags before sending a new message
      spi: spi-fsl-dspi: Add config and regmaps for S32G platforms
      spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
      spi: spi-fsl-dspi: Use DMA for S32G controller in target mode
      spi: spi-fsl-dspi: Reinitialize DSPI regs after resuming for S32G
      arm64: dts: Add DSPI entries for S32G platforms

Marius Trifu (1):
      spi: spi-fsl-dspi: Use spi_alloc_target for target

 .../devicetree/bindings/spi/fsl,dspi.yaml          |  18 +
 arch/arm64/boot/dts/freescale/s32g2.dtsi           |  78 +++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi           |  78 +++++
 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi    |  83 +++++
 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi    |  83 +++++
 drivers/spi/Kconfig                                |   4 +-
 drivers/spi/spi-fsl-dspi.c                         | 362 +++++++++++++++------
 7 files changed, 600 insertions(+), 106 deletions(-)
---
base-commit: d608703fcdd9e9538f6c7a0fcf98bf79b1375b60
change-id: 20250325-james-nxp-spi-caf1e2099231

Best regards,
-- 
James Clark <james.clark@linaro.org>


