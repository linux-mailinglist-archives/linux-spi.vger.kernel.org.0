Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA98441D59
	for <lists+linux-spi@lfdr.de>; Mon,  1 Nov 2021 16:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhKAPYO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Nov 2021 11:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhKAPYN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Nov 2021 11:24:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9019160F3A;
        Mon,  1 Nov 2021 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635780100;
        bh=baAHbUigvTO/CD6m2/aWQjhtf/CMuA+tvhEeKPu8M70=;
        h=From:To:Cc:Subject:Date:From;
        b=oFDPZmDxslPm6C2cHxUIIG/8k+oLQ8H1Lowt7ZWInlnqTEyiWLRPjuvcN5D3x6si/
         HmqEsHuNkLS286vBnh8zr/HvZyEaa/kW+ukFY6hbS1mh0LU6yr2T+ZqW4Px2JLoFi5
         2Q8JYdwuT/F8ZS35c9bamAxeGog4XMzjVYYwU0qVLmnrLeebHAmYsDhHbB3Zm7Wpop
         +vFQbPvdRenUfdCHQZnbhSVY+GkiKoRBYzcy03stZs74ajNJH7sP63FNboTMFncUV9
         LpY6CG5nh+fXcWIiBXmg9RTBlxyQazFMlDOUBaThX/iqs3vtFOPAa4p1wfUn/PnKET
         1uBm7R/N+lpTw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v5.16
