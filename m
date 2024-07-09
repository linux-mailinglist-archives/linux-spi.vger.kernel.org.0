Return-Path: <linux-spi+bounces-3815-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621CE92C5F9
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 00:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78F51F2351F
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 22:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB4187863;
	Tue,  9 Jul 2024 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eeQNiwN/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037717B05D;
	Tue,  9 Jul 2024 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563143; cv=none; b=ngwfoGOV9xcviatsORmjymYucEeGQxVcjNGPUsTALhHcOGKHYBfcJfKTMCESOpdZ4YvLYb+dlYet2fYgt5rlPH4ljXvuXzAJ4PWQkDcrVl46pwXelQvRxejZgQub48k9SVz+WHoUJyiThkGztJEa2T29dOF6RFNpSVn+YALmr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563143; c=relaxed/simple;
	bh=muXHBhPz3CpmZlzgRxiV683ZZacXLrqG4BWt+dPe/Fg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BhWpYb9TYnek5OZGaosEctxaaP2q6pc4ROM2xzhmpdyoeoLZUgcL+dsAGXygWlDnUSx6SeqDmfHKBWYzRS3S+OGpcFK7NTDvPSRkKcxQY+PTTuPl9NTfexuCbtp5f9eRB9wj43g6U2EJ9VjJr5UwsQ1cuwXWCq+UB8/0WMCIZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eeQNiwN/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KH3Li020309;
	Tue, 9 Jul 2024 15:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ZwtohZT/dGEt6pKD0UeX4Ie
	ypm55GaWGCGmHh5Aau9U=; b=eeQNiwN/z9ghutVERWUbJzIam8Kbw3ZywKLLUhD
	033FGZ3xvKKE1C1yC/fbdewmY0cQ3wuq2fc0r+zn6bFzB8Tpiq0G+GOh9xKIYnQ5
	DryLdNClgmr/BtgBv0AN7JxF2H5dMnoRgXbSuURucax0RD2Pzl//PX8c77aMS2q0
	k4itmTKRXOIP6bNiupwPeb0C/f7tDqLSWjuHSS+syXE6FCyoX+hEbU+VIMU4rZZN
	4bBWj9hbodQXM71SA+jQvjJK7o25LD9wCUxcU4GcFMCFJsTQUrkW2FFCIrmycJue
	WS5v9LZUoCK9mfU8mSXaDCmfCLJxaxN4yD7Ojfgx1gEnvpg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 408ntymyxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 15:12:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Jul 2024 15:12:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 15:12:14 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 807673F7073;
	Tue,  9 Jul 2024 15:12:14 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v10 0/9] Marvell HW overlay support for Cadence xSPI
Date: Tue, 9 Jul 2024 15:12:02 -0700
Message-ID: <20240709221211.2130456-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tFZpmLLU9_2HFlgitghP0Oje7_Ld_2vO
X-Proofpoint-GUID: tFZpmLLU9_2HFlgitghP0Oje7_Ld_2vO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_10,2024-07-09_01,2024-05-17_01

This patch series adds support for the second version of the Marvell
hardware overlay for the Cadence xSPI IP block. The overlay is a hardware
change made around the original xSPI block. It extends xSPI features with
clock configuration, interrupt masking, and full-duplex, variable-length SPI
operations.

These functionalities allow the xSPI block to operate not only with memory
devices but also with simple SPI devices and TPM devices.

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
 drivers/spi/spi-cadence-xspi.c                | 682 +++++++++++++++++-
 2 files changed, 694 insertions(+), 20 deletions(-)

-- 
2.43.0


