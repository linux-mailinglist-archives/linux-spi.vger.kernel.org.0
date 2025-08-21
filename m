Return-Path: <linux-spi+bounces-9572-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF960B2ED7E
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 07:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F81C83F44
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 05:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAED728C011;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWOw1CM0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1649620;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753440; cv=none; b=VXAAtKQVQimVNHbexXo9BxPxl1GJCX0NO/XIINcyh+mPy/WEWwoB7zqM6ZBDGi5+oMNyLbCXWsD0FXqj5ZrA9Pz2b8/kFUqpF1pwZOiO/pkM3hKHyq0NuVCpL1YmvUTrhAV05SiQbYAy6VoCtXOHt29MKnfIDAsSrmHjcQoI9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753440; c=relaxed/simple;
	bh=lgQDiZb0DulClOgWmp02Qm9x5FANbERY8z36HeeKjY0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D9iS732I2GDSLRO0G2ZOk/c0rN7rhTUAXOQfVQ7JzBor+vtMo627up1397oBv6z1xEJEXQ7tWRHLZI9hfx6oWzSxrV2iyp921WUPp4tVlWvVTSVmWveq1HISFKEZqgcIUDCDq8IJ045gnp+8t/aBj/Wdm8iKlh0Zaavv4yz7B2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWOw1CM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39B84C4CEED;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755753440;
	bh=lgQDiZb0DulClOgWmp02Qm9x5FANbERY8z36HeeKjY0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LWOw1CM0mSeh9LnE4EMguyfD2RqAFFJLfIvFo8UCMsACBpMF1uJdD2cgQYbgpohyF
	 j3p1hlTvCfx0Du9KWUQEGVs1KMkQoWPn74L0RgzCxLPSjhGLpZmSH2jy9EHsa0W4E3
	 b6FLItZPhg51Y5b8eixVYqIaL31i5Q6fANR1sFP25UspFoZxdF9TlJi59Gra0+rbtq
	 WRU05iQG6WZ/u6agK9Oilcj1wknrP2PwGRpUJP7XK+rskOzb413/La0fSZNK+GgCBy
	 OEI/XWV3TxdsQNPAudUyPireuEd27TPSc23Qne8CgWymFOVvAJYIffZLEnW097Ae/V
	 IxrNPuGh97VSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24450CA0EDC;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] support for Amlogic SPI Flash Controller IP
Date: Thu, 21 Aug 2025 13:17:14 +0800
Message-Id: <20250821-spifc-v2-0-b119f64b5c09@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANqrpmgC/zXMQQ6CMBCF4auQWVvTFlqJK+5hWECdgUmEktY0G
 tK7W4ku/5eXb4eIgTHCtdohYOLIfi2hTxW4eVgnFHwvDVpqI1vZiLgxOWEuVmFtaERFUL5bQOL
 X4dz60jPHpw/vg03qu/6F9ickJaQgarCWqO1gx25YHn5id3Z+gT7n/AHK10B2nAAAAA==
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755753436; l=1444;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=lgQDiZb0DulClOgWmp02Qm9x5FANbERY8z36HeeKjY0=;
 b=W5vglRBMS++ooBheJlBd00l+epbkQ75pXcWPZlHKO0zWWV5VrVLumigzlXRbPxKKhdcloJmfi
 Cr4bCBYMfSHDSCoG3yqk92DvcWB7SEPkc1YNKiexWvXg2SqBUjOz4+S
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

This Flash Controller is derived by adding an SPI path to the original
raw NAND controller. This controller supports two modes: raw mode and
SPI mode. The raw mode has already been implemented in the community
(drivers/mtd/nand/raw/meson_nand.c).
This submission supports the SPI mode.

Add the drivers and bindings corresponding to the SPI Flash Controller.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Remove clock reg descriptor and get clock from common clk.
- Remove ecc and ramdom descriptor in bindings.
- Modify the format and message description.
- Link to v1: https://lore.kernel.org/r/20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com

---
Feng Chen (2):
      spi: dt-bindings: add doc for Amlogic A113L2 SFC
      spi: amlogic: add driver for Amlogic SPI Flash Controller

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spifc driver

 .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  |   82 ++
 MAINTAINERS                                        |   10 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-amlogic-spifc-a4.c                 | 1224 ++++++++++++++++++++
 5 files changed, 1327 insertions(+)
---
base-commit: 8e13f0500222e187a82dd3c93c0ea8cd2a4d46a6
change-id: 20250804-spifc-5761e35fbe1f

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



