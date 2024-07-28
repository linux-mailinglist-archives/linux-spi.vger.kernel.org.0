Return-Path: <linux-spi+bounces-4027-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CD793E566
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5677B210A5
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213A82F30;
	Sun, 28 Jul 2024 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrdF/hi3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F608EAD0
	for <linux-spi@vger.kernel.org>; Sun, 28 Jul 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172523; cv=none; b=PEnTNzJ1nknbUa27mbsIQ8j3U0mquQc62Qfgqo1wvDMKsQkzj7B6ec9h76cw4twm4Oc/jjzq9dD5pbbkv/cMWpXlxJpK7rNuN4rbqt0DsHWSCHlj6YGVmnOon9Exog5Qfb/9dsqikiH/WGM8oN5F3UYLMgbES7ql8LLOazDN700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172523; c=relaxed/simple;
	bh=t8/zR6wZpeIic8DqQVjxZX/IQw1gAwaQkNY4aBe1tn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEV0h2I/w12i9KDNx0TxRbZGumWEcwupOnz6hTwIIlWbi4rK6xPFwocHuEh0syBzVB4wdVvjW1w3oZF3Qz6OWdMj8nWr+637/cyN9OFfsvkShNdzuHQNoa9/MJF8LNPtp3jS4X6cBrBZ8SR9Q0Ib3ww8FxptSYUCAnhZfpB2LeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrdF/hi3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722172521; x=1753708521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8/zR6wZpeIic8DqQVjxZX/IQw1gAwaQkNY4aBe1tn4=;
  b=BrdF/hi3AKakKa80xVwBa9QItYcWpsQ8Mdi/tfi9eZ2nXzViRo1vnCH3
   AdOKHeFpqK5RtRthxvNXUdpNW/E7k3qrOV0fLzGHRMJ/QKcUcv9Ke8WZD
   cxxIDFRmQgkjHNfjV+3zkfqXudNbp2KMpeCN3D4pWe175K/yhkCaU1XAU
   kc4kPP2HC7VkgZXr+9liv1BbS8H9z3i1DKzwoDG3oteUb6XSuY9yw9KUb
   2ppm3FbQs/DryQyvQxVo0tHdyHNEFPNOXLDNRCSWB3bQ4Fhz1s3BkIY7C
   PK1cKhM4Yqvjf81LAx5uyqY2ESJV5iKX+I5cbCMFVx47uPuPb1K9E1285
   Q==;
X-CSE-ConnectionGUID: Gwxxo9JjSoC2FVgU1vwn7Q==
X-CSE-MsgGUID: i5zOOghhT3OdTkR7OOTd/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="23713413"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="23713413"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:21 -0700
X-CSE-ConnectionGUID: L4ECNgH+TZSY7PznDVzvMA==
X-CSE-MsgGUID: +yMq9DfWTZ+JN5HAQioEtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="53389175"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:15 -0700
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
Subject: [PATCH v4 03/12] spi: intel-dg: implement spi access functions
Date: Sun, 28 Jul 2024 16:06:29 +0300
Message-Id: <20240728130638.1930463-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240728130638.1930463-1-alexander.usyskin@intel.com>
References: <20240728130638.1930463-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomas Winkler <tomas.winkler@intel.com>

Implement spi_read(), spi_erase() and spi_write() functions.

CC: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/spi/spi-intel-dg.c | 199 +++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/drivers/spi/spi-intel-dg.c b/drivers/spi/spi-intel-dg.c
index 661e5189fa58..863898c8739c 100644
--- a/drivers/spi/spi-intel-dg.c
+++ b/drivers/spi/spi-intel-dg.c
@@ -3,13 +3,16 @@
  * Copyright(c) 2019-2024, Intel Corporation. All rights reserved.
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/intel_dg_spi_aux.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 
 struct intel_dg_spi {
@@ -84,6 +87,33 @@ static inline u32 spi_read32(struct intel_dg_spi *spi, u32 address)
 	return ioread32(base + SPI_TRIGGER_REG);
 }
 
+static inline u64 spi_read64(struct intel_dg_spi *spi, u32 address)
+{
+	void __iomem *base = spi->base;
+
+	iowrite32(address, base + SPI_ADDRESS_REG);
+
+	return readq(base + SPI_TRIGGER_REG);
+}
+
+static void spi_write32(struct intel_dg_spi *spi, u32 address, u32 data)
+{
+	void __iomem *base = spi->base;
+
+	iowrite32(address, base + SPI_ADDRESS_REG);
+
+	iowrite32(data, base + SPI_TRIGGER_REG);
+}
+
+static void spi_write64(struct intel_dg_spi *spi, u32 address, u64 data)
+{
+	void __iomem *base = spi->base;
+
+	iowrite32(address, base + SPI_ADDRESS_REG);
+
+	writeq(data, base + SPI_TRIGGER_REG);
+}
+
 static int spi_get_access_map(struct intel_dg_spi *spi)
 {
 	u32 flmap1;
@@ -140,6 +170,175 @@ static int intel_dg_spi_is_valid(struct intel_dg_spi *spi)
 	return 0;
 }
 
