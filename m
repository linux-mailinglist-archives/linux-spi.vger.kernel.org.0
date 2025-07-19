Return-Path: <linux-spi+bounces-9128-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C1B0AE3E
	for <lists+linux-spi@lfdr.de>; Sat, 19 Jul 2025 08:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0204F1C27417
	for <lists+linux-spi@lfdr.de>; Sat, 19 Jul 2025 06:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2E72288F9;
	Sat, 19 Jul 2025 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="h8Rj8wJr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4D1EE03D;
	Sat, 19 Jul 2025 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752907342; cv=none; b=B/Ep9BYGfPx8ZkYfZRDbQ7uBaUfoesn2m115miLUA1VpDqdxuZYXWWLFiMVgim7RtxErBdZcduhl30FUQj35tdONj9Yn2wcVpm4vUm1DFLkEjybJfQfczHWP9EkhdM7Ki5gp5N6w5Rs8BceA+nKuUYyBwUr0XfI11Exc3QlDgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752907342; c=relaxed/simple;
	bh=HzN9WFA3sBB29f/wbLmsu7Lnrd10Ru3mmvx1wazQwmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lh4LU/1H0/2hOqbHprQ3wpOlXPcOAcc7ST5kjpmdrEZfwEbCHmQ3E4SZzh2qipTMKen8osFSSw8PoZTS3+xU5kAG0gW33p0SSsSkuOuPLbUroz0rVbU+ujv398ytbFVYGbAxN0OeKQVyRZLODeDYF5YOMMotbpZsAXJvKurUkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=h8Rj8wJr; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8F43103AF666;
	Sat, 19 Jul 2025 08:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752906855; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=W7UUoSU/JKBYw8AcTXyc+/yk9Zl2lFIybimWyZEP1ZU=;
	b=h8Rj8wJroOAmiypYvhf19SAuBvsOZATkKuF9QiNEl8FQq2Cv7pqZUybmESTBxhl4EPrWwS
	L6gVuXU1WwWz7qtUWikP5VkfJdtfJxHRJUcXCK/aGu9UJvGzaJNaZT7YiNXhDAJuZ951l0
	DnzjkOiXYVge+4077QucLV1BsrvTo8FQW3/74xH0R5LTb9EbP0AIhc4ap8PnZLr1gOckh9
	9MI1LMzM5rIE9NNOyNIDHZw1tnN5h3wKPcWIxB/HF9OM13aji3pc+mXaSdDPzVK+5NPt7d
	GapLCq/2buSnFDFdHv5XZFspY5GQsXRjkn4OyJ47ZVGpLjcI2/XnNqS8Iy2DFg==
From: Heiko Schocher <hs@denx.de>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Schocher <hs@denx.de>,
	Andrei Lalaev <andrey.lalaev@gmail.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/3] spidev: introduce trivial abb sensor device
Date: Sat, 19 Jul 2025 08:33:51 +0200
Message-Id: <20250719063355.73111-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


This series introduces the changes needed for trivial spi
based sensors from ABB, currently operated from userspace.

The last patch adds the spidevices to the DTS files, already
in mainline.

make dtbs_check showed no errors/warnings for the dts files

  DTC [C] arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtb
  DTC [C] arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtbo
  DTC [C] arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtb



Heiko Schocher (3):
  dt-bindings: trivial-devices: Document ABB sensors
  spi: spidev: Add an entry for the ABB spi sensors
  arm64: dts: imx8mp: add ABB spi sensors

 .../devicetree/bindings/trivial-devices.yaml  |  2 ++
 .../freescale/imx8mp-aristainetos3-helios.dts | 28 +++++++++++++++++++
 .../imx8mp-aristainetos3-proton2s.dts         | 22 +++++++++++++++
 drivers/spi/spidev.c                          |  2 ++
 4 files changed, 54 insertions(+)

-- 
2.20.1

base-commit: 3668990919df7a8df60ab1f39ec95f59434b68ec

