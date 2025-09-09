Return-Path: <linux-spi+bounces-9947-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C47B4A122
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 07:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D5937A04CD
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 05:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257352EB849;
	Tue,  9 Sep 2025 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6RU8K+U"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77BF9C1;
	Tue,  9 Sep 2025 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394809; cv=none; b=UR3ylE/4aq3OTpgB6bv6OvwgihC2CuE2yAxE5uNI760vCh5M/RSTQO4pP1chx3ib5d1k4Kv501W7Q3Cc37dCW31zc9HavR/+MAFsKxK66sr6x9MnjgaLtEaN6xgBum5ZCZ4yUL6WnpDhLXpsxzteFuCpEYpcbeLzNgIS+GbkGbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394809; c=relaxed/simple;
	bh=6PX2e7dGJjwC4zwK2oyfFNmBAEYYwMR+WepuRDhd+V4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s4dpiUFSdNOGcQwKiCkSqM55irIbhNdu7Dhmex7zRXmhHmIUuWsvXbql5j1in6Y0y7E8PdhcmWKJR+5nJYVlC/v0So5AaR8rgn1mtwr1WWSBvWQGFiMhug7/ptJno4+bFt0ea/A8hyWV5ai0WMcqflidiOJW40kZAfHZ/U2wzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6RU8K+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 766DEC4CEF4;
	Tue,  9 Sep 2025 05:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757394808;
	bh=6PX2e7dGJjwC4zwK2oyfFNmBAEYYwMR+WepuRDhd+V4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=W6RU8K+Uemim/kU+/rw2eH/pm0g/HObi2e5hZiuInqe9cSWMO4+BTczCHfjQ3iBHG
	 /v+2WVXTs5P03GMZBV3XClwKuz88IZcZHO17FK78IcOAGrEVINqg7abJws+45bBgmU
	 86avdnXw7vmeQ58U5Q4yfv5x83Gy7w5uyw3UtRTUjYzQVJRpo2jH0LPrlF84UZZOPE
	 yjZiY5hNyfdyY12CL+VLz7BK29cbaNKW5BX4Q3ZBSpWJcf7eeSYOXfAgUbIRQqx4bo
	 Vzd0lQgVkjgiQweZU6X6rpnsPhJoGZsms7qYu3D4Yu56n5zkrvxFbQNg3mHotmjUyc
	 ZEjygHURAFHhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62394CAC585;
	Tue,  9 Sep 2025 05:13:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v5 0/3] support for Amlogic SPI Flash Controller IP
Date: Tue, 09 Sep 2025 13:13:24 +0800
Message-Id: <20250909-spifc-v5-0-962bc147d17f@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHW3v2gC/2XMTQrCMBCG4atI1kYy+WvjynuIizadaQNqSiNFk
 d7dWCxUuvyGed43SzgETOy4e7MBx5BCvOdh9jvmu+reIg9N3kwKaUQpNE99IM9NYQGVoRqBWP7
 tB6TwnDvnS95dSI84vObsCN/rUih/hRG44EQalUBpK1ufqts1tsEffLyxb2OUKydhcTK7GsCR1
 bXxwm2dWju7OJVdgU5aoaEpyG6dXju3OJ0doCmoUY5Mqf/dNE0fbW3wR0QBAAA=
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757394806; l=1969;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=6PX2e7dGJjwC4zwK2oyfFNmBAEYYwMR+WepuRDhd+V4=;
 b=YzPNsHeKO+ldWi+RFRj6miT15/ZHAsvByjJbWR4va/heDq/6NXdgIbfh69kdvVWpqEYDVfvmI
 fU3RXriUQ+vD1izrpa/k1j+6WQDPKhYuOS+kNFzBWoplEEb9tRl8KT1
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
Changes in v5:
- Initialize local variables and handle exceptions solve compilation error problems.
- Link to v4: https://lore.kernel.org/r/20250829-spifc-v4-0-1e57fd39f584@amlogic.com

Changes in v4:
- Reword desc of 'amlogic, rx-adj' in bingding file.
- Link to v3: https://lore.kernel.org/r/20250826-spifc-v3-0-7e926041d7f6@amlogic.com

Changes in v3:
- Restore message description and modify subject [1/3] that was omitted in v2. 
- Link to v2: https://lore.kernel.org/r/20250821-spifc-v2-0-b119f64b5c09@amlogic.com

Changes in v2:
- Remove clock reg descriptor and get clock from common clk.
- Remove ecc and ramdom descriptor in bindings.
- Modify the format and message description.
- Link to v1: https://lore.kernel.org/r/20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com

---
Feng Chen (2):
      spi: dt-bindings: add Amlogic A113L2 SFC
      spi: amlogic: add driver for Amlogic SPI Flash Controller

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spifc driver

 .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  |   82 ++
 MAINTAINERS                                        |   10 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-amlogic-spifc-a4.c                 | 1222 ++++++++++++++++++++
 5 files changed, 1325 insertions(+)
---
base-commit: f8b3f0d7b2a91ba84d06343c3ca4522e35a65f56
change-id: 20250804-spifc-5761e35fbe1f

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



