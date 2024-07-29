Return-Path: <linux-spi+bounces-4047-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A099593F044
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 10:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DB2B20A8F
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EEF13C801;
	Mon, 29 Jul 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEKXvF/e"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1D139D12
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243142; cv=none; b=dJq0VeRb2FU2efZUuLro1e1qp0LejD9+ObNhLPOsHlI9Cvll+YLlh10Q/d78qsWoHOCQKaf0M2aT7eHFd7sVDcvFUJjGzQ+rulIXOfNQP4cOiCxvw56XsozEUjBlP3Zyen3FjTX29rJr9Oamm4vqI6IQ2iTlNOYxyiWYn7d9d7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243142; c=relaxed/simple;
	bh=RXv/8HHQlvGJZSc4bfEumgCJIypGPgEUU9zuekqRKBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YD9m0T8OAgW7cvGe0OFt5UyhvPqX3zQrCmfirN967O3wxw738KIkHLQWectajKTVY6H+mVgXZrKxJilF85rfUgXFy3OHqSmN9amFfTTMiuF3JmcAvzQtRrDccP5BGDynV/xeEvaxR0PQgu1Jxe3y4N3JKjo6LnqqWbY2+zJwPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEKXvF/e; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722243141; x=1753779141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXv/8HHQlvGJZSc4bfEumgCJIypGPgEUU9zuekqRKBA=;
  b=WEKXvF/e5WKKB4QmbCyFkyjecx4rhcFkFQAljgSIDtrn9Q+0pL4uK4N6
   NvFzQWoCRnbOEg2GzoiVWyODDIP0aRJyWgg6KkL5esrhBg7+igzxPC32E
   HP2oH8TwF2r0Pq9UrzlnaD4DOnl77jKHg05zqjlVKUX/Kf2k9TGx9WB+p
   8GbziSeu5otHJHHKDe0+snCkrkFYIvNCk7HxXihaXemOamrTWL20dG/IQ
   l1zO7pfRigeMentvdBrLZeM0rArEQt7Sxet939nIY2+3TL8Wy+97lbbxJ
   whWbtP9y6p7ihwZgTip9rtorJMXmRR7TM+OoB07JSSjepdI8X1WEAM1x3
   A==;
X-CSE-ConnectionGUID: ISLMrJsiS1C0f4cCSS6CqQ==
X-CSE-MsgGUID: Njd5e8GJQcaL3VFlk4K5Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="42509054"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="42509054"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:21 -0700
X-CSE-ConnectionGUID: pXreTNDUSkWyrD18VEPS+w==
X-CSE-MsgGUID: FfHF58rmS0auBndTB9tkKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="54708480"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:17 -0700
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
Subject: [PATCH v5 06/12] spi: intel-dg: align 64bit read and write
Date: Mon, 29 Jul 2024 11:43:20 +0300
Message-Id: <20240729084326.2278014-7-alexander.usyskin@intel.com>
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

GSC SPI HW errors on quad access overlapping 1K border.
Align 64bit read and write to avoid readq/writeq over 1K border.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/spi/spi-intel-dg.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/spi/spi-intel-dg.c b/drivers/spi/spi-intel-dg.c
index dfb457c43a5d..c76b0a70f8d8 100644
--- a/drivers/spi/spi-intel-dg.c
+++ b/drivers/spi/spi-intel-dg.c
@@ -231,6 +231,24 @@ static ssize_t spi_write(struct intel_dg_spi *spi, u8 region,
 		len_s -= to_shift;
 	}
 
+	if (!IS_ALIGNED(to, sizeof(u64)) &&
+	    ((to ^ (to + len_s)) & GENMASK(31, 10))) {
+		/*
+		 * Workaround reads/writes across 1k-aligned addresses
+		 * (start u32 before 1k, end u32 after)
+		 * as this fails on hardware.
+		 */
+		u32 data;
+
+		memcpy(&data, &buf[0], sizeof(u32));
+		spi_write32(spi, to, data);
+		if (spi_error(spi))
+			return -EIO;
+		buf += sizeof(u32);
+		to += sizeof(u32);
+		len_s -= sizeof(u32);
+	}
+
 	len8 = ALIGN_DOWN(len_s, sizeof(u64));
 	for (i = 0; i < len8; i += sizeof(u64)) {
 		u64 data;
@@ -289,6 +307,23 @@ static ssize_t spi_read(struct intel_dg_spi *spi, u8 region,
 		from += from_shift;
 	}
 
+	if (!IS_ALIGNED(from, sizeof(u64)) &&
+	    ((from ^ (from + len_s)) & GENMASK(31, 10))) {
+		/*
+		 * Workaround reads/writes across 1k-aligned addresses
+		 * (start u32 before 1k, end u32 after)
+		 * as this fails on hardware.
+		 */
+		u32 data = spi_read32(spi, from);
+
+		if (spi_error(spi))
+			return -EIO;
+		memcpy(&buf[0], &data, sizeof(data));
+		len_s -= sizeof(u32);
+		buf += sizeof(u32);
+		from += sizeof(u32);
+	}
+
 	len8 = ALIGN_DOWN(len_s, sizeof(u64));
 	for (i = 0; i < len8; i += sizeof(u64)) {
 		u64 data = spi_read64(spi, from + i);
-- 
2.34.1


