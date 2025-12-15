Return-Path: <linux-spi+bounces-11885-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB6CBE0C1
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 14:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 533813006991
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B088331A61;
	Mon, 15 Dec 2025 13:24:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835622FDFF;
	Mon, 15 Dec 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805065; cv=none; b=WKDxEFuEhFVPieUmrYGj+AqVXy0KOQS7UWO2jvJ/ab4oNd11dRYlBxdKiE4Uru6vCmGVcQbPESCtt0v5Fwltk4UlELrX87C+pWW2g5oyUEZ4tzLK+tmm2VKuagzNkpzLH6eX7V7hRmg8kAyN/3WzK9YxTXtA5EjFtDkDjGiW+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805065; c=relaxed/simple;
	bh=7/S5AKF02AmhC5gJx2S5+mzLVcttn9WZFq3q71e3L4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhef6g2BEQLqK0d1AA3kCX+1RdVsP0XSmSCBfL/p9avGFc4tVoFNRFeJovhFj81oBokcG2uj+d0zMIEFOaf+pCCyuRX/4AZtmdhyA0hMk6R3ykV7ov4pm9YXLbAcp7xcQuwQgOhanVjz3A7GZSCiH6DWzlS1HWGQ7n9Vvh0cbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 5BFDNvlP076730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Mon, 15 Dec 2025 21:23:57 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Dec
 2025 21:23:57 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V3 0/3] spi: atcspi200: Add support for Andes ATCSPI200 SPI controller
Date: Mon, 15 Dec 2025 21:23:46 +0800
Message-ID: <20251215132349.513843-1-cl634@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 5BFDNvlP076730

Hi all,

This series adds support for the Andes ATCSPI200 SPI controller.

Changes in v3:
  - Reworked the DT binding to properly describe the compatible fallback
    relationship, defining "andestech,qilai-spi" as a platform-specific
    compatible that falls back to the generic "andestech,ae350-spi".
  - Renamed the DT binding file from 'andestech,qilai-spi.yaml' to
    'andestech,ae350-spi.yaml' to match the generic fallback compatible.
  - Updated the 'compatible' property to use a 'oneOf' schema, enforcing
    the fallback requirement for the specific compatible string.
  - Updated the MAINTAINERS entry to reflect the renamed DT binding file.

Patch overview:
  - Patch 1: Adds the device tree binding documentation.
  - Patch 2: Add ATCSPI200 SPI controller driver.
  - Patch 3: Add MAINTAINERS entry for the ATCSPI200 SPI controller driver.

Comments and reviews are welcome.
Thanks for your time.

Best regards,
CL

CL Wang (3):
  dt-bindings: spi: Add support for ATCSPI200 SPI controller
  spi: atcspi200: Add ATCSPI200 SPI controller driver
  MAINTAINERS: Add MAINTAINERS entry for the ATCSPI200 SPI controller
    driver

 .../bindings/spi/andestech,ae350-spi.yaml     |  85 +++
 MAINTAINERS                                   |   6 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-atcspi200.c                   | 680 ++++++++++++++++++
 5 files changed, 781 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
 create mode 100644 drivers/spi/spi-atcspi200.c

-- 
2.34.1


