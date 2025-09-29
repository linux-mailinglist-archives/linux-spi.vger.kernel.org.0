Return-Path: <linux-spi+bounces-10352-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C640BBA9150
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 13:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B7B3B7AB4
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 11:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4717F3019CF;
	Mon, 29 Sep 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa4lMf94"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BA301710;
	Mon, 29 Sep 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146170; cv=none; b=j+9GEov8c2spKMwUqUBQpQw1L1Clyd5fI4Z1wGvPNqsDXIccQFKucaYM58gcjnhQ1WVux2EFQXJ0zSorTPLAAEnYHGSDusv6IIEHuGh0YtbDK8WyUBjKvilR73FISE9J+ck/Z3w6I5nAmVNb0CtXtM/ngr4e1Q+JYUAbLGa7pbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146170; c=relaxed/simple;
	bh=cDUNI++Cdhhh+27w7S9Gb/xbi27mfBOBj3pw8lK+YTA=;
	h=Message-ID:From:To:Cc:Subject:Date; b=YtnLip1VEXjxnZBaHSja1Pp97kFnr8FtYl7qjkbnfG/Hf8KCK7Wnto3x2t/N5Mjpns1QkzqtaEU9iGhlnIjVKC4D03ZOaglTqNW3rrvI7Fh9xJwO4a+XgjFmfdrZfbK/IGpqDpBB1vX9P+/BcPtt90i3FPsIIErYoFhdVq+o29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa4lMf94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AA1C4CEF4;
	Mon, 29 Sep 2025 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759146169;
	bh=cDUNI++Cdhhh+27w7S9Gb/xbi27mfBOBj3pw8lK+YTA=;
	h=From:To:Cc:Subject:Date:From;
	b=aa4lMf94P26k55Dq55YFFdvwoFWcMao/IiePh78gpDEDN0WvIhEdK4tSIE3zhVrr1
	 XTDP9n7/k2i8dU6ZfwTX77kcsUA73CXecMlHPifTLW3ocZhnh+3H0FfpQoRpcd6H14
	 grGZsNeJYYDIVPkSzb3aI+7kd1ZAen8+iMqzpDFsTJ2k5yL3pxZUXRD7fjs9ClC/Qr
	 9rTkkDRkN8RS6Q4rxzZumBgDvoLlzzNpwTfIWhmxWWPAnknsNhaMUPYB1F/Bky9aQA
	 sEIGyD+39S1ZVyp/RTiw3R1GyXCxDcA9xhJ3XJnbcImOkVNULNry4NlcU2yRZ/FmN7
	 lpDYUD7iDhciw==
Message-ID: <382d89fbfb545a45925ecee481f1847e@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.18
Date: Mon, 29 Sep 2025 12:42:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.18

for you to fetch changes up to 2bfb20b65d9bc1d0de58f8c28ca9d6f1d27bbc01:

  spi: rpc-if: Add resume support for RZ/G3E (2025-09-23 10:57:52 +0200)

----------------------------------------------------------------
spi: Updates for v6.18

There's one big core change in this release, Jonas Gorski has addressed
the issues with multiple chip selects which makes things more robust and
stable.  Otherwise there's quite a bit of driver work, as well as some
new drivers several existing drivers have had quite a bit of work done
on them.

Possibly the most interesting thing is the VirtIO driver, this is
apparently useful for some automotive applications which want to keep as
small and robust a host system as they can, moving less critical
functionality into guests.

 - James Clark has done some substantial updates on the Freescale DSPI
   driver, porting in code from the BSP and building onm top of that to
   fix some bugs and increase performance.
 - Jonas Gorski has fixed the issues with handling multple chip selects,
   making things more robust and scalable.
 - Support for higher performance modes in the NXP FSPI driver from
   Haibo Chen.
 - Removal of the obsolete S3C2443 driver, the underlying SoC support
   has been removed from the kernel.
 - Support for Amlogic AL113L2, Atmel SAMA7D65 and SAM9x7 and for VirtIO
   controllers.

----------------------------------------------------------------
Biju Das (2):
      spi: rpc-if: Drop deprecated SIMPLE_DEV_PM_OPS
      spi: rpc-if: Add resume support for RZ/G3E

Claudiu Beznea (1):
      spi: Drop dev_pm_domain_detach() call

Colin Ian King (1):
      spi: amlogic: Fix error checking on regmap_write call

Darshan R (1):
      spi: sunplus: sp7021: Clean up coding style

