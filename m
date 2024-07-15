Return-Path: <linux-spi+bounces-3864-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E19931679
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 16:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678361C206A8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4157A18D4DD;
	Mon, 15 Jul 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDGbCmAz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09418C354;
	Mon, 15 Jul 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052939; cv=none; b=rASYbT+dVDNN718LxHvLxxV6Y5uviLdkVQJCymR6alqm+D6BNOjyoNIt6EFfDq6DXjwnvCTaqFc5JQdmObkrNgGFvqQQQBVQMMY270aP6z70qbbDsd+NjvnB5RyNOjpo4SxMyLZy2zxD1fzWGLbLipRVE+uAaoM0FhXiESlmlbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052939; c=relaxed/simple;
	bh=XTHhSrSeM98AX8xyT2O21VNf27wHdupOsFiue7eoXMw=;
	h=Message-ID:From:To:Cc:Subject:Date; b=QQJ421FxEUrg8ooHd14aAIUyytOCQyCgfDPMB1w2dRu/BA7MdwzVBunytYfaNDgKbCqZba75rmp1qZAc7EeGIxqEi0X1Bavek+Exg2v+IMYlRnQMYSR2Cu9TrRwlOsegzQniuSjI8UXT3Pme4CRnRHMbkcPFxC/q0lT73wNIWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDGbCmAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D028AC32782;
	Mon, 15 Jul 2024 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052938;
	bh=XTHhSrSeM98AX8xyT2O21VNf27wHdupOsFiue7eoXMw=;
	h=From:To:Cc:Subject:Date:From;
	b=CDGbCmAzOTil0SiJ7soPWOB8cWi52Un22yEUDNYuPyX4Y4taGRZQuzKdnOU0shmkS
	 6bmtiLoipgY9WhDyq6p0UXtL17/il7vhRkb6B1DvHfdOmOp7WqaCz3gSriHG7+gQbr
	 i1swzsGegtsIwzM5X1MXNlLi2+KEZD2nNP1YovIExb2BdGhrKj6e4Lr3oMahbgqEgU
	 rZxlpB0uG5eXglCkRbM5iHw6NmRPJdBAp9+7EuRVPcynU5WgdspikpYIwqpmSJ5hH3
	 5CbRMiSTaLm6RUSsiJZY/acqjKABMvVmDd8WRuYIzI1uMXyvuqvktNPYCN0cVaSZLw
	 SNWbuixF0IdeA==
