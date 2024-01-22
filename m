Return-Path: <linux-spi+bounces-557-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B378362F3
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 13:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7511CB20DDA
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 12:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D323B2A4;
	Mon, 22 Jan 2024 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntXCTUVC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A53B290
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925934; cv=none; b=R5TtVA69ZFEY8OX3eA5Lme2e9IOtS8A9VAt5T9f9TR9o4iqUANhVL95MXrOGT5g/EiD4vjX05DQzKIcid4F+GOnSxNLozKNyjhwT2DUDdJFJgUbvokmvwmW1XoOqbSGQlQfLuhCYWxmrfKotYWkuidfQC7t0tKCPRCk9g21GzWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925934; c=relaxed/simple;
	bh=+D5afzHkCSUgtvf/oWTCN89WJYXKEtkdZefDcQnBq3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oycCKNVekMNItNzFGJ99nPD+PS7MYzVWV99/SAArC4HMTyWaS+hOiEN6vMgG54LFDrHIUQTfVrWiBUU0ZJJThKF6QNYCKMebhwq6k7XglA0TE3teiboLaxxO1+Pnz/m1xE8Jzf0ComPjmCg6JLaGkgb6X9MLIaDrwunEtEZHx7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntXCTUVC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705925932; x=1737461932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+D5afzHkCSUgtvf/oWTCN89WJYXKEtkdZefDcQnBq3Q=;
  b=ntXCTUVCqWYk/jIpo2x9Yb9VJ2iCMkYCyaYqURZX85XbEA4bJk/9+IpJ
   msFR3qna3JLvZgW5S4K772hfilspKmQon/YyylzEYe+UqJBNf4TYRMK5G
   xNj/9d9cVPd+/nCIzGPqvaJT82VvUUNgg2DPUqcp3PDuQ5UKHxUSJ7pmT
   /Kzxqr16grT7ZR0czSujv46xXONVzeBEfXOB2gL0GIZ2zlY/HtOoJeF0L
   d11vszKG/sSYbU8RlrHMaGyDhUoY1TPemhn7crulX0cpNv0RucmiUxFZA
   DjE/SehZbNf1xJBx0dBw5evigf3sef+DhdUxEfO5/h6vAny4IIxFQg27Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="1051412"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1051412"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:18:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="819671553"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="819671553"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 22 Jan 2024 04:18:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7299C23A; Mon, 22 Jan 2024 14:00:34 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH 1/2] spi: intel-pci: Remove Meteor Lake-S SoC PCI ID from the list
Date: Mon, 22 Jan 2024 14:00:33 +0200
Message-ID: <20240122120034.2664812-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122120034.2664812-1-mika.westerberg@linux.intel.com>
References: <20240122120034.2664812-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turns out this "SoC" side controller does not support certain commands,
such as reading chip JEDEC ID, so the controller is pretty much unusable
in Linux. We should be using the "PCH" side controller instead. For this
reason remove this PCI ID from the list.

Fixes: c2912d42e86e ("spi: intel-pci: Add support for Meteor Lake-S SPI serial flash")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 57d767a68e7b..b9918dcc3802 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -84,7 +84,6 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xae23), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.43.0


