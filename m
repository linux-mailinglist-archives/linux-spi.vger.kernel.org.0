Return-Path: <linux-spi+bounces-8012-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D1AB1181
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C210C4E1BA6
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5674F28F924;
	Fri,  9 May 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fhlfY358"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481D28ECEE
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788818; cv=none; b=fB5x0rolyIrHGjl4xTp1aQkQdtIdqdpEHJR0OdQXjZhv5S77UCXMKJBTR7eXkg/755hEsYd6YqIFZcp8I4ks2pUb/O5rSE71HP99uy3YHxZpnWI6Rp42Yip9x8JHoXULppXM2V52A8dMOOOWfohFed1Cdd1u7d2rpje0IS49Qj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788818; c=relaxed/simple;
	bh=8g6zkTjB4a5mBnaZeVYAI4MzPAjk54nrw+e13fId4pg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BZadTGoVgsPiz8N2q17jAushUBgyttjMnYoVBRAfeJc87vfhDhbGxfP/Sbn5JBbzC4OHsvvQcZmE7/SXPaT6N99pyN+tYX01uGVmozdnXNQOL8usowRLwrHbWnT0o/KP0w/pOmIbDSUMXe9YnH9EoCgbIfwrs3pf9MnQqbllsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fhlfY358; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0b9e2d640so1726500f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788814; x=1747393614; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdQh7LT8W4RzJzp1eDyrsDrfrxqK5LM5LuKtE8YNB2c=;
        b=fhlfY358qI5+DtRoqX4tKoB5DVTjbQROnCOTL+I2yEyoQg63DKHidte8HLzHb4DNw1
         mIEcu1FCbAijGE16qdEa0NaAE0daUym9+yWDek/QR7Ln9dHRvmQZvMKMM4kfZFkgeLT7
         A2p3qV8GyIi+/fy0w8VNHTCx3O0xWSAm/22UOFuKlbFlbIyyK3BC6bkj6K/1pn+OIccZ
         AIPF593aexSZSx2SBrdFp4+JI9bi8Kfw9MAEbbUFOnKAM+g+78TycMKP1oHuuW42iSOG
         f0MuHtAgl2HGm+vPqBo3xynG+HZ7cMzbiaZ5BbMW4uFaU+oGsNpFzHSnnDoI8MYuY87r
         8GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788814; x=1747393614;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdQh7LT8W4RzJzp1eDyrsDrfrxqK5LM5LuKtE8YNB2c=;
        b=w16OwVGSY/6t3elHGwx2zEMqc+QZcYG/p9gTGgUBHK9UgTfVt4ti3ZkMVH1+ASF4uI
         YT6p86SrPOffzx149JCg+5iNYo7p2+48Jfu5rU/LRG1AZfO6o1XzMAdGpHu8LnviiszD
         332qKMa8wlJw75WW2JFJf80O6RG+Fzhbxvh1tQyM4NVCshIE3vFFJxd1h8p+brhGC7p9
         jl5hkEpHVKDKKiDdOeCGswLqvR7VE0S1g7dlYco0B4L2iE/rhRoSA0F4908EKRdEJkR/
         LDUuKfoOtmRcNVHvepzQpgcx7kPeB6WC8IQwEXesTagOLfIGE+qXA239NH+nUkC9iC+i
         XmDw==
X-Gm-Message-State: AOJu0Yw3coZlLBi8VhmHcZ9j34FYA1txy2qUC9uXoC6cf3KNzENhEeqQ
	NYMtU9wZsqMvOk+Cyq6TaHKGBX8ABwGxClVLIAsmBMGQdY2MfCShpe8g5VeHb88=
