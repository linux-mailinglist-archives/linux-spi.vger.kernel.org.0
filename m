Return-Path: <linux-spi+bounces-9034-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F26AF85D4
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 04:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40CC5673B8
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 02:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC81DF246;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLoyU2wa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0F4B5AE;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751597974; cv=none; b=RZZSRWEPUBKc5RxbRVfudZRvnYj9HktTCBtA0T+b9zz5LHst2/LCEXIQSv2nalLO17mIu72FnIwXVo1DimORrYI+NwknBtiatFEDFNDA1jDDAilkzqi8iRQp8uJHx76KXXNbSq2AwO9KZmbUA924jN/N59RpA26o7O/2T60VMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751597974; c=relaxed/simple;
	bh=AN3zYOg/SC8p0HEnNd2sFLzv/mQYAsIfsucNFSrf+Ac=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lEHAJXSpPKEg6xN42YFSofCnVJN5RTSMhR7apmOnIK0NZs1xiEFsZJMKdEvHxWN1eyM+txU1S/Rs4qpJJQ+MB9qHI5xkwLb86v2ZrUEHI56NYaBZv1F17rPm5S96N4DCcB01l4SwpEUDHkupsveHvR/3mKMrRa0yyCuSAY9agGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLoyU2wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06EB4C4CEE3;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751597974;
	bh=AN3zYOg/SC8p0HEnNd2sFLzv/mQYAsIfsucNFSrf+Ac=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hLoyU2wa2vxnTXkRBu8+xSYKzeOYv6xj9kpTusX9MBr+0w3hJd6K7mbZ52hOwHqpS
	 cMO970JsYFT28MsqlQj4m8wgHhZ4p4wrgU6vYQzlx8ogMrYCqIhRF6Qo+M/G1layyJ
	 PoY2o2XUQjSk6gngJIWYNVHKqDk6dUWE2LknRejdPJJ0Fvx/MryDHk1GhgBO+eRCVr
	 Qpe4RnK2/RI2XE/oWQD70ifKmSTeIbbTpgwNmLPNHveAiQFkfYamU70smQHK/NViZz
	 5hLWkjXceobD9RgBVfCxKmBHuJ/mmCPiUlF6Og3QD9+qLZbhm7TV/SRa1mHRwl56yx
	 8F+pevcpKCCsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB148C83F07;
	Fri,  4 Jul 2025 02:59:33 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v4 0/3] support for amlogic the new SPI IP
Date: Fri, 04 Jul 2025 10:59:31 +0800
Message-Id: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJNDZ2gC/2XO3wqDIBiH4VsJj+fwT6btaPcxdmD6VcLK0CEb0
 b3PYkFjh78PnxdnFCE4iOhSzChActH5MY/yVCDT67ED7GzeiBEmSEU4jpOLHZaqZbRSDBptUH4
 7BWjda+vc7nn3Lj59eG/ZRNfrXii/hUQxwULV3DZQ21rwqx4evnPmbPyA1kZiB0fl7tjqqK6I0
 KpsrPh3/ODY/uPEszOS01ZIYKo2v25Zlg+IQNAaDAEAAA==
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751597972; l=1846;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=AN3zYOg/SC8p0HEnNd2sFLzv/mQYAsIfsucNFSrf+Ac=;
 b=YOtuMj0B9H0vJgflB6YDqgr4DZR8xDKRQE+zqr8EJGDkPns+8Wx77xxiHz6G5IWKC70LWsVFx
 SjJfINMCWdxDlZ4ZFu0uZcOT2TMP9aDOFCIZ4t90KAKctq0KAI8cb+d
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Introduced support for the new SPI IP (SPISG). The SPISG is
a communication-oriented SPI controller from Amlogic,supporting
three operation modes: PIO, block DMA, and scatter-gather DMA.

Add the drivers and device tree bindings corresponding to the SPISG.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v4:
- Add resets prop and modify some formats for bindings.
- Remove irrelevant headers files and fix some issues.
- Link to v3: https://lore.kernel.org/r/20250623-spisg-v3-0-c731f57e289c@amlogic.com

Changes in v3:
- Rename of bit definition and fix some issues.
- Enable runtime_suspend function.
- Link to v2: https://lore.kernel.org/r/20250617-spisg-v2-0-51a605a84bd5@amlogic.com

Changes in v2:
- Use regmap to operation register and drop bitfied define.
- Use "SPISG" prefix intead of "SPICC", and declare clock div table in the spisg_device. 
- Delete other power operation functions except for runtime_supspend and runtime_resume.
- Fix some format corrections.
- Link to v1: https://lore.kernel.org/r/20250604-spisg-v1-0-5893dbe9d953@amlogic.com

---
Sunny Luo (2):
      spi: dt-bindings: Add binding document of Amlogic SPISG controller
      spi: Add Amlogic SPISG driver

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spi driver

 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  |  59 ++
 MAINTAINERS                                        |   9 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-amlogic-spisg.c                    | 871 +++++++++++++++++++++
 5 files changed, 949 insertions(+)
---
base-commit: bd30b995df8fd053e13d10f78dbc7b2fa5ed1aae
change-id: 20250603-spisg-78f21682ebac

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



