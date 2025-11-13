Return-Path: <linux-spi+bounces-11182-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFDFC5669B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A4F64E1248
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1FB3314D9;
	Thu, 13 Nov 2025 08:53:38 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C6286405;
	Thu, 13 Nov 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024018; cv=none; b=c8zjixQHPaMqQPH+T6cNTITPiE4UBpsYKvg+IQj5ixVYf90WP491f73jHbnqvVw01Jd0BMdZghgnj/gGvQ79VbDDdKYb0zL8k3M4rjeCzXUNu/Z7zofngSjty7P2tVBv1EyCg+rorS+kADcIEGoAtLmiMbPxehvZEomVbW+JGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024018; c=relaxed/simple;
	bh=mGv89sVzXiRXV52S5ABIfy4jbiv6TAiW57W5EOhI76w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FyOdqeOEJCChRXZxZNL9a0pDw61vwsCEO6+wUt/OQu2JDu1NMUQSyADAyUrnkKEFET/3muny5O+AXyQJi1u90Ir7oHproTmGE8KaqcGwa+rXsr29JRlDJKdnPqrgkg4V+Q0jUjPMkBtcgW/z79beuCByjHloaSW/CnAcipZPBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 13 Nov
 2025 16:53:33 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 13 Nov 2025 16:53:32 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<clg@redhat.com>, <broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/4] spi: aspeed: Add AST2700 SoC support and Quad SPI handling update
Date: Thu, 13 Nov 2025 16:53:28 +0800
Message-ID: <20251113085332.89688-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series adds AST2700 support to the ASPEED FMC/SPI driver and
bindings, introduces 64-bit address compatibility, and improves
Quad SPI page programming behavior. It also implements AST2700-specific
segment logic, where range adjustment is not required because the
AST2700 SPI hardware controller already fixes decoding issues on
the existing platforms and adopts an updated scheme.

Chin-Ting Kuo (4):
  dt-bindings: spi: aspeed,ast2600-fmc: Add AST2700 SoC support
  spi: aspeed: Enable Quad SPI mode for page program
  spi: aspeed: Use phys_addr_t for bus addresses to support 64-bit
    platforms
  spi: aspeed: Add support for the AST2700 SPI controller

 .../bindings/spi/aspeed,ast2600-fmc.yaml      |   4 +-
 drivers/spi/spi-aspeed-smc.c                  | 107 +++++++++++++++---
 2 files changed, 95 insertions(+), 16 deletions(-)

-- 
2.34.1


