Return-Path: <linux-spi+bounces-7440-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52930A7E7C7
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744803A8D50
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 17:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA2B214A9C;
	Mon,  7 Apr 2025 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrIRZWRt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AE215F43
	for <linux-spi@vger.kernel.org>; Mon,  7 Apr 2025 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045259; cv=none; b=rhzJuyumYywJSyT0RS4ubh8JIYbjJnbpyeAU8se7ie3T3IpXI1Ll3MwMWj57imeyY5bCRdx7oaaafGsUtsgd2YrEDBbR+gkz9ztV0yEFJd4Ba7MHO+GDJNLPfS1M5Y6P+fMyYmM9WyL8grkEoPt91XnNMkdDf3lKohagzvQr1E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045259; c=relaxed/simple;
	bh=0CiJN4T6ILydjtZFtNIU5ke8rMfl4RRFaq/w4+nwQRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IxFNkL/5it/cAapwevk3V3GnZ6u41VR6jb237SV6YcjEV6QOu4MIooRLatvoGNB41kFieO6zDKnJIlN4aOttofvY7dd7OeJGP7W5f9qIaVKzulMHFZw+Xlg0M2wMi+DPaBio45k0kWSa0jwnKCWgvfDd3vg1mRnxDzWqc4bZnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrIRZWRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AF8C4CEDD;
	Mon,  7 Apr 2025 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744045258;
	bh=0CiJN4T6ILydjtZFtNIU5ke8rMfl4RRFaq/w4+nwQRI=;
	h=Subject:From:Date:To:From;
	b=hrIRZWRtEkCC5UKpQRVRoKWQyTBOr18GQXZ36IzA4WvSRMZujxaLj/eQhGTnnJ/bB
	 ijgglYDj6OoeeooJw+hiarwydDdoRhGJ19R9vwLNMAPC0Vllr0cfk+3OplrB1NdGVM
	 lFKFoh1kVgRg3i/bIPZex2pSmLEcnGtCYe9+bHKYhhfz8G/cIoWqtmhXnFfQHKkgIK
	 /0FFff/8Pz4xTDyW4dln/+KmyekmytnO7ppM7GplD4QlOXhY5RqwOuDTICArdEgDS0
	 QJzXs8cWkU+k4msGkm9doLdA4Bs2uAsauW+ZyhJsYqbeq0xUKV+1I/r5hvhGfvkfM7
	 UnSdxF0v91RQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF20E380CEEF;
	Mon,  7 Apr 2025 17:01:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174404529557.1107196.7642978804616349429.git-patchwork-summary@kernel.org>
Date: Mon, 07 Apr 2025 17:01:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Converge on using secs_to_jiffies() part two
  Submitter: Easwar Hariharan <eahariha@linux.microsoft.com>
  Committer: Andrew Morton <akpm@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=937701
  Lore link: https://lore.kernel.org/r/20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com
    Patches: [v3,01/16] coccinelle: misc: secs_to_jiffies: Patch expressions too
             [v3,02/16] scsi: lpfc: convert timeouts to secs_to_jiffies()
             [v3,03/16] accel/habanalabs: convert timeouts to secs_to_jiffies()
             [v3,04/16] ALSA: ac97: convert timeouts to secs_to_jiffies()
             [v3,05/16] btrfs: convert timeouts to secs_to_jiffies()
             [v3,08/16] ata: libata-zpodd: convert timeouts to secs_to_jiffies()
             [v3,09/16] xfs: convert timeouts to secs_to_jiffies()
             [v3,10/16] power: supply: da9030: convert timeouts to secs_to_jiffies()
             [v3,11/16] nvme: convert timeouts to secs_to_jiffies()
             [v3,14/16] platform/x86/amd/pmf: convert timeouts to secs_to_jiffies()
             [v3,15/16] platform/x86: thinkpad_acpi: convert timeouts to secs_to_jiffies()
             [v3,16/16] RDMA/bnxt_re: convert timeouts to secs_to_jiffies()

Series: Add support for SAMA7D65
  Submitter: Ryan Wanner <Ryan.Wanner@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=924303
  Lore link: https://lore.kernel.org/r/cover.1736522006.git.Ryan.Wanner@microchip.com
    Patches: [v6,1/3] dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
             [v6,2/3] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
             [v6,3/3] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,sama7d65-flexcom

Patch: [next] spi: spi-qpic-snand: use kmalloc() for OOB buffer allocation
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=946026
  Lore link: https://lore.kernel.org/r/20250320-qpic-snand-kmalloc-v1-1-94e267550675@gmail.com

Series: spi: axi-spi-engine: add offload support
  Submitter: David Lechner <dlechner@baylibre.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=931743
  Lore link: https://lore.kernel.org/r/20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com
    Patches: [v8,01/17] spi: add basic support for SPI offloading
             [v8,08/17] iio: buffer-dmaengine: split requesting DMA channel from allocating buffer
             [v8,09/17] iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_with_handle()
             [v8,10/17] iio: adc: ad7944: don't use storagebits for sizing
             [v8,12/17] doc: iio: ad7944: describe offload support
             [v8,13/17] dt-bindings: iio: adc: adi,ad4695: add SPI offload properties
             [v8,15/17] doc: iio: ad4695: add SPI offload support
             [v8,16/17] iio: dac: ad5791: sort include directives
             [v8,17/17] iio: dac: ad5791: Add offload support

Series: Add support to load QUP SE firmware from
  Submitter: Viken Dadhaniya <quic_vdadhani@quicinc.com>
  Committer: Bjorn Andersson <andersson@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=939594
  Lore link: https://lore.kernel.org/r/20250303124349.3474185-1-quic_vdadhani@quicinc.com
    Patches: [v3,1/9] dt-bindings: qcom: geni-se: Add 'firmware-name' property for firmware loading

Patch: spi: spi_amd: Add PCI-based driver for AMD HID2 SPI controller
  Submitter: Raju Rangoju <Raju.Rangoju@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=949298
  Lore link: https://lore.kernel.org/r/20250402121514.2941334-1-Raju.Rangoju@amd.com

Patch: arm64: zynqmp: Move firmware constants from binding to platform
  Submitter: Michal Simek <michal.simek@amd.com>
  Committer: Michal Simek <michal.simek@amd.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=930095
  Lore link: https://lore.kernel.org/r/cover.1738600745.git.michal.simek@amd.com

Patch: [v1,1/1] spi: Simplify conditionals in spi_set_cs()
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=948506
  Lore link: https://lore.kernel.org/r/20250331093915.4041600-1-andriy.shevchenko@linux.intel.com


Total patches: 29

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



