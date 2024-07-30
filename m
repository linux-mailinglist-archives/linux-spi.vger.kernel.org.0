Return-Path: <linux-spi+bounces-4082-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 751E294110D
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C071F240F7
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A48C1A0730;
	Tue, 30 Jul 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DQPK5knA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C218D4D7;
	Tue, 30 Jul 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339945; cv=none; b=UIt8D5ZiDtQ9Lf7HZ8WWsP3pGZlTRMMokWScbc/zeImE60kmi3HdqCSUBt01z24eP+IfTGazYpb4+RREKNULALE1ctyjweKLWONfdxMeDNXV6MTchGHMjTqaJ959y9lkSPjTWz7QsTkCXkfIQClRTPr2oudBq52fuSgBt46iJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339945; c=relaxed/simple;
	bh=I82S2mhSJS+Z0GItb6C3XmzanEjGnSvA4xFmeDw0tp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XfoAajibDq/VLmu7kzHH4hVea+CiDUusGmUP2BNCpS8mR0Y0qNtn0QRnToOLJZ5rbAVnf6XJv4hRwyOupIHwD2eMoHBLck1Lg4sCqASRZnTG6LQNI5mha1jEIWKBLfNQy+UTCLd1ZP1RHXMgCQgAkc1Efh+nWrkS78rAezsXXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DQPK5knA; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U7ucLN030420;
	Tue, 30 Jul 2024 04:45:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=F3bS0DEAvKVBCdXjr3S+8q/
	T3Eli4/+yRJ1XrOjQFJ0=; b=DQPK5knAvRlb036w+RhXjzL7Am0hREDGUQMCkzz
	mhUQmgFLFciZ4kEJSLljHscYN6ywur+GeDoPLkM1qWc8qBzQmo+Q5B/TLTX0Yr6H
	XTYoP5v3W+usNetzhi11jymyvVaOe/XrYs8ijxpEIIv7r7paVl4xJGLjUrYEIfbE
	hFi2Z4I8ZxNN0Vm5PMUmfTKpkOn3xocrEhIFJlwpB9Qlr4Lt88adZIRqq7L9017e
	nE8Rplw1SRdi3Rip6LvN/I7qj+eREKXGVkjCrP5l8NpybWjwGfYTiWab6iWBKyRU
	zabP7mYbOeO0reCIjJrq/kXwcoV45YhHlpzIyh8LhcO8Ovg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40n0dqsk96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 04:45:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Jul 2024 04:45:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Jul 2024 04:45:37 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 304235B692C;
	Tue, 30 Jul 2024 04:45:37 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v12 0/9] Marvell HW overlay support for Cadence xSPI
Date: Tue, 30 Jul 2024 04:45:24 -0700
Message-ID: <20240730114534.1837077-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mCtrfK1wkA72p6HK1kTyfP_E3BG0nqUs
X-Proofpoint-ORIG-GUID: mCtrfK1wkA72p6HK1kTyfP_E3BG0nqUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01

This patch series adds support for the second version of the Marvell
hardware overlay for the Cadence xSPI IP block. The overlay is a hardware
change made around the original xSPI block. It extends xSPI features with
clock configuration, interrupt masking, and full-duplex, variable-length SPI
operations.

These functionalities allow the xSPI block to operate not only with memory
devices but also with simple SPI devices and TPM devices.

Due to adding 64bit read/write driver will be limited to 64bit systems.

