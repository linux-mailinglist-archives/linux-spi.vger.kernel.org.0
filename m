Return-Path: <linux-spi+bounces-11843-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA53CB2822
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 864C730E5DD5
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 09:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1C42E1EEE;
	Wed, 10 Dec 2025 09:14:24 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447F3074B1;
	Wed, 10 Dec 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358064; cv=none; b=ucJIP/nXDdM3ePHWwUCyWjhgl4wYM1IhIYoRsZBVfGIoIVN5hMclu3bxi9aOKSxXgT/tvsMWi4cEeqDDlUlWF2Jm9hdwqeiyoaxQYI2EoOla3efXdeyrpnF1j0CG5hQ3ucA6pIF6qWSGxg6lV8MItFKR2NPQNIpEWXE56gQPZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358064; c=relaxed/simple;
	bh=DbrkSK9Pisa5WW6iqrOJfrhgalyCWsjIPOiwfw0BCrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VYOrJouSITeXV9tGNhsDPluyYaKdkIFK4BgZUbXDKdeWtVwK2mgZKEQOlk4ni7ICwLlrEVWgKcQceBvIVOjMQKxyamlsgN1NFnJtQD71PDgE87EGy/YE9BSC8y9wXydCSyWZQOGX7tZN8X9uzCkKTjeiM4Vb5rnfe0EW2nxXOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 5BA954uA081275;
	Wed, 10 Dec 2025 17:05:04 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 5BA94c7R080689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 10 Dec 2025 17:04:38 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Dec
 2025 17:04:38 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V2 0/3] spi: atcspi200: Add support for Andes ATCSPI200 SPI controller
Date: Wed, 10 Dec 2025 17:04:27 +0800
Message-ID: <20251210090430.3602380-1-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5BA954uA081275

Hi all,

This series adds support for the Andes ATCSPI200 SPI controller.

Changes in v2 include:
  - Added missing clock disable/unprepare handling in probe error paths.
  - Switched to devm_dma_request_chan() for proper DMA channel cleanup.
  - Updated the DT binding and documented all compatible strings.
  - Dropped the "spi_" prefix from dma-names as suggested.
  - Added suspend/resume support for power management.
  - Added the "andestech,ae350-spi" compatible string.
    
    AE350 is part of the AndeShape™ platform family and is a commercially
    supported product with a fixed, documented SoC-level architecture (memory
    map, interrupt topology, and peripheral integration). Although AE350 is
    often deployed on FPGA boards, the platform behaves as a stable SoC
    integration rather than a prototype.
    
    Upstream Linux already accepts FPGA-based platform-level compatible strings
    for stable SoC-like integrations. For example, the Tensilica FPGA platform
    uses:
    compatible = "cdns,xtfpga-spi";
   
    Following the same rationale, "andestech,ae350-spi" is proposed as the
    platform-level compatible string for AE350-based devices.

    More information about AE350 can be found at:
    https://www.andestech.com/en/products-solutions/andeshape-platforms/ae350-axi-based-platform-pre-integrated-with-n25f-nx25f-a25-ax25/

Patch overview:
  - Patch 1: Adds the device tree binding documentation.
  - Patch 2: Add ATCSPI200 SPI controller driver.
  - Patch 3: Add MAINTAINERS entry for the ATCSPI200 SPI controller driver.

Comments and reviews are welcome.
Thanks for your time.

Best regards,
CL

CL Wang (3):
  dt-bindings: spi: Add support for ATCSPI200 SPI controller
  spi: atcspi200: Add ATCSPI200 SPI controller driver
  MAINTAINERS: Add MAINTAINERS entry for the ATCSPI200 SPI controller
    driver

 .../bindings/spi/andestech,qilai-spi.yaml     |  86 +++
 MAINTAINERS                                   |   6 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-atcspi200.c                   | 680 ++++++++++++++++++
 5 files changed, 782 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
 create mode 100644 drivers/spi/spi-atcspi200.c

-- 
2.34.1


