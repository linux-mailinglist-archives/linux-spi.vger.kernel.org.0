Return-Path: <linux-spi+bounces-3969-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F893B251
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 16:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882531C21271
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC11EEAB;
	Wed, 24 Jul 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llD5OgWy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E6DDC5
	for <linux-spi@vger.kernel.org>; Wed, 24 Jul 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830151; cv=none; b=g/ktChE16y6ZFpvJLSeYi62RzLJN8roHAiFvj2/RRYz5q5TdjDZXREr3aN7cT19DEFcPdVtJvV6c5uDQwRahP58qX/YhzK9AUtbbyLCWFB6q/JdL63/UWZhCkm9rEX8VpCb0krxd2snP2n6MY4LkS7ylZjfMIEhCTC9PfD0E+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830151; c=relaxed/simple;
	bh=czB05BS6HT4dbgmuzTPUCyCXBiBfJbeYHzptJ2vMm3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsPtxyG+HbgyIpfqNkSSg+j+IfJfI+qbm/HLFv3bL2jYKFBwhSUNiM2Sso0bI4BdTlnDr5NR0O1Bm/IIN1pvoQQYAaUjwyQAxX/GoQ2kzSNiTDnWdOdDxbCCH45D/Dxj4nnwzdHLiInyH3KoCIWShkXRawwSfyPsKrcc8ZdoWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llD5OgWy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721830149; x=1753366149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=czB05BS6HT4dbgmuzTPUCyCXBiBfJbeYHzptJ2vMm3M=;
  b=llD5OgWyio0HVLStyMukoVmHgkuL6B54/hATp13UCYskgLyZ0PelsEa7
   caczowM+zIs68fkV+2Bmb1kpbC69BHT9pVJC+X/ALnBkfMdpQmO5c2yZn
   4Tcit5ShRuUVG3UMYauOeQBsMd3fIiYrdqT2jK5X+j5/Mke8Fhn/AShye
   G/UTcAl4lGJUQK+cJeX42G44QoX4XavvwrLpsVTV77Svme64bolkTQw26
   2Bo/uwPwBgE8Jp+k527c1AkH0sTqb5HkyLLPoYUO8WX4APl+YHQWPzPbZ
   4/5ONoYbHbn1boYcj+RQ8SiGSMMvss6Clku423uq9NHC8vEX9oL52pc8q
   A==;
X-CSE-ConnectionGUID: 4dsNdMM6RTCfbAfBb1coFg==
X-CSE-MsgGUID: oRZya3SAT/SBhsdyOLQ7cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30173748"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30173748"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:09:09 -0700
X-CSE-ConnectionGUID: RMp7dZquTCCq0ro+Sq+SvQ==
X-CSE-MsgGUID: reoZ/hvvQAiE1I727tD2aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="83211453"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:09:04 -0700
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
Subject: [PATCH v2 05/12] spi: intel-dg: implement mtd access handlers
Date: Wed, 24 Jul 2024 17:00:07 +0300
Message-Id: <20240724140014.428991-6-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724140014.428991-1-alexander.usyskin@intel.com>
References: <20240724140014.428991-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomas Winkler <tomas.winkler@intel.com>

Implement mtd read, erase, and write handlers.
For erase operation address and size should be 4K aligned.
For write operation address and size has to be 4bytes aligned.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/spi/spi-intel-dg.c | 152 +++++++++++++++++++++++++++++++++++--
 1 file changed, 147 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-intel-dg.c b/drivers/spi/spi-intel-dg.c
index 2ffc2d61fdc8..dc4d6c573522 100644
--- a/drivers/spi/spi-intel-dg.c
+++ b/drivers/spi/spi-intel-dg.c
@@ -174,7 +174,6 @@ static int intel_dg_spi_is_valid(struct intel_dg_spi *spi)
 	return 0;
 }
 
