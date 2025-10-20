Return-Path: <linux-spi+bounces-10724-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F338BF1EF4
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E21A44E21C1
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723E1218AB0;
	Mon, 20 Oct 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoVWyx+F"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C0226CF0
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972060; cv=none; b=Twds1vr3Np1i5BGAwfvMn5YMFp8Nt30kCKcM8MCwe0iRVb8gLRpW93mEamL/wC1v3aVHEVvsza9REjjF8ysDAumMUl0qvVWjyOKuHaW3QkhmC4UJTWr6biu0q7FhEkOHRVtWpmZlU9RAVrlkaQdBSV7lmjckyVmndzwLkw5nLxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972060; c=relaxed/simple;
	bh=4oWWtwEIVuiY4xQcn0JSvW+7NZElQ1ee74MTtGvFoWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xxgoy8MzWCAjchxfLzVH3Hkbpzquax/BheGDYJgSmXoLHkxb+P6WOE/s7b5QiiyfnYrilW9Bk76s53Gp+cf4/kmRJWSiZBrsZn9TwdvBWT8A13etS0fXsFy6jK2LDo8egG/pORmrRdyA9y7wAWClwUFNHFpxBvGhL77XxgbhgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoVWyx+F; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760972058; x=1792508058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4oWWtwEIVuiY4xQcn0JSvW+7NZElQ1ee74MTtGvFoWo=;
  b=NoVWyx+FAVwmG1WDsGi/0KH9z9MsT19uNjv6wDW9zjVhVS48ecBi7Js1
   L0xfRYvoYZEeBd159iW9/i8cPT9ENkTR/rgFzJ0YtNtaPnK3xrjZ+cnsZ
   0UocpJOWSZb4lxjTgNUvSxmKI5tBV6Xce/qb6mc5h8WZR+BPKN2UnDSGu
   UoC4lcxywhv7WERTyTGb2jiOuWBw+ishsG21VyzCPXkqxRapGipqi19Y5
   V6Vk+Y+f/9veH8yxcoZM68hBKPkhiCtyN9xDHrIYEy+0KLtEe355RTgMA
   MHalsOAVpa0WoPjRn0Yr8lhOMM+aibEgwQzm64yL1J5ijeIRBUePoPgvN
   w==;
X-CSE-ConnectionGUID: Htzd/aUsRNWSlhNHFsvXgw==
X-CSE-MsgGUID: +KVbLMWzSFKG9Y2uv8z2Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63006638"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63006638"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 07:54:17 -0700
X-CSE-ConnectionGUID: MsthhrYxRfunFL1kaP39YQ==
X-CSE-MsgGUID: 5SUWQMWUTD2gWN7lSYxyJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183756359"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 20 Oct 2025 07:54:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6896895; Mon, 20 Oct 2025 16:54:15 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/3] spi: intel: Add support for Arrow Lake-H and Wildcat Lake
Date: Mon, 20 Oct 2025 16:54:12 +0200
Message-ID: <20251020145415.3377022-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds Intel Arrow Lake-H and Wildcat Lake PCI IDs to the driver.
Also add support for the 128M component density that is needed for bigger
chips.

Mika Westerberg (3):
  spi: intel: Add support for 128M component density
  spi: intel-pci: Add support for Arrow Lake-H SPI serial flash
  spi: intel-pci: Add support for Intel Wildcat Lake SPI serial flash

 drivers/spi/spi-intel-pci.c | 2 ++
 drivers/spi/spi-intel.c     | 6 ++++++
 2 files changed, 8 insertions(+)

-- 
2.50.1


