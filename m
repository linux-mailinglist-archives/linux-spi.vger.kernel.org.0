Return-Path: <linux-spi+bounces-9123-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32844B09965
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jul 2025 03:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984291C47D30
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jul 2025 01:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E61319D880;
	Fri, 18 Jul 2025 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4vIJ27u"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD5191F89;
	Fri, 18 Jul 2025 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803540; cv=none; b=fr8xac2AMcXvqDOLpZw1GLwXainuzzNccE4G15y1SSHl2t9oYWBW4bJK/9EQ+4GwfQV6jxOuJsZomKKioHwDEbeQEiPXwmL/YVg8+F46D/giNpgoE8sRU+aozyna2Ve/xjdP5yA/L5XtqU5vuQ71Q/gyPgJ7f1qHQ9Vmff/+M8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803540; c=relaxed/simple;
	bh=T8ojarsyUU3VdRkPNIjPH+hMXuJfPiLhUJlGAKELHag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fMFr8hpMHz6mZ7iyqR5j54F08kxHCdgzUIbTynv1H6Udy3HR8S866mEzIQl80n0YKwP1ZJUQewf7MkEskdfVdXorIYVBzZrpwLqyRCZs49htMzU0Nvt+ee8Rd2Fkf772TfaRY0R1sZBVWnS2bgnjUovC6KSsZrExWrTaAgobtbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4vIJ27u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F330C4CEE3;
	Fri, 18 Jul 2025 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752803539;
	bh=T8ojarsyUU3VdRkPNIjPH+hMXuJfPiLhUJlGAKELHag=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=J4vIJ27ucyYSoQEfQeynNX2zuRsnmDUzQBbU0pxzcm08a0xg6CLc5OOV3MzCIpmPn
	 RMvTMDB/zDPPXrlsgpwFXxe+LASf1DF4xJlwQmL53fV/HIWww2E9DufdYileRAjDaI
	 KNljkw0hU8axRLMr1r51PBiNu0xAMNEGX6XSUDoS6L8qVkOiVecBEuGDFmt9BjxgT2
	 WFxupPiuLmHCf4/POeaL0aTSjbsEyzZKKaXxWT7Y2yEXXu7IkgkxjwGqmzGtXIP6FB
	 3d2SDBhzFlSkEesBz6fHNDt5AzVjv2ncP5ee6+0c0apoRpe4jt/hkEwSYue2XncKdW
	 9NRRYyYg0fjJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1ECC83F22;
	Fri, 18 Jul 2025 01:52:19 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v5 0/3] support for amlogic the new SPI IP
Date: Fri, 18 Jul 2025 09:52:15 +0800
Message-Id: <20250718-spisg-v5-0-b8f0f1eb93a2@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+oeWgC/2XOyQrCMBSF4VeRrI1kaIa68j3ERYbbNqCmNBIU6
 bubFouVLk/I93PfKMEQIKHj7o0GyCGFeC9D7HfIdebeAg6+bMQIE0QSjlMfUouVbhiVmoE1DpW
 //QBNeM6d86XsLqRHHF5zNtPpdSlU30KmmGCha+4t1L4W/GRu19gGd3DxhqZGZitH1eLY5KiRR
 BhdWS+2jq8cWy7OvDinOG2EAqZrt3XVz6nfnVVx0hboGwuSkn83juMHG2hVM0QBAAA=
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752803537; l=2119;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=T8ojarsyUU3VdRkPNIjPH+hMXuJfPiLhUJlGAKELHag=;
 b=Hw+zDiRsCmR+NB0r3zy0ptubSX5gfKCJ+VfAzYdlVxGanxFEZQbe9kezOWqTaE13KNUo+5uq3
 T2KAn61MQ+3BmQgtZcypOcX9fJNXM/+80R+skSaIE4pZxgg4iERjMrO
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
Changes in v5:
- The location for interrupting registration has been adjusted.
- Unexpected interrupt return IRQ_NONE.
- Modify div clk register and process reset_dev return value.
- Link to v4: https://lore.kernel.org/r/20250704-spisg-v4-0-6b731dfbe610@amlogic.com

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
 drivers/spi/spi-amlogic-spisg.c                    | 888 +++++++++++++++++++++
 5 files changed, 966 insertions(+)
---
base-commit: bd30b995df8fd053e13d10f78dbc7b2fa5ed1aae
change-id: 20250603-spisg-78f21682ebac

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



