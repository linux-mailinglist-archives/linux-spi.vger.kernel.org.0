Return-Path: <linux-spi+bounces-4044-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EBE93F03B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 10:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409681F22D6D
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 08:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B032139D12;
	Mon, 29 Jul 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbo7QejM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087213D297
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243128; cv=none; b=OII7BHGmgPWurPZBGhwQSZVaarLTOlfNyy94jw9V/Cyvnn3juRmu/nO+C9aYmaK7RFRBuN0m5k2XVPmmRDPC68zP77FhzeROb0PjRqMujvF8G1BzKu14QOy1iybfj0BkM/P4MnRLvoMr+fKw5fuUWYKp1QyiZT1PZTQx8BK6BCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243128; c=relaxed/simple;
	bh=t8/zR6wZpeIic8DqQVjxZX/IQw1gAwaQkNY4aBe1tn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ic/c9wzu2J+xa2yhmJ5+oS7W5GKOJTCuh/oeVWhb1bt4WnNOJxx0nbLcEJd9rbhTIRNxSw3Y5W4msnf7o6fOxk5ORke79KEnj+akJop7FtA3eBhCMkbZhPI1dfbVscT/Fu6UYNizDis13dKd8f2RrDnhnXVWks/hF6TMclmVk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbo7QejM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722243126; x=1753779126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8/zR6wZpeIic8DqQVjxZX/IQw1gAwaQkNY4aBe1tn4=;
  b=bbo7QejML77Pnsvxc1kUmOdyxW8VSK8ag7zK6VV10023igjz9vBleMe7
   RghEgPZCLhlSzOW7+9ueN+ovjhtEajd0DCSxEvTHAZbxVZqvjlo4OeiHx
   1yiZMYNLxRyQHLCf7hAwMczrTxvfRQzENnN3tXQmaYkk1QjVMtyO9cWNK
   Gk1U1lVNW1TbwlzSM/epNtU+MfE1KFIKsnoWAPonZR8hJ+ig5qlc0PZa2
   GhvyQe+Irm3oywo3pfRqKLRA0Zwb2xgkxGNUPZKxsTops24VKa5EHtRBC
   yT42ytltAC1ZUHF9MtHtmMuvzqJW8FOVTQGcVyQks/weGlwAFQ81J7iUa
   A==;
X-CSE-ConnectionGUID: kM3igUnDTlOiT5QKyeppIg==
X-CSE-MsgGUID: sOJsFbvbT3WqtAQzv74TJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="42508989"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="42508989"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:06 -0700
X-CSE-ConnectionGUID: r6eoKBGORt+5JnOfHC4SBQ==
X-CSE-MsgGUID: NOl+xQtSRnK2CYNzGjXX3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="54708364"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:01 -0700
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
Subject: [PATCH v5 03/12] spi: intel-dg: implement spi access functions
Date: Mon, 29 Jul 2024 11:43:17 +0300
Message-Id: <20240729084326.2278014-4-alexander.usyskin@intel.com>
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


