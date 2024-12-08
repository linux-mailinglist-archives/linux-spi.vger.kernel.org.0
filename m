Return-Path: <linux-spi+bounces-5966-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95539E8791
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 20:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80661635CB
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5875189F3B;
	Sun,  8 Dec 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hG4/A0sy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8E76410;
	Sun,  8 Dec 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733687801; cv=none; b=C2XMyqpS+TXGi8j3eRyVv9AGjZDm8YWLydXfJtWesq8H9wohqOaGli8+VBMqv+CHufZIuOBgjxw0piKIGI4m5a3UiSx8heKzi+xBJa8LzMk2cq2tKJAqywaO07rYgxetjF1bWYQyn2E7d4a3+4EsnoVxJdXwDkTML4DRtJz6xr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733687801; c=relaxed/simple;
	bh=IUUSslXpFVtelC9S1+ob0x5Ylh+xyRY5IweuSNGEX1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aouduvFevipI2cEgpfNv8QQHebio0luX+31u29hL498jzzVJZTq7DegPKxDeKjgfbiBEPiR8pW6iOBUV0Ht06mOswG0jbUpfHK+h6lxJchrYYIC86ETszYf+pbheomn+/hS6CP7cgJpHV6oyVZCkX/DQnIotkYI0hBC55gFFeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hG4/A0sy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733687800; x=1765223800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IUUSslXpFVtelC9S1+ob0x5Ylh+xyRY5IweuSNGEX1U=;
  b=hG4/A0syThoGGEoMPH+pR3weoAHgDy9Xr0xFnbtAxP5s7OsfTxvReqUH
   qv9HZS3e+zsSx4dR+SykuechVqeOAFV/wwwLd11LjnsnhUaGgIHrc6nPS
   f2CQkyCyjwaB+9ZWwsn8y3ysF9n2oZ35xUjTsgwQysiOhqo4rgxgS1ReB
   WHmxO/a5mfTMJL/GS1qZ2l47esUAgDR9UnvHVOHlsCKWOPEcyCbh4d60Z
   vVrbcMe0OD2v9hT/bNK5ZlzY1xQqKmGY/iNcYtrcp5Woy6oDOwwz22YPb
   a3IZxW4eYQL/6N3wMDb7zlE+LdGD5XLPGW6A/9sS7eeSa0hkUlevDCbbF
   w==;
X-CSE-ConnectionGUID: sjrMXhFvQTuG1PFcW7iw0Q==
X-CSE-MsgGUID: 7Maha8YSTjuiht+37KN8nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="45384107"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="45384107"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 11:56:39 -0800
X-CSE-ConnectionGUID: l0Y3YxLqQmmWKylHjkAXIg==
X-CSE-MsgGUID: BhlL3sj6SjmwBDfiyWO7jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="99332655"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 08 Dec 2024 11:56:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F03E21FD; Sun, 08 Dec 2024 21:56:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] spi: Unify and simplify fwnode related checks
Date: Sun,  8 Dec 2024 18:03:15 +0200
Message-ID: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of cleanups on top of recently added change.

Andy Shevchenko (2):
  spi: Unify firmware node type checks
  spi: Deduplicate deferred probe checks in spi_probe()

 drivers/spi/spi.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


