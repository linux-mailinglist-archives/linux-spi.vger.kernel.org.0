Return-Path: <linux-spi+bounces-2922-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9A78C8CE2
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287A42838F1
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8A61411C7;
	Fri, 17 May 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h22LymZg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD9140383;
	Fri, 17 May 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974874; cv=none; b=ESFzYgOL+E8uk3eZWXbjIYawlqcYPfQkCLDR/VBkwPSuFv5C9noLh5N81v5gowr3FyPklYUzoC4djF72JZWqub7Ivp/j2MBAM0WQNt3aWyxnvj42M3BzXyK2SUCXWRgloVsKT68iI7Xiilz8rOpR3HwgOPx+9SXurh0ERMb98qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974874; c=relaxed/simple;
	bh=58uaCEFrJnHV69wmGixRF0cIdsQsYxGDJ6YWjcApJ/0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TOC/RoFIE4GyklfiYDurii1+J2CFAbwrUN7D85T4Jdqo8Gi74O9A6vxVq+b+Yq5h6w1XJoK+9w32x5eW6UdPzU5AwnLUb5yvWp1SLuZtiwgIYUAGK3csi95YvReul7y1wdK3T1Pkbe60GqxSW0jgAkDC4fmlgYXqrmrwYvsKG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h22LymZg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715974872; x=1747510872;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=58uaCEFrJnHV69wmGixRF0cIdsQsYxGDJ6YWjcApJ/0=;
  b=h22LymZgtJP7u8bus93/4plmaqWanoWxtOtRQY2zRS7SZEGGH7Lzkyb/
   6+UM78jyfe3ip/MrNLHO95tTorV6lZ03QHQVSFU5Q/TxGsga9C8XBDu42
   MqEVM8mGDh9W4IyPRC/dxVChjl+efFHlVaWy85we3MSDZn2gmpQfpDV9T
   QGsAPUWiU00yiQSMpSYWt3+iqOIG/ZxBTIUajVLIVP6kRo1dUf8OG1pcD
   /EbmliO7ZNQUhq8VaeTOAPc709BON8nMn5cVrr5I+XvObHrg3SyHmCzAh
   ChurvenmtacWx9XGHH+P6op/OIlgKyd1+5a1H3W0tucIkMXjmveTtE1ds
   Q==;
X-CSE-ConnectionGUID: v5TUh/DxTb+JV/X1zU5e+g==
X-CSE-MsgGUID: 8I/9a3TPQnasaNRR1JOQHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22783105"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="22783105"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:41:10 -0700
X-CSE-ConnectionGUID: VLNn3fz2QTaa2kgiGzLsFw==
X-CSE-MsgGUID: Ahz/pBqGQjKFq+kOCtvryw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="32503705"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 17 May 2024 12:41:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 487421F1; Fri, 17 May 2024 22:41:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] spi: bitbang: Clean up the driver
Date: Fri, 17 May 2024 22:40:19 +0300
Message-ID: <20240517194104.747328-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few cleanups to the driver. No functional change intended.

Andy Shevchenko (3):
  spi: bitbang: Use typedef for txrx_*() callbacks
  spi: bitbang: Convert unsigned to unsigned int
  spi: bitbang: Replace hard coded number of SPI modes

 drivers/spi/spi-bitbang.c       | 73 ++++++++++++---------------------
 include/linux/spi/spi_bitbang.h |  7 ++--
 2 files changed, 31 insertions(+), 49 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


