Return-Path: <linux-spi+bounces-11193-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 78845C5C818
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 11:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4502A35D210
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB313A258;
	Fri, 14 Nov 2025 10:10:54 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FA30AAC1;
	Fri, 14 Nov 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115054; cv=none; b=qHaShp5XQlLFm3Hxf06UFv7riRy26TGL53KGlHCqFveo/lvCHurpzyaVFPmnNYc30TbYDXqC0D+rntAFvwTj2XmA8z6RBVqxuh7jaMjl+D4ycoOU6L8MRPJeYjaVO2Lix8IrNg/tdqkh0MmD3n+u7RGuDhHIZgM41znzE/Z+f2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115054; c=relaxed/simple;
	bh=+SwaqD8Es6cBCi/E/K42IKpSZxBowjUGjaQu61NX95w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qaHVuCl3zMlu4fnguchipzzNhsGE+K29tl0t6Clnj0mrXSk0jEnvmpAdTS/MXy7WLewyCP37UtCRTGeP4rflUgS4KmSkHSe7Z9oK6MYxgIedbGaR6tRTCkXiY6wDUtbibQTFQ4gYXmYUp+nnwxTA5YiOcOefTiY4oVKE2rFj4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 14 Nov
 2025 18:10:42 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 14 Nov 2025 18:10:42 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<clg@redhat.com>, <broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 0/4] spi: aspeed: Add AST2700 SoC support and Quad SPI handling update
Date: Fri, 14 Nov 2025 18:10:38 +0800
Message-ID: <20251114101042.1520997-1-chin-ting_kuo@aspeedtech.com>
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

Changes in v2:
  - Some differences between AST2600 and AST2700 are described in
    commit message of the dt-bindings patch.

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


