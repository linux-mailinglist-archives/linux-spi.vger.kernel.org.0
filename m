Return-Path: <linux-spi+bounces-4048-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA25393F04A
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 10:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457FB282CC6
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283EF139D12;
	Mon, 29 Jul 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwKat6O4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7913D63B
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243148; cv=none; b=kLuEspkgMkgz1qQWxd6JNzMcBPhThTlUampO1aSygz7wxIQAo8uMCvloLl9et/ITTtweGdjleppcLXqesgh5J4BvjMTTRbeIYtFjoBrdIo6UPGcgBD5M7YIWzqYKugWnUDvgEki1m50wNn4sfGkPY9qmFKZ+TOv6hkKpeE4WBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243148; c=relaxed/simple;
	bh=eUyFHGpLnm0GiFr6R45QRYKMqFyqBiOPWuSQdcI130g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VwM2M0V7Nl0vol3JKiRbKQapAqfwMk81ADUEAzQGX3x4hi5SPhiRudZVHOYgahu94U7OE/WWo6pPatKa/h2/+EBN0XW3Z5fDZi2iZcgHk0D0XNHVlZl9nKkW2kwsSXdRq5epydgUpDs4z0WM9FLQvM+NtTBw5TsWb2iLeKqdxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwKat6O4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722243146; x=1753779146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eUyFHGpLnm0GiFr6R45QRYKMqFyqBiOPWuSQdcI130g=;
  b=GwKat6O48Mjb0AZB5w5khykvnRjTqm7ddCnHFatzWTJf9TqRZInRAscG
   aHAEBiCx1dOdd+vafb3retbpi2IMfAw7KpgVhvOrEfPm4ATNf3tVjtagH
   9ubidkl6vbXdPLvA6BH4NPq9rogtdOabtDtcaGxxyZ6+LE2BW+SPQRAbK
   wUBpmoMO9f7VVnqJ0Xi26TiPi/Uxuy0opwRgxcCDJbHUNsr1pWNvAD/GR
   F2cmGs1GVeOV85e13+YKJmC/Afq4LVGx0jltdFG9Ijv/JmmecIceW0LAw
   xcE9Bc7RiENrxvLs62foJNYwXC4pCOaa7+iCyhDCXF0ehD0+eXPT47XVw
   Q==;
X-CSE-ConnectionGUID: rtmwsBEYTUyF5132hrGJyQ==
X-CSE-MsgGUID: Dws/QwB7QW2uPGJmHNeG6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="42509065"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="42509065"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:26 -0700
X-CSE-ConnectionGUID: lmxSimx4Tg+OFMM5nGJbMQ==
X-CSE-MsgGUID: pBcDycI5SmCl4XgtgLwGdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="54708510"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:22 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Mark Brown <broonie@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-spi@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH v5 07/12] spi: intel-dg: wake card on operations
Date: Mon, 29 Jul 2024 11:43:21 +0300
Message-Id: <20240729084326.2278014-8-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729084326.2278014-1-alexander.usyskin@intel.com>
References: <20240729084326.2278014-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable runtime PM in spi driver to notify graphics driver that
whole card should be kept awake while spi operations are
performed through this driver.

CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/spi/spi-intel-dg.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/spi/spi-intel-dg.c b/drivers/spi/spi-intel-dg.c
index c76b0a70f8d8..a14fc3190520 100644
--- a/drivers/spi/spi-intel-dg.c
+++ b/drivers/spi/spi-intel-dg.c
@@ -12,11 +12,14 @@
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/pm_runtime.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 
+#define INTEL_DG_SPI_RPM_TIMEOUT 500
+
 struct intel_dg_spi {
 	struct kref refcnt;
 	struct mtd_info mtd;
@@ -471,6 +474,12 @@ static int intel_dg_spi_erase(struct mtd_info *mtd, struct erase_info *info)
 	total_len = info->len;
 	addr = info->addr;
 
+	ret = pm_runtime_resume_and_get(mtd->dev.parent);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %d\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&spi->lock);
 
 	while (total_len > 0) {
@@ -512,6 +521,8 @@ static int intel_dg_spi_erase(struct mtd_info *mtd, struct erase_info *info)
 
 out:
 	mutex_unlock(&spi->lock);
+	pm_runtime_mark_last_busy(mtd->dev.parent);
+	pm_runtime_put_autosuspend(mtd->dev.parent);
 	return ret;
 }
 
@@ -545,6 +556,12 @@ static int intel_dg_spi_read(struct mtd_info *mtd, loff_t from, size_t len,
 	if (len > spi->regions[idx].size - from)
 		len = spi->regions[idx].size - from;
 
+	ret = pm_runtime_resume_and_get(mtd->dev.parent);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %zd\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&spi->lock);
 
 	ret = spi_read(spi, region, from, len, buf);
@@ -557,6 +574,8 @@ static int intel_dg_spi_read(struct mtd_info *mtd, loff_t from, size_t len,
 	*retlen = ret;
 
 	mutex_unlock(&spi->lock);
+	pm_runtime_mark_last_busy(mtd->dev.parent);
+	pm_runtime_put_autosuspend(mtd->dev.parent);
 	return 0;
 }
 
@@ -590,6 +609,12 @@ static int intel_dg_spi_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (len > spi->regions[idx].size - to)
 		len = spi->regions[idx].size - to;
 
+	ret = pm_runtime_resume_and_get(mtd->dev.parent);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %zd\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&spi->lock);
 
 	ret = spi_write(spi, region, to, len, buf);
@@ -602,6 +627,8 @@ static int intel_dg_spi_write(struct mtd_info *mtd, loff_t to, size_t len,
 	*retlen = ret;
 
 	mutex_unlock(&spi->lock);
+	pm_runtime_mark_last_busy(mtd->dev.parent);
+	pm_runtime_put_autosuspend(mtd->dev.parent);
 	return 0;
 }
 
@@ -747,6 +774,17 @@ static int intel_dg_spi_probe(struct auxiliary_device *aux_dev,
 		}
 	}
 
+	pm_runtime_enable(device);
+
+	pm_runtime_set_autosuspend_delay(device, INTEL_DG_SPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(device);
+
+	ret = pm_runtime_resume_and_get(device);
+	if (ret < 0) {
+		dev_err(device, "rpm: get failed %d\n", ret);
+		goto err_norpm;
+	}
+
 	spi->base = devm_ioremap_resource(device, &ispi->bar);
 	if (IS_ERR(spi->base)) {
 		dev_err(device, "mmio not mapped\n");
@@ -769,9 +807,13 @@ static int intel_dg_spi_probe(struct auxiliary_device *aux_dev,
 
 	dev_set_drvdata(&aux_dev->dev, spi);
 
+	pm_runtime_put(device);
 	return 0;
 
 err:
+	pm_runtime_put(device);
+err_norpm:
+	pm_runtime_disable(device);
 	kref_put(&spi->refcnt, intel_dg_spi_release);
 	return ret;
 }
@@ -783,6 +825,8 @@ static void intel_dg_spi_remove(struct auxiliary_device *aux_dev)
 	if (!spi)
 		return;
 
+	pm_runtime_disable(&aux_dev->dev);
+
 	mtd_device_unregister(&spi->mtd);
 
 	dev_set_drvdata(&aux_dev->dev, NULL);
-- 
2.34.1


