Return-Path: <linux-spi+bounces-9352-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72423B21554
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 21:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D284630CA
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 19:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBAB1F4CA1;
	Mon, 11 Aug 2025 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IZbqyB/c"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A292311C3E;
	Mon, 11 Aug 2025 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940800; cv=none; b=HmuakbqeZC7YRpCr1nUtkD8HHu3CnsQFU6JtQ2d4DdQZIpqPO1NrFLjpXunrzNfeLV2jCtnRo2DEGTx1cjQArUZVUzeV3cJxnfk1IZq+rVH9Nw6T7OVknG2C7dZh4dbJ+v+8mae/fAr2hZMwBfJ3E4WZTdcaSya2WUTBj4h4T1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940800; c=relaxed/simple;
	bh=fXE9x0dnhGQ8h61z9jnyCQ4PIkNkTGgP1awTzdtOxpU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u7FnhhQIpun4xyh5Wyxq+gikBEcY6Ussc9F49NbA/Ka3wEAL2P0kyiFNQh+9bcGZggJBkF/jodcOqo6LpT+1ELC42Oi9hfy7J/9TaDOp6NqvjQQX1NtS/I3k3fLUKphMJyfvXEUmFCcXH65JHayI56+z7L+1IiBSPyk7j5eyN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IZbqyB/c; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BJWwlT1609347;
	Mon, 11 Aug 2025 14:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754940778;
	bh=G8Kby90UsAQLrUgV/PU9XSM9vV3CObRxk/OXLyHe7pE=;
	h=From:To:CC:Subject:Date;
	b=IZbqyB/co7KVIMDsC1EMUvqYsAfI/RRV6N6jrQ9UrFmffhH3TTo721azBc43WVwxC
	 FFWwvdeRS1ZZv2U4I/t6IoWukJqvb0p1cGSJgm08iQYTIsDdr39g2W8Zn8h9x9mHQN
	 a9KsLq3oMqEvhlt6OQAENHs7mdlEI2y1ZyCJXr3c=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BJWvjS3895668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 14:32:57 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 14:32:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 14:32:57 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BJWq1n3690681;
	Mon, 11 Aug 2025 14:32:53 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <mwalle@kernel.org>, <p-mantena@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [RFC PATCH 00/10] SPINAND PHY Tuning Series
Date: Tue, 12 Aug 2025 01:02:09 +0530
Message-ID: <20250811193219.731851-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

High-speed operation of certain SPI NAND/NOR controllers, such as the
Cadence OSPI controller, requires execution of a PHY tuning sequence
after switching the device to the appropriate mode (SDR or DDR).
Without PHY, the controller in SDR mode can operate only at one-fourth
of the reference clock. This series introduces an SDR-based PHY tuning
procedure to enable higher-speed operation in SDR mode.

A new _execute_tuning() hook is added to the mtd_info structure for
each MTD device. This hook is invoked when a flash partition named
'ospi.phypattern' is detected. The flash-specific _execute_tuning()
implementation retrieves the PHY tuning parameters-such as the
pre-defined tuning pattern and its size-and uses them to perform a
readback/compare operation against the known pre-flashed data in
'ospi.phypattern' as part of the tuning process.

From the flash driver, spi_mem_execute_tuning() is called with an
appropriate read_op. This function invokes cqspi_execute_tuning(),
which contains the PHY tuning algorithm. These APIs are flash-agnostic,
relying only on the correct read_op being passed. DDR mode tuning with
DQS support will be implemented in a future series.

In the NOR driver, _execute_tuning() follows the same approach of
pre-flashing a known pattern into the target partition and reading it
back during tuning. For NAND flashes, the tuning pattern can be written
directly to the cache via write_to_cache() and subsequently read back
using read_from_cache() during the tuning procedure. This support will
be added in a later phase.

At present, the series does not implement fallback handling for tuning
failures (e.g., reducing maximum frequency or adjusting dummy cycles).
Future enhancements will add fallback mechanisms to select a lower
operating frequency and optimal dummy cycle configuration.

Device Tree updates required for this functionality will be submitted
in a separate patch series after this one is merged.

This series was tested on TI's AM62A SK with W35N01JW OSPI NAND flash.
The read and write throughput with and without PHY:

Without PHY:
     READ: 7.1 MB/s
     WRITE: 6 MB/s
     
Wth PHY:
     READ: 35.1 MB/s
     WRITE: 9.2 MB/s
     
Repo: https://github.com/santhosh21/linux/commits/spinand_phy_rfc_v1
Test log: https://gist.github.com/santhosh21/d2d52cc03d2423200971b0ab9c3b9365

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Pratyush Yadav (2):
  spi: spi-mem: Introduce support for tuning controller
  spi: cadence-quadspi: Enable PHY for aligned DAC reads

Santhosh Kumar K (8):
  spi: spi-mem: Define spi_mem_tuning_params and
    spi_mem_get_tuning_params()
  mtd: nand: spi: Introduce _execute_tuning for mtd devices
  mtd: mtdcore: Call mtd_execute_tuning during mtd_register
  spi: cadence-quadspi: Move cqspi_readdata_capture() above all
    operations
  spi: cadence-quadspi: Use BIT() macro for CQSPI_REG_READCAPTURE_BYPASS
  spi: cadence-quadspi: Enable PHY for data writes
  spi: cadence-quadspi: Implement PHY for higher frequencies in SDR mode
  spi: cadence-quadspi: Define cqspi_get_tuning_params()

 drivers/mtd/mtdcore.c             |  19 +
 drivers/mtd/mtdcore.h             |   1 +
 drivers/mtd/nand/spi/core.c       |  61 +++
 drivers/spi/spi-cadence-quadspi.c | 727 ++++++++++++++++++++++++++++--
 drivers/spi/spi-mem.c             |  22 +
 include/linux/mtd/mtd.h           |   1 +
 include/linux/spi/spi-mem.h       |  23 +
 7 files changed, 823 insertions(+), 31 deletions(-)

-- 
2.34.1


