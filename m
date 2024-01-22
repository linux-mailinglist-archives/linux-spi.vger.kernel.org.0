Return-Path: <linux-spi+bounces-558-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EF883645A
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 14:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ECC0B2953F
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E43CF7F;
	Mon, 22 Jan 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6mmSP7k"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6863CF72
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929533; cv=none; b=ZsspXFhfVa7sih6VCLfs8S/tc6eVt7QOw/zqRYm3Fd9cfDJUHHiLGdLzbPKbYuGAgdNKh9abZPpRoA10Q5yV7P5HTm+4AbLgPPiZuMWnTTYii9R8AJOzui2s7kNPDdifGHKHLXrJ1zMT1mC0Cdfo4DZH4uE/FTI+tPYj6+1vvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929533; c=relaxed/simple;
	bh=rI5SdAeX+93MZA8iN3wMNvYtSx30nN9lqluSY+TlnI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkHdGB6vgwn8ef1B1FFJ5cp+jcYf/2zbl9RjsT7bVdJHjk0BoYyMtgBPPaAF7oTbq6SA2ry6Rw+ij+TL6djZjYBkkSKTx5LxDrlh4RTNBoOZsYeIqEA9XxlGSAOfnyz3iKfNC0j2LT7mrDviMUPtSRiCNC3wHjclASnENGdGoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6mmSP7k; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705929533; x=1737465533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rI5SdAeX+93MZA8iN3wMNvYtSx30nN9lqluSY+TlnI0=;
  b=K6mmSP7kmlamc0KTIJEJQX/RZhiOy6CQgclII9q+AP9Wo6oQJwiIZBaA
   I3lUEbS8rzrZnhnX99mkKYyge0O6eZscgPLqWKNkPWxQrhez+lwwzSCeZ
   4bX5tK1bAl0QRdzvRziBOuDB1c+qUbenl4fjzDhJPxnnuX0V6FobfeJRn
   ShCBTTeqIM9BjFiWlBSMxhFPVgwXhYyI2QeNFZZM9AOPP/4+LXmeHlnkH
   qbuzoro+sx6cEEnqKeKbagfQhJU8azeuj1RRWtxKXbM4Q8IvGC0yxxc7j
   WsiAEOCQQy8ajX/v3qumLBp2EbJBYuoLLG9L9W9k4jgFRxB4xta90DKkD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="8302033"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="8302033"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 05:18:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="958731660"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="958731660"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Jan 2024 05:18:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5EFE224D; Mon, 22 Jan 2024 14:00:34 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH 0/2] spi: intel-pci: Meteor Lake fix and Arrow Lake PCI ID
Date: Mon, 22 Jan 2024 14:00:32 +0200
Message-ID: <20240122120034.2664812-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The Meteor Lake-S SPI-NOR PCI ID is for a controller that does not
support all the necessary operations so the first patch removes that
from the driver. Second one adds the correct one (the same is used in
Arrow Lake).

Mika Westerberg (2):
  spi: intel-pci: Remove Meteor Lake-S SoC PCI ID from the list
  spi: intel-pci: Add support for Arrow Lake SPI serial flash

 drivers/spi/spi-intel-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


