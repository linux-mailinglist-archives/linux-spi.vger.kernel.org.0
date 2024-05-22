Return-Path: <linux-spi+bounces-3008-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5B8CC55B
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3813FB21334
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB83C1420A9;
	Wed, 22 May 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ady4lhI9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C041F17B;
	Wed, 22 May 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397828; cv=none; b=VCyZ04ztHIBIIalIb0sToPaxsxH/fu2V47BqOxnB/pj/IJhjeYghx+ZXJWofPwhmEqt25tPPQ3sCDVX/k9dz/+ho0irVLURst8chgqiJoabpk6XFYX/hbY0Z0OHF9dRmTpSVxdH0l5sF+2AOXhtAHiNtTtFe8QzY2yjp9hZG9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397828; c=relaxed/simple;
	bh=EDYiEPwBiLwANwrOE2xUCd+SiLuSIGHn2RhSnXDlKR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oaM6oRk1N7yTZlXgsP29CSYhHlo259BFL350NLaG9BR6D7+ejf4xkTNNFE03qpfJxn/fy7ORxvvM3k6NHg7gIuvxTx/42ccZ1ncMkuM2iT3TQaFhokCWfYhElzRAlbDu/hTa7DCVu/Q3VzT8K0PN3VRCDBZk3rk8NcYlPYdf1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ady4lhI9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716397827; x=1747933827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EDYiEPwBiLwANwrOE2xUCd+SiLuSIGHn2RhSnXDlKR8=;
  b=ady4lhI9LILHOE/0K4dY3959e1vgabz9sgJVbAQMAU7doEair+GpSXCT
   j58KU59s5jILKgwG8VMZWoF4ZfnJFXIMrPXmI3YG+EUcYtRqBfUDiUuCI
   FRsGW6loap3qfMSbX2PdXvDSLr8p8OEe2gZYUhU6nGeXvMNoSUUWb/Lkj
   B2+OG6ij+I4U3B4T3ccT+D7HEKwqm3WBocJbVDQljwgzY2775QDNwimSv
   9Uo2iH+G/Eo4wIEKEsEkT2cnQArVahra7CgiqUlL36uyRTNtzyvfS0c/x
   VxsXR3DJ17azOLzqLzqflD7Pxz6KK5AfOXxXdzQT1LPNdPghJCEk2HsOh
   A==;
X-CSE-ConnectionGUID: 5U8/LgfhRf27qev5gENk9Q==
X-CSE-MsgGUID: E4SF7rPmR9mlGI8f0of+Pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="35180060"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="35180060"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:10:27 -0700
X-CSE-ConnectionGUID: wcIOMKQ5RWKK0DxwWFVjEQ==
X-CSE-MsgGUID: uTyT67bdQPWk99Itli993Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38204819"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 22 May 2024 10:10:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 17FC3179; Wed, 22 May 2024 20:10:23 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] soi: Don't call DMA sync API when not needed
Date: Wed, 22 May 2024 20:09:48 +0300
Message-ID: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A couple of fixes to avoid calling DMA sync API when it's not needed.
This doesn't stop from discussing if IOMMU code is doing the right thing,
i.e. dereferences SG list when orig_nents == 0, but this is a separate
story.

Andy Shevchenko (2):
  spi: Don't mark message DMA mapped when no transfer in it is
  spi: Check if transfer is mapped before calling DMA sync APIs

 drivers/spi/spi.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