X-Gm-Gg: ASbGncsaCCQ05jOPOFUMJazAOgV1GKCDV+B68NVikiT3+BE9wdHd7N9+5qbzJPJQTdu
	1cpCX2ltVehrOAKnTszgMTEQFanN0cL4kuZzyAMeCrl185MVOzYfc9UKV05NWGNmw/7mq/4SNiF
	gUfzCEPPxqgUtJAqa22AYizQhvX7EkaWM9XtXwOPzDMD1ahAvLagf3PEw0iKrVzq4pAPmHjYMb2
	dTOlfIdK9/PSR0wCvmlbImxQ3L8vi6FgNxHeiqrAmyrec63OfxfX+jTSuuA8Do2rqoTCgIcBJX6
	/2A17kDlWvzi557G5vwdtYp9EDrBCuZrw1mEWwtuo34DeSU=
X-Google-Smtp-Source: AGHT+IF8zf0HZ+jIS52ar661eUuXC/rKe9WCfGGwcqpO6GEcFF49TaMuxQRQxMt3K3cGjEyD0Y8O6g==
X-Received: by 2002:adf:8b1c:0:b0:3a0:8712:4f51 with SMTP id ffacd0b85a97d-3a1f64b5a97mr1959695f8f.40.1746788814469;
        Fri, 09 May 2025 04:06:54 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:06:54 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 00/14] spi: spi-fsl-dspi: DSPI support for NXP S32G
 platforms
Date: Fri, 09 May 2025 12:05:47 +0100
Message-Id: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIvhHWgC/x3MMQqAMAxA0atIZgNtxEGvIg5Fo0awlkZEkd7d6
 viG/x9QjsIKbfFA5FNUdp9hywKGxfmZUcZsIEO1qajG1W2s6K+AGgQHN1km0zRUWchNiDzJ9f+
 6PnsRPfZ4f/uU0gslR/0vbgAAAA==
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org, 
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, James Clark <james.clark@linaro.org>, 
 Xulin Sun <xulin.sun@windriver.com>, Marius Trifu <marius.trifu@nxp.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>, 
 Andra-Teodora Ilie <andra.ilie@nxp.com>, 
 Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>, 
 Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>, Dan Nica <dan.nica@nxp.com>, 
 Larisa Grigore <Larisa.Grigore@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
X-Mailer: b4 0.14.0

DT and driver changes for DSPI on S32G platforms. First 4 commits add
new S32G registers and device settings along with restricting userspace
register access properly for all devices. Then some DMA mode fixes along
with adding support for target mode, which uses DMA. Followed by some
other minor bug fixes and then finally add the DT compatibles and
binding docs.

---
Andra-Teodora Ilie (1):
      spi: spi-fsl-dspi: Enable modified transfer protocol

Bogdan-Gabriel Roman (1):
      spi: spi-fsl-dspi: Halt the module after a new message transfer

Ciprian Marian Costea (2):
      dt-bindings: spi: dspi: Add S32G support
      spi: spi-fsl-dspi: Enable support for S32G platforms

James Clark (2):
      spi: spi-fsl-dspi: Define regmaps per device
      spi: spi-fsl-dspi: Re-use one volatile regmap for both device types

Larisa Grigore (7):
      spi: spi-fsl-dspi: restrict register range for regmap access
      spi: spi-fsl-dspi: Add config and regmaps for S32G platforms
      spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
      spi: spi-fsl-dspi: Reset SR flags before sending a new message
      spi: spi-fsl-dspi: Use DMA for S32G controller in target mode
      spi: spi-fsl-dspi: Reinitialize DSPI regs after resuming for S32G
      arm64: dts: Add DSPI entries for S32G platforms

Marius Trifu (1):
      spi: spi-fsl-dspi: Use spi_alloc_target for target

 .../devicetree/bindings/spi/fsl,dspi.yaml          |  18 ++
 arch/arm64/boot/dts/freescale/s32g2.dtsi           |  78 +++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi           |  78 +++++
 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi    |  87 +++++
 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi    |  77 +++++
 drivers/spi/Kconfig                                |   4 +-
 drivers/spi/spi-fsl-dspi.c                         | 356 +++++++++++++++------
 7 files changed, 592 insertions(+), 106 deletions(-)
---
base-commit: 9c69f88849045499e8ad114e5e13dbb3c85f4443
change-id: 20250325-james-nxp-spi-caf1e2099231

Best regards,
-- 
James Clark <james.clark@linaro.org>


