Return-Path: <linux-spi+bounces-1269-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3B850EC7
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 09:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3341C20830
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2A79FD;
	Mon, 12 Feb 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPu6Gtys"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C4F4E3
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726032; cv=none; b=Zi8GL6XmmMX0/VgwNgirqgDZCjSt0QwjNKyjWTsWi7So//AzhBuYpb1NLFXmJi06RDknzlV5eYBOAXK2dttr2x8/ANGCRoVQHmC8ZXo8Ygv6Frp6hRm5Njs7dZh+W5RQs8LDDlfMbnSoL8QgTVCIGCE5NtQ7gew5ZiozQc8HRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726032; c=relaxed/simple;
	bh=IqGwlBBX8bUDtuT67YcpJVFAomaAMJtrw60+wpG6k2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AV+Mmz5JLdBLsjqRzb+GAsBbFIrp8L7E0/q1jN6N/ggCJ4N7MM3ON9W4Jq4XOcpGELV2bifdWI+xqsM19NQ76v2c7npozD9YDcJdJpouN1OlfntN3Gnv/jd9O6JTw3J00nK/wIl0NKYqpJdH2L3ErenyPYaMCunydFBm2Qx365Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPu6Gtys; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707726031; x=1739262031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IqGwlBBX8bUDtuT67YcpJVFAomaAMJtrw60+wpG6k2Y=;
  b=YPu6GtystvzRkuhpX3Moww/mmHQ182V6kKi0ysJ/oiD3rVluvTpAqOGd
   Gw8pbhZkfhvmLbxuuMdxLIutuUxaeJO7a4Q3sEhR7f+D5pZY8OtviyqQh
   Vv+1TykLfhtFtXE1UFeQ6sRmBcVncbyCjO7SZc/KUwcQrLJHqCUP+kyFZ
   ACT8UyC6wrIHNQy7WcOJ/gkpb9wxC7bsWSYdOIWTmvXx9uqpy4eGP/f3E
   ez4AuzUz+JGbCgj7Amv+KwuBqF3T43oMdIijyHBDKQShZXTZHjQBN3fwJ
   E1kH7mLlwz1Q8W0NrfD333pV1cT92cLk3DuFKhwzUmvLyACHnQpp0iDFC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="27135752"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="27135752"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 00:20:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935015901"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="935015901"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 00:20:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 83E7E30E; Mon, 12 Feb 2024 10:20:27 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] spi: intel-pci: Add support for Lunar Lake-M SPI serial flash
Date: Mon, 12 Feb 2024 10:20:27 +0200
Message-ID: <20240212082027.2462849-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Intel Lunar Lake-M PCI ID to the driver list of supported devices.
This is the same controller found in previous generations.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index ce4416c4d49e..0ff6c4284609 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -86,6 +86,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa823), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.43.0


