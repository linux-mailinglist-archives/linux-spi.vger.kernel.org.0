Return-Path: <linux-spi+bounces-4501-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2639684AC
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 12:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582CD1F21D5B
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0013D8B2;
	Mon,  2 Sep 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XejGzRD/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AB1420B6;
	Mon,  2 Sep 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272940; cv=none; b=P8dWgttczAO7v15sdKlS0oyDmWWi0D/Su+0CGTbS6WLWTnsbsLvn2iRnphR6UNDp4bL7uWrK8aexOl16EyKdpEV0vKIEFkIF9iDN4gpc79xn0k+CYE7zVwQn/J5DVUdeK5IzhWdaZbYMWp/VM+C9qQ6J5O3Yh57MMXbuKOQ25vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272940; c=relaxed/simple;
	bh=tAZPAyRBypdF7BXU6XmKUeI+XvVrWAWgO2fmm22tRRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMvGnVnp2q+VqWm5d9KyOGwY3dDFk8pqMGir71DUbPkQEm9UXSWYmgNWohz6GwaEgalL4OsouoS75Xd8ts3sQT+GILVQlrCYv8Ga/g6DXFp+lS4xLz4K1Kbf4KFxG15O3RPbMiVW6jGwO4IOdTf3yO5vQWFReEGyYjH1M7h0ERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XejGzRD/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725272939; x=1756808939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tAZPAyRBypdF7BXU6XmKUeI+XvVrWAWgO2fmm22tRRo=;
  b=XejGzRD/m6e/eKx/YaokdduvL71Tkc3b5hl6J7UL8EAHJG151wR51UWT
   jr3CPVG0iLRBIpHbzua90BmqE0B8AvLqG8ObNHsT4hJfmHkDlO4raWFXA
   /5Yt7A1cbVD2xJf0O3ORzgVWOg9OQ0NA/Uvi6zt4XZPcNXdH7OSyPenTp
   2JAWXQvcF8Oxk3+mahHOWvXTU2TsQa+dotI/xP1Vaay91xjKhflz3FGFh
   iZarLr08L76uysjbj8ynJd8UKIXBz909El7pLOhLgKed+oJkTmD5bRgev
   2eRTPfJWOiJCd+ThAfbBxzyOt3+rUNwRXeUEKWMkv2q1QzBBHLFdc9StB
   g==;
X-CSE-ConnectionGUID: MpEmqEZOSXS9NO5GWSVaJg==
X-CSE-MsgGUID: SsyL00maRMad59WxuHYeZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="24006831"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="24006831"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:28:58 -0700
X-CSE-ConnectionGUID: mfun6F74QyKWMmCypyZh5Q==
X-CSE-MsgGUID: 46LviGhDTWi1f+M/ro7MWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="65286705"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2024 03:28:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 78879233; Mon, 02 Sep 2024 13:28:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] spi: ppc4xx: Revert "handle irq_of_parse_and_map() errors"
Date: Mon,  2 Sep 2024 13:28:26 +0300
Message-ID: <20240902102853.2476165-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit had been applied twice as
  0f245463b01e ("spi: ppc4xx: handle irq_of_parse_and_map() errors")
and
  f1011ba20b83 ("spi: ppc4xx: handle irq_of_parse_and_map() errors")

This reverts commit f1011ba20b83da3ee70dcb4a6d9d282a718916fa.

Fixes: f1011ba20b83 ("spi: ppc4xx: handle irq_of_parse_and_map() errors")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: reworded Subject and the commit message (Mark)
 drivers/spi/spi-ppc4xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 36722fa6c8bf..2c43b498432f 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -415,9 +415,6 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 		goto free_host;
 	hw->irqnum = ret;
 
-	if (hw->irqnum <= 0)
-		goto free_host;
-
 	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
 			  0, "spi_ppc4xx_of", (void *)hw);
 	if (ret) {
-- 
2.43.0.rc1.1336.g36b5255a03ac


