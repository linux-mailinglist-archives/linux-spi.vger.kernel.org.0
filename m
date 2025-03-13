Return-Path: <linux-spi+bounces-7109-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F2A5F219
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 12:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CF7188E92A
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF996266199;
	Thu, 13 Mar 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLcrso4E"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193ED26560B;
	Thu, 13 Mar 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864469; cv=none; b=PUK5v/7RLL6cHK9pZ7VMoKbby0OMuv8l3ZdUBZqJLUz0wLLGwcD4JdG72GgxX7Y+zmyiJI4VqYhdN9wJs/wd75iYJFDTqo9lqdvnGGFI3ZZZNQ2gz6VlvvC9u4L2NlhBFg78DTJzb2PkprPpnLVEdjuSfIOQsH1XVxYKcUghrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864469; c=relaxed/simple;
	bh=U/Q/0h/esesBGgSEURjD5WBzn2PpFAaabIM7VOSzjS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anmxTmhoeo+M9wJ9MHShALKJBsJu5Z+2fED9HAOUgIcXMol4cooSUATGklf6A3lelYBRzjXqXw9kk/nphjplWLrlOiJ9QyDxEznDFMxTP4RAPX3aSObwCOiy4myEetVUWkN+WIKQSCqsxQ03fRoXGeOy3N5qm+FHEItoSvfQO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLcrso4E; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741864468; x=1773400468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U/Q/0h/esesBGgSEURjD5WBzn2PpFAaabIM7VOSzjS0=;
  b=jLcrso4EzWF/Qhp9MBU64uzsTtrJuT/3F8CK66eV0wsfdxfrjssuWdng
   s2RpGHNQU7NGAN/UpHM4yrI+3ULEhlexozkS+B06QKjUgP4BuO/b3znh5
   jneDQTs5G1ItYpp6iVk6FoYsZZnkmxsURNvUq5h3HhJtfWtJDMcfi3TjW
   sA2hT8ztxMetbuQDGFQaPztOH1A0iFALhKsh6H/roKaE05HGYdGaEx/5I
   PL8bdRbDGKMZnNS/vLnBTfMiI+RBkSP56kb5odAhH/rWKfIA4DWdJLCw6
   Tj/5FHcSDAUBnV9BjU2wdVXaRcnaVV5MswPDGr6ysniQHhU3RNyuyS3MF
   A==;
X-CSE-ConnectionGUID: 4Kw+JmhTSBevRUa4YrqRYw==
X-CSE-MsgGUID: 7eYq8hs0T6e1fEurhrhwsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53612341"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53612341"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:14:27 -0700
X-CSE-ConnectionGUID: 1AUU88FWRGmh9mlC7X5BJA==
X-CSE-MsgGUID: 9xonymIsQfKqIsODAX2VVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="144104378"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 13 Mar 2025 04:14:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C5C821FC; Thu, 13 Mar 2025 13:14:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Longbin Li <looong.bin@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] spi: sg2044-nor: A couple of cleanups
Date: Thu, 13 Mar 2025 13:12:58 +0200
Message-ID: <20250313111423.322775-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has one ordering issue and one missed case for dev_err_probe().
Address that in this mini-series.

In v2:
- fixed obvious typo (LKP)

Andy Shevchenko (2):
  spi: sg2044-nor: Fully convert to device managed resources
  spi: sg2044-nor: Convert to dev_err_probe()

 drivers/spi/spi-sg2044-nor.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

-- 
2.47.2