Message-ID: <46da42db74d7a64dc347375f8087a6f4.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.11
Date: Mon, 15 Jul 2024 15:15:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit df75470b317b46affbe1f5f8f006b34175be9789:

  spi: spi-imx: imx51: revert burst length calculation back to bits_per_word (2024-06-19 14:07:13 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.11

for you to fetch changes up to 3048dc8ba46b7ba11581f2a7e06849af0df13136:

  spi: dt-bindings: at91: Add sama7d65 compatible string (2024-07-12 00:18:43 +0100)

----------------------------------------------------------------
spi: Updates for v6.11

There's some quite exciting core work in this release, we've got the
beginnings of support for hardware initiated transfers which is itself
independently useful for optimising fast paths in existing drivers.

We also have a rework of the DMA mapping which allows finer grained
decisions about DMA mapping messages and also helps remove some bodges
that we'd had.

Otherwise it's a fairly quiet release, a few new drivers and features
for existing drivers, together with various cleanups and DT binding
conversions.

One regmap SPI fix made it's way in here too which I should probably
have sent as a regmap fix instead.

 - Support for pre-optimising messages, reducing the overhead for
   messages that are repeatedly used (eg, reading the interrupt status
   from a device).  This will also be used for hardware initiated
   transfers in future.
 - A reworking of how DMA mapping is done, introducing a new helper and
   allowing the DMA mapping decision to be done per transfer instead of
   per message.
 - Support for Atmel SAMA7D64, Freescale LX2160A DSPI and WCH CH341A.

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      spi: spi-cadence: Enable spi refclk in slave mode

Andy Shevchenko (27):
      spi: bitbang: Use typedef for txrx_*() callbacks
      spi: bitbang: Convert unsigned to unsigned int
      spi: bitbang: Replace hard coded number of SPI modes
      spi: gpio: Make use of device properties
      spi: gpio: Use traditional pattern when checking error codes
      spi: Replace custom code with device_match_acpi_handle()
      spi: Refactor spi_stop_queue()
      spi: pxa2xx: Wrap pxa_ssp_request() to be device managed resource
      spi: pxa2xx: Reorganize the SSP type retrieval
      spi: pxa2xx: Remove no more needed driver data
      spi: pxa2xx: Remove hard coded number of chip select pins
      spi: pxa2xx: Utilise temporary variable for struct device
      spi: pxa2xx: Print DMA burst size only when DMA is enabled
      spi: pxa2xx: Remove duplicate check
      spi: pxa2xx: Remove superflous check for Intel Atom SoCs
      spi: pxa2xx: Extract pxa2xx_spi_platform_*() callbacks
      spi: pxa2xx: Move platform driver to a separate file
      spi: pxa2xx: Convert PCI driver to use spi-pxa2xx code directly
      regmap: spi: Fix potential off-by-one when calculating reserved size
      spi: Introduce internal spi_xfer_is_dma_mapped() helper
      spi: dw: Use new spi_xfer_is_dma_mapped() helper
      spi: ingenic: Use new spi_xfer_is_dma_mapped() helper
      spi: omap2-mcspi: Use new spi_xfer_is_dma_mapped() helper
      spi: pxa2xx: Use new spi_xfer_is_dma_mapped() helper
      spi: pci1xxxx: Use new spi_xfer_is_dma_mapped() helper
      spi: qup: Use new spi_xfer_is_dma_mapped() helper
      spi: Rework per message DMA mapped flag to be per transfer

Charles Keepax (2):
      spi: cs42l43: Refactor accessing the SDCA extension properties
      spi: cs42l43: Refactor accessing the SDCA extension properties

Chen Ni (1):
      spi: atmel-quadspi: Add missing check for clk_prepare

David Lechner (5):
      spi: axi-spi-engine: Add SPI_CS_HIGH support
      Documentation: devres: add missing SPI helpers
      spi: add devm_spi_optimize_message() helper
      spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
      spi: axi-spi-engine: remove platform_set_drvdata()

Eddie James (1):
      spi: dt-bindings: Document the IBM FSI-attached SPI controller

Fabio Estevam (4):
      spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
      spi: spi-fsl-lpspi: Switch to SYSTEM_SLEEP_PM_OPS()
      spi: spi-imx: Pass pm_ptr()
      spi: spi-fsl-lpspi: Pass pm_ptr()

Frank Li (4):
      spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
      spi: dt-bindings: fsl-dspi: Convert to yaml format
      spi: dt-bindings: fsl-dspi: add dmas and dma-names properties
      spi: dt-bindings: fsl-dspi: add compatible string 'fsl,lx2160a-dspi'

Jeff Johnson (1):
      spi: add missing MODULE_DESCRIPTION() macros

Ji Sheng Teoh (2):
      spi: spi-cadence: Add optional reset control support
      spi: dt-bindings: spi-cadence: Add optional reset control

Johannes Thumshirn (1):
      spi: add ch341a usb2spi driver

Kanak Shilledar (2):
      spi: dt-bindings: brcm,bcm2835-spi: convert to dtschema
      spi: dt-bindings: snps,dw-apb-ssi.yaml: update compatible property

Li zeming (2):
      spi: spi: Remove unnecessary ‘0’ values from rc
      spi: spi: Remove unnecessary ‘0’ values from status

Mark Brown (11):
      Merge existing fixes from spi/for-6.10 into new branch
      Add optional reset control for Cadence SPI
      spi: differentiate between unsupported and invalid
      spi: bitbang: Clean up the driver
      spi: gpio: Convert to be used outside of OF
      Add support for GPIO based CS
      spi: Merge up fixes
      spi: Rework DMA mapped flag
      spi: Merge up fixes
      spi: add devm_spi_optimize_message() helper
      spi: add devm_spi_optimize_message() helper

Martin Kaiser (1):
      spi: imx: remove empty cleanup function

Michael Hennerich (1):
      spi: xcomm: add gpiochip support

Miquel Raynal (4):
      spi: dw: differentiate between unsupported and invalid requests
      spi: mxic: differentiate between unsupported and invalid requests
      spi: rpc-if: differentiate between unsupported and invalid requests
      spi: wpcm-fiu: differentiate between unsupported and invalid requests

Neil Armstrong (1):
      dt-bindings: spi: amlogic,a1-spifc: add missing power-domains

Nicolas Ferre (1):
      spi: dt-bindings: at91: Add sama7d65 compatible string

Nuno Sa (3):
      spi: xcomm: make use of devm_spi_alloc_host()
      spi: xcomm: remove i2c_set_clientdata()
      spi: xcomm: fix coding style

Prajna Rajendra Kumar (3):
      spi: dt-bindings: Add num-cs property for mpfs-spi
      spi: spi-microchip-core: Fix the number of chip selects supported
      spi: spi-microchip-core: Add support for GPIO based CS

Rob Herring (Arm) (1):
      spi: dt-bindings: marvell,mmp2-ssp: Merge PXA SSP into schema

Simon Trimmer (1):
      spi: cs42l43: Add speaker id support to the bridge configuration

Uwe Kleine-König (1):
      spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices

Xianwei Zhao (2):
      spi: meson-spicc: set SPI clock flag CLK_SET_RATE_PARENT
      spi: meson-spicc: add spicc loopback mode

 .editorconfig                                      |   3 -
 .mailmap                                           |   3 +
 Documentation/admin-guide/LSM/tomoyo.rst           |  35 +-
 Documentation/admin-guide/mm/transhuge.rst         |   4 +-
 Documentation/cdrom/cdrom-standard.rst             |   4 +-
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |   3 +-
 Documentation/devicetree/bindings/arm/sunxi.yaml   |   6 +-
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |   2 +-
 .../devicetree/bindings/input/elan,ekth6915.yaml   |  19 +-
 .../devicetree/bindings/input/ilitek,ili2901.yaml  |  66 ++++
 .../devicetree/bindings/serial/mrvl,pxa-ssp.txt    |  64 ----
 .../devicetree/bindings/spi/amlogic,a1-spifc.yaml  |   3 +
 .../bindings/spi/atmel,at91rm9200-spi.yaml         |   8 +-
 .../devicetree/bindings/spi/brcm,bcm2835-spi.txt   |  23 --
 .../devicetree/bindings/spi/brcm,bcm2835-spi.yaml  |  50 +++
 .../bindings/spi/fsl,dspi-peripheral-props.yaml    |  30 ++
 .../devicetree/bindings/spi/fsl,dspi.yaml          | 116 ++++++
 .../devicetree/bindings/spi/ibm,spi-fsi.yaml       |  55 +++
 .../devicetree/bindings/spi/marvell,mmp2-ssp.yaml  |  35 +-
 .../bindings/spi/microchip,mpfs-spi.yaml           |  29 +-
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   4 +
 .../devicetree/bindings/spi/spi-cadence.yaml       |   7 +
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 ----
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../devicetree/bindings/usb/realtek,rts5411.yaml   |   1 +
 Documentation/driver-api/driver-model/devres.rst   |   3 +
 Documentation/kbuild/kconfig-language.rst          |  12 +-
 Documentation/networking/af_xdp.rst                |  33 +-
 .../userspace-api/media/v4l/dev-subdev.rst         |   2 +-
 MAINTAINERS                                        |  10 +-
 Makefile                                           |   2 +-
 arch/arm/kernel/ftrace.c                           |  17 +-
 arch/arm64/include/asm/el2_setup.h                 |   6 +-
 arch/arm64/include/asm/io.h                        |  36 +-
 arch/arm64/include/asm/kvm_arm.h                   |   6 +
 arch/arm64/include/asm/kvm_emulate.h               |  71 +++-
 arch/arm64/include/asm/kvm_host.h                  |  25 +-
 arch/arm64/include/asm/kvm_hyp.h                   |   4 +-
 arch/arm64/include/asm/kvm_pkvm.h                  |   9 +
 arch/arm64/kernel/armv8_deprecated.c               |   3 +
 arch/arm64/kvm/arm.c                               |  76 ++++
 arch/arm64/kvm/emulate-nested.c                    |  21 +-
 arch/arm64/kvm/fpsimd.c                            |  11 +-
 arch/arm64/kvm/guest.c                             |   3 +-
 arch/arm64/kvm/hyp/aarch32.c                       |  18 +-
 arch/arm64/kvm/hyp/fpsimd.S                        |   6 +
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  36 +-
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h             |   1 -
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  84 ++++-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  17 +-
 arch/arm64/kvm/hyp/nvhe/setup.c                    |  25 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |  24 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |  12 +-
 arch/arm64/kvm/nested.c                            |   6 +-
 arch/arm64/kvm/reset.c                             |   3 +
 arch/arm64/mm/contpte.c                            |   4 +-
 arch/loongarch/boot/dts/loongson-2k0500-ref.dts    |   4 +-
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts    |   4 +-
 arch/loongarch/boot/dts/loongson-2k2000-ref.dts    |   2 +-
 arch/loongarch/include/asm/numa.h                  |   1 +
 arch/loongarch/include/asm/stackframe.h            |   2 +-
 arch/loongarch/kernel/head.S                       |   2 +-
 arch/loongarch/kernel/setup.c                      |   6 +-
 arch/loongarch/kernel/smp.c                        |   5 +-
 arch/loongarch/kernel/vmlinux.lds.S                |  10 +-
 arch/parisc/include/asm/cacheflush.h               |  15 +-
 arch/parisc/include/asm/pgtable.h                  |  27 +-
 arch/parisc/kernel/cache.c                         | 413 +++++++++++++--------
 arch/riscv/kvm/aia_device.c                        |   7 +-
 arch/riscv/kvm/vcpu_onereg.c                       |   4 +-
 arch/riscv/mm/fault.c                              |   4 +-
 arch/riscv/mm/init.c                               |  21 +-
 arch/s390/boot/startup.c                           |  27 +-
 arch/s390/boot/vmem.c                              |  12 +-
 arch/s390/boot/vmlinux.lds.S                       |   1 +
 arch/s390/configs/debug_defconfig                  |  43 ++-
 arch/s390/configs/defconfig                        |  40 +-
 arch/s390/configs/zfcpdump_defconfig               |   5 +-
 arch/s390/kernel/crash_dump.c                      |  54 +--
 arch/x86/boot/compressed/Makefile                  |   4 +-
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/include/asm/uaccess.h                     |   4 +-
 arch/x86/include/asm/vmxfeatures.h                 |   2 +-
 arch/x86/kernel/amd_nb.c                           |   9 +-
 arch/x86/kernel/machine_kexec_64.c                 |  11 +-
 arch/x86/kvm/Kconfig                               |  11 +-
 arch/x86/kvm/lapic.c                               |  39 +-
 arch/x86/kvm/lapic.h                               |   2 +-
 arch/x86/kvm/mmu/mmu.c                             |  46 ++-
 arch/x86/kvm/mmu/spte.h                            |   9 +
 arch/x86/kvm/mmu/tdp_iter.h                        |   2 +
 arch/x86/kvm/mmu/tdp_mmu.c                         |   2 +-
 arch/x86/kvm/svm/sev.c                             |  19 +-
 arch/x86/kvm/svm/svm.c                             |  69 +++-
 arch/x86/kvm/svm/svm.h                             |   4 +-
 arch/x86/kvm/vmx/nested.c                          |   5 +
 arch/x86/kvm/vmx/vmx.c                             |  11 +-
 arch/x86/kvm/x86.c                                 |  11 +-
 arch/x86/lib/getuser.S                             |   6 +-
 arch/x86/mm/numa.c                                 |   6 +-
 block/bio-integrity.c                              |  26 +-
 block/blk-flush.c                                  |   3 +-
 block/blk-zoned.c                                  |   3 +
 block/sed-opal.c                                   |   2 +-
 drivers/acpi/ac.c                                  |   4 +-
 drivers/acpi/acpica/acevents.h                     |   4 +
 drivers/acpi/acpica/evregion.c                     |   6 +-
 drivers/acpi/acpica/evxfregn.c                     |  54 +++
 drivers/acpi/apei/einj-core.c                      |   2 +-
 drivers/acpi/ec.c                                  |  12 +-
 drivers/acpi/sbs.c                                 |   4 +-
 drivers/acpi/thermal.c                             |   8 +-
 drivers/acpi/x86/utils.c                           |  24 +-
 drivers/ata/libata-scsi.c                          |   8 +-
 drivers/ata/pata_macio.c                           |   9 +-
 drivers/base/core.c                                |  48 +--
 drivers/base/regmap/regmap-spi.c                   |   3 +-
 drivers/block/loop.c                               |  23 ++
 drivers/block/nbd.c                                |  51 ++-
 drivers/block/null_blk/main.c                      |   4 +-
 drivers/char/tpm/tpm.h                             |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |   3 +-
 drivers/char/tpm/tpm_tis_core.h                    |   2 +-
 drivers/clk/clkdev.c                               |  11 +-
 drivers/clk/sifive/sifive-prci.c                   |   8 -
 drivers/cpufreq/amd-pstate-ut.c                    |   3 +-
 drivers/cpufreq/amd-pstate.c                       |  36 +-
 {include/linux => drivers/cpufreq}/amd-pstate.h    |  33 --
 drivers/cpufreq/intel_pstate.c                     |  22 +-
 drivers/cxl/core/region.c                          |  18 +-
 drivers/edac/amd64_edac.c                          |   8 +-
 drivers/edac/igen6_edac.c                          |   4 +-
 drivers/firewire/Kconfig                           |   2 +-
 drivers/firewire/core-card.c                       |   6 +-
 drivers/firewire/core-cdev.c                       |   6 +-
 drivers/firewire/core-topology.c                   |   2 +-
 drivers/firewire/core-transaction.c                |  30 +-
 drivers/firmware/efi/efi-pstore.c                  |   8 +-
 drivers/firmware/efi/libstub/loongarch.c           |   2 +-
 drivers/firmware/efi/libstub/zboot.lds             |   1 +
 drivers/firmware/efi/runtime-wrappers.c            |  13 +-
 drivers/gpio/Kconfig                               |   2 +-
 drivers/gpio/gpio-gw-pld.c                         |   1 +
 drivers/gpio/gpio-mc33880.c                        |   1 +
 drivers/gpio/gpio-pcf857x.c                        |   1 +
 drivers/gpio/gpio-pl061.c                          |   1 +
 drivers/gpio/gpio-tqmx86.c                         | 110 ++++--
 drivers/gpu/drm/Kconfig                            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   2 -
 drivers/gpu/drm/amd/include/pptable.h              |  91 ++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |  20 +-
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c |   5 -
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |   8 -
 .../drm/arm/display/komeda/komeda_pipeline_state.c |   2 +-
 drivers/gpu/drm/bridge/panel.c                     |   7 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   6 +
 drivers/gpu/drm/exynos/exynos_dp.c                 |   1 -
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   7 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   7 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   8 +
 drivers/gpu/drm/nouveau/dispnv04/disp.c            |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c             |   5 -
 drivers/gpu/drm/nouveau/nouveau_display.c          |   6 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |   1 +
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |   4 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c   |   8 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  19 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   3 -
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c      |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  28 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  60 ++-
 drivers/gpu/drm/xe/xe_gt_idle.c                    |   9 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |  14 +-
 drivers/gpu/drm/xe/xe_guc_pc.c                     |   6 -
 drivers/gpu/drm/xe/xe_ring_ops.c                   |  18 +-
 drivers/hid/hid-asus.c                             |   4 +-
 drivers/hid/hid-core.c                             |   1 -
 drivers/hid/hid-debug.c                            |   2 +
 drivers/hid/hid-ids.h                              |   2 +
 drivers/hid/hid-input.c                            |  13 +
 drivers/hid/hid-logitech-dj.c                      |   4 +-
 drivers/hid/hid-logitech-hidpp.c                   |   1 +
 drivers/hid/hid-nintendo.c                         |   6 +-
 drivers/hid/hid-nvidia-shield.c                    |   4 +-
 drivers/hid/i2c-hid/i2c-hid-of-elan.c              |  59 ++-
 drivers/hid/intel-ish-hid/ishtp/loader.c           |  79 ++--
 drivers/hid/intel-ish-hid/ishtp/loader.h           |  33 +-
 drivers/i2c/busses/i2c-at91-slave.c                |   3 +-
 drivers/i2c/busses/i2c-designware-slave.c          |   2 +-
 drivers/i2c/busses/i2c-synquacer.c                 |  11 +-
 drivers/iio/adc/ad7173.c                           |  37 +-
 drivers/iio/adc/ad9467.c                           |   4 +-
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |   6 +-
 drivers/iio/dac/ad5592r-base.c                     |   2 +-
 drivers/iio/imu/bmi323/bmi323_core.c               |   5 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   4 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  19 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |   2 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   4 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   1 +
 drivers/iio/inkern.c                               |   2 +-
 drivers/iio/pressure/bmp280-core.c                 |  10 +-
 drivers/iio/temperature/mlx90635.c                 |   6 +-
 drivers/input/touchscreen/silead.c                 |  19 +-
 drivers/iommu/amd/amd_iommu.h                      |   3 +-
 drivers/iommu/amd/init.c                           |  11 +-
 drivers/iommu/amd/iommu.c                          |  48 +--
 drivers/iommu/amd/ppr.c                            |  25 +-
 drivers/iommu/dma-iommu.c                          |   8 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  44 +--
 drivers/irqchip/irq-riscv-intc.c                   |   9 +-
 drivers/irqchip/irq-sifive-plic.c                  |  34 +-
 drivers/leds/led-class.c                           |   6 -
 drivers/media/pci/intel/ipu6/ipu6-isys-queue.c     |   6 +-
 drivers/media/pci/intel/ipu6/ipu6-isys.c           |  71 ++--
 drivers/media/pci/intel/ipu6/ipu6.c                |   5 +-
 drivers/media/pci/intel/ivsc/mei_csi.c             |   5 +-
 drivers/media/pci/mgb4/mgb4_core.c                 |   7 +-
 drivers/media/pci/saa7134/saa7134-cards.c          |   2 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c      |   9 +-
 drivers/misc/mei/main.c                            |   2 +-
 drivers/misc/mei/pci-me.c                          |   4 +-
 drivers/misc/mei/platform-vsc.c                    |  39 +-
 drivers/misc/mei/vsc-fw-loader.c                   |   2 +-
 drivers/net/dsa/qca/qca8k-leds.c                   |  12 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |  51 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c     |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |  12 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c  |  11 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   8 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |  20 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   4 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  21 +-
 drivers/net/ethernet/intel/ice/ice.h               |  44 ++-
 drivers/net/ethernet/intel/ice/ice_base.c          |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |  27 +-
 drivers/net/ethernet/intel/ice/ice_main.c          | 118 +++---
 drivers/net/ethernet/intel/ice/ice_nvm.c           | 116 +++++-
 drivers/net/ethernet/intel/ice/ice_type.h          |  14 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  13 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   9 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   9 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  33 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 104 ++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |   8 +
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   8 +-
 .../net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c  |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   3 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   4 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |   1 +
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |   4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  25 +-
 drivers/net/geneve.c                               |  10 +-
 drivers/net/netdevsim/netdev.c                     |   3 +-
 drivers/net/phy/micrel.c                           | 104 +++++-
 drivers/net/phy/sfp.c                              |   3 +-
 drivers/net/virtio_net.c                           |  42 +--
 drivers/net/vmxnet3/vmxnet3_drv.c                  |   2 +-
 drivers/net/vxlan/vxlan_core.c                     |   8 +-
 drivers/net/wireless/ath/ath10k/Kconfig            |   1 +
 drivers/net/wireless/ath/ath11k/core.c             |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  38 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |  25 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   9 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  39 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   5 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   4 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  41 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |  17 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |  43 ++-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  12 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   5 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |  15 -
 drivers/net/wwan/iosm/iosm_ipc_devlink.c           |   2 +-
 drivers/nvme/host/core.c                           |  10 +-
 drivers/nvme/host/fabrics.c                        |   6 +-
 drivers/nvme/host/ioctl.c                          |  15 +-
 drivers/nvme/host/pr.c                             |   2 +-
 drivers/nvme/target/core.c                         |   1 +
 drivers/nvme/target/fabrics-cmd-auth.c             |   3 -
 drivers/nvme/target/fabrics-cmd.c                  |   6 -
 drivers/nvme/target/passthru.c                     |   6 +-
 drivers/of/irq.c                                   | 125 ++++---
 drivers/of/of_private.h                            |   3 +
 drivers/of/of_test.c                               |   1 +
 drivers/of/property.c                              |  30 +-
 drivers/parport/parport_amiga.c                    |   8 +-
 drivers/pci/access.c                               |   4 -
 drivers/pci/pci.c                                  |   1 -
 drivers/pci/probe.c                                |   3 -
 drivers/platform/x86/Kconfig                       |   1 +
 drivers/platform/x86/amd/hsmp.c                    |  50 ++-
 drivers/platform/x86/dell/dell-smbios-base.c       | 103 ++---
 drivers/platform/x86/touchscreen_dmi.c             |  59 +--
 drivers/pnp/base.h                                 |   1 +
 drivers/pnp/driver.c                               |   6 +
 drivers/ptp/ptp_chardev.c                          |   3 +-
 drivers/ras/amd/atl/internal.h                     |   2 +-
 drivers/ras/amd/atl/system.c                       |   2 +-
 drivers/ras/amd/atl/umc.c                          | 160 +++++---
 drivers/scsi/device_handler/scsi_dh_alua.c         |  31 +-
 drivers/scsi/mpi3mr/mpi3mr_app.c                   |  62 ++++
 drivers/scsi/mpi3mr/mpi3mr_transport.c             |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |  19 +
 drivers/scsi/mpt3sas/mpt3sas_base.h                |   3 -
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                 |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |  27 +-
 drivers/scsi/qedf/qedf.h                           |   1 +
 drivers/scsi/qedf/qedf_main.c                      |  47 ++-
 drivers/scsi/scsi.c                                |  14 +
 drivers/scsi/scsi_transport_sas.c                  |  23 ++
 drivers/scsi/sd.c                                  |  17 +-
 drivers/scsi/sr.h                                  |   2 +-
 drivers/scsi/sr_ioctl.c                            |   5 +-
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   4 +-
 drivers/spi/atmel-quadspi.c                        |  11 +-
 drivers/spi/internals.h                            |   8 +
 drivers/spi/spi-altera-core.c                      |   1 +
 drivers/spi/spi-axi-spi-engine.c                   |  42 ++-
 drivers/spi/spi-bitbang.c                          |  73 ++--
 drivers/spi/spi-cadence.c                          |  27 +-
 drivers/spi/spi-ch341.c                            | 241 ++++++++++++
 drivers/spi/spi-cs42l43.c                          |  95 +++--
 drivers/spi/spi-dw-bt1.c                           |  10 +-
 drivers/spi/spi-dw-core.c                          |   4 +-
 drivers/spi/spi-fsl-cpm.c                          |   1 +
 drivers/spi/spi-fsl-dspi.c                         |  19 +-
 drivers/spi/spi-fsl-lib.c                          |   1 +
 drivers/spi/spi-fsl-lpspi.c                        |   8 +-
 drivers/spi/spi-gpio.c                             |  66 ++--
 drivers/spi/spi-imx.c                              |  22 +-
 drivers/spi/spi-ingenic.c                          |   4 +-
 drivers/spi/spi-meson-spicc.c                      |  22 +-
 drivers/spi/spi-microchip-core.c                   |   6 +-
 drivers/spi/spi-mxic.c                             |   2 +-
 drivers/spi/spi-omap-uwire.c                       |   1 +
 drivers/spi/spi-omap2-mcspi.c                      |   9 +-
 drivers/spi/spi-pci1xxxx.c                         |   5 +-
 drivers/spi/spi-pxa2xx-pci.c                       |  39 +-
 drivers/spi/spi-pxa2xx-platform.c                  | 214 +++++++++++
 drivers/spi/spi-pxa2xx.c                           | 259 ++-----------
 drivers/spi/spi-pxa2xx.h                           |   6 +
 drivers/spi/spi-qup.c                              |  10 +-
 drivers/spi/spi-rpc-if.c                           |  12 +-
 drivers/spi/spi-wpcm-fiu.c                         |   6 +-
 drivers/spi/spi-xcomm.c                            |  75 +++-
 drivers/spi/spi.c                                  | 134 +++----
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   2 +-
 .../interface/vchiq_arm/vchiq_debugfs.c            |   8 +-
 .../interface/vchiq_arm/vchiq_debugfs.h            |   2 +-
 drivers/thermal/gov_step_wise.c                    |  17 +
 drivers/thermal/thermal_core.c                     |  48 ++-
 drivers/thermal/thermal_core.h                     |   2 +
 drivers/thermal/thermal_debugfs.c                  |  18 +-
 drivers/thermal/thermal_trip.c                     |  20 +-
 drivers/thunderbolt/debugfs.c                      |   5 +-
 drivers/tty/n_tty.c                                |  22 +-
 drivers/tty/serial/8250/8250_dw.c                  |  36 +-
 drivers/tty/serial/8250/8250_dwlib.c               |   3 +-
 drivers/tty/serial/8250/8250_dwlib.h               |  33 +-
 drivers/tty/serial/8250/8250_pxa.c                 |   1 +
 drivers/tty/serial/Kconfig                         |   3 +-
 drivers/tty/serial/Makefile                        |   2 +-
 drivers/tty/serial/serial_core.c                   |   2 +-
 drivers/tty/serial/serial_port.c                   |   7 +
 drivers/ufs/core/ufs-mcq.c                         |  17 +-
 drivers/ufs/core/ufshcd.c                          |   6 +-
 drivers/usb/Makefile                               |   1 +
 drivers/usb/chipidea/core.c                        |   8 +-
 drivers/usb/chipidea/ulpi.c                        |   5 +
 drivers/usb/class/cdc-wdm.c                        |   4 +-
 drivers/usb/core/hcd.c                             |  12 +-
 drivers/usb/host/xhci-pci.c                        |   7 +
 drivers/usb/host/xhci-ring.c                       |  59 ++-
 drivers/usb/host/xhci.h                            |   1 +
 drivers/usb/storage/alauda.c                       |   9 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   5 +-
 drivers/usb/typec/ucsi/ucsi.c                      |   7 +-
 drivers/usb/typec/ucsi/ucsi_glink.c                |   2 +-
 drivers/vfio/device_cdev.c                         |   7 +
 drivers/vfio/group.c                               |   7 +
 drivers/vfio/pci/vfio_pci_core.c                   | 271 ++++----------
 drivers/vfio/vfio_main.c                           |  44 +++
 fs/bcachefs/alloc_background.c                     |  22 +-
 fs/bcachefs/bcachefs.h                             |   3 +-
 fs/bcachefs/btree_cache.c                          |   9 +-
 fs/bcachefs/btree_gc.c                             |  17 +-
 fs/bcachefs/btree_io.c                             |   8 +-
 fs/bcachefs/btree_iter.c                           |  11 +-
 fs/bcachefs/btree_key_cache.c                      |  33 +-
 fs/bcachefs/btree_locking.c                        |   1 +
 fs/bcachefs/btree_node_scan.c                      |   9 +-
 fs/bcachefs/buckets.c                              | 293 ++++++++-------
 fs/bcachefs/buckets.h                              |  17 +-
 fs/bcachefs/buckets_types.h                        |   2 +
 fs/bcachefs/data_update.c                          |   3 +-
 fs/bcachefs/ec.c                                   |  26 +-
 fs/bcachefs/extents.c                              |   9 +-
 fs/bcachefs/fs-ioctl.c                             |  17 +-
 fs/bcachefs/fs.c                                   |   3 +
 fs/bcachefs/fsck.c                                 |   3 +
 fs/bcachefs/io_read.c                              |  37 +-
 fs/bcachefs/io_write.c                             |  19 +-
 fs/bcachefs/move.c                                 |  16 +-
 fs/bcachefs/movinggc.c                             |   7 +-
 fs/bcachefs/super-io.c                             |   6 +-
 fs/bcachefs/super.c                                |  10 +-
 fs/btrfs/btrfs_inode.h                             |  10 +
 fs/btrfs/disk-io.c                                 |  10 +-
 fs/btrfs/extent_io.c                               |  60 +--
 fs/btrfs/file.c                                    |  16 +
 fs/btrfs/ordered-data.c                            |  31 ++
 fs/btrfs/tree-log.c                                |  17 +-
 fs/cachefiles/daemon.c                             |   3 +-
 fs/cachefiles/internal.h                           |   5 +
 fs/cachefiles/ondemand.c                           | 218 ++++++++---
 fs/debugfs/inode.c                                 |  10 +-
 fs/file.c                                          |   4 +-
 fs/iomap/buffered-io.c                             |  56 ++-
 fs/jfs/xattr.c                                     |   4 +-
 fs/nfs/dir.c                                       |  77 ++--
 fs/nfs/nfs4proc.c                                  |  24 +-
 fs/nfs/pagelist.c                                  |   5 +
 fs/nfs/symlink.c                                   |   2 +-
 fs/nilfs2/dir.c                                    |   2 +-
 fs/nilfs2/segment.c                                |   3 +
 fs/proc/base.c                                     |   2 +-
 fs/smb/client/smb2pdu.c                            |   3 -
 fs/smb/client/smb2transport.c                      |   2 +-
 fs/smb/server/smb2pdu.c                            |  22 +-
 fs/smb/server/vfs.c                                |  17 +-
 fs/smb/server/vfs.h                                |   3 +-
 fs/smb/server/vfs_cache.c                          |   3 +-
 fs/xfs/libxfs/xfs_sb.c                             |   7 +-
 include/acpi/acpixf.h                              |   4 +
 include/dt-bindings/net/ti-dp83867.h               |   4 +-
 include/dt-bindings/net/ti-dp83869.h               |   4 +-
 include/linux/atomic/atomic-arch-fallback.h        |   6 +-
 include/linux/atomic/atomic-instrumented.h         |   8 +-
 include/linux/atomic/atomic-long.h                 |   4 +-
 include/linux/bio.h                                |   4 +
 include/linux/cdrom.h                              |   2 +-
 include/linux/device.h                             |   2 -
 include/linux/huge_mm.h                            |  10 +-
 include/linux/i2c.h                                |   1 -
 include/linux/io_uring_types.h                     |   3 +-
 include/linux/iommu.h                              |   2 +-
 include/linux/kcov.h                               |  47 ++-
 include/linux/ksm.h                                |  17 +-
 include/linux/lockdep.h                            |   5 -
 include/linux/mm_types.h                           |   2 +-
 include/linux/netfs.h                              |   2 +-
 include/linux/pci.h                                |   2 -
 include/linux/pnp.h                                |   6 +-
 include/linux/pse-pd/pse.h                         |   4 +-
 include/linux/spi/spi.h                            |  13 +-
 include/linux/spi/spi_bitbang.h                    |   7 +-
 include/linux/sysfs.h                              |   9 +
 include/linux/vfio.h                               |   1 +
 include/linux/vfio_pci_core.h                      |   2 -
 include/net/bluetooth/hci_core.h                   |  36 +-
 include/net/ip_tunnels.h                           |   5 +-
 include/net/rtnetlink.h                            |   1 +
 include/net/tcp_ao.h                               |   7 +-
 include/scsi/scsi_transport_sas.h                  |   2 +
 include/trace/events/cachefiles.h                  |   8 +-
 include/trace/events/firewire.h                    | 113 +++---
 include/uapi/linux/input-event-codes.h             |   2 +
 include/uapi/linux/stat.h                          |   2 +-
 io_uring/cancel.h                                  |   4 +-
 io_uring/io-wq.c                                   |  10 +-
 io_uring/io_uring.c                                |   1 +
 io_uring/io_uring.h                                |   2 +-
 io_uring/napi.c                                    |  24 +-
 io_uring/register.c                                |   4 +
 io_uring/rsrc.c                                    |   1 +
 kernel/bpf/devmap.c                                |   3 -
 kernel/bpf/syscall.c                               |  11 +-
 kernel/bpf/verifier.c                              |   4 +
 kernel/events/core.c                               |  13 +
 kernel/time/tick-common.c                          |  42 +--
 kernel/trace/bpf_trace.c                           |   2 -
 lib/test_rhashtable.c                              |   1 +
 mm/filemap.c                                       |   2 +-
 mm/huge_memory.c                                   |   8 +-
 mm/hugetlb.c                                       |  16 +-
 mm/kmsan/core.c                                    |  15 +-
 mm/ksm.c                                           |  17 +-
 mm/memblock.c                                      |   4 +
 mm/memcontrol.c                                    |   2 -
 mm/mempool.c                                       |   2 +-
 mm/page_alloc.c                                    |  50 ++-
 mm/page_io.c                                       |   2 +-
 mm/slub.c                                          |   5 +-
 mm/util.c                                          |  10 +-
 mm/vmalloc.c                                       |   2 +-
 mm/vmscan.c                                        |   2 +-
 net/ax25/af_ax25.c                                 |   6 +
 net/ax25/ax25_dev.c                                |   2 +-
 net/bluetooth/hci_sync.c                           |   2 +-
 net/bluetooth/l2cap_core.c                         |  12 +-
 net/bpf/test_run.c                                 |   6 +
 net/bridge/br_mst.c                                |  13 +-
 net/core/dev.c                                     |   3 +-
 net/core/dst_cache.c                               |   2 +
 net/core/rtnetlink.c                               |  44 ++-
 net/ethtool/ioctl.c                                |   2 +-
 net/ethtool/tsinfo.c                               |   6 +-
 net/ipv4/devinet.c                                 |   2 +-
 net/ipv4/fib_frontend.c                            |   7 +-
 net/ipv4/tcp.c                                     |   9 +-
 net/ipv4/tcp_ao.c                                  |  13 +-
 net/ipv4/tcp_timer.c                               |   6 +-
 net/ipv6/ila/ila_lwt.c                             |   7 +-
 net/ipv6/ioam6_iptunnel.c                          |   8 +-
 net/ipv6/ip6_fib.c                                 |   6 +-
 net/ipv6/netfilter.c                               |   1 +
 net/ipv6/route.c                                   |   5 +-
 net/ipv6/rpl_iptunnel.c                            |  14 +-
 net/ipv6/seg6_iptunnel.c                           |  14 +-
 net/ipv6/tcp_ipv6.c                                |   3 +-
 net/mac80211/cfg.c                                 |   9 +-
 net/mac80211/he.c                                  |  10 +-
 net/mac80211/ieee80211_i.h                         |   2 +
 net/mac80211/main.c                                |  10 +-
 net/mac80211/mesh.c                                |   1 +
 net/mac80211/mesh_pathtbl.c                        |  13 +
 net/mac80211/parse.c                               |   2 +-
 net/mac80211/scan.c                                |  14 +-
 net/mac80211/sta_info.c                            |   4 +-
 net/mac80211/util.c                                |   2 +
 net/mptcp/pm_netlink.c                             |  21 +-
 net/mptcp/protocol.c                               |  10 +-
 net/ncsi/internal.h                                |   2 +
 net/ncsi/ncsi-manage.c                             |  73 ++--
 net/ncsi/ncsi-rsp.c                                |   4 +-
 net/netfilter/ipset/ip_set_core.c                  |  81 ++--
 net/netfilter/ipset/ip_set_list_set.c              |  30 +-
 net/netfilter/nft_meta.c                           |   3 +
 net/netfilter/nft_payload.c                        |   4 +
 net/sched/sch_generic.c                            |   1 +
 net/sched/sch_multiq.c                             |   2 +-
 net/sched/sch_taprio.c                             |  15 +-
 net/smc/af_smc.c                                   |  22 +-
 net/sunrpc/auth_gss/auth_gss.c                     |   4 +-
 net/sunrpc/auth_gss/svcauth_gss.c                  |   2 +-
 net/unix/af_unix.c                                 | 108 +++---
 net/unix/diag.c                                    |  12 +-
 net/wireless/core.c                                |   2 +-
 net/wireless/pmsr.c                                |   8 +-
 net/wireless/rdev-ops.h                            |   6 +-
 net/wireless/scan.c                                |  50 ++-
 net/wireless/sysfs.c                               |   4 +-
 net/wireless/util.c                                |   7 +-
 net/xdp/xsk.c                                      |   5 +-
 scripts/atomic/kerneldoc/sub_and_test              |   2 +-
 scripts/kconfig/confdata.c                         |  13 -
 scripts/kconfig/expr.c                             |  29 --
 scripts/kconfig/expr.h                             |   1 -
 scripts/kconfig/gconf.c                            |   3 +-
 scripts/kconfig/menu.c                             |   2 -
 scripts/link-vmlinux.sh                            |   2 +-
 scripts/mod/modpost.c                              |   5 +-
 security/tomoyo/Kconfig                            |   2 +-
 security/tomoyo/common.c                           |   2 +-
 tools/arch/arm64/include/asm/cputype.h             |   6 +
 tools/arch/x86/include/asm/msr-index.h             |   9 +-
 tools/arch/x86/include/uapi/asm/kvm.h              |  22 +-
 tools/include/uapi/asm-generic/unistd.h            |   5 +-
 tools/include/uapi/drm/i915_drm.h                  |  31 +-
 tools/include/uapi/linux/kvm.h                     |   4 +-
 tools/include/uapi/linux/stat.h                    |   4 +-
 tools/lib/bpf/features.c                           |   3 +-
 tools/perf/Makefile.perf                           |   1 +
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |   1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   3 +-
 tools/perf/builtin-record.c                        |   6 +-
 tools/perf/builtin-trace.c                         |   2 +-
 .../beauty/arch/x86/include/asm/irq_vectors.h      |   8 +-
 tools/perf/trace/beauty/include/linux/socket.h     |   3 +-
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h |  14 +-
 tools/perf/trace/beauty/include/uapi/linux/prctl.h |  22 ++
 tools/perf/trace/beauty/include/uapi/linux/stat.h  |   4 +-
 tools/power/cpupower/utils/helpers/amd.c           |  26 +-
 tools/testing/cxl/test/mem.c                       |   1 +
 tools/testing/selftests/alsa/Makefile              |   2 +-
 .../selftests/bpf/progs/test_sk_storage_tracing.c  |   2 +-
 tools/testing/selftests/cachestat/test_cachestat.c |   1 +
 .../selftests/filesystems/overlayfs/dev_in_maps.c  |   1 +
 tools/testing/selftests/ftrace/config              |  26 +-
 .../ftrace/test.d/dynevent/test_duplicates.tc      |   2 +-
 .../ftrace/test.d/filter/event-filter-function.tc  |  20 +-
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       |   3 +-
 tools/testing/selftests/futex/Makefile             |   2 -
 tools/testing/selftests/futex/functional/Makefile  |   2 +-
 .../selftests/futex/functional/futex_requeue_pi.c  |   2 +-
 tools/testing/selftests/kvm/Makefile               |   1 +
 .../selftests/kvm/s390x/shared_zeropage_test.c     | 111 ++++++
 tools/testing/selftests/net/hsr/config             |   1 +
 tools/testing/selftests/net/lib.sh                 |  18 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   5 +-
 tools/testing/selftests/openat2/openat2_test.c     |   1 +
 624 files changed, 7112 insertions(+), 3986 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili2901.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/fsl,dspi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/fsl,dspi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
 rename {include/linux => drivers/cpufreq}/amd-pstate.h (82%)
 create mode 100644 drivers/spi/spi-ch341.c
 create mode 100644 drivers/spi/spi-pxa2xx-platform.c
 create mode 100644 tools/testing/selftests/kvm/s390x/shared_zeropage_test.c

