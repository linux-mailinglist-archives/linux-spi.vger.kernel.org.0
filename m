Return-Path: <linux-spi+bounces-9355-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F7B2155A
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 21:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66451190845E
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9A2D6630;
	Mon, 11 Aug 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cIHNiIc1"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F322D63EF;
	Mon, 11 Aug 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940814; cv=none; b=T4QjOHlB+IXpCdd1NDzCfpC5X4cOfYlNcrAu1VwSrxSL3OkhFEAtumKvB19zYkJYpj/ttIPQq/CeaN0c0FUld2b5H/pX0/o14kF4Kip8VkKV96DDmXqEyIDwR7TJKPD6zxCqKYJF1li0qObMC//U3eZ5TPuj5a3LN5yJs3dym6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940814; c=relaxed/simple;
	bh=KEzWFBcwrXQMQm7m4doco1MeSg2Xh+gOQVNxD7S1psU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbvhPCyI5yZP7Fc1Qv3Yw18gsIuAQekhF53EmdBXOA3PeyXy8+23BeC0upQdc1k9m4MP98FkVUD9wpw6TXk+EXKAUEIzOcwqkjk5UHsUdwp1G2pFNF/+RI2aYCJGHeo0sg/MDMB6ipAVUbtTrfs69ej8jd2BQFfohlZFjQVeDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cIHNiIc1; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57BJXOr41609411;
	Mon, 11 Aug 2025 14:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754940804;
	bh=5gk44N9m+4BFJqlP2jfYY0PfWMGLlRjYM9wX9ai9Aag=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cIHNiIc1qKSBLG53AFIj+g3eoBXDCHmk36So4EgJLdyix0/W4iAWxSeHMns9xYzIx
	 Vw83pgdmq2CJajYGpU+jitAMHrfsrnPK+7MiM0kK6ONACoDGiEki0LL8iucYd/bc13
	 LF6NUbwvVw2hGobHRgpue8epZaQgzJtFcbRUDgzQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57BJXO3s2910915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 14:33:24 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 14:33:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 14:33:23 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57BJWq1t3690681;
	Mon, 11 Aug 2025 14:33:19 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <mwalle@kernel.org>, <p-mantena@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [RFC PATCH 06/10] spi: cadence-quadspi: Use BIT() macro for CQSPI_REG_READCAPTURE_BYPASS
Date: Tue, 12 Aug 2025 01:02:15 +0530
Message-ID: <20250811193219.731851-7-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811193219.731851-1-s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Simplify CQSPI_REG_READCAPTURE_BYPASS macro and add comment on Bypass
bit.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index da5823bcc1ea..1d86a7bc405e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -180,7 +180,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_DELAY_TSHSL_MASK		0xFF
 
 #define CQSPI_REG_READCAPTURE			0x10
-#define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
+#define CQSPI_REG_READCAPTURE_BYPASS		BIT(0)
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
 
@@ -453,10 +453,15 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi,
 
 	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
 
+	/*
+	 * Bypass bit - to enable/disable the signal from adapted loopback
+	 * clock circuit which is driven into Rx DLL and is used for data
+	 * capturing rather than internally generated ref_clk.
+	 */
 	if (bypass)
-		reg |= (1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
+		reg |= CQSPI_REG_READCAPTURE_BYPASS;
 	else
-		reg &= ~(1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
+		reg &= ~CQSPI_REG_READCAPTURE_BYPASS;
 
 	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
 		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
-- 
2.34.1