Example ACPI entry:
      Device (SPI0) {
        Name (_HID, "PRP0001")          // ACPI_DT_NAMESPACE_HID
        Name (_UID, 0)
        Name (_DDN, "SPI controller 0")
        Name (_CCA, ONE)

        Method (_STA) {Return (0xF)}

        Name (_CRS, ResourceTemplate() {

          QWordMemory ( ResourceConsumer,// ResourceUsage
                        PosDecode,       // Decode
                        MinFixed,        // MinType
                        MaxFixed,        // MaxType
                        NonCacheable,    // MemType
                        ReadWrite,       // ReadWriteType
                        0,               // AddressGranularity
                        0x804000000000,  // MinAddress
                        0x804000001037,  // MaxAddress
                        0,               // AddressTranslation
                        0x1038)          // AddressLength

          QWordMemory ( ResourceConsumer,// ResourceUsage
                        PosDecode,       // Decode
                        MinFixed,        // MinType
                        MaxFixed,        // MaxType
                        NonCacheable,    // MemType
                        ReadWrite,       // ReadWriteType
                        0,               // AddressGranularity
                        0x804010000000,  // MinAddress
                        0x804010000007,  // MaxAddress
                        0,               // AddressTranslation
                        0x8)             // AddressLength

          QWordMemory ( ResourceConsumer,// ResourceUsage
                        PosDecode,       // Decode
                        MinFixed,        // MinType
                        MaxFixed,        // MaxType
                        NonCacheable,    // MemType
                        ReadWrite,       // ReadWriteType
                        0,               // AddressGranularity
                        0x804000002000,  // MinAddress
                        0x804000004027,  // MaxAddress
                        0,               // AddressTranslation
                        0x2028)          // AddressLength

          QWordMemory ( ResourceConsumer,// ResourceUsage
            PosDecode,       // Decode
            MinFixed,        // MinType
            MaxFixed,        // MaxType
            NonCacheable,    // MemType
            ReadWrite,       // ReadWriteType
            0,               // AddressGranularity
            0x804000008000,  // MinAddress
            0x804000008237,  // MaxAddress
            0,               // AddressTranslation
            0x238)           // AddressLength

          Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive) { 0x7A }
        })

        Name (_DSD, Package() {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package () {
                Package () { "compatible", "marvell,cn10-xspi-nor"},
                Package () { "reg", 0x8040},
            }
        })
      } // SPI0

Changes:
v12:
  Add 64BIT Kconfig requirement

v11:
  Fix SDMA x86 build issue. Instead of ioread64_rep use readq functions

v10:
  Modify SDMA operation - Read as much data as possible using ioread64_rep, complete transfer with
  memcpy. Ignore first step if buffer is not alligned
  Clean unnecesary tennary operators
  Add spi_transfer_delay_exec call
  Rename "current_cycle_count" to "current_transfer_length"

v9:
  Split into smaller patches:
    - Marvell overlay splitted into: PHY, Clock, Interrupt and SDMA ops
    - ACPI support splitted into resource mapping, CS parameter reading and tx/rx bus length
  Add separate ops and a few function pointers to distinguish between Cadence and Marvell:
    - SDMA read handler.
    - IRQ enable/disable handler
    - Separate mem_ops for Marvell xSPI
  Cleanup xfer code from magic numbers
  Add more descriptive commit msg for xfer block
  Use bitrev8 instead of custom bit reversal
  Rework Marvell SDMA read operations
  Add example ACPI entry

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

Witold Sadowski (9):
  spi: dt-bindings: cadence: Add Marvell overlay bindings documentation
    for Cadence XSPI
  spi: cadence: Add static PHY configuration in Marvell overlay
  spi: cadence: Add clock configuration for Marvell xSPI overlay
  spi: cadence: Add Marvell SDMA operations
  spi: cadence: Add Marvell xSPI interrupt changes
  spi: cadence: Add Marvell xfer operation support
  spi: cadence: Change resource mapping
  spi: cadence: Change cs property reading.
  spi: cadence: Try to read spi-tx/rx-bus width property using ACPI

 .../devicetree/bindings/spi/cdns,xspi.yaml    |  32 +-
 drivers/spi/Kconfig                           |   2 +-
 drivers/spi/spi-cadence-xspi.c                | 692 +++++++++++++++++-
 3 files changed, 705 insertions(+), 21 deletions(-)

-- 
2.43.0


