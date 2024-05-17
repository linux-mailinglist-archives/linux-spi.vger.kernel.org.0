Return-Path: <linux-spi+bounces-2924-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1678C8CEA
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A12CB22913
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593131411C7;
	Fri, 17 May 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqJ6o4sf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF5140389;
	Fri, 17 May 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974973; cv=none; b=WHvBeppmVqgzr1ncb8fCJ0ASppccfGHHoXP58Sfv6FwcbsTrOpu5Ora0jUG0wiGhr9lWJ/mx7SLBc6IjA3eql+13bk5xUIxrqCZ7yteBgyF7YEZzURNorZaVnMOpsrjc/3tBzEfWrXHasfUl1bsQV3DmXfn5VcLv/sw9MnIRpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974973; c=relaxed/simple;
	bh=T1kuw4kCQWu1DfL0XSLMFMWTgv2DAoA+X+Ligd/mQMI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTlUz6qyaszDeeVTA1ipZ5AmcHroFhMktJxJB5W9Ld4qv8HG6LnPkuo52enKOethWyRUtcDFFhL16jQJyqSkc5ejFA8/PFznZRrrhU6FFXaADB4phH+UQAcK+sBxQViTwkymhyft0eKje6uBf7iuS9M2u63KRArj2/DAFqn8wV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqJ6o4sf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715974972; x=1747510972;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=T1kuw4kCQWu1DfL0XSLMFMWTgv2DAoA+X+Ligd/mQMI=;
  b=GqJ6o4sfDzw+EX7tfWxPDqOVt+/ejxQUCWTJrnI61Mb+yNFzqwoP2ZNq
   bUl6ar8Gqv2JE+LLAx9IAJ473jmXc542QDTCuzQoc/XdllZuhs7wnjO/j
   nekBgSrcJDUQQQwvZvq2If5XSUdn80tW88AVaxSim0CWfo4WtDa9BUDaj
   4b+10raSbmk0qh9n8MY8h8ivFQ1+N6aoxxhM0X3pqYOeUl1cMqU/363I/
   pGoaxEut8i3lo2icDP11fccFcHrgSMpexaEyhMwq5WXgOimMCobqM0vxx
   ueTRvzSxu/nXbPZFFGJzH/QX+fua3iz4/66I9cT63eGnjQSn4d1R7KIg2
   g==;
X-CSE-ConnectionGUID: sal2Nk4GSIWnMTmWUsBqbQ==
X-CSE-MsgGUID: xSv3uM8VSfijCMYulG1hIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12284443"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12284443"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:42:50 -0700
X-CSE-ConnectionGUID: PLe1T2pqTAC0fd0MbVuRgw==
X-CSE-MsgGUID: zPPbqklARa6KYf38OCmlCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31877130"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 17 May 2024 12:42:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 786F644E; Fri, 17 May 2024 22:42:47 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] spi: gpio: Make num_chipselect 8-bit in the struct spi_gpio_platform_data
Date: Fri, 17 May 2024 22:42:03 +0300
Message-ID: <20240517194246.747427-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
References: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no use for whole 16-bit for the number of chip select pins.
Drop it to 8 bits.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi_gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi_gpio.h b/include/linux/spi/spi_gpio.h
index 5f0e1407917a..30f29df811a4 100644
--- a/include/linux/spi/spi_gpio.h
+++ b/include/linux/spi/spi_gpio.h
@@ -19,7 +19,7 @@
  * @num_chipselect: how many target devices to allow
  */
 struct spi_gpio_platform_data {
-	u16		num_chipselect;
+	u8	num_chipselect;
 };
 
 #endif /* __LINUX_SPI_GPIO_H */
-- 
2.43.0.rc1.1336.g36b5255a03ac


