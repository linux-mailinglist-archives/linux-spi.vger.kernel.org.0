Return-Path: <linux-spi+bounces-2791-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A058C08CC
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 03:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799882818A1
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 01:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124213A3E7;
	Thu,  9 May 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y4BJAy+6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721F13A245;
	Thu,  9 May 2024 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216754; cv=none; b=e0R9ZCXfhEUAWwnUl5oHr9a1QgdC9pnICwBKoneyAln7nkFUNkuwj1V6bNmzpt5ZEuJ8RBwhD4/Nu+LvqHt51w8S1NzYsvC3tKY/VR+SA12c11GiS9hH4kyBMwU3bsmd8jNeKkO5LgCRB45jNCvPFpTqDizJqxa6QMBd+/u5eoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216754; c=relaxed/simple;
	bh=aWL989HshbaXjzBpmW01Jn8rCGdyHquMhcGQgvpaYHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ozKjqRdMW5fK4QyygEXIXY0rd9zxiN6dvXQK54FN0F1Jx3TmYSr7kZ4Hhc3iZwG5xILZA507r6UageNN4WQq6lcMv47LFOdGufiGXhOpYITkrnUqiO+fdKSIfm5azIVwFkVsI0jN3thD6I4bG2Zq66Tv03NDfvc6l58/4jYxiIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y4BJAy+6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448NZQ4t003003;
	Wed, 8 May 2024 18:05:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=1ziXM84v
	wkAQEm9wJoTxhPmS3BttgwdI8/7OI4KfSvU=; b=Y4BJAy+6wd46jjOX8Dny0nyf
	5kpBFh74jaupX3nTYylSKFzGQy1XNQvUZwxaGgufEfPoyMqDYXhfgcUs3C5Ye/0O
	WJmNdXneyWVoe6tpYMqV6GFS8BbZ+ZDCeHQO3pYHsyukrpl21HhHlkFL8lYBGQJ+
	znuW72ipzrT1kVNdb+X4mOHyVfA9LB4jc2d/2D9PDVgKoUZv4MUMHoj/OAPOW0Tu
	n+19cRzixvpIDduO4JCaw0rX91vVu2npK89YDx72wizZie2vw05ClZ9lcNBD8SqL
	pQz5HnOCCJ3X8BPpL53q2Svf6GxdV5ANfqv2uBt03nfxzwOiHdDIiG9r5lvrwg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y0b2d2g0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 18:05:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 8 May 2024 18:05:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 18:05:46 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 403375B694D;
	Wed,  8 May 2024 18:05:46 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v4 0/5] Marvell HW overlay support for Cadence xSPI
Date: Wed, 8 May 2024 18:05:18 -0700
Message-ID: <20240509010523.3152264-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Vi8q5V1-Aj62z6Zy3deNZjySo-1wVNzf
X-Proofpoint-ORIG-GUID: Vi8q5V1-Aj62z6Zy3deNZjySo-1wVNzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_10,2024-05-08_01,2023-05-22_02

This patch series is adding support for second version of Marvell HW
overlay for Cadence xSPI IP block.
Overlay is HW change made around orginal xSPI block.
Overlay extends xSPI features, with clock configuration, interrupt
masking and full-duplex, variable length SPI operations.
All that functionalites allows xSPI block to operate not only with
memory devices, but also with simple SPI devices, or TPM devices.

Changes:
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

 .../devicetree/bindings/spi/cdns,xspi.yaml    |  78 ++-
 drivers/spi/spi-cadence-xspi.c                | 623 +++++++++++++++++-
 2 files changed, 668 insertions(+), 33 deletions(-)

-- 
2.43.0


