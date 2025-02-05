Return-Path: <linux-spi+bounces-6630-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC6A28B2F
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 14:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C413A6615
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A610A3E;
	Wed,  5 Feb 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMjpaJX/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B91519B5;
	Wed,  5 Feb 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760790; cv=none; b=Oq39FpQPDNP6TyOOYWvB9nRKXqxNpdi7CzPkK2MGMoQkN9CKYBBwvJri0YVoakilA+oJTVWiMz9KkdwNSk0n0CWVCQIeFQJPHSIvk/aoSsCZA7Ys77jTGv9XDPevGytuMJNgquwSZD4sOuYUzGmnjV7cfMmhqSKy9zauKkirrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760790; c=relaxed/simple;
	bh=9JX2CffjyBacTB5rR+H29IweGyYHRhQIJrU3bNLITM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQr9Zkk8T1s0mFIHHwVHbseVcZVbxhx3HWXjvrTGPi4+5NxdEvBYQTDz8VMOlWeShtzwS+b29AUSMMZzW8uilVXyazoHWfzjvfo2EbARDR2VYPDcIyDq77N8GKVv4Tt+OdBPGQUqnWT5DOw0UfUNRRwDGxO2iM5Z4dkD8M974UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMjpaJX/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760789; x=1770296789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9JX2CffjyBacTB5rR+H29IweGyYHRhQIJrU3bNLITM0=;
  b=VMjpaJX/f7duYaB1jyb3Uqo905BhrNE0/vWgq8Sod4z8Rr5qyJFxBOqx
   3BicWsviZ+eO7ENHqEF8vEd5ObMxXtXdXdSkJlLbaWKHCINRxcYY5q6QP
   URxfxhZrXsHHB3JhyDE0aMBaJ+fuq0Qu9hPO6hLISjXFgtE2UYblkSOwu
   b0hBMXkPzgKcNm3DBa5o/c7g/nF19UeHL0B/yolpzngqHg1zB7BBBBYuU
   aR2lnyw/yazETvyZFBglramntbVIZup8NXtnnVUJe5lsS+Sn6StD6Vopy
   m1hm0URD6fs03iufmkiqK4RdSix1Sq/7xTyxIAiyjTFj9JC2Lg7g32pAe
   Q==;
X-CSE-ConnectionGUID: kH0RtxC3RQOT3bdqQFU+Ug==
X-CSE-MsgGUID: zYMrvJipQmaucw35FsXoLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38555941"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="38555941"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:06:29 -0800
X-CSE-ConnectionGUID: ZY2pmcv9TgOfG8WhokUXpA==
X-CSE-MsgGUID: rsGxzk/lToyAriSm3GuO7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115896144"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 05 Feb 2025 05:06:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 78B0110A; Wed, 05 Feb 2025 15:06:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Replace custom fsleep() implementation
Date: Wed,  5 Feb 2025 15:06:24 +0200
Message-ID: <20250205130624.716039-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_spi_transfer_delay_ns() partially reimplements what fsleep() does.
Replace that code by calling fsleep() instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a7a4647717d4..68e675877168 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1495,10 +1495,7 @@ static void _spi_transfer_delay_ns(u32 ns)
 	} else {
 		u32 us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
 
-		if (us <= 10)
-			udelay(us);
-		else
-			usleep_range(us, us + DIV_ROUND_UP(us, 10));
+		fsleep(us);
 	}
 }
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


