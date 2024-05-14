Return-Path: <linux-spi+bounces-2842-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B58C50A1
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 13:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127DC280F6A
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1578913DDD1;
	Tue, 14 May 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BnLoj0zt"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F213DDAB;
	Tue, 14 May 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683519; cv=none; b=NzwM9JXLIUCF/fwFLWOlwlH4AS5MQo/K0DlTtACV8GuPmGBT89JmRsvJ6wLODi1IV9Mr7c/gFPf4BEev1S6Q3woiJ1P90NPQq4NGlGprp1Vw+R3lh68aEjS9VX6wh0+Zm4OMKpL1MTBXjkuDAI0MSMaRxtZLtrRMCqyHgAlOKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683519; c=relaxed/simple;
	bh=rlzB6/rDQbIjLk5lmcHcPcaK9fFkQm1X7kDxNwBZFVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiHjP5Dyp3X2hX7LAnF0KDqxXGXDnpOqAp3+Izdu7s3mZqGBvBsGqp4gIccJYuqZfSLhNty3LYx0mouXh2PbC5d48kM1k64JknuSV2/aFWP7X6p9gIs6BHOarwhZRfxhpDITz1Tc7uQmhub1yxbzOZFjn1F4pN8cMGqOwHB1drQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BnLoj0zt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715683517; x=1747219517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rlzB6/rDQbIjLk5lmcHcPcaK9fFkQm1X7kDxNwBZFVc=;
  b=BnLoj0ztel0mdFjT7MM5or7uNFkU0AAJURHbwYZkuaxssXVXV3w9WOa+
   TiitbXaBATX+o2Qa02AnccCPinVF0J2wsMBh6i6cfpIZxrW8+oXTzr52R
   AB70VzJzkNXF+VZEoDVQ+vxdgPMpjXBOOS0+oczJ/WYR+YixE2Xq7uaEP
   q6RDe05/seD4Kk/lVuZkXXlyv02rheceFomnJauIt2s3i1o7OYbC6TVqH
   czkwfgbB0yJIPVT+4SP1UxNr4c7YgEyfkAxoZ+ynSaqvES3a/kWlWx5vg
   pDhWMgjVOCiob+jqDiwr4WfLR6YOiNsJtVpn6f6nNP/T/UONsUcojKgC7
   w==;
X-CSE-ConnectionGUID: CRVhllyDQl2XuPQNxlB5Rg==
X-CSE-MsgGUID: nK6nDysRTn+Y+1qP6SwjEQ==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="24625780"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 03:45:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 03:45:03 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 03:45:01 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>,
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v2 3/3] spi: spi-microchip-core: Add support for GPIO based CS
Date: Tue, 14 May 2024 11:45:08 +0100
Message-ID: <20240514104508.938448-4-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
References: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The SPI "hard" controller within the PolarFire SoC is capable of
handling eight CS lines, but only one CS line is wired. Therefore, use
GPIO descriptors to configure additional CS lines.

Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index c10de45aa472..6246254e1dff 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -258,6 +258,9 @@ static int mchp_corespi_setup(struct spi_device *spi)
 	struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
+	if (spi_is_csgpiod(spi))
+		return 0;
+
 	/*
 	 * Active high targets need to be specifically set to their inactive
 	 * states during probe by adding them to the "control group" & thus
@@ -516,6 +519,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	host->num_chipselect = num_cs;
 	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->use_gpio_descriptors = true;
 	host->setup = mchp_corespi_setup;
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->transfer_one = mchp_corespi_transfer_one;
-- 
2.25.1


