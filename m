Return-Path: <linux-spi+bounces-11633-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C582EC8FF53
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B441E4E2293
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0E73019D1;
	Thu, 27 Nov 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYWyquNE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AB2C3757;
	Thu, 27 Nov 2025 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270037; cv=none; b=C9tX9mQVvOI0A09Ma+gg8qPSclfJ3dwXT5207rzU1D0e3J3Y/XLdMG7x1QqCOBh0HesFCpXxIjqBp/nICKyk8cCIzJf56RgQ7LxTOJZEP1HwtO4DYI74YJVxVAHiOmJEZnr6pKs/Ago6Ge0+0ixqwAa49R64yKJO1c3A3JM/S1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270037; c=relaxed/simple;
	bh=WejVC7OasaaC3aO+LqcYVQswYBmRhUAqysaoABJy84Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpHUPTSCKPqSJaceMnqzuwBx/fbrgAxcXxsLJUkG9AN34zeWy2R4xTLg4LLpqdp0B6Fs+XSskg3jEJYVIIQgpQ4d7FyhAdhcyg8oN8jEXq+Efb29zM8SvlM60YMHqE0GP/TeCspc0q/QOYQA2frn9eOCewnJHhbvv7nI39sR6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYWyquNE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764270035; x=1795806035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WejVC7OasaaC3aO+LqcYVQswYBmRhUAqysaoABJy84Q=;
  b=PYWyquNEnJQdR3pAOfK23mNu10OCCLOWFNZ9PqFTtH/rgLGM5EASyGQo
   m3IvhClrl6lcgRx4f5WSyQMt3W+AE9kmFLcI5Bex7GKmbVav6oB3AIjcm
   2xJAYjQaLI5U8HpXv3kX8xE2T1nbuxX/cddG5sg+krPel6RvLEbQn4lSS
   iuvlokNdxtcrpi5ILr33+HMme/aHjByncZjNfsXmLZdwD00fjsxooZkAF
   GU0Znw6OxbWsAnMZbYX+6kIiQZqSYjpdFt6fZb4SnXWQAKt/wYyVvx5RC
   aTz6eWgcPWFlA+i/dmiaqJYlPdtGq59yCCaZb9ju+aiMUCl/YHBirF6dD
   w==;
X-CSE-ConnectionGUID: BpuQc44OSkqOJjEgh5oILw==
X-CSE-MsgGUID: wZkEzoItShSv5HmxcV8/SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="91796252"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="91796252"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:00:35 -0800
X-CSE-ConnectionGUID: aZDhr22VTcuSK4iVwy+XWg==
X-CSE-MsgGUID: /0/OhDTXQhG+J53PjS0RZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="216645898"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2025 11:00:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3664C9F; Thu, 27 Nov 2025 20:00:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/6] spi: microchip-core: Code improvements
Date: Thu, 27 Nov 2025 19:58:57 +0100
Message-ID: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


While reading some other stuff, I noticed that this driver may
be improved. Here is the set of refactoring and cleaning it up.

Changelog v3:
- collected tags (Prajna)
- restored dummy read in TX-only transfers

v2: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>

Changelog v2:
- dropped device property agnostic API conversion change (Mark)

Andy Shevchenko (6):
  spi: microchip-core: use min() instead of min_t()
  spi: microchip-core: Refactor FIFO read and write handlers
  spi: microchip-core: Replace dead code (-ENOMEM error message)
  spi: microchip-core: Utilise temporary variable for struct device
  spi: microchip-core: Use SPI_MODE_X_MASK
  spi: microchip-core: Remove unneeded PM related macro

 drivers/spi/spi-microchip-core-spi.c | 95 ++++++++++++----------------
 1 file changed, 40 insertions(+), 55 deletions(-)

-- 
2.50.1


