Return-Path: <linux-spi+bounces-11165-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775E8C5078A
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 05:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0C31896326
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 04:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDDF19067C;
	Wed, 12 Nov 2025 04:00:57 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BF2594BD;
	Wed, 12 Nov 2025 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920057; cv=none; b=ZDxOBVZZlOa2NXpl9E5nuD7PEeiiDH7zFE8cZc9uhMxuUb8iKwBEMmy1B2cqmwQ5+DYzWawCamkZ7uNhxI6eko1b1mybz76hPupvlb2FYPHONTpdxUkBHZIBkv8D53klRzLpBWSrzNXyy4VfHDR8mArhDq76nQoGRm8daqybA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920057; c=relaxed/simple;
	bh=+JNw26AcRPzp8BFz4eGTyUjmcy9mhR+RkotLhCGBoHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QR4To5vvSWksGOujpgEl3fL7mazX0xuQyYfSAxz2NMz/P3QtXVNt95Couzj8Qw2r0LHGyIvyNISGnuNUq4XuXfbCo6Jf2BV80Y/Rl66ygiLWasdrzwoISQKrJ357pY5OB+OFEbVLQ/W69XV1kq4Mxp4KK80lVWBTjHBYz2l6MX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 5AC3mfNA061617;
	Wed, 12 Nov 2025 11:48:41 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 5AC3lmUT061394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 12 Nov 2025 11:47:48 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 11:47:48 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH 0/2] spi: atcspi200: Add support for Andes ATCSPI200 SPI controller
Date: Wed, 12 Nov 2025 11:47:22 +0800
Message-ID: <20251112034724.1977630-1-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5AC3mfNA061617

This patch series adds support for the Andes ATCSPI200 SPI controller.

Patch 1 adds the device tree binding documentation for the controller.
Patch 2 introduces the SPI controller driver implementation.

Please help review, thanks.

CL Wang (2):
  dt-bindings: spi: Add support for ATCSPI200 SPI controller
  spi: atcspi200: Add ATCSPI200 SPI driver

 .../bindings/spi/andestech,qilai-spi.yaml     |  84 +++
 MAINTAINERS                                   |   6 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-atcspi200.c                   | 651 ++++++++++++++++++
 5 files changed, 751 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
 create mode 100644 drivers/spi/spi-atcspi200.c

-- 
2.34.1


