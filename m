Return-Path: <linux-spi+bounces-181-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1388180AA01
	for <lists+linux-spi@lfdr.de>; Fri,  8 Dec 2023 18:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FE3B20B5A
	for <lists+linux-spi@lfdr.de>; Fri,  8 Dec 2023 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1509E37151;
	Fri,  8 Dec 2023 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSusbQW+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA610F8;
	Fri,  8 Dec 2023 09:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702055083; x=1733591083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XyNMLeHiHgz9zyJ+B2ye1DJ6XRbnBWA/BZKLjYEhKJo=;
  b=LSusbQW+tl+7RaVL+Vl26m991wP7Owlz26sDc018r7aLWYq64JC8kcw0
   6vNeysbRkoHL0CHOwX6EbeMtxqtPvcLFuWoPU1ELfBO1326K9RkwqMfTo
   dt1ano/ig/vnuqygR/FKmjdYSLlz1erU3yK0XKiGAzqkZey1oS2LqNGbi
   o97wcAJNNHiuoV/2oTPCDACvOSfpQNAFKE/1KBAzd6uOjfWzXzVuNi+tD
   PQZViwJ7G3B2lpdZCPv4/hqluAcQxa6IM0gMDHQET92XLTtn7kAQX6sCX
   A/0jXg0e1UkAzjBxHo3jZ+Af1vh7RURLlGf/Eo5hkS+hcbN3oMDhkelj2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1311102"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="1311102"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="838189001"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="838189001"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2023 09:04:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 966E9154; Fri,  8 Dec 2023 19:04:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] spi: pxa2xx: Update documentation
Date: Fri,  8 Dec 2023 19:02:53 +0200
Message-ID: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of documentation updates.

Since v1:
- spelled controller fully in patch 1
- fixed inconsistent indentation in patch 2

Andy Shevchenko (2):
  spi: pxa2xx: Use inclusive language
  spi: pxa2xx: Update DMA mapping and using logic in the documentation

 Documentation/spi/pxa2xx.rst | 59 +++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


