Return-Path: <linux-spi+bounces-4826-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C397A3A5
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 16:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F3D28BDC5
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C1157E78;
	Mon, 16 Sep 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZyT15nW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF615852B
	for <linux-spi@vger.kernel.org>; Mon, 16 Sep 2024 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495069; cv=none; b=Nroa6+AfTlW3xQHJo7uq0xilsENl++3SpPFOd6VT2EEjorPq0rUg5BhknUkPclWSHY26oCmmMvuz9cAqMQcO+QD/YbusNie9UF3qcC7xwaM1tQhB9br320tbd8C5h89tg1JQ/koxQc5JHllKIvl+t78PLGKZeNZSPyonVHY93FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495069; c=relaxed/simple;
	bh=gN5slz9StV0ARNaF+GeyJLWw/kU6KYETQewkwfxR/tM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myjB93KdxH+F55iwRSv/yRIeNNYl914XSnqLkm4WskUCcW5q+Afx7R7o9rx+GOndp9rcZvZ/nYYfpMtKpjEDwK5UirIHOSzHhjX/WoKPgJHBGwow1nD2G/yLsr+P/HwS9Wb4bAmHiYYE21gdxuj0DGbUG1dbfYhr6sJsrRBM2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZyT15nW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726495067; x=1758031067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gN5slz9StV0ARNaF+GeyJLWw/kU6KYETQewkwfxR/tM=;
  b=VZyT15nW67znVU1+q32abemomo2cC/KyKV3x4kdlcxTyGGQ+cdIhyL19
   Vlr15QgnWRB1Yzqor7TbHD360CgdwVbNzm5lek2eDQYKL2MLJVj1Zln/P
   sxUr/B59/b0MFhv9sv2SS92mlG6W4rG3B/ufVJi00dhj2Yf37ZH04B56a
   kM6jf4mwNB6DnmhXRfkSQae6rYwsyiMHtpHEWmtOSZD6o2vLlJOSoOlJo
   2/gU50U3AS6lIrep7V8fiI5wH7fiWuZjfh4ib3/jbXz7OB3kb97qgvbTc
   /VPp0xvIj4ra1/YaY2/Lx5+CY8W2SXVgh2IPBjD2tX2Ls7CQc9GIgcHCy
   A==;
X-CSE-ConnectionGUID: +I9nCJpBRY+pBQtNhgvllg==
X-CSE-MsgGUID: JHNfuBQcSpOvKakw+gaqsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="36666821"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="36666821"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 06:57:47 -0700
X-CSE-ConnectionGUID: gu3OBeuxRm6ntaTMvi4ukQ==
X-CSE-MsgGUID: +cqocSQHTk2s8wHBIA7x5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68837342"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 06:57:42 -0700
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
Subject: [PATCH v6 04/12] spi: intel-dg: spi register with mtd
Date: Mon, 16 Sep 2024 16:49:20 +0300
Message-Id: <20240916134928.3654054-5-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916134928.3654054-1-alexander.usyskin@intel.com>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomas Winkler <tomas.winkler@intel.com>

Register the on-die spi device with the mtd subsystem.
Refcount spi object on _get and _put mtd callbacks.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/spi/spi-intel-dg.c | 111 +++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/spi/spi-intel-dg.c b/drivers/spi/spi-intel-dg.c
index 863898c8739c..a936014f1a76 100644
--- a/drivers/spi/spi-intel-dg.c
+++ b/drivers/spi/spi-intel-dg.c
@@ -10,6 +10,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
@@ -17,6 +19,8 @@
 
 struct intel_dg_spi {
 	struct kref refcnt;
+	struct mtd_info mtd;
+	struct mutex lock; /* region access lock */
 	void __iomem *base;
 	size_t size;
 	unsigned int nregions;
@@ -407,6 +411,23 @@ static int intel_dg_spi_init(struct intel_dg_spi *spi, struct device *device)
 	return n;
 }
 
+static int intel_dg_spi_erase(struct mtd_info *mtd, struct erase_info *info)
+{
+	return 0;
+}
+
+static int intel_dg_spi_read(struct mtd_info *mtd, loff_t from, size_t len,
+			     size_t *retlen, u_char *buf)
+{
+	return 0;
+}
+
+static int intel_dg_spi_write(struct mtd_info *mtd, loff_t to, size_t len,
+			      size_t *retlen, const u_char *buf)
+{
+	return 0;
+}
+
 static void intel_dg_spi_release(struct kref *kref)
 {
 	struct intel_dg_spi *spi = container_of(kref, struct intel_dg_spi, refcnt);
@@ -415,9 +436,90 @@ static void intel_dg_spi_release(struct kref *kref)
 	pr_debug("freeing spi memory\n");
 	for (i = 0; i < spi->nregions; i++)
 		kfree(spi->regions[i].name);
+	mutex_destroy(&spi->lock);
 	kfree(spi);
 }
 
