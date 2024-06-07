Return-Path: <linux-spi+bounces-3349-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B060290088B
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654B12919E9
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24916196DAB;
	Fri,  7 Jun 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JKQTg3nD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4CF1922FD;
	Fri,  7 Jun 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773524; cv=none; b=LOllzED+bMmCj4KZxrLjJNRin5mftZ/RRqLxSY0ogwaSYxVh5zljT0XCSLr1URWBvlnmc5NrMQu3wdJXPQ7wjls8GT5SceXDSOE4tcfhrfxLuSil0+KV4n9rsFihfSnMMUsXU9cNPo9g1OYRKR0EKSmy4RJJMyEBiOw6xl9ZuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773524; c=relaxed/simple;
	bh=KoDPDozy9evErMPAUWLxm84r9sZ2z9AbSjfQVeXcjmo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VdqEbNIuLh0itLvJnpNG68GaVE4pkx6sQ1cShzkpEtVE4fESeoXmQpreefl2yC1sPw5Z/8kR95w0ftOFK5ZcYlv6+RcXHw2EX8QJx2QNH5e4QZuGXSrjHGc0YbTb6qyYGMSD+h3gAfX4RCzYCSka3P1wvX3o5wmYFfyCdGxAlXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JKQTg3nD; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457AEqoM014883;
	Fri, 7 Jun 2024 08:18:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Jj/FpZ4qEw41Rz5TmoR61vp
	31Vn5uSKlVlaQjgzfc90=; b=JKQTg3nD0iAMQiHhv3W+Rsw2SsBqRWyTt/Qhs7q
	56jyisE370gRugNiz3IvxTuwZLZAmSfzhKKmBWvYMc/QJZM0SxsWNNV6l5QjIiQ8
	ji0zgpeyJsMPb1DYF/KedINQ1tILai6B/26BnrwLclD3nYXy80N5Hx16t69AztIO
	YsKJLw5jjuORuNntl13YHqAMJIqnm1zXHxR5jXNHLXShxQDoZ37w/GzwSw+FmK5h
	z+9YRyaAtfcQnveAfG6pJI73YD2SYyCrw9A6/4dtFWQVfy00g0zklIDL/kqhQoJb
	ojggwaDaXSBQMScGHcn0cAg6Y3+/tumgbWQKqm1eWo+T7Rw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ym09ngx2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 08:18:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 7 Jun 2024 08:18:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 7 Jun 2024 08:18:35 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 3B1305B6922;
	Fri,  7 Jun 2024 08:18:35 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v8 0/4] Marvell HW overlay support for Cadence xSPI
Date: Fri, 7 Jun 2024 08:18:27 -0700
Message-ID: <20240607151831.3858304-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SVm8_Sv8f12TRrq57BywvqJouMAiC6FK
X-Proofpoint-ORIG-GUID: SVm8_Sv8f12TRrq57BywvqJouMAiC6FK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_09,2024-06-06_02,2024-05-17_01

This patch series adds support for the second version of the Marvell
hardware overlay for the Cadence xSPI IP block. The overlay is a hardware
change made around the original xSPI block. It extends xSPI features with
clock configuration, interrupt masking, and full-duplex, variable-length SPI
operations.

These functionalities allow the xSPI block to operate not only with memory
devices but also with simple SPI devices and TPM devices.

Changes:
v8:
  Rename xferbase to xfer
  Rework DLL reset, to return non inverted boolean value
  Rework STIG and SDMA status check, to return non inverted boolean value

v7:
  Rebase patches to latest sources, changes in "Allow to read basic xSPI configuration
 from ACPI"
  Removed bugfix, as it was integrated to next tree from v6

v6:
  Fix item order in cdns,xspi.yaml

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

Witold Sadowski (3):
  spi: dt-bindings: cadence: Add Marvell overlay bindings documentation
    for Cadence XSPI
  spi: cadence: Add Marvell xSPI IP overlay changes
  spi: cadence: Add MRVL overlay xfer operation support

 .../devicetree/bindings/spi/cdns,xspi.yaml    |  32 +-
 drivers/spi/spi-cadence-xspi.c                | 603 +++++++++++++++++-
 2 files changed, 620 insertions(+), 15 deletions(-)

-- 
2.43.0


