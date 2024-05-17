Return-Path: <linux-spi+bounces-2917-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9848C8A98
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0446A1F24F8C
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676F13D8BF;
	Fri, 17 May 2024 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGasy3Xc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02713D63B;
	Fri, 17 May 2024 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965872; cv=none; b=PuDny9CWdyhN+gSCOKj17Rhk8H4F5HU2IcqfSkQ+NIV7lfrXIaxLeTprGy5COYFDsjM5ohYfsBId080kT0HL+o6/nbhzECWxehNUWG6NT56E6ky9qolihmQ/3sFe4pXW+oPF3nHqU8KuF5e/AFFpIpO4ByWdOeYRw9imD6NwvPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965872; c=relaxed/simple;
	bh=Q39OZJ1/kqSWkZy2OroNdgyPzEqNTwwlwHlGAT9vlhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SW50py79uW6lXj6pisQ9iz6kh4943w3Hlmc5dygvoTJDqaRAxttjLD6bZ1tubAW+cHtugK4n//wyxACMU14NhUuf4bcH8UOAA63434d+CGwYJ5wtKzOzdSb6XLDnWsyujjr2fs6PPMF5iGHiorJgs91nGYilpS8x7UpB9tCNdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGasy3Xc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715965870; x=1747501870;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q39OZJ1/kqSWkZy2OroNdgyPzEqNTwwlwHlGAT9vlhc=;
  b=AGasy3XcJ+DtN/fKxzu54vNT0qKO7UmsFGqjNRqvfHgPCJsiXUmOJ0OP
   QN4kcKzVhuj1acpbjVtYqKPOKFa/8vHr5goVB7aArvlrCuxHe30S2tXLy
   ZEerPdC8buDVM4yHyaueolFilWO3nN2adUf0Dw5var/WsyoYNOFZIgdG/
   PoH7L7DAVVSCrtedW52cfhLC+KZGKRwmaQlmJ5jvF2y9OEahLfoEpSgbo
   Lj+3LOUUcBDcTJd0Pz7sBEx1qe1f+kMhcyTDdiGR5v9UXW4vxt3rBUJLN
   xLn5X6JQtREHt+DX0Nc9V3tai2SmF9/RG/RwdTQoeTlrMYvQ22Z6M2bQe
   A==;
X-CSE-ConnectionGUID: jywtw2a0SXGShE9NW3PdEA==
X-CSE-MsgGUID: Y18bQlQVRque+jnH0NwOgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="15985632"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="15985632"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 10:11:09 -0700
X-CSE-ConnectionGUID: ODBIwRM3QLq8K0mB4IUPEA==
X-CSE-MsgGUID: /C55syMrQheaD0v3/At6Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36272330"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 17 May 2024 10:11:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 42B291F1; Fri, 17 May 2024 20:11:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: pxa2xx: Move PXA SSP bindings to the correct folder
Date: Fri, 17 May 2024 20:11:03 +0300
Message-ID: <20240517171103.221856-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SSP stands for Serial Synchronous Protocol and has nothing to do with
UART, also known as USART, where 'A' stands for Asynchronous.

Move the SSP bindings to where it belongs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../devicetree/bindings/{serial => spi}/mrvl,pxa-ssp.txt          | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{serial => spi}/mrvl,pxa-ssp.txt (100%)

diff --git a/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt b/Documentation/devicetree/bindings/spi/mrvl,pxa-ssp.txt
similarity index 100%
rename from Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
rename to Documentation/devicetree/bindings/spi/mrvl,pxa-ssp.txt
-- 
2.43.0.rc1.1336.g36b5255a03ac


