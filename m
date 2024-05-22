Return-Path: <linux-spi+bounces-3010-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8238CC55E
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 19:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1891C21BEE
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34AC1422CC;
	Wed, 22 May 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgXqBqqm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087A1422A3;
	Wed, 22 May 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397830; cv=none; b=rNMsG/BlvXLqJkQM7YLjlLGa5lOObekTnl+MeJYsaVv40vAxupwQp2qH9Wex+Goqkw3s7UvjfZlKuWbDyqN8jXu740MnasEBA5BckJsmuX6gQIFiae1cziNvEO6rbk/S24DAczvRHwmRWUkPg1HANf86SFEA2ShoFeapqHOZxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397830; c=relaxed/simple;
	bh=nwG0WUS3w8dj+oNT2dSZeWDdD5j+3sQO7tCGorOHTFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsSdNqQsRphUeyAah41G1PB33DxLMNUzqBeN+22qZfUm/39EhnAZgixQ3BJaRjHEAZ9zwV2m45bJ+W8sS34PH085aKWY4ouF0gOIR26J5lH5E1zknZT8pDGoaJl8URwWP8dVjlEq8Cfsat8Sep+n4CugJnOVXgB4VVqzate+PZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgXqBqqm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716397829; x=1747933829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nwG0WUS3w8dj+oNT2dSZeWDdD5j+3sQO7tCGorOHTFM=;
  b=cgXqBqqmO2IQkMG5n36nbNPG0Lq0BH0gPZDmbjoI59D2Y09wPoj4clVj
   Eu58eoqWVvu8QfYaq58V2F5IifsrcUMXp3iE7tgHqw4vpg6kME2mSOqmB
   rAm2wRdFmyaTZdUjyBCIT71g2fAIOHni9wi7llYRh97iIKkl9YeVkLbtu
   8qeVLVRXMPdszNo8u54+R4kN0dDCtVUKZguchnhzfa9TiMJT/Y6LXg0cQ
   TunjMd/A7MPIXlQUHnFhZ1FTYBDLW8Oj29sF7xY8iJsW8hzLu+mLaUiMf
   toMW05H+pzk3OinZviU4B7oUiBxMT0YZiSxzp+9YK5thUGfHas0Lc/aMT
   w==;
X-CSE-ConnectionGUID: z3l/G0lgSSSVcvsOvDqX5w==
X-CSE-MsgGUID: iOjFVe+oS76LDJGDvQ0oMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="35180063"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="35180063"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:10:27 -0700
X-CSE-ConnectionGUID: eIpLBzi7Sp28WbGf1GKNPw==
X-CSE-MsgGUID: w/o2HKg4Qx6hawYBbRHXFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38204820"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 22 May 2024 10:10:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BE6043C1; Wed, 22 May 2024 20:10:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: Don't mark message DMA mapped when no transfer in it is
Date: Wed, 22 May 2024 20:09:49 +0300
Message-ID: <20240522171018.3362521-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
References: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to set the DMA mapped flag of the message if it has
no mapped transfers. Moreover, it may give the code a chance to take
the wrong paths, i.e. to exercise DMA related APIs on unmapped data.
Make __spi_map_msg() to bail earlier on the above mentioned cases.

Fixes: 99adef310f68 ("spi: Provide core support for DMA mapping transfers")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2efd4964f7c..51811f04e463 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1243,6 +1243,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	else
 		rx_dev = ctlr->dev.parent;
 
+	ret = -ENOMSG;
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* The sync is done before each transfer. */
 		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
@@ -1272,6 +1273,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 			}
 		}
 	}
+	/* No transfer has been mapped, bail out with success */
+	if (ret)
+		return 0;
 
 	ctlr->cur_rx_dma_dev = rx_dev;
 	ctlr->cur_tx_dma_dev = tx_dev;
-- 
2.43.0.rc1.1336.g36b5255a03ac


