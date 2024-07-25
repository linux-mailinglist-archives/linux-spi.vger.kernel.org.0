Return-Path: <linux-spi+bounces-3993-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832393C388
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 16:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72E01F22AC8
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838F199386;
	Thu, 25 Jul 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKUWv2Os"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9A1EB2F
	for <linux-spi@vger.kernel.org>; Thu, 25 Jul 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916333; cv=none; b=lPKK4NNLvvPsPEQkmojx8Re0AU4aYYEQTkkHwwIOlNQqKSb9lQoYte6SVmR6gcgi5OaH+fCdyJlf58qHBGH0gx56zKk/fVYwtiBOKHot0j7RkRP7Qypvo64c4gETfTYvUWB2zUat8WUXUXAz1JDTiTZ0vm+/kaRgyvK9Ay7xahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916333; c=relaxed/simple;
	bh=gA14zLLi9b8+u0fO0AwBvXMUmragaKJIlZtkidHrRdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acEADhpLJrwi87N1b6+ej/OeAoF5ll9566zWArkmlNiem9Vx2axg06aavoDladHAFp0ITiL6xrwJeArfLVZUhhtveUr+vclVNPNSioxTJNgda4/AYGBuh/4buKNb3DkBcRYyZS+xh+0hjkexZlhAfTrLbV/nsPl+61djPrHlnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKUWv2Os; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721916332; x=1753452332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gA14zLLi9b8+u0fO0AwBvXMUmragaKJIlZtkidHrRdU=;
  b=NKUWv2OsNUh3HKc5ugqjJzbf6+QmgJ4SHUo/7E2fPIL8UKJVKBd6+xT2
   Lt3TUTeNv6EeSYWP2yuaychRP/cSHsTBcal3P3X3vq6JWUGZVDpJ396c6
   6ZQvXV46+16YVF1h155NNQMMrBMcr7+b9jsLTQESwddC5g/L5/URnk6Xe
   lqbvtDHMTXCEZ3lbDsWQwMQ6DAOgSxDqMQoKlbfXl1K3AZ1wvYKgT0/NJ
   Z0UqeKOskiV2VSKQr0EOhsv9KcdAFbXLzQDP/4zxNUwThZ+gOAyCJfTXi
   XNYKug5m5rIq7hKH0TOkWP7iHEiumyEFIolZGYAWuKO5kj3+SlNPtVDsD
   w==;
X-CSE-ConnectionGUID: zguf5/XXSzyT9hTGZOpFZA==
X-CSE-MsgGUID: HsMyokcjSeqRrm15dsmoAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19504784"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19504784"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:05:31 -0700
X-CSE-ConnectionGUID: uTKo8zEGQp65h10xjq914Q==
X-CSE-MsgGUID: 9mxSGsYSS9KkeBokCXG5lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53007732"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:05:24 -0700
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
Subject: [PATCH v3 02/12] spi: intel-dg: implement region enumeration
Date: Thu, 25 Jul 2024 16:56:47 +0300
Message-Id: <20240725135657.1061836-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725135657.1061836-1-alexander.usyskin@intel.com>
References: <20240725135657.1061836-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomas Winkler <tomas.winkler@intel.com>

In intel-dg spi, there is no access to the spi controller,
the information is extracted from the descriptor region.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/spi/spi-intel-dg.c | 190 +++++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/drivers/spi/spi-intel-dg.c b/drivers/spi/spi-intel-dg.c
index 7a00d222bb72..1da8f527d47c 100644
--- a/drivers/spi/spi-intel-dg.c
+++ b/drivers/spi/spi-intel-dg.c
@@ -17,14 +17,197 @@ struct intel_dg_spi {
 	void __iomem *base;
 	size_t size;
 	unsigned int nregions;
+	u32 access_map;
 	struct {
 		const char *name;
 		u8 id;
 		u64 offset;
 		u64 size;
+		unsigned int is_readable:1;
+		unsigned int is_writable:1;
 	} regions[];
 };
 
