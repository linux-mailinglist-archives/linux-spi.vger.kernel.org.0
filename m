Return-Path: <linux-spi+bounces-7604-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732DBA8B022
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 08:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896E6172183
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 06:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58C21CC61;
	Wed, 16 Apr 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsVv0/AB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83A1F416A;
	Wed, 16 Apr 2025 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784419; cv=none; b=kC6K0pkNHneYl00gNj71qC3NCS4BK1HzXZL6Uf9JSp0K399LGow4pbh788BWTiyYooLm5I8rN6uy33zzcLc49OWQuoawTn0CLGrKKrqYH/fJZXnwhQlEZzVRQB8yUo/L4nf1wqEYJpvQIhVrvxl/LZ0np+sn2pBrWFJL2dPjdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784419; c=relaxed/simple;
	bh=de7mb9bXqsW8hsV163Pv5fgjPWR8LwlkM2ImhAfhCjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ci0mhKMbApK1DzS1ZXcdnaYq3Sr2/5W3e4mOHGvHlcl/Fz+aiPh4dMb2dH7v49au6/Oto8imyOlqZm19jKlNrskFhJpZPPZT3Q/e7f7QQIuKfTJI0P6pmVIilc/5t5IhbwNkrTs73sj/Ph9eR90vCrEP224HgNzD+rfu+MVwx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsVv0/AB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744784418; x=1776320418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=de7mb9bXqsW8hsV163Pv5fgjPWR8LwlkM2ImhAfhCjM=;
  b=BsVv0/ABWXnC+t97F0BEQ+oCY7GlgiB8igcEPMoh1Iuv5+qbEIVk0sWX
   XDaBYrvLUppvYQbQRU/FbC6wbY6GRvdN94anIOEH8GIfOcVQZDsxF+C5u
   DwSjTFatMFtcmNtpzRYd6+NAr2VW8eBuEkBP2mmsZOpC/b2iDqz8HXawZ
   +0MmMzT35wsd8UtOC+NUAKYeQcL5SO7qLjV0QcyLmHsSGD8d+Nkdc+At8
   W1w/PI6YSGKoO7dq39jm8h39lL1RHnKiWylVYfYel4LJsII+lUBjXe0Rg
   s1+FHvv/0aKeQQgI6vdb01jMe/AHrc3kYpYow8xtd+DRGjttVowWgcNI6
   g==;
X-CSE-ConnectionGUID: o7w3+lUAQtqBV9AHhzyIIQ==
X-CSE-MsgGUID: gwEIC6cMT56dciy2MX6L2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="57683526"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="57683526"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:20:17 -0700
X-CSE-ConnectionGUID: QUzL/qA9Q8+3iHwji36pLg==
X-CSE-MsgGUID: Au+DYGunT0Ocssxqb9aonQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="167508185"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 15 Apr 2025 23:20:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 80554221; Wed, 16 Apr 2025 09:20:14 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v1 0/2] spi: Introduce and use spi_bpw_to_bytes()
Date: Wed, 16 Apr 2025 09:16:33 +0300
Message-ID: <20250416062013.1826421-1-andriy.shevchenko@linux.intel.com>
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

This mini-series introduces it and replaces current users
under drivers/spi and we expect more (and possibly some lurking
in other subsystems).

Mark, if you okay with the idea, please, make this to be an immutable
branch or tag for others to pull.

Andy Shevchenko (2):
  spi: Add spi_bpw_to_bytes() helper and use it
  spi: dw: Use spi_bpw_to_bytes() helper

 drivers/spi/spi-dw-core.c |  2 +-
 drivers/spi/spi.c         |  2 +-
 include/linux/spi/spi.h   | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.47.2


