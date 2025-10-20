Return-Path: <linux-spi+bounces-10722-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD330BF1EFA
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25DB461C21
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBB1514F7;
	Mon, 20 Oct 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIAIaiHI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E4225397
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972059; cv=none; b=gPdZD4rMN7pyga0PD7/QI3m5ubBkO1Boi9Njspw/hDZHqfYbK9kNPmt4+CJuoraXwQmLXxYOH5xL9AoH8rP1dW20XsC6gM0X6qyoSedpBPAuNGfTwX5e7ZkGW5wzhUuvJaT0SXsLDangx0jdspQWZK4bzWbRXgN6eh9Qs0hKdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972059; c=relaxed/simple;
	bh=SEfjQnhDDUPHQ1n3XwFMDghRVeNnJhPozAOgbFqTEak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDZ3hLs+Z0u/0W+n2SIuxVV+QvWKZdogrjsxxMZoYP3uFNMgN/uNyspf4o1mjiDZ77IUyOzBLsOwXjpXwK9AG1/Z/3GY8iu4dooJuFE+ClCvhg9c2sNzfg2Ae52t6lxejZJwzBGvgy1kaIFso8bLoBARxmqb3TuzlHCB2QRB3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIAIaiHI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760972057; x=1792508057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SEfjQnhDDUPHQ1n3XwFMDghRVeNnJhPozAOgbFqTEak=;
  b=UIAIaiHIPm1nA3ihpyKLsIk3sOUQTZza3k8xbYRWyxyS91gWCu7yUIYt
   v0F8Aftna04vokZ6C0oGeUkI1lQxGIIVwlP0ynisaNS1A7trNfOXA5R4v
   27R6C2DwOt+Z30oq9kJz0fo/mgBjHuXtf0ehmDHQ6o9rY24I/za2iIdX5
   1hs1i+2Ov01ARUnIhqVDM6bRkQu1dn8NAgcIvIe5NrMdQYkDa1VU1shzG
   LB+QTsQrBgpUZy91ySloiUD3GQPmJ8pD5Xe7T++kUb7QCVq2knRV1EIL9
   pzpGHczcUr97PTk21CzJsTWbKE9rVQUanUNZSC4afdairB72zSmbOviOP
   g==;
X-CSE-ConnectionGUID: 8dD8sHyNQWy3RYi4lSxIww==
X-CSE-MsgGUID: MNXa2T82RKOf5Du0SzqVUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73692614"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="73692614"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 07:54:17 -0700
X-CSE-ConnectionGUID: TBCsKp0lSUaVUsCGg2zT/A==
X-CSE-MsgGUID: NMTUex3sQpeUL9ih58daYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183190258"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 20 Oct 2025 07:54:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6EC1797; Mon, 20 Oct 2025 16:54:15 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/3] spi: intel-pci: Add support for Arrow Lake-H SPI serial flash
Date: Mon, 20 Oct 2025 16:54:14 +0200
Message-ID: <20251020145415.3377022-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020145415.3377022-1-mika.westerberg@linux.intel.com>
References: <20251020145415.3377022-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Intel Arrow Lake-H PCI ID to the driver list of supported devices.
This is the same controller found in previous generations.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 4b63cb98df9c..49b4d3061197 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -79,6 +79,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x51a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x5794), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7723), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
-- 
2.50.1


