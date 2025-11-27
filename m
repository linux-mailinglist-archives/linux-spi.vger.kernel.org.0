Return-Path: <linux-spi+bounces-11634-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC1C8FF54
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4AD3AB5E3
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9116D302161;
	Thu, 27 Nov 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFA7dQIC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB52E11D7;
	Thu, 27 Nov 2025 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270037; cv=none; b=Enk91FBONJoaJ2eA/QGuCawzH+Nd0uleEPr+WC6b86EbRlmYIM6LpkdJd8n35H4YS564RuYoV9I0LDKKkeM0Vv+6T/T4Bm9gqSct68WyOcSgnpfttwh6ZXPIUmGdI0zTl/mZOi4ue8sZAWc0XizmR+Dq+iY5dyKEjcLmegzj1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270037; c=relaxed/simple;
	bh=oYdB1GXPJJOqdeYXnfWfCep2w45kxF/iHqiuAw9Dd8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flrTo3My9L/YoJd2SjaI20zY8zsP3EwmZmhpKFA9mKX8d+Z9UrwD27YJvmR0TVfJKEx2m9ZyeQp+NXbUXTo0d2I0mwCYMRh4wf8smd4k21f7jgTSa+c+hakiyWnRtpLMWtjfGsySqtspC8Pk+laL7iBp7GfRZjTqoYh1VyH1NG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFA7dQIC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764270035; x=1795806035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oYdB1GXPJJOqdeYXnfWfCep2w45kxF/iHqiuAw9Dd8Y=;
  b=CFA7dQICEpW4TvkrnBAy1KElZj1e461RkmlZH/ILSxxAql8G8FQYNQ8T
   uQZnmzyqdtTBBpXGjPGSeawH+WLmzctYLpJsK9mcMFQYSG1V905kNLW58
   LhITWS2TwF1Q3duNoRaetyyElW2OodYOFknlvwXROjkuk95oqTfEZyKkN
   GPNVimUvsqvjGbxlQwDUNioE4AlIGUmbzQ4vi2kP1Qes0lnT7zaYZ2vfT
   hixw6Wqn2WgWUHNS6xYCbxGX1HnGOwVvrXNEDvfAo8QHU+dEaIqbsKI9l
   D+Uftr7ERZvz7N95ZPiaZQR9PHAqDq4udGMV397BYIwf/fooqalk27mhQ
   Q==;
X-CSE-ConnectionGUID: 6vSX+E05STWNxQU0OunJuQ==
X-CSE-MsgGUID: UNVNi81DSzG0BjU/+mpt9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66480310"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66480310"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:00:35 -0800
X-CSE-ConnectionGUID: NnNSyZSvS0SZFo2EAYehbQ==
X-CSE-MsgGUID: Zxggb9enT3SHj9/RnhR7tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193312322"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 27 Nov 2025 11:00:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 41A94A2; Thu, 27 Nov 2025 20:00:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/6] spi: microchip-core: Replace dead code (-ENOMEM error message)
Date: Thu, 27 Nov 2025 19:59:00 +0100
Message-ID: <20251127190031.2998705-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
References: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all, the convention in the kernel that we do not issue
error messages for -ENOMEM. Second, it's ignored by dev_err_probe().
Replace dead code by a simple return statement.

Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 439745a36f9c..fa6fb2d3f7d0 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -298,8 +298,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
 	if (!host)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "unable to allocate host for SPI controller\n");
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, host);
 
-- 
2.50.1


