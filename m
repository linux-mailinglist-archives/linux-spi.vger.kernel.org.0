Return-Path: <linux-spi+bounces-556-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176AE8362BD
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 13:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27EB299425
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893A3B19D;
	Mon, 22 Jan 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duRQlHOj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FDE37144
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924839; cv=none; b=NXiSznhe/bE9BbEVS0OTvXGmWfDSUNTYzyzvRv7Z1weIZQw3tHNSSZZ9EHsCmxZg0MSbin7Sji1m2KQgxmxd+pkQslsqEs9DklxUszFvq2c0OE0o/ehWjxkn4k3cGrEkZmz1nDnml8ZoLdIhUwgBAvRAUkkPIzhFHaZkd+eZ0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924839; c=relaxed/simple;
	bh=53pvPQIjhOm0vA33Ijdc2HrRy5UfknmCjZF7bXUddd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfXcZN2lB+hIvX94zoKe4gqRdnEU+4vSlp3GUmcyihsJ0ADskz/4XBdr6OE1iTzcq6+YhyvJvwyBb0RyhHkNSh3Hx+Eu7hM9Q4XVMEi9t+qXgRyU5LcqM1FLPoiV1WcL0LbARNE7qz4wzJprhTlVrWT9G6kenWKm/phddiTVK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duRQlHOj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705924838; x=1737460838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53pvPQIjhOm0vA33Ijdc2HrRy5UfknmCjZF7bXUddd4=;
  b=duRQlHOjAYG8JRIpq/hBMp6tXT+zJesdCFWslJwmwahujILt1vQsPwSC
   p8/6DaUfVjfl+6Iad8rgGXxOAWqGzxwfh5YFrxNGBi+bzkP/d12nuiCgn
   KfVFLLhK2w60GCsUCLHqnIrWnnmb063BFpopvPlXHgB8Q/0fLot59Ki5S
   HBHAyqve4dFanVxC02bXRcMtt0k6nAfr9JurvdJVoKIxnFar/6TNcpXgy
   NA3jcV5wDs4CniF6QNADuuWiXn4pU0TB3ol5AxM5zpnlXIFUO3iYAkegE
   2jZsIFXYE4xzadK/ru6F77jANIl1hSVRlLPkQnbsPcWTheHOG/bn8dEdA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22667311"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22667311"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:00:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="875951757"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="875951757"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2024 04:00:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7BC0638C; Mon, 22 Jan 2024 14:00:34 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: intel-pci: Add support for Arrow Lake SPI serial flash
Date: Mon, 22 Jan 2024 14:00:34 +0200
Message-ID: <20240122120034.2664812-3-mika.westerberg@linux.intel.com>
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

This adds the PCI ID of the Arrow Lake and Meteor Lake-S PCH SPI serial
flash controller. This one supports all the necessary commands Linux
SPI-NOR stack requires.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index b9918dcc3802..07d20ca1164c 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -76,6 +76,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x9d24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x9da4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa0a4), (unsigned long)&cnl_info },
-- 
2.43.0


