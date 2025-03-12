Return-Path: <linux-spi+bounces-7100-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F228DA5E273
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 18:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09925175117
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E02571B1;
	Wed, 12 Mar 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HD0nQ+8t"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88924EAAE;
	Wed, 12 Mar 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800024; cv=none; b=rMDhLYbBucygxFkAdrYjEMz4ia3bmMqhGY1KnAWvjnr5fdCPSeKKpEtp42zBK+nc4fO2pkOgUMfyruFBPJJTrJptr7YTrKSrrq9x4UVnFDmg/QvgIiz4sAcwxi9o9Xi/SxfxJt0NBuvTEGHZ71lGjjemJZn5Vdqo5+CrPhvOqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800024; c=relaxed/simple;
	bh=Myhv0yGQQB3mIdLPFVgRi5RvxLh/5Iv2Tj7DlB+lz1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrHr5VAAAQic3dTSZXe4bRjjyNuli39DLrAoxreyqHLN6vkti3GUhZCRsuA+inw3J5UEuQDrZXdyDb7cE/d1ijOpFPByI5sS5FX/FFpcMF6Wl4qu10CzrxgkDJ5eCmgK6BJwlQhxCF0x1h1AQlIaYgRXbJA+9LMx2lQ1M9c5xpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HD0nQ+8t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741800022; x=1773336022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Myhv0yGQQB3mIdLPFVgRi5RvxLh/5Iv2Tj7DlB+lz1E=;
  b=HD0nQ+8tL35AKHrRCJddVxxjvtORl35xnVK9FbK+dbejJ2nKZqmNKTlB
   hMR0oEbWjARugKdtecgV7Zzvah6hW+GizH+RuISuMXnpouzLAw8d3XgOd
   3fVLQtPqkPTmRAgO1JTW+Jh7i7r9GvbAEhBoonwDb1PGHn8c5r7YLhNUu
   3QAq2Q43VWqISqZTez9a1PZdUpne9TuRqDdx13rSODDsfPnRyunWQaLP5
   +2+IQVG0GErQEBzBeVXu34ZWRFG46uGwlCGrY8fLW5U38BaFmHsKs5gn1
   IEM7dA09o4QUgZ5CU8fBKI4T+POl9B7/zR/xWCsxsFLVcYUPNHxTKCX7K
   w==;
X-CSE-ConnectionGUID: C+ExU6P4Q2mtbnSyUPOBKg==
X-CSE-MsgGUID: 8rMeH2MDSKy6EK0pcZk9tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60290607"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="60290607"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:20:20 -0700
X-CSE-ConnectionGUID: m+HNnOfRRwCILfckPUhv8A==
X-CSE-MsgGUID: KZZYwwkfSnKYumrnHVcEPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125769470"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 12 Mar 2025 10:20:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7D54E1F2; Wed, 12 Mar 2025 19:20:17 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Longbin Li <looong.bin@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/2] spi: sg2044-nor: A couple of cleanups
Date: Wed, 12 Mar 2025 19:19:15 +0200
Message-ID: <20250312172016.4070094-1-andriy.shevchenko@linux.intel.com>
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

Andy Shevchenko (2):
  spi: sg2044-nor: Fully convert to device managed resources
  spi: sg2044-nor: Convert to dev_err_probe()

 drivers/spi/spi-sg2044-nor.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

-- 
2.47.2