+__maybe_unused
+static unsigned int spi_get_region(const struct intel_dg_spi *spi, loff_t from)
+{
+	unsigned int i;
+
+	for (i = 0; i < spi->nregions; i++) {
+		if ((spi->regions[i].offset + spi->regions[i].size - 1) > from &&
+		    spi->regions[i].offset <= from &&
+		    spi->regions[i].size != 0)
+			break;
+	}
+
+	return i;
+}
+
+static ssize_t spi_rewrite_partial(struct intel_dg_spi *spi, loff_t to,
+				   loff_t offset, size_t len, const u32 *newdata)
+{
+	u32 data = spi_read32(spi, to);
+
+	if (spi_error(spi))
+		return -EIO;
+
+	memcpy((u8 *)&data + offset, newdata, len);
+
+	spi_write32(spi, to, data);
+	if (spi_error(spi))
+		return -EIO;
+
+	return len;
+}
+
+__maybe_unused
+static ssize_t spi_write(struct intel_dg_spi *spi, u8 region,
+			 loff_t to, size_t len, const unsigned char *buf)
+{
+	size_t i;
+	size_t len8;
+	size_t len4;
+	size_t to4;
+	size_t to_shift;
+	size_t len_s = len;
+	ssize_t ret;
+
+	spi_set_region_id(spi, region);
+
+	to4 = ALIGN_DOWN(to, sizeof(u32));
+	to_shift = min(sizeof(u32) - ((size_t)to - to4), len);
+	if (to - to4) {
+		ret = spi_rewrite_partial(spi, to4, to - to4, to_shift,
+					  (uint32_t *)&buf[0]);
+		if (ret < 0)
+			return ret;
+
+		buf += to_shift;
+		to += to_shift;
+		len_s -= to_shift;
+	}
+
+	len8 = ALIGN_DOWN(len_s, sizeof(u64));
+	for (i = 0; i < len8; i += sizeof(u64)) {
+		u64 data;
+
+		memcpy(&data, &buf[i], sizeof(u64));
+		spi_write64(spi, to + i, data);
+		if (spi_error(spi))
+			return -EIO;
+	}
+
+	len4 = len_s - len8;
+	if (len4 >= sizeof(u32)) {
+		u32 data;
+
+		memcpy(&data, &buf[i], sizeof(u32));
+		spi_write32(spi, to + i, data);
+		if (spi_error(spi))
+			return -EIO;
+		i += sizeof(u32);
+		len4 -= sizeof(u32);
+	}
+
+	if (len4 > 0) {
+		ret = spi_rewrite_partial(spi, to + i, 0, len4,
+					  (uint32_t *)&buf[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return len;
+}
+
+__maybe_unused
+static ssize_t spi_read(struct intel_dg_spi *spi, u8 region,
+			loff_t from, size_t len, unsigned char *buf)
+{
+	size_t i;
+	size_t len8;
+	size_t len4;
+	size_t from4;
+	size_t from_shift;
+	size_t len_s = len;
+
+	spi_set_region_id(spi, region);
+
+	from4 = ALIGN_DOWN(from, sizeof(u32));
+	from_shift = min(sizeof(u32) - ((size_t)from - from4), len);
+
+	if (from - from4) {
+		u32 data = spi_read32(spi, from4);
+
+		if (spi_error(spi))
+			return -EIO;
+		memcpy(&buf[0], (u8 *)&data + (from - from4), from_shift);
+		len_s -= from_shift;
+		buf += from_shift;
+		from += from_shift;
+	}
+
+	len8 = ALIGN_DOWN(len_s, sizeof(u64));
+	for (i = 0; i < len8; i += sizeof(u64)) {
+		u64 data = spi_read64(spi, from + i);
+
+		if (spi_error(spi))
+			return -EIO;
+
+		memcpy(&buf[i], &data, sizeof(data));
+	}
+
+	len4 = len_s - len8;
+	if (len4 >= sizeof(u32)) {
+		u32 data = spi_read32(spi, from + i);
+
+		if (spi_error(spi))
+			return -EIO;
+		memcpy(&buf[i], &data, sizeof(data));
+		i += sizeof(u32);
+		len4 -= sizeof(u32);
+	}
+
+	if (len4 > 0) {
+		u32 data = spi_read32(spi, from + i);
+
+		if (spi_error(spi))
+			return -EIO;
+		memcpy(&buf[i], &data, len4);
+	}
+
+	return len;
+}
+
+__maybe_unused
+static ssize_t
+spi_erase(struct intel_dg_spi *spi, u8 region, loff_t from, u64 len, u64 *fail_addr)
+{
+	u64 i;
+	const u32 block = 0x10;
+	void __iomem *base = spi->base;
+
+	for (i = 0; i < len; i += SZ_4K) {
+		iowrite32(from + i, base + SPI_ADDRESS_REG);
+		iowrite32(region << 24 | block, base + SPI_ERASE_REG);
+		/* Since the writes are via sguint
+		 * we cannot do back to back erases.
+		 */
+		msleep(50);
+	}
+	return len;
+}
+
 static int intel_dg_spi_init(struct intel_dg_spi *spi, struct device *device)
 {
 	int ret;
-- 
2.34.1


