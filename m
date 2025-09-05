Return-Path: <linux-spi+bounces-9920-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F289B462FC
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6837C2CE8
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AE6315D50;
	Fri,  5 Sep 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xuep0fgk"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7026F2B4;
	Fri,  5 Sep 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098846; cv=none; b=u8ev/6kdCldai9uXWh20og6tBz962ZBPtbrukPqQUaSNLE9/4rWUXdQEB6aLl24ZO/8hFO1+p5Rg7jScI1zYCVsQc9dCTnx3cM9bIHUAPPLW0cVwtmGNMJU/K/6a+svt4edxLisT9cuC2gH3mp95wqojNyAnImSGQ7YeZ8RUV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098846; c=relaxed/simple;
	bh=jbDPoQPVj5LefJL1Lsz3kSRZPC4a/jkVm3mJ4yFeteE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NPxB4no8ZAA04pNB+88+cudSqLKS2aHTPfJztzLA8hbndFL294eBQevEKWqoMzMCTJIVQflOWbLWbsy3RuTxYLy4iYQ6MmBrIDunM95En/M1IKuNZwFWI+WNvjxLo0H8iMfv11oTcxNfoNvqVjCvXJ2IUxDB2kb+TWaHS896bBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xuep0fgk; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585J0FmF3384990;
	Fri, 5 Sep 2025 14:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757098815;
	bh=Sz++EvfKy+SO0R/e8eeoLx/0K6KwEUb7JRKGZipN1m4=;
	h=From:To:CC:Subject:Date;
	b=Xuep0fgkLP4jZyDepsStGuXenEdMDDzyCyovUBZlectNJkE5ZathsJVNSOPiEM03Q
	 0TQ8zNx1s9rK6mZC9O2p7Z4uYwLzre0OaL+2R1y+zxuNQA5qQsZO2NkKzFb39PmuRB
	 SXeGSsCCX0tMeM3jYz9nAbv6d2hsBqu9qjxVfzlg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585J0E0d561817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 14:00:15 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 14:00:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 14:00:13 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585J09kO887531;
	Fri, 5 Sep 2025 14:00:10 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <theo.lebrun@bootlin.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <s-k6@ti.com>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v2 0/4] Miscellaneous fixes and clean-ups
Date: Sat, 6 Sep 2025 00:29:54 +0530
Message-ID: <20250905185958.3575037-1-s-k6@ti.com>
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

This series introduces some small but important fixes and cleanups in
the Cadence QSPI Controller.

Changes in v2:
 - Use max_t() instead of if case
 - Add a logic to return failure if there are no flash device declared.
 - Convert all the open coded bit shifts to BIT() macro
 - Link to v1: https://lore.kernel.org/linux-spi/20250904133130.3105736-1-s-k6@ti.com/T/#m2a5b6024ae6f147615e54e12688d8ceb5acc6228

Tested on TI's AM62A SK and AM62P SK:
Logs: https://gist.github.com/santhosh21/0d25767b58d9a1d9624f2c502dd8f36b

Signed-off-by: Santhosh Kumar K s-k6@ti.com

Pratyush Yadav (2):
  spi: cadence-quadspi: Flush posted register writes before INDAC access
  spi: cadence-quadspi: Flush posted register writes before DAC access

Santhosh Kumar K (1):
  spi: cadence-quadspi: Fix cqspi_setup_flash()

Vignesh Raghavendra (1):
  spi: cadence-quadspi: Use BIT() macros where possible

 drivers/spi/spi-cadence-quadspi.c | 34 +++++++++++++++++++------------
 1 file changed, 21 insertions(+), 13 deletions(-)

-- 
2.34.1


