Return-Path: <linux-spi+bounces-9317-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D2B1E05F
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB22A6270AF
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7F1519A6;
	Fri,  8 Aug 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN9OTQdS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD92E36E0;
	Fri,  8 Aug 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754618436; cv=none; b=b4qXjWpylWMCyl8HhnkBgR2RO5YLTo3uS7lcKD2xduYhrZQCzz46UllJwLK5b3n76fRHAUl83AH2tyew9Edyf4NDg8GjlI5ONWn+8Ypiyr/2X85+IfYaf+7XWoRbcxWEtt6ADki/fAsM/DF29ncfdju4yqnG6F4fZbSHb04FVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754618436; c=relaxed/simple;
	bh=Q9TvXkCZZFK5X+atV+OgJiaaH15TABP2XLM2/bN3sx4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fScr3zdQKn6bZ+lmAw8BLgeNLc9HcO/jAzS68dz1F2MdHLma3PAQ77rRLT5WOBcaBZX7co4FrN2kvmbBjjHwCe9dpwvGGjuruCWRpZj8szgVMnW+W5AOTxROv6HVMjlXkI199isOfEi93Z8ZByEF9W9BeGoeYXsAbam8HTymtBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN9OTQdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2921AC4CEEB;
	Fri,  8 Aug 2025 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754618436;
	bh=Q9TvXkCZZFK5X+atV+OgJiaaH15TABP2XLM2/bN3sx4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FN9OTQdS5b6ueW4LBI3PdFzR+pJf0vrM0UlaNRhYXs54NdBceQnAF3xl/eB4dI043
	 9MTJoqlVI6kvstaIDN/fht+uHuB2hlhsdm3BgrEXpdzSUsHcrJ0MyqeEIwaDIgJB3e
	 FA+Uw/iE/tTVpS12By2uO0yZZkoWjxK3cYH7ARM1BEvBbJ2HKypOX+bDTfAFXfxO3K
	 cZ+loURTob82ESfk2fcKhISY+MJNEYIeCFJUOeesoNSNTICvq992LdNpDPL46O8rWl
	 RQq9LADfkmnqrKWr48jdKiguuvjVeQmmng443tZ/B5KJGbu6NWBrJYpenjtnkpeMlA
	 oFnQGnNeND9yQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C05BC87FD2;
	Fri,  8 Aug 2025 02:00:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] support for Amlogic SPI Flash Controller IP
Date: Fri, 08 Aug 2025 10:00:33 +0800
Message-Id: <20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEFalWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwMT3eKCzLRkXVNzM8NUY9O0pFTDNCWg2oKi1LTMCrA50bG1tQBFzYk
 0VwAAAA==
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754618434; l=1178;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=Q9TvXkCZZFK5X+atV+OgJiaaH15TABP2XLM2/bN3sx4=;
 b=0P/Gz33Pfi1wslGAfGII4PqKRTTYGefeUIhLu62F6trfQX8GwyFjb3ZT1BSiGIS4QiVjJ6FFb
 1eXhkxn4fdWDMSRI5/MsRJG9DnEXScg1SETR5SvYmi7hzyOyDZo3wHl
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
Feng Chen (2):
      spi: dt-bindings: add doc for Amlogic A113L2 SFC
      spi: amlogic: add driver for Amlogic SPI Flash Controller

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spifc driver

 .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  |  104 ++
 MAINTAINERS                                        |   10 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-amlogic-spifc-a4.c                 | 1328 ++++++++++++++++++++
 5 files changed, 1453 insertions(+)
---
base-commit: 60fcf916e06250108143a993bd803c6b12ad8d02
change-id: 20250804-spifc-5761e35fbe1f

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