+static int intel_dg_spi_get_device(struct mtd_info *mtd)
+{
+	struct mtd_info *master;
+	struct intel_dg_spi *spi;
+
+	if (!mtd)
+		return -ENODEV;
+
+	master = mtd_get_master(mtd);
+	spi = master->priv;
+	if (WARN_ON(!spi))
+		return -EINVAL;
+	pr_debug("get spi %s %d\n", mtd->name, kref_read(&spi->refcnt));
+	kref_get(&spi->refcnt);
+
+	return 0;
+}
+
+static void intel_dg_spi_put_device(struct mtd_info *mtd)
+{
+	struct mtd_info *master;
+	struct intel_dg_spi *spi;
+
+	if (!mtd)
+		return;
+
+	master = mtd_get_master(mtd);
+	spi = master->priv;
+	if (WARN_ON(!spi))
+		return;
+	pr_debug("put spi %s %d\n", mtd->name, kref_read(&spi->refcnt));
+	kref_put(&spi->refcnt, intel_dg_spi_release);
+}
+
+static int intel_dg_spi_init_mtd(struct intel_dg_spi *spi, struct device *device,
+				 unsigned int nparts, bool writeable_override)
+{
+	unsigned int i;
+	unsigned int n;
+	struct mtd_partition *parts = NULL;
+	int ret;
+
+	dev_dbg(device, "registering with mtd\n");
+
+	spi->mtd.owner = THIS_MODULE;
+	spi->mtd.dev.parent = device;
+	spi->mtd.flags = MTD_CAP_NORFLASH | MTD_WRITEABLE;
+	spi->mtd.type = MTD_DATAFLASH;
+	spi->mtd.priv = spi;
+	spi->mtd._write = intel_dg_spi_write;
+	spi->mtd._read = intel_dg_spi_read;
+	spi->mtd._erase = intel_dg_spi_erase;
+	spi->mtd._get_device = intel_dg_spi_get_device;
+	spi->mtd._put_device = intel_dg_spi_put_device;
+	spi->mtd.writesize = SZ_1; /* 1 byte granularity */
+	spi->mtd.erasesize = SZ_4K; /* 4K bytes granularity */
+	spi->mtd.size = spi->size;
+
+	parts = kcalloc(spi->nregions, sizeof(*parts), GFP_KERNEL);
+	if (!parts)
+		return -ENOMEM;
+
+	for (i = 0, n = 0; i < spi->nregions && n < nparts; i++) {
+		if (!spi->regions[i].is_readable)
+			continue;
+		parts[n].name = spi->regions[i].name;
+		parts[n].offset  = spi->regions[i].offset;
+		parts[n].size = spi->regions[i].size;
+		if (!spi->regions[i].is_writable && !writeable_override)
+			parts[n].mask_flags = MTD_WRITEABLE;
+		n++;
+	}
+
+	ret = mtd_device_register(&spi->mtd, parts, n);
+
+	kfree(parts);
+
+	return ret;
+}
+
 static int intel_dg_spi_probe(struct auxiliary_device *aux_dev,
 			      const struct auxiliary_device_id *aux_dev_id)
 {
@@ -449,6 +551,7 @@ static int intel_dg_spi_probe(struct auxiliary_device *aux_dev,
 	if (!spi)
 		return -ENOMEM;
 
+	mutex_init(&spi->lock);
 	kref_init(&spi->refcnt);
 
 	spi->nregions = nregions;
@@ -481,6 +584,12 @@ static int intel_dg_spi_probe(struct auxiliary_device *aux_dev,
 		goto err;
 	}
 
+	ret = intel_dg_spi_init_mtd(spi, device, ret, ispi->writeable_override);
+	if (ret) {
+		dev_err(device, "failed init mtd %d\n", ret);
+		goto err;
+	}
+
 	dev_set_drvdata(&aux_dev->dev, spi);
 
 	return 0;
@@ -497,6 +606,8 @@ static void intel_dg_spi_remove(struct auxiliary_device *aux_dev)
 	if (!spi)
 		return;
 
+	mtd_device_unregister(&spi->mtd);
+
 	dev_set_drvdata(&aux_dev->dev, NULL);
 
 	kref_put(&spi->refcnt, intel_dg_spi_release);
-- 
2.34.1