David Lechner (4):
      MAINTAINERS: merge TRIGGER SOURCE sections
      spi: offload trigger: adi-util-sigma-delta: clean up imports
      include: adi-axi-common: add version check function
      spi: axi-spi-engine: use adi_axi_pcore_ver_gteq()

Dharma Balasubiramani (2):
      dt-bindings: spi: Document sam9x7 QSPI
      dt-bindings: spi: Define sama7d65 QSPI

Feng Chen (2):
      spi: dt-bindings: add Amlogic A113L2 SFC
      spi: amlogic: add driver for Amlogic SPI Flash Controller

Gabor Juhos (5):
      spi: spi-qpic-snand: avoid double assignment in qcom_spi_probe()
      spi: spi-qpic-snand: remove unused 'dev' member of struct 'qpic_ecc'
      spi: spi-qpic-snand: remove 'clr*status' members of struct 'qpic_ecc'
      spi: spi-qpic-snand: handle 'use_ecc' parameter of qcom_spi_config_cw_read()
      spi: spi-qpic-snand: simplify clock handling by using devm_clk_get_enabled()

Haibo Chen (5):
      spi: spi-nxp-fspi: extract function nxp_fspi_dll_override()
      spi: spi-nxp-fspi: set back to dll override mode when clock rate < 100MHz
      spi: spi-nxp-fspi: Add the DDR LUT command support
      spi: spi-nxp-fspi: add the support for sample data from DQS pad
      spi: spi-nxp-fspi: Add OCT-DTR mode support

Haixu Cui (3):
      virtio: Add ID for virtio SPI
      virtio-spi: Add virtio-spi.h
      SPI: Add virtio SPI driver

James Clark (7):
      spi: fsl-dspi: Avoid using -EINPROGRESS error code
      spi: fsl-dspi: Store status directly in cur_msg->status
      spi: spi-fsl-dspi: Stub out DMA functions
      spi: spi-fsl-dspi: Use non-coherent memory for DMA
      spi: spi-fsl-dspi: Use whole page for DMA buffers
      spi: spi-fsl-dspi: Increase target mode DMA buffer size
      spi: spi-fsl-dspi: Report FIFO overflows as errors

Jonas Gorski (7):
      spi: fix return code when spi device has too many chipselects
      spi: keep track of number of chipselects in spi_device
      spi: move unused device CS initialization to __spi_add_device()
      spi: drop check for validity of device chip selects
      spi: don't check spi_controller::num_chipselect when parsing a dt device
      spi: reduce device chip select limit again
      spi: rename SPI_CS_CNT_MAX => SPI_DEVICE_CS_CNT_MAX

Krzysztof Kozlowski (2):
      spi: s3c64xx: Drop S3C2443
      spi: dt-bindings: samsung: Drop S3C2443

Liao Yuanhong (2):
      spi: bcm2835: Remove redundant semicolons
      spi: mtk-snfi: Remove redundant semicolons

Manikandan Muralidharan (3):
      spi: atmel: simplify MR register update in cs_activate()
      spi: dt-bindings: atmel,at91rm9200-spi: Add support for optional 'spi_gclk' clock
      spi: atmel: Add support for handling GCLK as a clock source

Mark Brown (15):
      Merge existing fixes from spi/for-6.17 into new branch
      spi: spi-qpic-snand: cleanup 'qpic_ecc' structure
      spi: offload-trigger: followup
      spi: use min_t() to improve code
      spi: Remove the use of dev_err_probe()
      add COMPILE_TEST support
      spi: spi-fsl-dspi: Target mode improvements
      support for Amlogic SPI Flash Controller IP
      spi: axi-spi-engine: improve version checks
      Miscellaneous fixes and clean-ups
      spi: spi-nxp-fspi: add DTR mode support
      Add QSPI support for sam9x7 and sama7d65 SoCs
      spi: multi CS cleanup and controller CS limit
      Virtio SPI Linux driver
      spi: rpc-if: Add resume support for RZ/G3E

Pratyush Yadav (2):
      spi: cadence-quadspi: Flush posted register writes before INDAC access
      spi: cadence-quadspi: Flush posted register writes before DAC access

Qianfeng Rong (4):
      spi: spi-fsl-lpspi: use min_t() to improve code
      spi: npcm-fiu: use min_t() to improve code
      spi: spl022: use min_t() to improve code
      spi: SPISG: Use devm_kcalloc() in aml_spisg_clk_init()

Rosen Penev (3):
      spi: rb4xx: depend on OF
      spi: rb4xx: add COMPILE_TEST support
      spi: rb4xx: use devm for clk_prepare_enable

