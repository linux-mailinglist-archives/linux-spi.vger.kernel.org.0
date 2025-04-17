Return-Path: <linux-spi+bounces-7639-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F62A92168
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7297AC0EC
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA00F25393D;
	Thu, 17 Apr 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJTQRwq8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1819D898;
	Thu, 17 Apr 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903536; cv=none; b=mI0sPVdylOvGi+Ct//Ew27MPU2Xj5HNWUJuFPItjm39YgLuAQOUDhErnH5BnoJoGhYLf9Ojp0uiisZ6NkShr/F5A1bioSplvUucxAHd1MTA0FbQZTvFmmAnZ9fPhavHq34TELeVq7RClMjYRUZP857opX3gHBNvbnrXQTh6IA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903536; c=relaxed/simple;
	bh=0cNODjtMzQvTjxbraB134HV4rNt2CkUTWIKaRQZK7eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gh0J2pgf8iwL5h4p/BhBVaz+rlHSslN4HQvHFG3MPhxclEGk+ZON6gMr8n9SEqmA54JRchbaQA6ODpOwIyIh8cI0xNZG8AACv4rr024co3ETwz5t+pTQ7jUvnMnsfnqljCG4njLrcnM4e29hiQ9l2O4JvsY6MCrWxbF8euDU6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJTQRwq8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744903535; x=1776439535;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0cNODjtMzQvTjxbraB134HV4rNt2CkUTWIKaRQZK7eM=;
  b=YJTQRwq8kFtWKQ7T20+oeXCdDBVqf7itQSN8hcYWxBobrUIKNXFd9UMz
   zJfkZlsUIJybfTTss7aObptnlPJUivF0nEFDiB4VAVo1VpNCsOlRyoZMv
   kbjCx2WB++kfz/gYcFAO/3KoaddbUM6HRx0rCKYVQ/iUMtVUQzrr/5QC+
   +87atdcvLACVsJMsgMj+tVQ1M4qHwv2cnBTVBzQ29chV48WR+iuaIMxHt
   BQfa/nZFvPSvF5yLEYj/NDB/xTpV7Zqcp206lG/+CBCgFfz96ne2ai+fD
   uB7sFxVZ1Pr8D/nqNyKqqszXv1F3z2YAjK0ls9+0kek9fNJ/Xdi1kOJ/T
   A==;
X-CSE-ConnectionGUID: iIZ5SNiKTrCP1aN81CeO+g==
X-CSE-MsgGUID: lootWWIAQbGkZURLnJ9S8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57491905"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57491905"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:25:34 -0700
X-CSE-ConnectionGUID: +f1x/O7SS1GSEvPFwETy3g==
X-CSE-MsgGUID: qy7HJ4h/RUSPEq78f7rp+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="135688098"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 17 Apr 2025 08:25:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AF3215D9; Thu, 17 Apr 2025 18:25:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/2] spi: Introduce and use spi_bpw_to_bytes()
Date: Thu, 17 Apr 2025 18:24:45 +0300
Message-ID: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
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

In v3:
- fixed the typos in the examples

In v2:
- improved examples in the code comment and commit message (David)

Andy Shevchenko (2):
  spi: Add spi_bpw_to_bytes() helper and use it
  spi: dw: Use spi_bpw_to_bytes() helper

 drivers/spi/spi-dw-core.c |  2 +-
 drivers/spi/spi.c         |  2 +-
 include/linux/spi/spi.h   | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.47.2


