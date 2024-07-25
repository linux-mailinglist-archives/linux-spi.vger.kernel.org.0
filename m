Return-Path: <linux-spi+bounces-3997-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E75A93C395
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 16:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC4C1F22829
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963C816DEA8;
	Thu, 25 Jul 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hl+Y9VoX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E51173347
	for <linux-spi@vger.kernel.org>; Thu, 25 Jul 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916354; cv=none; b=cJj0c+aVeZrbeYKlRZ9sX5vLyA5XihEs+PNsr+EfmWxAuZJUs9G6hrL5TV1OmmwVbaFnystscHd8RwH3r79QnVBDLfF7qj8730oXSEXktWXvFzIU3xv4QiAiEocexxtywu2RwV8xtOt5km9KvpgvIZhMCF0m5n7FssQgpxGg3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916354; c=relaxed/simple;
	bh=2uaDlZD0uMy4pTVqQ0jeYFWBfu/L/qwRKStrAtd4+nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2trWAzNRsQSiZjnne582Nhq7gf3z980ky11YKbE3BKaM+Nab59WHUVA7IQAtlhGPmJTsaIb0WWei+8G0LP5jSREaSVuh+Yjr4aGjHcgI3ExI7t852k++0XjWB9nG3LG+2VKUMFpAUoEpo6JdvAKA2LIsQ+W8J9Vlxxcqj8UZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hl+Y9VoX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721916353; x=1753452353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2uaDlZD0uMy4pTVqQ0jeYFWBfu/L/qwRKStrAtd4+nU=;
  b=hl+Y9VoXULlJmlRZkzJQZOxcavms/F84EbuCdozEGuCwOpB4CiqlwhwO
   nQ17H4yUMDJb5sJgb0r1yq1FRWNM/tlQZj+pOBDvQA/Xt8/b/B6fqwC99
   1fk/fzV/az+U1kkr4CzTWsXhY7E329gVCIQJSN8C2582xCTQk9UyxWOpq
   Of6+U+I/wc7Y0QWeNfdLWzBqYf+gs4NedBByKFlXObFq4EEdmjYy2gpB2
   k6Axm8yITx8dpj8D0C3bIl/UHg6bg1VPudsal4mZOGvHDNCd8bcw7OPdT
   tTGU+j2NG6k6JQkW2vaMXo33vLFcudrd5mkXUF4W3TzXnOFh3yOZR7jrx
   A==;
X-CSE-ConnectionGUID: tPd2oG5tRDind9fw2N/YkQ==
X-CSE-MsgGUID: h4JjezzxRbCoM8uYIBgClg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19504847"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19504847"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:05:53 -0700
X-CSE-ConnectionGUID: r75fFjeIRqSCh8qgoA06fA==
X-CSE-MsgGUID: PwaTcJEgSA+HuyZLvvA5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53007770"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:05:47 -0700
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
Subject: [PATCH v3 06/12] spi: intel-dg: align 64bit read and write
Date: Thu, 25 Jul 2024 16:56:51 +0300
Message-Id: <20240725135657.1061836-7-alexander.usyskin@intel.com>
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

GSC SPI HW errors on quad access overlapping 1K border.
Align 64bit read and write to avoid readq/writeq over 1K border.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/spi/spi-intel-dg.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/spi/spi-intel-dg.c b/drivers/spi/spi-intel-dg.c
index dc4d6c573522..534e99cb336d 100644
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


