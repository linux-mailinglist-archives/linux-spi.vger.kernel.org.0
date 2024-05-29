Return-Path: <linux-spi+bounces-3136-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22528D40EE
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 00:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648091F235AF
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDBE16B745;
	Wed, 29 May 2024 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FstAeVDc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE98BFF;
	Wed, 29 May 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020037; cv=none; b=roSojNUjaodThHDjGsDbmEZHOGOminE26Z3PI4t8lG5DIPfl6mrWza9O5MlKatDkzi/J9ZGzk1MIxDelWS2YUI9dW1vdkTdISCFjveCPL/ouwqj4IC7xSLlm9yhYJakmkxajO3+lSxN4DN0w3J5i4IcDwqPrYrJ58QT9qXpzgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020037; c=relaxed/simple;
	bh=YjCleeYAzSR7zQt0aAH6p3nhdoDWeahE/LiAam2Xqcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Az4JKos+WhfNY3H4BDDBR+0WZI1n4gX6BI/wXjxWnJQiohzg2w4cnkqm+B+PP61+odmxu51lHg0mSDiy7PQe6kzlsx979KUK19Usce9hfeOnmizhRM5U2WLs/t60NzF3Kcb2PXTRozfvdVE+eiyRKKMB6QIP3LEL99cuxlTtMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FstAeVDc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TIdMZ4015558;
	Wed, 29 May 2024 15:00:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=7+zfQi8FKQNx7QJP8h2QDR/
	Pi8jvaeO598p5vCvJuhE=; b=FstAeVDcTfHhHF8sI26OxZ2OD3NvT0xU4zIkthJ
	I+3dZtgAQ+mKL+KFa28JHaAvdBh+SBt0B4bt+ajBBh4JhgceQOiLdsna9FmQ0zV7
	p1bjTGj4EiG3AETasrIpnjSYwyWUafeUao5IARNGiuBeGemX0TSkx04htsPiB2na
	AvYjI4L6QRFpnoNU/W4+8tsXWuTjBD8JrRJdKBoUTsUNIfu0cTnnEBWVqPKWDuiu
	Oaz4kA31ylKD7unLqgsfPiSwQjso0hAjuG6OGi2SMma4PIbjC3SPOlCsvjVVqc4d
	Mi6/wCN+ImExDiJ/LkcC2l96dgO9I6otyh5izzAE6elHXzg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ye1r12k8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 15:00:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 29 May 2024 15:00:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 29 May 2024 15:00:29 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id A42475B694A;
	Wed, 29 May 2024 15:00:29 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v7 0/4] Marvell HW overlay support for Cadence xSPI
Date: Wed, 29 May 2024 15:00:22 -0700
Message-ID: <20240529220026.1644986-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LqFaT8eXZad8CkyddjKZAW-l6H9JB0eP
X-Proofpoint-GUID: LqFaT8eXZad8CkyddjKZAW-l6H9JB0eP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01

This patch series adds support for the second version of the Marvell
hardware overlay for the Cadence xSPI IP block. The overlay is a hardware
change made around the original xSPI block. It extends xSPI features with
clock configuration, interrupt masking, and full-duplex, variable-length SPI
operations.

These functionalities allow the xSPI block to operate not only with memory
devices but also with simple SPI devices and TPM devices.

Changes:
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
 drivers/spi/spi-cadence-xspi.c                | 598 +++++++++++++++++-
 2 files changed, 615 insertions(+), 15 deletions(-)

-- 
2.43.0


