Return-Path: <linux-spi+bounces-2923-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A211E8C8CE7
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7912847E4
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4CE14036B;
	Fri, 17 May 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLhakqJg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D06140363;
	Fri, 17 May 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974971; cv=none; b=U5JbAu40f8RCcvCDOBqHckA9Rz8Zebs474G1ImLmnOB5YeyvumIVNI38pewbrE5BsodRkbM0XaN4edw0pjPkgz3YQ4Pf0ilM+v4silHzNeaj9kFXYcLy/vzrUkLzpACbEwds7Ov+ynGWmbM7MldFmYH+2aYAQjJ1eIodkZ8Q5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974971; c=relaxed/simple;
	bh=vKKeJE84GjcL1kTEGVbp0Fdmde1mk6S+ku2UwHVtXm0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Qa8m7qLHLmGQEO8MMZ9DGdiWuSmGk5FeVkuseIsnlakAnviWsGuiExJIdrcHB5B7ViXW/huZbD0Tgj+39/xMOBRrLI6BsYYIqR8MfzerkzPRe76JGzzMWdFrmVO9HVXG6mNvrbd3fWO199FNKsV4G3rcGcQCfkOUh3VcWJTsZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLhakqJg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715974971; x=1747510971;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vKKeJE84GjcL1kTEGVbp0Fdmde1mk6S+ku2UwHVtXm0=;
  b=NLhakqJg4fki1yGKXZNUvRvgI7ct2DwWxoGONB0S3nsvC3xLWzDSdzhE
   fCjyVev5cRmqs4yv/btNNAvlHBW6z9ZG5HRNq1e1oSVOgkG6SJvG9x2/q
   6iD0U7dgISZnHcvE7yiIYyQFwZDGezxpy0tl3kyq6om3uMhNmN3j3E705
   gKSHHhFWfXO1Syl1NomcQrXRDQiqlrASWKCI8wsxxe4plhG88gxh6MRRq
   xd/4C5MRjzrvEwLpe05ETn8/3Bdp6megraPj39agncktbAya5+whLkzCQ
   hSj390Oz/ATDviHuCuXPqHo9Anc0892/YVuIRKEnVFOcFbAg6aTqJz1Rm
   A==;
X-CSE-ConnectionGUID: 708vMxORS8qfTW8wolVX5Q==
X-CSE-MsgGUID: 4SzJwFrPQrqITeXHZm0NoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12284438"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12284438"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:42:50 -0700
X-CSE-ConnectionGUID: U3HfcRuzRt+XAIE/veAGoA==
X-CSE-MsgGUID: 2bHMFqiMQc+JlFNJfBKgxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31877128"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 17 May 2024 12:42:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4BA331F1; Fri, 17 May 2024 22:42:47 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] spi: gpio: Convert to be used outside of OF
Date: Fri, 17 May 2024 22:42:00 +0300
Message-ID: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver to be used outside of OF and a couple of cleanups.

Andy Shevchenko (3):
  spi: gpio: Make use of device properties
  spi: gpio: Use traditional pattern when checking error codes
  spi: gpio: Make num_chipselect 8-bit in the struct
    spi_gpio_platform_data

 drivers/spi/spi-gpio.c       | 66 ++++++++++++++----------------------
 include/linux/spi/spi_gpio.h |  2 +-
 2 files changed, 26 insertions(+), 42 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