Date:   Mon, 01 Nov 2021 15:21:23 +0000
Message-Id: <20211101152139.9019160F3A@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 16a8e2fbb2d49111004efc1c7342e083eafabeb0:

  spi-mux: Fix false-positive lockdep splats (2021-10-14 13:32:19 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.16

for you to fetch changes up to 28b5eaf9712bbed90c2b5a5608d70a16b7950856:

  spi: Convert NXP flexspi to json schema (2021-10-29 18:56:02 +0100)

----------------------------------------------------------------
spi: Updates for v5.16

This is quite a quiet release for SPI, there's been a bit of cleanup to
the core from Uwe but nothing functionality wise.  We have added several
new drivers, Cadence XSPI, Ingenic JZ47xx, Qualcomm SC7280 and SC7180
and Xilinx Versal OSPI.

There's a trivial conflict in the Tegra driver that's been causing
issues.

----------------------------------------------------------------
Arnd Bergmann (2):
      spi: tegra20: fix build with CONFIG_PM_SLEEP=n
      spi: cadence-quadspi: fix dma_unmap_single() call

Artur Rojek (2):
      SPI: add Ingenic JZ47xx driver.
      MIPS: JZ4780: CI20: DTS: add SPI controller config

Colin Ian King (1):
      spi: cadence: Fix spelling mistake "nunber" -> "number"

Dmitry Osipenko (2):
      spi: tegra20-slink: Put device into suspend on driver removal
      spi: tegra210-quad: Put device into suspend on driver removal

Eddie James (2):
      spi: fsi: Print status on error
      spi: fsi: Fix contention in the FSI2SPI engine

Kamal Dasu (2):
      spi: bcm-qspi: Add mspi spcr3 32/64-bits xfer mode
      spi: bcm-qspi: add support for 3-wire mode for half duplex transfer

Krzysztof Kozlowski (3):
      spi: rspi: drop unneeded MODULE_ALIAS
      spi: sh-msiof: drop unneeded MODULE_ALIAS
      spi: s3c64xx: describe driver in KConfig

Kuldeep Singh (1):
      spi: Convert NXP flexspi to json schema

Lad Prabhakar (1):
      spi: spi-rpc-if: Check return value of rpcif_sw_init()

Lucas Tanure (4):
      spi: amd: Refactor code to use less spi_master_get_devdata
      spi: amd: Refactor amd_spi_busy_wait
      spi: amd: Remove unneeded variable
      spi: amd: Don't wait for a write-only transfer to finish

Mark Brown (8):
      Merge existing fixes from spi/for-5.15
      Merge series "Support for Ingenic JZ47xx SPI controller" from Artur Rojek <contact@artur-rojek.eu>:
      Merge branch 'spi-5.15' into spi-5.16
      Merge series "add support for Cadence's XSPI controller" from Parshuram Thombare <pthombar@cadence.com>:
      Merge branch 'spi-5.15' into spi-5.16
      Merge series "spi: Various Cleanups" from Uwe Kleine-König <u.kleine-koenig@pengutronix.de>:
      Merge series "spi-bcm-qspi spcr3 enahancements" from Kamal Dasu <kdasu.kdev@gmail.com>:
      Merge branch 'spi-5.15' into spi-5.16

Maíra Canal (1):
      spi: at91-usart: replacing legacy gpio interface for gpiod

Parshuram Thombare (3):
      spi: cadence: add dt-bindings documentation for Cadence XSPI controller
      spi: cadence: add support for Cadence XSPI controller
      spi: cadence: fix static checker warning

Paul Cercueil (1):
      dt-bindings: spi: Document Ingenic SPI controller bindings

Qing Wang (1):
      spi: replace snprintf in show functions with sysfs_emit

Rajesh Patil (2):
      spi: Add sc7280 support
      spi: Add sc7180 binding

Sai Krishna Potthuri (4):
      firmware: xilinx: Add OSPI Mux selection support
      dt-bindings: spi: cadence-quadspi: Add support for Xilinx Versal OSPI
      spi: cadence-quadspi: Add OSPI support for Xilinx Versal SoC
      spi: cadence-quadspi: Add Xilinx Versal external DMA support

Uwe Kleine-König (4):
      spi: Move comment about chipselect check to the right place
      spi: Remove unused function spi_busnum_to_master()
      spi: Reorder functions to simplify the next commit
      spi: Make several public functions private to spi.c

Vinod Koul (1):
      spi: spi-geni-qcom: Add support for GPI dma

Wan Jiabing (2):
      spi: orion: Add of_node_put() before goto
      spi: cadence: Add of_node_put() before return

Yang Yingliang (1):
      spi: bcm-qspi: Fix missing clk_disable_unprepare() on error in bcm_qspi_probe()

Yoshitaka Ikeda (1):
      spi: Fixed division by zero warning

 .../bindings/interconnect/qcom,sdm660.yaml         |  46 +-
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  12 +
 .../devicetree/bindings/spi/cdns,xspi.yaml         |  77 +++
 .../devicetree/bindings/spi/ingenic,spi.yaml       |  72 +++
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |   6 +-
 .../devicetree/bindings/spi/spi-nxp-fspi.txt       |  44 --
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml      |  86 +++
 Documentation/hwmon/k10temp.rst                    |  17 -
 Documentation/spi/spi-summary.rst                  |   8 -
 MAINTAINERS                                        |  30 +-
 Makefile                                           |   2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile                   |   2 +-
 arch/arm64/kvm/perf.c                              |   3 -
 arch/arm64/kvm/pmu-emul.c                          |   9 +-
 arch/m68k/68000/entry.S                            |   4 -
 arch/m68k/Kconfig                                  |   1 -
 arch/m68k/coldfire/entry.S                         |   4 -
 arch/m68k/include/asm/processor.h                  |  31 +-
 arch/m68k/include/asm/segment.h                    |  59 --
 arch/m68k/include/asm/thread_info.h                |   3 -
 arch/m68k/include/asm/tlbflush.h                   |  11 +-
 arch/m68k/include/asm/traps.h                      |   4 +
 arch/m68k/include/asm/uaccess.h                    | 215 ++++---
 arch/m68k/kernel/asm-offsets.c                     |   2 +-
 arch/m68k/kernel/entry.S                           |  58 +-
 arch/m68k/kernel/process.c                         |   4 +-
 arch/m68k/kernel/signal.c                          | 199 +++----
 arch/m68k/kernel/traps.c                           |  13 +-
 arch/m68k/mac/misc.c                               |   1 -
 arch/m68k/mm/cache.c                               |  25 +-
 arch/m68k/mm/init.c                                |   6 -
 arch/m68k/mm/kmap.c                                |   1 -
 arch/m68k/mm/memory.c                              |   1 -
 arch/m68k/mm/motorola.c                            |   2 +-
 arch/m68k/sun3/config.c                            |   3 +-
 arch/m68k/sun3/mmu_emu.c                           |   6 +-
 arch/m68k/sun3/sun3ints.c                          |   1 -
 arch/m68k/sun3x/prom.c                             |   1 -
 arch/mips/boot/dts/ingenic/ci20.dts                |   9 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  44 +-
 arch/mips/net/bpf_jit.c                            |  57 +-
 arch/nios2/Kconfig.debug                           |   3 +-
 arch/nios2/kernel/setup.c                          |   2 -
 arch/s390/kvm/interrupt.c                          |   4 +-
 arch/s390/kvm/kvm-s390.c                           |   2 +-
 arch/s390/kvm/kvm-s390.h                           |   2 +-
 arch/x86/crypto/sm4-aesni-avx-asm_64.S             |   5 +-
 arch/x86/events/core.c                             |   1 +
 arch/x86/events/intel/core.c                       |   1 +
 arch/x86/include/asm/kvm_page_track.h              |   2 +-
 arch/x86/include/asm/kvmclock.h                    |  14 +
 arch/x86/kernel/kvmclock.c                         |  13 +-
 arch/x86/kvm/cpuid.c                               |   4 +-
 arch/x86/kvm/emulate.c                             |   3 +-
 arch/x86/kvm/hyperv.c                              |   7 +-
 arch/x86/kvm/hyperv.h                              |   2 +-
 arch/x86/kvm/ioapic.c                              |  10 +-
 arch/x86/kvm/mmu/mmu.c                             |  17 +-
 arch/x86/kvm/mmu/page_track.c                      |   4 +-
 arch/x86/kvm/mmu/paging_tmpl.h                     |  46 +-
 arch/x86/kvm/svm/nested.c                          |  10 +-
 arch/x86/kvm/svm/sev.c                             |  92 ++-
 arch/x86/kvm/svm/svm.c                             | 137 +++--
 arch/x86/kvm/svm/svm.h                             |   3 +-
 arch/x86/kvm/vmx/evmcs.c                           |  12 +-
 arch/x86/kvm/vmx/nested.c                          |  24 +-
 arch/x86/kvm/vmx/vmx.c                             |  39 +-
 arch/x86/kvm/vmx/vmx.h                             |   5 +-
 arch/x86/kvm/x86.c                                 |  28 +-
 arch/x86/net/bpf_jit_comp.c                        |  66 ++-
 block/bfq-iosched.c                                |  16 +-
 drivers/acpi/nfit/core.c                           |  12 +
 drivers/base/core.c                                |  90 ++-
 drivers/block/nbd.c                                |  29 +-
 drivers/crypto/ccp/ccp-ops.c                       |  14 +-
 drivers/firmware/xilinx/zynqmp.c                   |  17 +
 drivers/gpio/gpio-pca953x.c                        |  11 +-
 drivers/gpio/gpio-rockchip.c                       |  22 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  31 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |   8 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  15 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c           |   5 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   5 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   6 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |   4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   4 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |   5 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |   2 -
 .../drm/i915/gt/uc/abi/guc_communication_ctb_abi.h |  10 +-
 .../i915/gt/uc/abi/guc_communication_mmio_abi.h    |  10 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |   4 +-
 drivers/gpu/drm/i915/i915_request.c                |  11 +-
 drivers/gpu/drm/tegra/dc.c                         |   3 -
 drivers/gpu/drm/tegra/dc.h                         |   6 -
 drivers/gpu/drm/tegra/uapi.c                       |   2 +-
 drivers/gpu/host1x/fence.c                         |   6 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |   8 +-
 drivers/hid/hid-apple.c                            |   7 +
 drivers/hid/hid-betopff.c                          |  13 +-
 drivers/hid/hid-u2fzero.c                          |   4 +-
 drivers/hid/wacom_wac.c                            |   8 +
 drivers/hwmon/k10temp.c                            |   6 -
 drivers/hwmon/ltc2947-core.c                       |   8 +-
 drivers/hwmon/mlxreg-fan.c                         |  12 +-
 drivers/hwmon/occ/common.c                         |  17 +-
 drivers/hwmon/pmbus/ibm-cffps.c                    |  10 +-
 drivers/hwmon/pmbus/mp2975.c                       |   2 +-
 drivers/hwmon/tmp421.c                             |  71 ++-
 drivers/hwmon/w83791d.c                            |  29 +-
 drivers/hwmon/w83792d.c                            |  28 +-
 drivers/hwmon/w83793.c                             |  26 +-
 drivers/infiniband/core/cma.c                      |  51 +-
 drivers/infiniband/core/cma_priv.h                 |   1 +
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |   8 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |  31 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  13 +-
 drivers/infiniband/hw/irdma/cm.c                   |   4 +-
 drivers/infiniband/hw/irdma/hw.c                   |  14 +-
 drivers/infiniband/hw/irdma/i40iw_if.c             |   2 +-
 drivers/infiniband/hw/irdma/main.h                 |   1 -
 drivers/infiniband/hw/irdma/user.h                 |   2 +
 drivers/infiniband/hw/irdma/utils.c                |   2 +-
 drivers/infiniband/hw/irdma/verbs.c                |   9 +-
 drivers/infiniband/hw/qib/qib_sysfs.c              |   2 +-
 drivers/infiniband/hw/usnic/usnic_ib.h             |   2 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |   2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |  16 +-
 drivers/interconnect/qcom/sdm660.c                 |  25 +-
 drivers/iommu/apple-dart.c                         |  56 +-
 drivers/iommu/intel/dmar.c                         |   6 +-
 drivers/ipack/devices/ipoctal.c                    |  63 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.c        |  18 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.h        |  28 +-
 drivers/media/rc/ir_toy.c                          |  21 +-
 drivers/mmc/host/dw_mmc.c                          |  15 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   2 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |  17 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |   1 +
 drivers/net/dsa/mv88e6xxx/global1.c                |   2 +
 drivers/net/dsa/mv88e6xxx/port.c                   |   2 +
 drivers/net/ethernet/broadcom/bgmac-platform.c     |   3 +
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |   3 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   1 -
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  16 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   6 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  21 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  29 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  28 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  27 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  33 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |   2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   8 -
 drivers/net/ethernet/intel/e100.c                  |  22 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   8 +-
 drivers/net/ethernet/micrel/Makefile               |   6 +-
 drivers/net/ethernet/micrel/ks8851_common.c        |   8 +
 drivers/net/ethernet/pensando/ionic/ionic_stats.c  |   9 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   4 +
 drivers/net/ethernet/sun/Kconfig                   |   1 +
 drivers/net/hamradio/Kconfig                       |   1 +
 drivers/net/mdio/mdio-ipq4019.c                    |   6 +-
 drivers/net/mdio/mdio-mscc-miim.c                  |  15 +-
 drivers/net/mhi_net.c                              |   6 +-
 drivers/net/phy/bcm7xxx.c                          | 114 +++-
 drivers/net/phy/mdio_bus.c                         |   5 +
 drivers/net/phy/mxl-gpy.c                          |  23 +-
 drivers/net/usb/smsc95xx.c                         |   3 +
 drivers/net/wireless/mac80211_hwsim.c              |   4 +-
 drivers/nvdimm/pmem.c                              |   5 +-
 drivers/nvme/host/core.c                           |   4 +-
 drivers/nvme/host/nvme.h                           |   6 +
 drivers/nvme/host/pci.c                            |   3 +-
 drivers/perf/arm_pmu.c                             |   2 +
 drivers/pinctrl/core.c                             |   2 +-
 drivers/pinctrl/pinctrl-amd.c                      |  19 +-
 drivers/pinctrl/pinctrl-amd.h                      |   1 +
 drivers/pinctrl/pinctrl-rockchip.c                 |  67 +++
 drivers/pinctrl/pinctrl-rockchip.h                 |  10 +
 drivers/pinctrl/qcom/pinctrl-sc7280.c              |   1 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  37 +-
 drivers/ptp/ptp_kvm_x86.c                          |   9 +-
 drivers/s390/cio/blacklist.c                       |   8 +-
 drivers/s390/cio/css.c                             |  40 +-
 drivers/s390/cio/css.h                             |  10 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |   4 +-
 drivers/scsi/csiostor/csio_init.c                  |   1 +
 drivers/scsi/qla2xxx/qla_isr.c                     |   4 +-
 drivers/scsi/ses.c                                 |   2 +-
 drivers/scsi/ufs/ufshcd.c                          |   3 +-
 drivers/scsi/virtio_scsi.c                         |   4 +-
 drivers/spi/Kconfig                                |  26 +-
 drivers/spi/Makefile                               |   2 +
 drivers/spi/atmel-quadspi.c                        |   2 +-
 drivers/spi/spi-amd.c                              | 113 ++--
 drivers/spi/spi-at91-usart.c                       |  27 +-
 drivers/spi/spi-bcm-qspi.c                         | 193 ++++++-
 drivers/spi/spi-cadence-quadspi.c                  | 214 +++++++
 drivers/spi/spi-cadence-xspi.c                     | 642 +++++++++++++++++++++
 drivers/spi/spi-fsi.c                              | 121 ++--
 drivers/spi/spi-geni-qcom.c                        | 254 +++++++-
 drivers/spi/spi-ingenic.c                          | 482 ++++++++++++++++
 drivers/spi/spi-mtk-nor.c                          |   2 +-
 drivers/spi/spi-orion.c                            |   1 +
 drivers/spi/spi-rpc-if.c                           |   4 +-
 drivers/spi/spi-rspi.c                             |   1 -
 drivers/spi/spi-sh-msiof.c                         |   1 -
 drivers/spi/spi-stm32-qspi.c                       |   2 +-
 drivers/spi/spi-tegra20-slink.c                    |   6 +-
 drivers/spi/spi-tegra210-quad.c                    |   4 +-
 drivers/spi/spi-tle62x0.c                          |   2 +-
 drivers/spi/spi.c                                  | 237 +++-----
 drivers/staging/media/hantro/hantro_drv.c          |   2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_video.c  |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   5 +
 drivers/vdpa/vdpa_user/vduse_dev.c                 |  10 +-
 drivers/vfio/pci/vfio_pci_core.c                   |   2 +-
 drivers/vhost/vdpa.c                               |   2 +-
 drivers/virtio/virtio.c                            |   7 +-
 drivers/watchdog/Kconfig                           |   2 +-
 fs/binfmt_elf.c                                    |   2 +-
 fs/debugfs/inode.c                                 |   2 +-
 fs/ext4/dir.c                                      |   6 +-
 fs/ext4/ext4.h                                     |   3 -
 fs/ext4/extents.c                                  |  19 +-
 fs/ext4/fast_commit.c                              |   6 +
 fs/ext4/inline.c                                   | 150 ++---
 fs/ext4/inode.c                                    | 176 ++----
 fs/ext4/super.c                                    |  21 +-
 fs/io-wq.c                                         |   5 +-
 fs/io_uring.c                                      |  17 +-
 fs/kernfs/dir.c                                    |   9 +-
 fs/ksmbd/auth.c                                    | 205 -------
 fs/ksmbd/crypto_ctx.c                              |  16 -
 fs/ksmbd/crypto_ctx.h                              |   8 -
 fs/ksmbd/misc.c                                    |  17 +-
 fs/ksmbd/oplock.c                                  |  41 +-
 fs/ksmbd/smb2pdu.c                                 | 256 ++++++--
 fs/ksmbd/smb2pdu.h                                 |   9 +
 fs/ksmbd/smb_common.c                              |  47 +-
 fs/ksmbd/smb_common.h                              |   8 -
 fs/ksmbd/smbacl.c                                  |  21 +-
 fs/ksmbd/transport_tcp.c                           |   4 +-
 fs/vboxsf/super.c                                  |  12 +-
 fs/verity/enable.c                                 |   2 +-
 fs/verity/open.c                                   |   2 +-
 include/kvm/arm_pmu.h                              |   3 -
 include/linux/bpf.h                                |   3 +-
 include/linux/cpumask.h                            |   7 +-
 include/linux/firmware/xlnx-zynqmp.h               |  12 +
 include/linux/fwnode.h                             |  11 +-
 include/linux/kvm_host.h                           |   6 -
 include/linux/perf/arm_pmu.h                       |   6 +
 include/linux/perf_event.h                         |   4 +-
 include/linux/sched.h                              |   2 +-
 include/linux/spi/spi.h                            |  55 --
 include/net/ip_fib.h                               |   2 +-
 include/net/mac80211.h                             |   8 +-
 include/net/nexthop.h                              |   2 +-
 include/net/pkt_sched.h                            |   1 +
 include/net/sock.h                                 |  33 +-
 include/sound/rawmidi.h                            |   1 +
 include/trace/events/cachefiles.h                  |   2 +-
 include/uapi/sound/asound.h                        |   1 +
 kernel/bpf/bpf_struct_ops.c                        |   7 +-
 kernel/bpf/core.c                                  |   2 +-
 kernel/cgroup/cgroup.c                             |  17 +-
 kernel/events/core.c                               |  34 +-
 kernel/sched/debug.c                               |   8 +-
 kernel/sched/fair.c                                |   6 +-
 net/bpf/test_run.c                                 |  14 +-
 net/bridge/br_multicast.c                          |   6 +-
 net/bridge/br_private.h                            |   2 +-
 net/core/dev_addr_lists.c                          |   6 +
 net/core/sock.c                                    |  52 +-
 net/ipv4/fib_semantics.c                           |  16 +-
 net/ipv4/netfilter/iptable_raw.c                   |   2 +-
 net/ipv4/udp.c                                     |  10 +-
 net/ipv6/netfilter/ip6_tables.c                    |   1 +
 net/ipv6/route.c                                   |   5 +-
 net/ipv6/udp.c                                     |   2 +-
 net/mac80211/mesh_pathtbl.c                        |   5 +-
 net/mac80211/mesh_ps.c                             |   3 +-
 net/mac80211/rate.c                                |   4 -
 net/mac80211/rx.c                                  |   3 +-
 net/mac80211/tx.c                                  |  12 +
 net/mac80211/wpa.c                                 |   6 +
 net/mptcp/mptcp_diag.c                             |   2 +-
 net/mptcp/pm_netlink.c                             |   4 +-
 net/mptcp/protocol.c                               |   2 +-
 net/mptcp/protocol.h                               |   2 +-
 net/mptcp/subflow.c                                |   2 +-
 net/mptcp/syncookies.c                             |  13 +-
 net/mptcp/token.c                                  |  11 +-
 net/mptcp/token_test.c                             |  14 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |   4 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |   4 +
 net/netfilter/nf_conntrack_core.c                  | 154 +++--
 net/netfilter/nf_nat_core.c                        |  17 +-
 net/netfilter/nf_nat_masquerade.c                  | 168 +++---
 net/netfilter/nf_tables_api.c                      |  30 +-
 net/netfilter/nft_compat.c                         |  17 +-
 net/netfilter/xt_LOG.c                             |  10 +-
 net/netfilter/xt_NFLOG.c                           |  10 +-
 net/sched/cls_flower.c                             |   6 +
 net/sched/sch_api.c                                |   6 +
 net/sctp/input.c                                   |   2 +-
 net/unix/af_unix.c                                 |  83 ++-
 sound/core/rawmidi.c                               |   9 +
 sound/drivers/pcsp/pcsp_lib.c                      |   2 +-
 sound/firewire/motu/amdtp-motu.c                   |   7 +-
 sound/firewire/oxfw/oxfw.c                         |  13 +-
 sound/pci/hda/hda_intel.c                          |  12 +-
 sound/pci/hda/patch_cs8409.c                       |   3 +
 sound/pci/hda/patch_realtek.c                      | 129 +++++
 sound/pci/pcxhr/pcxhr_core.c                       |   2 +-
 sound/soc/fsl/fsl_esai.c                           |  16 +-
 sound/soc/fsl/fsl_micfil.c                         |  15 +-
 sound/soc/fsl/fsl_sai.c                            |  14 +-
 sound/soc/fsl/fsl_spdif.c                          |  14 +-
 sound/soc/fsl/fsl_xcvr.c                           |  15 +-
 sound/soc/intel/boards/sof_sdw.c                   |   5 +
 sound/soc/mediatek/Kconfig                         |   3 +
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |  19 +-
 .../mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c  |   7 +-
 sound/soc/sof/core.c                               |   4 +-
 sound/soc/sof/imx/imx8.c                           |   9 +-
 sound/soc/sof/imx/imx8m.c                          |   9 +-
 sound/soc/sof/loader.c                             |   8 +-
 sound/soc/sof/trace.c                              |   1 -
 sound/soc/sof/xtensa/core.c                        |   4 +-
 sound/usb/card.c                                   |  18 +-
 sound/usb/mixer.c                                  |  26 +-
 sound/usb/mixer.h                                  |   3 +-
 sound/usb/mixer_quirks.c                           |   2 +-
 tools/lib/bpf/linker.c                             |   8 +-
 tools/objtool/special.c                            |  38 +-
 tools/perf/Documentation/jitdump-specification.txt |   2 +-
 tools/perf/Documentation/perf-c2c.txt              |   2 +-
 tools/perf/Documentation/perf-intel-pt.txt         |   2 +-
 tools/perf/Documentation/perf-lock.txt             |   2 +-
 tools/perf/Documentation/perf-script-perl.txt      |   2 +-
 tools/perf/Documentation/perf-script-python.txt    |   2 +-
 tools/perf/Documentation/perf-stat.txt             |   2 +-
 tools/perf/Documentation/topdown.txt               |   2 +-
 tools/perf/arch/arm/util/auxtrace.c                |   8 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  24 +-
 tools/perf/arch/arm/util/perf_regs.c               |   2 +-
 tools/perf/arch/arm/util/pmu.c                     |   2 +-
 tools/perf/arch/arm/util/unwind-libdw.c            |   6 +-
 tools/perf/arch/arm/util/unwind-libunwind.c        |   4 +-
 tools/perf/arch/x86/util/iostat.c                  |   2 +-
 tools/perf/builtin-stat.c                          |   2 +
 .../perf/pmu-events/arch/powerpc/power8/other.json |   2 +-
 tools/perf/tests/code-reading.c                    |   4 +-
 tools/perf/tests/dwarf-unwind.c                    |  39 +-
 tools/perf/util/config.c                           |   2 +-
 tools/testing/selftests/bpf/Makefile               |   3 +-
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh   |  13 +-
 tools/testing/selftests/kvm/.gitignore             |   1 +
 tools/testing/selftests/kvm/Makefile               |   1 +
 .../selftests/kvm/access_tracking_perf_test.c      |   6 +-
 tools/testing/selftests/kvm/demand_paging_test.c   |  15 +-
 tools/testing/selftests/kvm/dirty_log_perf_test.c  |  62 +-
 tools/testing/selftests/kvm/include/test_util.h    |   4 +-
 .../selftests/kvm/include/x86_64/processor.h       |  34 +-
 tools/testing/selftests/kvm/kvm_page_table_test.c  |   7 +-
 tools/testing/selftests/kvm/lib/test_util.c        |  17 +-
 tools/testing/selftests/kvm/rseq_test.c            |  70 ++-
 tools/testing/selftests/kvm/steal_time.c           |   4 +-
 .../selftests/kvm/x86_64/svm_int_ctl_test.c        | 128 ++++
 tools/testing/selftests/netfilter/nft_nat_zones.sh | 309 ++++++++++
 .../testing/selftests/netfilter/nft_zones_many.sh  | 156 +++++
 virt/kvm/kvm_main.c                                |  68 ++-
 382 files changed, 6468 insertions(+), 2765 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/ingenic,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
 delete mode 100644 arch/m68k/include/asm/segment.h
 create mode 100644 drivers/spi/spi-cadence-xspi.c
 create mode 100644 drivers/spi/spi-ingenic.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
 create mode 100755 tools/testing/selftests/netfilter/nft_nat_zones.sh
 create mode 100755 tools/testing/selftests/netfilter/nft_zones_many.sh
