Return-Path: <linux-spi+bounces-9417-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C9B26BFF
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E3016F414
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BE523CEE5;
	Thu, 14 Aug 2025 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bibmmQvZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA52246BD8
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187625; cv=none; b=pe3+F0jjwOJcgrFPAOLCCQ2cu44WODoHIdsJqqICAXQUkuvOJRGEU4qAa+45gZ+4JFtfqp9ulbPS/nISjJXHlBCowuZ18Mnun9p6WSX+IVKeV7PhqpA5j1uth4jXR9xzpL/OyJZPmQH1jnkMgVv7uRZBIYAONwPzIncpje2lW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187625; c=relaxed/simple;
	bh=MEMndkwsKz3Wir01XY15+wsOAiobH1YxwPbkYo3eX7Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iskGET7XqvXBJ/jf0s1EzWsDTuip+PdHq4QVc31hXEpKZZ0YJuAxpBgZ2NbTaQRqgDvB4idlLNIigRVbGsg5Wp6szIM2bRszG3VV1z+3Qcts+XnSjh8vEzEnFguDLFX63fw8mL/XYd0YDsPRPpHHM2pZlrOEsyI/JTB1PPNypro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bibmmQvZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so5711625e9.1
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187621; x=1755792421; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yj38X/0MfiFnhuC5i4RxM2VUGXAWD2Xbv8OmXp3rmdA=;
        b=bibmmQvZBZkUL7IGH+Xr/U4n4OtdjnPCPKcsE6j2efOgUnz/WDj4Vzydfgr22xW3AP
         iu0rrm9Fgw2dOl/kVAVN6g7nArEG0h7FfhnoDiD4ZkGz57/vxoPH+D/VXMRLcVbfc5X8
         +PWAjKS/MB54XYnfxDaGXXZyp0Ox0gzswZVK6a+b+z5XBEGJuz96Z190tjK5wso9uSej
         sKH7COfdHJTG6vQUvYlPzmX5kQDQ0Jlz3lQzwbWTIJ6mzRyKyG3woa56dpcAbA/77fG6
         4w2cLhCmwb36dKAa+khZ7YkJbHHPVPjxfkDtJDcvXgjYU8S+FnGlYggVj6nSxFhRxM+3
         MKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187621; x=1755792421;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yj38X/0MfiFnhuC5i4RxM2VUGXAWD2Xbv8OmXp3rmdA=;
        b=R+/V7E+WORSB7xqgf6j1MHDZ++6bGqnwr5kIE6RO1F7T1dlVCRsx3YKmtZTGE/YPVE
         /0gCqE3a3Zvm0sR+iUN7f0RGFh9H3RNBbk+NTui8R0c//9wNvhhfxMgDrGalXiakDquW
         uBn6PkYTevWFl95EcA9qW4wKb5huybUAwtC0wWUwYavs6Ofz5J2l4blz5HmN9z9wAKcL
         iOyDoRtPyTwYUiiAS78QVSm7gR6++FhWwWtfc0RAEBDdDDzN11ni5vLP1XUi97IR+yv4
         3fgZtKMW56q7EHhfY6nMEJ2TdzM+Sc/kG9AmIeL90RLsi0B+AdVzHd7nHMo3mXIkrzkv
         wkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyeVFc4XRJdJFzjhDZtRep6USwOngZuleCw8rtjsFfy021aOYS4lts4Gjr06stOhVMiU5BQ3gpgUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXCAY18b3zUgUI8u6DKBkIlO0zHhIHtwpJNUCldhw+Ke7e3f9
	3XtiwXAgaC9gsdV/XRmvo31cTp8E1rcBn9lHQ3Jm8z73GZvE1bHkIqL1nCu+72GC5ok=
