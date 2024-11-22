Return-Path: <linux-spi+bounces-5799-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1D69D5C17
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 10:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209042814E5
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5126418A6D3;
	Fri, 22 Nov 2024 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdQquU9X"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2715AAD9
	for <linux-spi@vger.kernel.org>; Fri, 22 Nov 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268556; cv=none; b=jJo0UnHYNyLshRv1sj4MEulO/q3V0if2wvRrJIt7nm9tm/rXrSM8wu2AMSLVomAz0EbqTgVnoe30ID4vMbbjdvXLxacMIdKoNEQ2LtqxG8QFTM5HfqWs1DTTndLR8WymLyJh0a1SqQwvn1y1FratooHc3a3oJJt5JjQxpdFGhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268556; c=relaxed/simple;
	bh=Fi/Ch3JunQZsfu3tqNFi8C/eLoWkVqpVvmDE7j2Cx/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hqy7gGTitvddz9Es28lciGpFFkYNRl0hqRvEYaept0WNnDNC+beFLFW1sb5aH8ll3qVRk7WdmV2/TLVJvBC96XYPgvT+K7Hr+ff6MpR0G/GfRTVwcf3OGPTBJYa3/zUrD7zNWCuK6eqwIA4b0ICeQxi1Ved3fz7xFdYxViAIis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdQquU9X; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732268554; x=1763804554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fi/Ch3JunQZsfu3tqNFi8C/eLoWkVqpVvmDE7j2Cx/A=;
  b=kdQquU9XMZ3vh0QQAFiXuBH+24ds8OozMci6RBucjddsBLV/AEYWxlv4
   PbRahla8rYf3REtVwBGd7XI+cS0i/zimfTT/100GQGWWDsBi/smSChILE
   u7tbVVVYA9y6HgQCOv++svKQ3SqTmGpbaVWLjAIIpBLKhUmKVtWuLZfLg
   kGpnzOTlcUqtBPxsv27iAVxpKGXsuEkEqprMko/Fcun3MdBBJpdSzVD1t
   qEPCKhnMQVn6V5iPS2hNjNNfDjBzeppQZMcvBpAXe3eoSdwRBGzGcafP7
   81HbsDNRtDC3427WQzCogPmwjbo3ZA0SuTKNoyiL1vgjX+vjF7oxVjmue
   Q==;
X-CSE-ConnectionGUID: EEP7GkWBRk6dnuuCMZzJxw==
X-CSE-MsgGUID: Lf9FOtkORsWT/bfUs9Q9Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="36323739"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="36323739"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 01:42:33 -0800
X-CSE-ConnectionGUID: rgNM9sRNRUCVOux3mrXHcQ==
X-CSE-MsgGUID: jrJ9I3mpSeqb6kH9PhcQUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="94971681"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.246.21.136])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 01:42:31 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] spi: Fix acpi deferred irq probe
Date: Fri, 22 Nov 2024 10:42:24 +0100
Message-Id: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When probing spi device take care of deferred probe of ACPI irq gpio
similar like for OF/DT case.

From practical standpoint this fixes issue with vsc-tp driver on
Dell XP 9340 laptop, which try to request interrupt with spi->irq
equal to -EPROBE_DEFER and fail to probe with the following error:

vsc-tp spi-INTC10D0:00: probe with driver vsc-tp failed with error -22

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Fixes: 33ada67da352 ("ACPI / spi: attach GPIO IRQ from ACPI description to SPI device")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/spi/spi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c1dad30a4528..0f3e6e2c2474 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -424,6 +424,16 @@ static int spi_probe(struct device *dev)
 			spi->irq = 0;
 	}
 
+	if (has_acpi_companion(dev) && spi->irq < 0) {
+		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
+
+		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
+		if (spi->irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		if (spi->irq < 0)
+			spi->irq = 0;
+	}
+
 	ret = dev_pm_domain_attach(dev, true);
 	if (ret)
 		return ret;
@@ -2869,9 +2879,6 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	acpi_set_modalias(adev, acpi_device_hid(adev), spi->modalias,
 			  sizeof(spi->modalias));
 
-	if (spi->irq < 0)
-		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
-
 	acpi_device_set_enumerated(adev);
 
 	adev->power.flags.ignore_parent = true;
-- 
2.34.1