Sakari Ailus (1):
      spi: ljca: Remove Wentong's e-mail address

Santhosh Kumar K (1):
      spi: cadence-quadspi: Fix cqspi_setup_flash()

Thomas Weißschuh (1):
      spi: loopback-test: Don't use %pK through printk

Tim Kuo (1):
      spi: mt65xx: add dual and quad mode for standard spi device

Varshini Rajendran (3):
      spi: atmel-quadspi: add padcalib, 2xgclk, and dllon capabilities
      spi: atmel-quadspi: add support for SAM9X7 QSPI controller
      spi: atmel-quadspi: Add support for sama7d65 QSPI

Vignesh Raghavendra (1):
      spi: cadence-quadspi: Use BIT() macros where possible

Waqar Hameed (1):
      spi: nxp-fspi: Remove error print for devm_add_action_or_reset()

Wolfram Sang (1):
      spi: remove unneeded 'fast_io' parameter in regmap_config

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spifc driver

Xichao Zhao (7):
      spi: spi_amd: Remove the use of dev_err_probe()
      spi: SPISG: Remove the use of dev_err_probe()
      spi: Remove the use of dev_err_probe()
      spi: mt65xx: Remove the use of dev_err_probe()
      spi: pxa2xx: Remove the use of dev_err_probe()
      spi: s3c64xx: Remove the use of dev_err_probe()
      spi: mxs: fix "transfered"->"transferred"

 .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  |   82 ++
 .../bindings/spi/atmel,at91rm9200-spi.yaml         |   11 +-
 .../devicetree/bindings/spi/atmel,quadspi.yaml     |    3 +
 .../devicetree/bindings/spi/samsung,spi.yaml       |    1 -
 MAINTAINERS                                        |   25 +-
 drivers/spi/Kconfig                                |   24 +-
 drivers/spi/Makefile                               |    2 +
 drivers/spi/atmel-quadspi.c                        |  134 ++-
 drivers/spi/spi-altera-platform.c                  |    1 -
 drivers/spi/spi-amd-pci.c                          |    5 +-
 drivers/spi/spi-amd.c                              |    2 +-
 drivers/spi/spi-amlogic-spifc-a4.c                 | 1222 ++++++++++++++++++++
 drivers/spi/spi-amlogic-spisg.c                    |    4 +-
 drivers/spi/spi-atmel.c                            |   78 +-
 drivers/spi/spi-axi-spi-engine.c                   |   17 +-
 drivers/spi/spi-bcm2835.c                          |    2 +-
 drivers/spi/spi-cadence-quadspi.c                  |   36 +-
 drivers/spi/spi-fsl-dspi.c                         |  232 ++--
 drivers/spi/spi-fsl-lpspi.c                        |    8 +-
 drivers/spi/spi-ljca.c                             |    2 +-
 drivers/spi/spi-loopback-test.c                    |   12 +-
 drivers/spi/spi-microchip-core-qspi.c              |    3 +-
 drivers/spi/spi-microchip-core.c                   |    3 +-
 drivers/spi/spi-mt65xx.c                           |   30 +-
 drivers/spi/spi-mtk-snfi.c                         |    1 -
 drivers/spi/spi-mxs.c                              |    2 +-
 drivers/spi/spi-npcm-fiu.c                         |    6 +-
 drivers/spi/spi-nxp-fspi.c                         |  117 +-
 .../spi/spi-offload-trigger-adi-util-sigma-delta.c |    5 +-
 drivers/spi/spi-pl022.c                            |   13 +-
 drivers/spi/spi-pxa2xx.c                           |    2 +-
 drivers/spi/spi-qpic-snand.c                       |   58 +-
 drivers/spi/spi-rb4xx.c                            |   36 +-
 drivers/spi/spi-rpc-if.c                           |   12 +-
 drivers/spi/spi-s3c64xx.c                          |   19 +-
 drivers/spi/spi-sunplus-sp7021.c                   |    6 +-
 drivers/spi/spi-virtio.c                           |  431 +++++++
 drivers/spi/spi.c                                  |   85 +-
 include/linux/adi-axi-common.h                     |   21 +
 include/linux/spi/spi.h                            |   16 +-
 include/uapi/linux/virtio_ids.h                    |    1 +
 include/uapi/linux/virtio_spi.h                    |  181 +++
 42 files changed, 2583 insertions(+), 368 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
 create mode 100644 drivers/spi/spi-amlogic-spifc-a4.c
 create mode 100644 drivers/spi/spi-virtio.c
 create mode 100644 include/uapi/linux/virtio_spi.h

