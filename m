Return-Path: <linux-spi+bounces-8611-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580DBADBF4D
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 04:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449633AC25E
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 02:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B906220297C;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXAdnN/V"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD11624DD;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750128523; cv=none; b=sTt0rXg/W7TPHgeIKuxb5igQzmDZb76YgriUv0YzR0mAlcMNWsn8dHhrNgtMxzAGe3y+YPmBdP3IL4He8qu3pSD24ioXUAnE3imChjgPtb6Fuui981zFAV2QL7z8brxSlCW/qb5Hc3ul0ggE5eumPL9YCBSxwr2FIJOAyu4oPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750128523; c=relaxed/simple;
	bh=DklztjJ2Mw4DZTzCJXFIusPWDE6iqwE0hRAVc+zb/5M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EZzj2HyJuKdABuGcHBi7qjqpiFbTxmYBaLXNHOBS12H5YDq67L6xCuuq0AGHFzNm3bmk8JcazDL42k9fbMCWjtWtf0/OhZbdlrbmZGkqkEqXTIKaGi2IomYAVhXOeI7L6OK78y9IeHHu3jtMY1Yj95BmfSTzKJGDRgRosZCaigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXAdnN/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1410FC4CEEA;
	Tue, 17 Jun 2025 02:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750128523;
	bh=DklztjJ2Mw4DZTzCJXFIusPWDE6iqwE0hRAVc+zb/5M=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RXAdnN/VH4whkEDHi0WhWsgK0TD7IDzbqiegcOr8PAe/4GJk+joOalb9pVGxfU9W8
	 vzRlHw2yZ9Y3UzN5eZkuCRmU/GV/Uj3OvEZRx0zow+BdXW+jLfvEDF3o7r8+QEH+/X
	 WlwW9rnX/FR09001rWLFG8GucBxi64Yc0JZanNOWuq+f/8nC4NE1nVM58O1LbIcPtr
	 Nv6HAJCQ7SE5N99mdASgfCpoIAGvR8PghnVFgSrZLGB0ZM55r8BFCXXCfjKEbCIaSY
	 ZmJtjLPb3sRjnj5ep7Ji4LLWzUFJK8++bzt8FnVLgxNsw/Gs7Rv6GqvZ2Ty4kYuMwm
	 bX8YIABlGxAWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41F2C71155;
	Tue, 17 Jun 2025 02:48:42 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] support for amlogic the new SPI IP
Date: Tue, 17 Jun 2025 10:48:35 +0800
Message-Id: <20250617-spisg-v2-0-51a605a84bd5@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIPXUGgC/zXMQQ6DIBCF4auYWZcGsFh11Xs0LhBGnKSKgYa0M
 dy91LTL/+Xl2yFiIIzQVzsETBTJryXkqQIz69UhI1saJJeKN7xmcaPo2LWdpGhaiaM2UL5bwIl
 eh3MfSs8Unz68DzaJ7/oXLj8hCcaZarvajtjZTtU3vTy8I3M2foEh5/wBvye3UZwAAAA=
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750128521; l=1440;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=DklztjJ2Mw4DZTzCJXFIusPWDE6iqwE0hRAVc+zb/5M=;
 b=8h9iC9im/B3MsOYxsjoF/SsNde6GwLGzHa0m3zbNfwkanuyQJc2YiiDB/4mkEiGbxoWFHVw3a
 mrUv4z5DSneBIlVg5e9geBhXGLt5rG9DeNZfOReOCIDhe1z5P9+zp4m
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
Changes in v2:
- Use regmap to operation register and drop bitfied define.
- Use "SPISG" prefix intead of "SPICC", and declare clock div table in the spisg_device. 
- Delete other power operation functions except for runtime_supspend and runtime_resume.
- Fix some format corrections.
- Link to v1: https://lore.kernel.org/r/20250604-spisg-v1-0-5893dbe9d953@amlogic.com

---
Sunny Luo (2):
      dt-bindings: spi: Add binding document of Amlogic SPISG controller
      spi: Add Amlogic SPISG driver

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spi driver

 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  |  55 ++
 MAINTAINERS                                        |   9 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-amlogic-spisg.c                    | 878 +++++++++++++++++++++
 5 files changed, 952 insertions(+)
---
base-commit: bd30b995df8fd053e13d10f78dbc7b2fa5ed1aae
change-id: 20250603-spisg-78f21682ebac

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



