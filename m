Return-Path: <linux-spi+bounces-8467-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CD6AD65BF
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 04:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933AA17E5F5
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A4718DB1A;
	Thu, 12 Jun 2025 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vTwZXb+/"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42A1E487;
	Thu, 12 Jun 2025 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749695733; cv=none; b=ItemaUucHpu31bjEnX7R7yMot7QgTRSiJIKloA6l1QHDvai5CzTR2WzpjwMuax0ByvJpbp48Iz1BJ3uZ2tF8msAYgmA8OgKr/+fnG4HrqaKvSSNSh7rNuq0OFrMo34gxDGezzZQrGDUBar50C8xMw+y7DDmf6YdulphQ50MkTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749695733; c=relaxed/simple;
	bh=+Hl9AseBvho7o3ZFIC2BtmGxdTeZ72nbwCuHpN3Rsuk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WSq1R6mFcEMO9OxIwH44RznKEZ76xXNbT4jcyskiaj6Tf0Lv1EFLpS1GmePyxYbQimvrcBlnnwC8KP4cw98jyenbTFS/NyPjKTz1JO1QBcyI/lxVDywykyMG6p9YsVN36EOOfVSqCgCEL2c5g6HvMr4o+uPIkXz3n5943kdGhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vTwZXb+/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749695732; x=1781231732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Hl9AseBvho7o3ZFIC2BtmGxdTeZ72nbwCuHpN3Rsuk=;
  b=vTwZXb+/pFMv6T74A5URA9nRjiR5rsvWE7TM073qwNF7uLNKGjqmIair
   qgpLQDg5gRX5wXE6I7oO8xwEL8hGOOYfWsLILOJdS4qiFNlTzLF6vEZXG
   HmkUaz4atpm7VitHrFMT9fKcdNQY57eTyLamJCY+wnDcqqFdarTPUQeal
   jTitsTT2TN0jQ2nmulvjeHlbpkUI7rJYumvyrjvJUfQc0Ae580asgvTIl
   0vxXpnxIwa6uv1eL0oEobskqOPSS1TjOxXWe5RNMNtw634K7yCurb7kSz
   9g9MttB9THRtKMMfBD1CCDtiOQkYt5Ms/UJ7KgWGB+H9gVhCk2/Nz1Kxk
   A==;
X-CSE-ConnectionGUID: 3+ULmwrQSE+9xSkTZap4DA==
X-CSE-MsgGUID: ZohDiDdpQnyM6qFl4owkJg==
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="42703047"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jun 2025 19:35:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 11 Jun 2025 19:35:02 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 11 Jun 2025 19:35:01 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 for-next] spi: spi-pci1xxxx: Drop MSI-X usage as unsupported by DMA engine
Date: Thu, 12 Jun 2025 08:00:59 +0530
Message-ID: <20250612023059.71726-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Removes MSI-X from the interrupt request path, as the DMA engine used by
the SPI controller does not support MSI-X interrupts.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 209a074a18a6..a6c8bf228288 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -765,7 +765,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 				return -EINVAL;
 
 			num_vector = pci_alloc_irq_vectors(pdev, 1, hw_inst_cnt,
-							   PCI_IRQ_ALL_TYPES);
+							   PCI_IRQ_INTX | PCI_IRQ_MSI);
 			if (num_vector < 0) {
 				dev_err(&pdev->dev, "Error allocating MSI vectors\n");
 				return num_vector;
-- 
2.25.1


