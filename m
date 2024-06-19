Return-Path: <linux-spi+bounces-3477-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BFA90F00B
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 16:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87EC1C2210E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A6D15E81;
	Wed, 19 Jun 2024 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FmPxiJy3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD76125C9;
	Wed, 19 Jun 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806648; cv=none; b=Z34/8DOi5sLpFPaaoLM414l2Q/72WJ9yv9ZYBflhXrUC4b7qOAvYBK6NXcbSkxrxknoztI5NnCA5kBwo/qXVwcF0W2POj2AZWdzSbu6B1inHcMJ8NJpPISrvnDDVAp6vtBDQPcAV3gRV4RBe6e66qxUzs5ndTAveR69WgLPJ51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806648; c=relaxed/simple;
	bh=NVgY0XjwH1/Dzdx4p/6biFDtQtQB8fKlhZZyNBuaOWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LHctFbsCay8/owTSTomjWsHbNPSsHYAUSVYyTW7GhKdLalebmcxW0pde5msHNXRQfKfMIV2lA/jAL+DKCQyDJVm8ssvUfP/KEM/jzwZUZ5XA9Jndrl5qr5+MUhe00fqxZbD6OnFbGtxIEjfOzcRR3mwPsKeicP7c9r/7AE3A7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FmPxiJy3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9l8id011743;
	Wed, 19 Jun 2024 07:17:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=LoRSQm0IEzl5RYRAlaSG62F
	7NMGt8qNHT0zSPippKns=; b=FmPxiJy3NgVq/myT9Knm6nldBhZvd2O7HcXvDK0
	aeU5XytMfwBUQEbWsPbdHFg2+wWGfNfbfPMatapjYmFP9YIh6OWrFyj44Ld+ItUv
	LxTVbNt0xM9Vsg1tMXQFf1Ww2PT4HMsbbkOaC0J/OgiBDsN/hiv5g1KFCPZbQfJP
	+VrDI93wmsRrSlz/0VGJb4TOBGSTfLk0kZp67GwCg9g7ED//luroY6n1ol5kZXvQ
	+0cGvmOb+csPeO7HDQLgEOuUhHyE+heH/gX2YVw9VCiMl/+xIbSMNS+0CgWUHB+C
	sED38Dzu/ESdQWfvQFrqmNJLavDt2kTCuT7DH3SzgYSc9aQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yuw0jrudr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 07:17:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:20 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 5F81E3F7044;
	Wed, 19 Jun 2024 07:17:20 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v9 0/9] Marvell HW overlay support for Cadence xSPI
Date: Wed, 19 Jun 2024 07:17:06 -0700
Message-ID: <20240619141716.1785467-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: u9i0x1Q0MT5weM-xOac4eeKEA6J_je4C
X-Proofpoint-ORIG-GUID: u9i0x1Q0MT5weM-xOac4eeKEA6J_je4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

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
 drivers/spi/spi-cadence-xspi.c                | 665 +++++++++++++++++-
 2 files changed, 677 insertions(+), 20 deletions(-)

-- 
2.43.0


