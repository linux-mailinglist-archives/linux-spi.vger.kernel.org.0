Return-Path: <linux-spi+bounces-9922-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B577B46319
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 21:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE70BA12AF
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 18:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAD91FA859;
	Fri,  5 Sep 2025 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AnimHq6M"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165326FA5E;
	Fri,  5 Sep 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098847; cv=none; b=b6rKlQGocsKU0Mu4/vb+VTxnhftBb2Mg0gnO0Qdp6NMl17CKmjnade3rFjLDEdglq7GZ+hI5x+2h5+vPoJbV2RIH+G/KQ9H/mAK+KAlqVq9jBOo4I/y2GBHnuXglYnykq3AHi9zoUoCPzigsb5Qj6kjET0DGZecJFBqIquA++Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098847; c=relaxed/simple;
	bh=j4VflqOu9YM6FVcu8x38R6Ar4Y2F7g3tKkfvruWPGVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARJR/LYIK5nEjgEG+8rmErmoi0HLgsBGPly9Mw/nLSt/NNrILUOImoA2T+MzcX05u5Yo6mnoSUz+iw+9L+rhxkz3T7TMGP+VDIgADUIOpNIcvLKp0nbRBHBWyoMhKTMOZ65YGv99I5U01siy+VDCTNG/uiW3Zidgdmgv7HV8WkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AnimHq6M; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585J0NlQ3385046;
	Fri, 5 Sep 2025 14:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757098823;
	bh=R3inDNh1OryvySryjg4PnJ+gpe2qBjPpT4W89C1B584=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AnimHq6MhbB4Ngy09aR5UVyUZ4I0SkjslcrFV+JL/ZKcbHV1aW4TrWOIJyRWOuKwK
	 fuOjboqtMoM0QI3uLDuv+FkAJksKcjUZiF8NbYgpo7+aaGXmFti+LReeNBtWh0vLrF
	 BxGEQ5hzNNet4wN8G6rlddSRPvrzvKsphDb/Hhss=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585J0NdG1097788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 14:00:23 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 14:00:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 14:00:23 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585J09kQ887531;
	Fri, 5 Sep 2025 14:00:19 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <theo.lebrun@bootlin.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <s-k6@ti.com>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 2/4] spi: cadence-quadspi: Flush posted register writes before DAC access
Date: Sat, 6 Sep 2025 00:29:56 +0530
Message-ID: <20250905185958.3575037-3-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905185958.3575037-1-s-k6@ti.com>
References: <20250905185958.3575037-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Pratyush Yadav <pratyush@kernel.org>

cqspi_read_setup() and cqspi_write_setup() program the address width as
the last step in the setup. This is likely to be immediately followed by
a DAC region read/write. On TI K3 SoCs the DAC region is on a different
endpoint from the register region. This means that the order of the two
operations is not guaranteed, and they might be reordered at the
interconnect level. It is possible that the DAC read/write goes through
before the address width update goes through. In this situation if the
previous command used a different address width the OSPI command is sent
with the wrong number of address bytes, resulting in an invalid command
and undefined behavior.

Read back the size register to make sure the write gets flushed before
accessing the DAC region.

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
CC: stable@vger.kernel.org
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index eaf9a0f522d5..447a32a08a93 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -719,6 +719,7 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
@@ -1063,6 +1064,7 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
-- 
2.34.1


