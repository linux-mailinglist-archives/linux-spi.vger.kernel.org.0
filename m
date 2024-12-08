Return-Path: <linux-spi+bounces-5967-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04709E8793
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 20:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E86A281452
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1341917D9;
	Sun,  8 Dec 2024 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3eKrgVx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D91547C5;
	Sun,  8 Dec 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733687802; cv=none; b=rgORbN5m8aFLKBNr34uTUMsp7+KX/MRhtCUkJKDsZaunsKKafOP/qg53O28mM7rfUJLYiLydZ4ecj/IdNtmdlQckGNVDehkhZ1UG9cT0aA7skmnv/j2fm5oiy3jDo89QwLnVNkSXqDAn8udwvnuwe3EXtlBKoLTUmfmqkpvj7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733687802; c=relaxed/simple;
	bh=UVYOMh1kZEgr2A915NBnpaJaxt1QLu79qEQ2ILCqlXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZr7r0IP/jvhqeskFllN8iYcijQE8sTaovTdGo3qdxL27GIayKv6nfxXuKCzHGW4D9R18ExPW8edaOZ6JdP99vVrzTH4TCrAmZ1ju2Tm8zdFgyC1SfExIV13VoOCGcMXR1yXkjclam3cKzcmGQt0SumdMTMlnckzWcZl0btEA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3eKrgVx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733687800; x=1765223800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UVYOMh1kZEgr2A915NBnpaJaxt1QLu79qEQ2ILCqlXQ=;
  b=i3eKrgVxtd4/+wcDJtMoX3mWc/pKg8/oqLo2DcanX85Fqsc0/ud3A8jM
   MBDKxVD0MZ5n+XaqGAbILyFKzpYHY6Dv99CItMcw3MKQIGQxOl+/SsFtm
   UC/9BcpsC7QczWb6ETzGLEdraCcJU4eK4GGNwa9DGiso9q7aP2HE6aW0V
   5pNC1hBZaDJX/BHqVKQkgfq7E9jVqWCYDypbsA6MfNCrA4HuLyptj4Wup
   fbtRNywKsyP8/uhYXyppe5COMqa/ko3rbXq0ulk9hokO6f+zEDFTyPoJP
   hdasBsOB3/fOkNw6OFC8jxfg/z0MPj96+AJrYjw/WG5WG+sr00fsVTFUO
   g==;
X-CSE-ConnectionGUID: 7btlaIPxTjWE21ic8UdlrQ==
X-CSE-MsgGUID: 06cwOHSIRfqSIh8Y/1tWvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="44663067"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="44663067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 11:56:39 -0800
X-CSE-ConnectionGUID: ReM3beMNQvOyNsFn5OMHKg==
X-CSE-MsgGUID: AmLt/O4WRnyNrpO/G1EgiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="132274258"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 08 Dec 2024 11:56:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 11380426; Sun, 08 Dec 2024 21:56:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] spi: Deduplicate deferred probe checks in spi_probe()
Date: Sun,  8 Dec 2024 18:03:17 +0200
Message-ID: <20241208195635.1271656-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
References: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deduplicate deferred probe checks in spi_probe() and enable
the error message for ACPI case as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 88f785b9e6ec..e0f79773be70 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -417,19 +417,14 @@ static int spi_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (is_of_node(fwnode)) {
+	if (is_of_node(fwnode))
 		spi->irq = of_irq_get(dev->of_node, 0);
-		if (spi->irq == -EPROBE_DEFER)
-			return dev_err_probe(dev, -EPROBE_DEFER, "Failed to get irq\n");
-		if (spi->irq < 0)
-			spi->irq = 0;
-	} else if (is_acpi_device_node(fwnode) && spi->irq < 0) {
+	else if (is_acpi_device_node(fwnode) && spi->irq < 0)
 		spi->irq = acpi_dev_gpio_irq_get(to_acpi_device_node(fwnode), 0);
-		if (spi->irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		if (spi->irq < 0)
-			spi->irq = 0;
-	}
+	if (spi->irq == -EPROBE_DEFER)
+		return dev_err_probe(dev, spi->irq, "Failed to get irq\n");
+	if (spi->irq < 0)
+		spi->irq = 0;
 
 	ret = dev_pm_domain_attach(dev, true);
 	if (ret)
-- 
2.43.0.rc1.1336.g36b5255a03ac