-__maybe_unused
 static unsigned int spi_get_region(const struct intel_dg_spi *spi, loff_t from)
 {
 	unsigned int i;
@@ -206,7 +205,6 @@ static ssize_t spi_rewrite_partial(struct intel_dg_spi *spi, loff_t to,
 	return len;
 }
 
-__maybe_unused
 static ssize_t spi_write(struct intel_dg_spi *spi, u8 region,
 			 loff_t to, size_t len, const unsigned char *buf)
 {
@@ -265,7 +263,6 @@ static ssize_t spi_write(struct intel_dg_spi *spi, u8 region,
 	return len;
 }
 
-__maybe_unused
 static ssize_t spi_read(struct intel_dg_spi *spi, u8 region,
 			loff_t from, size_t len, unsigned char *buf)
 {
@@ -324,7 +321,6 @@ static ssize_t spi_read(struct intel_dg_spi *spi, u8 region,
 	return len;
 }
 
-__maybe_unused
 static ssize_t
 spi_erase(struct intel_dg_spi *spi, u8 region, loff_t from, u64 len, u64 *fail_addr)
 {
@@ -413,18 +409,164 @@ static int intel_dg_spi_init(struct intel_dg_spi *spi, struct device *device)
 
 static int intel_dg_spi_erase(struct mtd_info *mtd, struct erase_info *info)
 {
-	return 0;
+	struct intel_dg_spi *spi;
+	unsigned int idx;
+	u8 region;
+	u64 addr;
+	ssize_t bytes;
+	loff_t from;
+	size_t len;
+	size_t total_len;
+	int ret = 0;
+
+	if (!mtd || !info)
+		return -EINVAL;
+
+	spi = mtd->priv;
+	if (WARN_ON(!spi))
+		return -EINVAL;
+
+	if (!IS_ALIGNED(info->addr, SZ_4K) || !IS_ALIGNED(info->len, SZ_4K)) {
+		dev_err(&mtd->dev, "unaligned erase %llx %llx\n",
+			info->addr, info->len);
+		info->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
+		return -EINVAL;
+	}
+
+	total_len = info->len;
+	addr = info->addr;
+
+	mutex_lock(&spi->lock);
+
+	while (total_len > 0) {
+		if (!IS_ALIGNED(addr, SZ_4K) || !IS_ALIGNED(total_len, SZ_4K)) {
+			dev_err(&mtd->dev, "unaligned erase %llx %zx\n", addr, total_len);
+			info->fail_addr = addr;
+			ret = -ERANGE;
+			goto out;
+		}
+
+		idx = spi_get_region(spi, addr);
+		if (idx >= spi->nregions) {
+			dev_err(&mtd->dev, "out of range");
+			info->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
+			ret = -ERANGE;
+			goto out;
+		}
+
+		from = addr - spi->regions[idx].offset;
+		region = spi->regions[idx].id;
+		len = total_len;
+		if (len > spi->regions[idx].size - from)
+			len = spi->regions[idx].size - from;
+
+		dev_dbg(&mtd->dev, "erasing region[%d] %s from %llx len %zx\n",
+			region, spi->regions[idx].name, from, len);
+
+		bytes = spi_erase(spi, region, from, len, &info->fail_addr);
+		if (bytes < 0) {
+			dev_dbg(&mtd->dev, "erase failed with %zd\n", bytes);
+			info->fail_addr += spi->regions[idx].offset;
+			ret = bytes;
+			goto out;
+		}
+
+		addr += len;
+		total_len -= len;
+	}
+
+out:
+	mutex_unlock(&spi->lock);
+	return ret;
 }
 
 static int intel_dg_spi_read(struct mtd_info *mtd, loff_t from, size_t len,
 			     size_t *retlen, u_char *buf)
 {
+	struct intel_dg_spi *spi;
+	ssize_t ret;
+	unsigned int idx;
+	u8 region;
+
+	if (!mtd)
+		return -EINVAL;
+
+	spi = mtd->priv;
+	if (WARN_ON(!spi))
+		return -EINVAL;
+
+	idx = spi_get_region(spi, from);
+
+	dev_dbg(&mtd->dev, "reading region[%d] %s from %lld len %zd\n",
+		spi->regions[idx].id, spi->regions[idx].name, from, len);
+
+	if (idx >= spi->nregions) {
+		dev_err(&mtd->dev, "out of ragnge");
+		return -ERANGE;
+	}
+
+	from -= spi->regions[idx].offset;
+	region = spi->regions[idx].id;
+	if (len > spi->regions[idx].size - from)
+		len = spi->regions[idx].size - from;
+
+	mutex_lock(&spi->lock);
+
+	ret = spi_read(spi, region, from, len, buf);
+	if (ret < 0) {
+		dev_dbg(&mtd->dev, "read failed with %zd\n", ret);
+		mutex_unlock(&spi->lock);
+		return ret;
+	}
+
+	*retlen = ret;
+
+	mutex_unlock(&spi->lock);
 	return 0;
 }
 
 static int intel_dg_spi_write(struct mtd_info *mtd, loff_t to, size_t len,
 			      size_t *retlen, const u_char *buf)
 {
+	struct intel_dg_spi *spi;
+	ssize_t ret;
+	unsigned int idx;
+	u8 region;
+
+	if (!mtd)
+		return -EINVAL;
+
+	spi = mtd->priv;
+	if (WARN_ON(!spi))
+		return -EINVAL;
+
+	idx = spi_get_region(spi, to);
+
+	dev_dbg(&mtd->dev, "writing region[%d] %s to %lld len %zd\n",
+		spi->regions[idx].id, spi->regions[idx].name, to, len);
+
+	if (idx >= spi->nregions) {
+		dev_err(&mtd->dev, "out of range");
+		return -ERANGE;
+	}
+
+	to -= spi->regions[idx].offset;
+	region = spi->regions[idx].id;
+	if (len > spi->regions[idx].size - to)
+		len = spi->regions[idx].size - to;
+
+	mutex_lock(&spi->lock);
+
+	ret = spi_write(spi, region, to, len, buf);
+	if (ret < 0) {
+		dev_dbg(&mtd->dev, "write failed with %zd\n", ret);
+		mutex_unlock(&spi->lock);
+		return ret;
+	}
+
+	*retlen = ret;
+
+	mutex_unlock(&spi->lock);
 	return 0;
 }
 
-- 
2.34.1