+#define SPI_TRIGGER_REG       0x00000000
+#define SPI_VALSIG_REG        0x00000010
+#define SPI_ADDRESS_REG       0x00000040
+#define SPI_REGION_ID_REG     0x00000044
+/*
+ * [15:0]-Erase size = 0x0010 4K 0x0080 32K 0x0100 64K
+ * [23:16]-Reserved
+ * [31:24]-Erase SPI RegionID
+ */
+#define SPI_ERASE_REG         0x00000048
+#define SPI_ACCESS_ERROR_REG  0x00000070
+#define SPI_ADDRESS_ERROR_REG 0x00000074
+
+/* Flash Valid Signature */
+#define SPI_FLVALSIG          0x0FF0A55A
+
+#define SPI_MAP_ADDR_MASK     0x000000FF
+#define SPI_MAP_ADDR_SHIFT    0x00000004
+
+#define REGION_ID_DESCRIPTOR  0
+/* Flash Region Base Address */
+#define FRBA      0x40
+/* Flash Region __n - Flash Descriptor Record */
+#define FLREG(__n)  (FRBA + ((__n) * 4))
+/*  Flash Map 1 Register */
+#define FLMAP1_REG  0x18
+#define FLMSTR4_OFFSET 0x00C
+
+#define SPI_ACCESS_ERROR_PCIE_MASK 0x7
+
+static inline void spi_set_region_id(struct intel_dg_spi *spi, u8 region)
+{
+	iowrite32((u32)region, spi->base + SPI_REGION_ID_REG);
+}
+
+static inline u32 spi_error(struct intel_dg_spi *spi)
+{
+	u32 reg = ioread32(spi->base + SPI_ACCESS_ERROR_REG) &
+		  SPI_ACCESS_ERROR_PCIE_MASK;
+
+	/* reset error bits */
+	if (reg)
+		iowrite32(reg, spi->base + SPI_ACCESS_ERROR_REG);
+
+	return reg;
+}
+
+static inline u32 spi_read32(struct intel_dg_spi *spi, u32 address)
+{
+	void __iomem *base = spi->base;
+
+	iowrite32(address, base + SPI_ADDRESS_REG);
+
+	return ioread32(base + SPI_TRIGGER_REG);
+}
+
+static int spi_get_access_map(struct intel_dg_spi *spi)
+{
+	u32 flmap1;
+	u32 fmba;
+	u32 fmstr4;
+	u32 fmstr4_addr;
+
+	spi_set_region_id(spi, REGION_ID_DESCRIPTOR);
+
+	flmap1 = spi_read32(spi, FLMAP1_REG);
+	if (spi_error(spi))
+		return -EIO;
+	/* Get Flash Master Baser Address (FMBA) */
+	fmba = ((flmap1 & SPI_MAP_ADDR_MASK) << SPI_MAP_ADDR_SHIFT);
+	fmstr4_addr = fmba + FLMSTR4_OFFSET;
+
+	fmstr4 = spi_read32(spi, fmstr4_addr);
+	if (spi_error(spi))
+		return -EIO;
+
+	spi->access_map = fmstr4;
+	return 0;
+}
+
+static bool spi_region_readable(struct intel_dg_spi *spi, u8 region)
+{
+	if (region < 12)
+		return spi->access_map & (1 << (region + 8)); /* [19:8] */
+	else
+		return spi->access_map & (1 << (region - 12)); /* [3:0] */
+}
+
+static bool spi_region_writeable(struct intel_dg_spi *spi, u8 region)
+{
+	if (region < 12)
+		return spi->access_map & (1 << (region + 20)); /* [31:20] */
+	else
+		return spi->access_map & (1 << (region - 8)); /* [7:4] */
+}
+
+static int intel_dg_spi_is_valid(struct intel_dg_spi *spi)
+{
+	u32 is_valid;
+
+	spi_set_region_id(spi, REGION_ID_DESCRIPTOR);
+
+	is_valid = spi_read32(spi, SPI_VALSIG_REG);
+	if (spi_error(spi))
+		return -EIO;
+
+	if (is_valid != SPI_FLVALSIG)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int intel_dg_spi_init(struct intel_dg_spi *spi, struct device *device)
+{
+	int ret;
+	unsigned int i, n;
+
+	/* clean error register, previous errors are ignored */
+	spi_error(spi);
+
+	ret = intel_dg_spi_is_valid(spi);
+	if (ret) {
+		dev_err(device, "The SPI is not valid %d\n", ret);
+		return ret;
+	}
+
+	if (spi_get_access_map(spi))
+		return -EIO;
+
+	for (i = 0, n = 0; i < spi->nregions; i++) {
+		u32 address, base, limit, region;
+		u8 id = spi->regions[i].id;
+
+		address = FLREG(id);
+		region = spi_read32(spi, address);
+
+		base = (region & 0x0000FFFF) << 12;
+		limit = (((region & 0xFFFF0000) >> 16) << 12) | 0xFFF;
+
+		dev_dbg(device, "[%d] %s: region: 0x%08X base: 0x%08x limit: 0x%08x\n",
+			id, spi->regions[i].name, region, base, limit);
+
+		if (base >= limit || (i > 0 && limit == 0)) {
+			dev_dbg(device, "[%d] %s: disabled\n",
+				id, spi->regions[i].name);
+			spi->regions[i].is_readable = 0;
+			continue;
+		}
+
+		if (spi->size < limit)
+			spi->size = limit;
+
+		spi->regions[i].offset = base;
+		spi->regions[i].size = limit - base + 1;
+		/* No write access to descriptor; mask it out*/
+		spi->regions[i].is_writable = spi_region_writeable(spi, id);
+
+		spi->regions[i].is_readable = spi_region_readable(spi, id);
+		dev_dbg(device, "Registered, %s id=%d offset=%lld size=%lld rd=%d wr=%d\n",
+			spi->regions[i].name,
+			spi->regions[i].id,
+			spi->regions[i].offset,
+			spi->regions[i].size,
+			spi->regions[i].is_readable,
+			spi->regions[i].is_writable);
+
+		if (spi->regions[i].is_readable)
+			n++;
+	}
+
+	dev_dbg(device, "Registered %d regions\n", n);
+
+	/* Need to add 1 to the amount of memory
+	 * so it is reported as an even block
+	 */
+	spi->size += 1;
+
+	return n;
+}
+
 static void intel_dg_spi_release(struct kref *kref)
 {
 	struct intel_dg_spi *spi = container_of(kref, struct intel_dg_spi, refcnt);
@@ -92,6 +275,13 @@ static int intel_dg_spi_probe(struct auxiliary_device *aux_dev,
 		goto err;
 	}
 
+	ret = intel_dg_spi_init(spi, device);
+	if (ret < 0) {
+		dev_err(device, "cannot initialize spi\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
 	dev_set_drvdata(&aux_dev->dev, spi);
 
 	return 0;
-- 
2.34.1