X-Gm-Gg: ASbGncsojrNRFfELfU2OMpD+6GYAlxGzBIR5g0DJ7b4e5UupFYw2WKeOmnMoabcW14M
	VOVvNNKmv+2fWydhuttiGmbhVozKwUEzDRMT42XyiDsQduJBXP/H743tRTpj+CMB0VuiJOVmzgQ
	xOzFKZ+BpQytKeauqaBLZTxT2157PY3fbRYlerxAFgwZyJxUBAU0RJDMwgWsxcThxCm6MXaLTMC
	o58fyLfMvDBAhR5oQuNYvzOmaZLO7EcZCXaEsqrAMXaRtXFaDoop29yYRp5Tij+HksbNkkH3/SM
	8ucRVIoA8vIPWLlVjfif03CfaLIvB+kGsvhQixsCQt/qWH+x3spTsKDOIsYGrhhyCsvQ2QRZqXC
	q6xsopyKi0t+SK4vAK2RAYVgfxXsJR94=
X-Google-Smtp-Source: AGHT+IGccfHVH8S3HQU2QCeEdvi+7U1L+lLQrDOX9EP621ilEY0DVdTkWjRgqUW6HC5Zu2JnCCHaEg==
X-Received: by 2002:a05:600c:470a:b0:459:db5a:b097 with SMTP id 5b1f17b1804b1-45a1b6489e0mr37662135e9.16.1755187621381;
        Thu, 14 Aug 2025 09:07:01 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 00/13] spi: spi-fsl-lpspi: Generic fixes and support for
 S32G devices
Date: Thu, 14 Aug 2025 17:06:40 +0100
Message-Id: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAJnmgC/2XOSwqDMBCA4atI1k3JgxjtqvcoXUSd6BRrQlKCR
 bx7oxRKcfkPzDezkAgBIZJLsZAACSO6KQc/FaQdzNQDxS43EUwoprmiD/OESKfZ09FHj5Rb06o
 KtDCqJnnLB7A47+LtnnvA+HLhvR9IfJt+LckPVuKU0a4uhdSVsbJtriNOJrizCz3ZsCR+QMWOz
 ySRAalryzvTlBrgD1jX9QNSTsKt8AAAAA==
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

Various fixes for LPSI along with some refactorings. None of the fixes
are strictly related to S32G, however these changes all originate from
the work to support S32G devices. The only commits that are strictly
related are for the new s32g2 and s32g3 compatible strings.

Signed-off-by: James Clark <james.clark@linaro.org>
---
To: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
To: Fugang Duan <B38611@freescale.com>
To: Gao Pan <pandy.gao@nxp.com>
To: Fugang Duan <fugang.duan@nxp.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Larisa Grigore <larisa.grigore@nxp.com>
To: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
To: Ciprianmarian Costea <ciprianmarian.costea@nxp.com>
To: s32@nxp.com
Cc: linux-spi@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
James Clark (7):
      spi: spi-fsl-lpspi: Enumerate all pin configuration definitions
      spi: spi-fsl-lpspi: Add DT property to override default pin config
      spi: spi-fsl-lpspi: Constify devtype datas
      spi: spi-fsl-lpspi: Make prescale erratum a bool
      spi: spi-fsl-lpspi: Parameterize reading num-cs from hardware
      dt-bindings: lpspi: Update maximum num-cs value
      dt-bindings: lpspi: Document nxp,lpspi-pincfg property

Larisa Grigore (6):
      spi: spi-fsl-lpspi: Fix transmissions when using CONT
      spi: spi-fsl-lpspi: Set correct chip-select polarity bit
      spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
      spi: spi-fsl-lpspi: Clear status register after disabling the module
      spi: spi-fsl-lpspi: Add compatible for S32G
      dt-bindings: lpspi: Document support for S32G

 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     | 21 +++++-
 drivers/spi/spi-fsl-lpspi.c                        | 87 +++++++++++++++-------
 2 files changed, 82 insertions(+), 26 deletions(-)
---
base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
change-id: 20250715-james-nxp-lpspi-1fac58e72a59

Best regards,
-- 
James Clark <james.clark@linaro.org>


