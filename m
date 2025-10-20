Return-Path: <linux-spi+bounces-10723-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD714BF1EFD
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68872461C63
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE1225397;
	Mon, 20 Oct 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYrJtZfK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22D227E95
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972059; cv=none; b=O5eiIosaZxHZ+sKLMKSKaxWbJxANsMKgo1FWpz7GpU9Oqu2F1nJwghgmd99y2+n8kDiKUk+0OoNpgrBzWTadUicbv80NDDPUjlM2O8HRPUNIrL5z0c0KaHXew4cJe898XE6vnV29S/G6U4/HxaaJd2Y2QI7U8z+05RQwnKdtpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972059; c=relaxed/simple;
	bh=dbF1xQufcuyg/uzfcwHFbc7YsOM1cy+/tHYmXqfR/BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmAl1RJqvPc8VwSH9gnSWizBM8gPP8OTowiOHaN0k3ymEghVZzEYmpvIgWph1KD5omu1H/tBP2tvN/P1O1bqH4bmNnXBfLV9tPniJAh1Q+qbbJWpAcij5Zmo6RwXRHyuQNsCD76lVZV1eTMh1wDISO6iCVDXFIEsmNkEZ4+haQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYrJtZfK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760972058; x=1792508058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dbF1xQufcuyg/uzfcwHFbc7YsOM1cy+/tHYmXqfR/BE=;
  b=YYrJtZfKZzwpnIwBzPPvs0Ey4jrkZyxSvUL1tkk/ROdWM8+qbaqbh+1Q
   O2zqDySGEobKuJ3LT+3RKsX8OMdJC5ouZ3bBgAnKhGv1Rk0Qhgg/dDQU8
   JWyhLux+CbXu9QAXE2tAbVvq2sbyA3WpEys+JJpyFQ53Gae7MWdDTqG9V
   R697R3Nf5hzuLh3gann/7K1jWdPnnrlA02sCi9ceU/z80vQ8uiVaNQeFy
   JsS6f5RRMsf0MwhPM9QRBiJ5oPcdX/DRg0u/JPkgH5bjzV9Bdy0XaDhQn
   htG4PO3nOJJklkHPp95icenbLbUVj66i5hACWLrFVPVjoLx78+qiBrQc0
   Q==;
X-CSE-ConnectionGUID: jETrvwEkS2CziiPD5T1Kqw==
X-CSE-MsgGUID: cx7czQb3R729RWVFrLVnQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62994858"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="62994858"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 07:54:17 -0700
X-CSE-ConnectionGUID: Hq+bO39RQ12FolmnTGon4Q==
X-CSE-MsgGUID: +2BwkHU0TZWQ1gICnujO6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="187754636"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 20 Oct 2025 07:54:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6B7F896; Mon, 20 Oct 2025 16:54:15 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/3] spi: intel: Add support for 128M component density
Date: Mon, 20 Oct 2025 16:54:13 +0200
Message-ID: <20251020145415.3377022-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020145415.3377022-1-mika.westerberg@linux.intel.com>
References: <20251020145415.3377022-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the recent hardware the flash component density can be increased to
128M. Update the driver to support this. While there log a warning if we
encounter an unsupported value in this field.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 13bbb2133507..1775ad39e633 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -132,6 +132,7 @@
 #define FLCOMP_C0DEN_16M		0x05
 #define FLCOMP_C0DEN_32M		0x06
 #define FLCOMP_C0DEN_64M		0x07
+#define FLCOMP_C0DEN_128M		0x08
 
 #define INTEL_SPI_TIMEOUT		5000 /* ms */
 #define INTEL_SPI_FIFO_SZ		64
@@ -1347,7 +1348,12 @@ static int intel_spi_read_desc(struct intel_spi *ispi)
 	case FLCOMP_C0DEN_64M:
 		ispi->chip0_size = SZ_64M;
 		break;
+	case FLCOMP_C0DEN_128M:
+		ispi->chip0_size = SZ_128M;
+		break;
 	default:
+		dev_warn(ispi->dev, "unsupported C0DEN: %#lx\n",
+			 flcomp & FLCOMP_C0DEN_MASK);
 		return -EINVAL;
 	}
 
-- 
2.50.1


