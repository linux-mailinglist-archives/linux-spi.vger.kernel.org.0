Return-Path: <linux-spi+bounces-9662-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF9B35166
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 04:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CD8244280
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB321FF25;
	Tue, 26 Aug 2025 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZuOUcx2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F91EF091;
	Tue, 26 Aug 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174212; cv=none; b=pCHs1PI4x0ZaD3sOeKVPZU/8Ac52JAJJHsy5SVlNMm2EAp/ku5b0lIZ9Y06hb5tDqNeLbYh52YONvjyVYyPhCrZ+YVEA3meqNg7pjf4vYmWjLPm1ZA1ca1FFWqELSykvwms5SlbQW+dSMfJt6Ku0bAYSPbLQYRljgygpFHT07TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174212; c=relaxed/simple;
	bh=0ZhDCvNeyZHdraVAF+JAqgTlwwrIyBAkGodg6u0wvUA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cKA1ZTCzPghpvihgl1RHcH/NQgoihdP63TlfE9hTT29aABveWfMi7PVOdEBnhDgda243W6I/Qe6ZKyCLYwH4nR7W+nR6Utpf2vN5a4l19eik3N14zW8EFfMJCRYKEHaw06GM1U3QlcXsnphzjdRIdIIRdr9XMRzTuXQqOkODp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZuOUcx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85782C4CEED;
	Tue, 26 Aug 2025 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756174211;
	bh=0ZhDCvNeyZHdraVAF+JAqgTlwwrIyBAkGodg6u0wvUA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fZuOUcx2q6h1iCxzrNMUQL0lonRgF5qYCxzdeIRXOejR2NdRobcnlA1tuFpbtDP2F
	 PR28vfT64msDEu8XPkG4RwMq4D/YG7q3lsVQ4x3ekOg/lJNZ1nNAj8YyCdFNI5ikri
	 5n1T0O3zRCUneXhdyoL19MDpVS07fzdqp8MHyLuQ/rDDmjqu4IdUOuOTBmecVSa8KA
	 LapmeK5+4ypLxeyeiKyURUn5vDZsBkzkl6h4jAVyT6gv6/D1EX7ysCjnmz4YrC5CWM
	 97Ea1Tl3IousamtPsYVcIg0un+rTKpgK7PXIhFkmSG4HUfq178FswQuO0lQLDodLKQ
	 8bwDf/6D1/nWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F9CA0EFA;
	Tue, 26 Aug 2025 02:10:11 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/3] support for Amlogic SPI Flash Controller IP
Date: Tue, 26 Aug 2025 10:10:08 +0800
Message-Id: <20250826-spifc-v3-0-7e926041d7f6@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAXrWgC/1WMwQ6CMBAFf4Xs2Zq20Aqe/A/jgdYtbCKUtKbRE
 P7dQiTR47y8mRkiBsII52KGgIki+TFDeSjA9u3YIaN7ZpBcKl7zisWJnGXqpAWWyhkUDvJ3Cuj
 otXWut8w9xacP7y2bxLruhfpbSIJx5lyFJUepW20u7fDwHdmj9QOsjSR/PCl2T2bPCNE4XRlle
 fPvLcvyAbqGCwjUAAAA
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756174209; l=1621;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=0ZhDCvNeyZHdraVAF+JAqgTlwwrIyBAkGodg6u0wvUA=;
 b=WqzjJ1o4w2CJM/Xelv4MpMLD0YDe780ru8Sk78CgDKc/OJSmr4X3uP8OFjAy/nGkOkc+cP27Q
 kSr91M6OrF/Ac9tKU2W0ZsOYUYoXaQpQshLXCoNSl/7FRwRNoDFtzyR
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
 drivers/spi/spi-amlogic-spifc-a4.c                 | 1224 ++++++++++++++++++++
 5 files changed, 1327 insertions(+)
---
base-commit: f8b3f0d7b2a91ba84d06343c3ca4522e35a65f56
change-id: 20250804-spifc-5761e35fbe1f

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



