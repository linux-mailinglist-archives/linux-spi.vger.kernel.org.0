Return-Path: <linux-spi+bounces-3098-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5708CFBB6
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8331C20C1B
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8DD56477;
	Mon, 27 May 2024 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fRFfKEc2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863895B1E4;
	Mon, 27 May 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799347; cv=none; b=TW3bNj12fydXS1V/E0DRI2L7tD8wCwZvMYV1sGYZ/jWuM5IDTMF0rrd4AU+C3P3A6vZvYLQh8vyiIyyJ6reyltf+EwfeeJ1CApuhbqbbx//z+zIjNpYKTjVuhtqEt/iJvMmegqwhlSbGM35wrTvpJBDxsHorFKeN3rHhUDh8Z60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799347; c=relaxed/simple;
	bh=wMke3pk+Q8Yc51ZnjrhVgZzI4yQg+J7H1u3uiOXwuRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XgF7IAtEwveMyh6fL8SPClSbPG/lnvzTlJL87N2y+MK/0PN5M3xuUkCIjYAyWjRMxM327v9IcI6xrWwoPy/Ze+I76ROWrwvBy7nyqe1ozI8o5+ysX3UtWncZblT1ajfU/iJ9qKjTQQIXw0yiK62/e7dqZBwYkV8N8fasX/4F6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fRFfKEc2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44QMfgE3013967;
	Mon, 27 May 2024 01:42:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=p9v7Sb3yf5TF805OLgl5nmz
	kISpwqYZ/JBbywfOH2Vk=; b=fRFfKEc2fR7QIUfu4vfe6OBKOy7jpsz1OjeOWZe
	C8fjLtysxk23C+JiVSyqVKdy+xsUw6UJ3HdHMImOViSn0HITsoSIsyS/L0UQYnIV
	OCML5prwnQ/OtLcga+1ksSerGBt4tyfRl7NkJGqbyunFeDnff0rSIEsv/FMqDxRY
	lRy52DlnhnVozwS/gCoXRD6u+mc2BypIbhgJCTf1xCMZr2Tw1rtDPjA/+4Xj52D8
	POzhf35mXYU8CbLAY+/MB0gI+yu54bV8py+TxUg1L4aLhSZT+bA0DYzi7x5qk/SY
	OcXNRraoiRomE/ctzTdBvo9egEJVPxD8f380cwf7Xdp9BoQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ybfgf4ky6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 01:42:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 27 May 2024 01:42:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 27 May 2024 01:42:20 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id DB9803F7062;
	Mon, 27 May 2024 01:42:19 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v5 0/5] Marvell HW overlay support for Cadence xSPI
Date: Mon, 27 May 2024 01:42:10 -0700
Message-ID: <20240527084216.667380-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TopXZG2da8zieySCJVTtbJv5MVMELtOR
X-Proofpoint-GUID: TopXZG2da8zieySCJVTtbJv5MVMELtOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

This patch series adds support for the second version of the Marvell
hardware overlay for the Cadence xSPI IP block. The overlay is a hardware
change made around the original xSPI block. It extends xSPI features with
clock configuration, interrupt masking, and full-duplex, variable-length SPI
operations.

These functionalities allow the xSPI block to operate not only with memory
devices but also with simple SPI devices and TPM devices.

Changes:
v5:
  Rework cdns,xspi.yaml file
  Reword commit messages
  Move mamory mapping to ACPI patch
  Use devm_platform_ioremap_resource instead of two step mapping

v4:
  Rename new Marvell registers to keep naming conventions
  Rename mrvl,xspi-nor to marvell,cnxx,xspi-nor
  Various fixed for cdns,xspi.yaml file:
    - Remove unnecesary parameters
    - Link register xferbase with marvell,cn10-xspi-nor
    - Move default values to .c file from device-tree
  Clock configuration optimization
  ACPI fixes:
    - Remove incorrect ACPI match table
  Added .data field to device_id, fixes for matching in ACPI and dtb case
  Minor style comment changes

v3:
  Removed all kconfig changes
  Added device-tree mrvl,xspi-nor tag

v2:
  Support for second overlay iteration

v1:
  -

v0:
  Initial support for v1 overlay

Piyush Malgujar (1):
  spi: cadence: Allow to read basic xSPI configuration from ACPI

Witold Sadowski (4):
  spi: cadence: Ensure data lines set to low during dummy-cycle period
  dt-bindings: spi: cadence: Add MRVL overlay bindings documentation for
    Cadence XSPI
  spi: cadence: Add Marvell xSPI IP overlay changes
  spi: cadence: Add MRVL overlay xfer operation support

 .../devicetree/bindings/spi/cdns,xspi.yaml    |  38 +-
 drivers/spi/spi-cadence-xspi.c                | 620 +++++++++++++++++-
 2 files changed, 631 insertions(+), 27 deletions(-)

-- 
2.43.0


