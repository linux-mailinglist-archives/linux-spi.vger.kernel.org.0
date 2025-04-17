Return-Path: <linux-spi+bounces-7635-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF0BA92142
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC461B60101
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FA253B57;
	Thu, 17 Apr 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1fuFtYz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32308253B46;
	Thu, 17 Apr 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903204; cv=none; b=IEJndcAgz7xbKj+eJUKzlJv7O7W3swTOESHlR2wu0vsJ4gw3Gj9UghLYUEtYtBo12/8jy8/cG4c9eE9sxf8uFmRGeBi0AQo/SkPfsEkIops1cPzBBCGpDpCzm5BA+jF/luXxQKH86LSh83BPnQt7TgKaC9YnpWGS9fEVBtuatCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903204; c=relaxed/simple;
	bh=iF0MFNdSqNf+d8zIASv5RomdNLV7tGRC5qSAGQtei6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyu5/Tz6fmqGsCWfnHI5/yI+FHSB4oFHBUx92RDXqd11O3ER6EkuqxUAH84cZZDt/v+7gFKTPVtykiLC8YPaiCMb3Z/NTQ5Z+/D6UK+nx2OhU9EGeOaJ57wts4ownexDmw1gAP2coWC7fJ//ugx38uKgHOZ7JXK1934mbM9bwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1fuFtYz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744903203; x=1776439203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iF0MFNdSqNf+d8zIASv5RomdNLV7tGRC5qSAGQtei6s=;
  b=l1fuFtYzUWUNuuiOqWUVDCRLPlE8aMXf5SRsmbw19g66cpGbrEN51VDM
   DUzshMKpTlKYiF2qNVLepYBmsf2QbzCEwu7eKtHTB1SyBIdi9jCEZL1Zu
   /nf/5zrQKN4aWvGkBGTxJSL5BbhEk39ml025DwbOQYB7d6YAurJyqbnpq
   HAVoyhoRzfvL/a6ss5ICFGXTDsMF/GuvFSulqWcyX9znZHjpWL8udnLhL
   DsttNvkMpWd4Q+UqZTZ9P1RhWJ5sTU1Z263WRT196I9HIwx/FHtcIY9ZL
   nuHhep3tTnks/GBcoj2kVKyKbbOKFSRa8xYiWQwRVD02VxjGmGKYzPDaQ
   w==;
X-CSE-ConnectionGUID: JUsv5irySo+n04BaI1rMjg==
X-CSE-MsgGUID: sERTl/3+T6meWxZX8GWjGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46625080"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46625080"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:20:03 -0700
X-CSE-ConnectionGUID: Tlt1Fk2nQ/OQgo63fGVrxQ==
X-CSE-MsgGUID: pODSp18WQcO3fPjhgp67OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="130689869"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2025 08:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E2EC75D9; Thu, 17 Apr 2025 18:19:59 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] spi: Introduce and use spi_bpw_to_bytes()
Date: Thu, 17 Apr 2025 18:17:51 +0300
Message-ID: <20250417151958.490174-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently in the discussion with David the idea of having
a common helper popped up. The helper converts the given
bits per word to bytes. The result will always be power-of-two
(e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
More details are in the respective code comment.

This mini-series introduces it and replaces current users
under drivers/spi and we expect more (and possibly some
lurking in other subsystems).

Mark, if you okay with the idea, please, make this to be
an immutable branch or tag for others to pull.

In v2:
- improved examples in the code comment and commit message (David)

Andy Shevchenko (2):
  spi: Add spi_bpw_to_bytes() helper and use it
  spi: dw: Use spi_bpw_to_bytes() helper

 drivers/spi/spi-dw-core.c |  2 +-
 drivers/spi/spi.c         |  2 +-
 include/linux/spi/spi.h   | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.47.2


