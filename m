Return-Path: <linux-spi+bounces-960-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1360D8457D6
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 13:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F89284E6C
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D23F53360;
	Thu,  1 Feb 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fliwXmvS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B445336D
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790405; cv=none; b=R25vfFGUIsnn94gfdBFlRvwSVmfzE82TEm5XtyqhXypYtnpdRr60A6kZ45mGl/y/mPvLNA1IxwskAr2BJkVzBbb7CaEwJj406sMa+bT528NGpfO3C1E1yot2ujyoIEcgiPAxCqqIHyaTokzx7WZ0aV8qeNZSJ8TBamfyoZlh8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790405; c=relaxed/simple;
	bh=v7hFzSCwwpUb2pq2SBuNOF8t4jnH5oNqYv8dzniYkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUyzJNmmzyDMGhQ168y7Egb7wRiagVm/hU6qjzt0rYhzo9V+Zng728/bhsAWdisj9GeF2+d4jH7txk/a9guY53pjD+Oktj+I6Te27ezHNL37VSQnky9aEPpvmmj3UP/uz9BKOvSf/Opu0t0fw2D+7xTNaS/37YJXUzDtYPa2+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fliwXmvS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790405; x=1738326405;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v7hFzSCwwpUb2pq2SBuNOF8t4jnH5oNqYv8dzniYkQQ=;
  b=fliwXmvSl77d1iKpqlR8Sny6enq4UaUDsZjz7fihU3g0gfQlEMeAbxVv
   GW3N36Ut5iu7fdMuMVl1qujXAVtyhxkTYeuyxV/LQQFIKkyZKaBLPZ1wb
   3EUsFof7rfVPCKFrZlslZl69eFVCcXJ/0BKbe7Q2CeJHURUxD+2dunP5j
   uo4lEmFug+IXJOW+RCQkKdKymYWBJtKebGgiFtrifw70VrIo4UYdQ8XBP
   lVC+apGrYw0IHAUnVfk02tBqWGOcYva41gRLhTqutpWXmjfohzO0EP8a3
   dtBSOAcy2wE9Q9SUGbpTpkCP0WCXzq+gqbi03QCQ6OQQ+H7DPTHXQX2tq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10982179"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10982179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908237685"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="908237685"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2024 04:26:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 1880A9FD; Thu,  1 Feb 2024 14:16:39 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH 1/2] spi: intel: Add default partition and name to the second chip
Date: Thu,  1 Feb 2024 14:16:37 +0200
Message-ID: <20240201121638.207632-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should make it easier to identify the second chip and also allows
using "mtdparts=" and the like with this chip too.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 3654ae35d2db..467d39bf00b4 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -1346,6 +1346,7 @@ static int intel_spi_read_desc(struct intel_spi *ispi)
 static int intel_spi_populate_chip(struct intel_spi *ispi)
 {
 	struct flash_platform_data *pdata;
+	struct mtd_partition *parts;
 	struct spi_board_info chip;
 	int ret;
 
@@ -1376,7 +1377,23 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 	if (ispi->host->num_chipselect < 2)
 		return 0;
 
-	chip.platform_data = NULL;
+	pdata = devm_kzalloc(ispi->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->name = devm_kasprintf(ispi->dev, GFP_KERNEL, "%s-chip1",
+				     dev_name(ispi->dev));
+	pdata->nr_parts = 1;
+	parts = devm_kcalloc(ispi->dev, pdata->nr_parts, sizeof(*parts),
+			     GFP_KERNEL);
+	if (!parts)
+		return -ENOMEM;
+
+	parts[0].size = MTDPART_SIZ_FULL;
+	parts[0].name = "BIOS1";
+	pdata->parts = parts;
+
+	chip.platform_data = pdata;
 	chip.chip_select = 1;
 
 	if (!spi_new_device(ispi->host, &chip))
-- 
2.43.0


