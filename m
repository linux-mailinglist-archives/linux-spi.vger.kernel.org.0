Return-Path: <linux-spi+bounces-1228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3F84EA87
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 22:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2961C218AE
	for <lists+linux-spi@lfdr.de>; Thu,  8 Feb 2024 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6359E4F1E9;
	Thu,  8 Feb 2024 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES/os9hi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB94EB4F
	for <linux-spi@vger.kernel.org>; Thu,  8 Feb 2024 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427922; cv=none; b=ZcuIznnFRV21wXBvIKFADYdh9KTQDcXVx7bS+91S5MSGr4uJIK0O1qLUkmFp64AAphpqGpUxIv2ae/wO5wg17fBlSJDsDJkLo29qUd896X1VaB4jNZwvdrn8UoMwTxv0j8hHoJYhL05q4iKuPYfrYzh/PgG0sGS2iYBbmqV2Llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427922; c=relaxed/simple;
	bh=Wo0p+N0JKFfNlFZtBc3t5/EfL6nkaJVV3pLQHWKNwIM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=F79IRuyQknEtMtQN5Ho59RBal7Zc2MPM1FwtwANMmXOnNHkCUHTDpFwyst3M6ORgtTeE2nO6SVDae8BKp7D7RVev4iQkOp98GvGBoOmP0305jTULkMvIzbG82bekPkvGjJ0fKbgREGnMe6abQLKL/35zbT6n6dgG5OvwJIcnKGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES/os9hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4415C433F1;
	Thu,  8 Feb 2024 21:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707427921;
	bh=Wo0p+N0JKFfNlFZtBc3t5/EfL6nkaJVV3pLQHWKNwIM=;
	h=Subject:From:Date:To:From;
	b=ES/os9hiH7+TmL/poSH5sZbWeaIQO0Uy9vmmFKrgylETqeFv6Ev7zveb8mUJqwJ5w
	 kEGQt8A/r+CNoLJT7y1z6GrHCXponVbkn21LkNa8DdRPGLQGYo/ihfG9/Myaut3BGX
	 axgxj/hapQ5F0v7W6C4GS6t5ZgTXAuGMFmpZyICbRd0bBQmegASxYhg5e2MKAwqjAV
	 0nTP0OgtxlExJyyKoWAP0If4KmxOO64Mb9Aoq6uMQG3XdGWqzSE/gJ2hBUKELEvQsY
	 PZ05lWkZcTwHFAiEmWhjmidexO2xu/XGgggF4lO4/d3Sc0rwjrgVxIViZ1NcTda3mD
	 AztAKYtE3n+xA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80E27E2F2F0;
	Thu,  8 Feb 2024 21:32:01 +0000 (UTC)
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
 <170742792142.10103.13947120606117885373.git-patchwork-summary@kernel.org>
Date: Thu, 08 Feb 2024 21:32:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: get rid of some legacy macros
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=818763
  Lore link: https://lore.kernel.org/r/cover.1705944943.git.u.kleine-koenig@pengutronix.de
    Patches: [v2,01/33] fpga: ice40-spi: Follow renaming of SPI "master" to "controller"
             [v2,02/33] ieee802154: ca8210: Follow renaming of SPI "master" to "controller"
             [v2,03/33] iio: adc: ad_sigma_delta: Follow renaming of SPI "master" to "controller"
             [v2,04/33] Input: pxspad - follow renaming of SPI "master" to "controller"
             [v2,05/33] Input: synaptics-rmi4 - follow renaming of SPI "master" to "controller"
             [v2,06/33] media: mgb4: Follow renaming of SPI "master" to "controller"
             [v2,07/33] media: netup_unidvb: Follow renaming of SPI "master" to "controller"
             [v2,08/33] media: usb/msi2500: Follow renaming of SPI "master" to "controller"
             [v2,09/33] media: v4l2-subdev: Follow renaming of SPI "master" to "controller"
             [v2,10/33] misc: gehc-achc: Follow renaming of SPI "master" to "controller"
             [v2,11/33] mmc: mmc_spi: Follow renaming of SPI "master" to "controller"
             [v2,12/33] mtd: dataflash: Follow renaming of SPI "master" to "controller"
             [v2,14/33] net: ks8851: Follow renaming of SPI "master" to "controller"
             [v2,15/33] net: vertexcom: mse102x: Follow renaming of SPI "master" to "controller"
             [v2,16/33] platform/chrome: cros_ec_spi: Follow renaming of SPI "master" to "controller"
             [v2,18/33] spi: cadence-quadspi: Don't emit error message on allocation error
             [v2,19/33] spi: cadence-quadspi: Follow renaming of SPI "master" to "controller"
             [v2,20/33] spi: cavium: Follow renaming of SPI "master" to "controller"
             [v2,21/33] spi: geni-qcom: Follow renaming of SPI "master" to "controller"
             [v2,22/33] spi: loopback-test: Follow renaming of SPI "master" to "controller"
             [v2,23/33] spi: slave-mt27xx: Follow renaming of SPI "master" to "controller"
             [v2,24/33] spi: spidev: Follow renaming of SPI "master" to "controller"
             [v2,25/33] staging: fbtft: Follow renaming of SPI "master" to "controller"
             [v2,26/33] staging: greybus: spi: Follow renaming of SPI "master" to "controller"
             [v2,27/33] tpm_tis_spi: Follow renaming of SPI "master" to "controller"
             [v2,28/33] usb: gadget: max3420_udc: Follow renaming of SPI "master" to "controller"
             [v2,29/33] video: fbdev: mmp: Follow renaming of SPI "master" to "controller"
             [v2,30/33] wifi: libertas: Follow renaming of SPI "master" to "controller"
             [v2,31/33] spi: fsl-lib: Follow renaming of SPI "master" to "controller"
             [v2,32/33] spi: Drop compat layer from renaming "master" to "controller"
             [v2,33/33] Documentation: spi: Update documentation for renaming "master" to "controller"

Series: spi: s3c64xx: straightforward cleanup
  Submitter: Tudor Ambarus <tudor.ambarus@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=823938
  Lore link: https://lore.kernel.org/r/20240207120431.2766269-1-tudor.ambarus@linaro.org
    Patches: [v5,01/17] spi: s3c64xx: sort headers alphabetically
             [v5,02/17] spi: s3c64xx: explicitly include <linux/io.h>
             [v5,03/17] spi: s3c64xx: explicitly include <linux/bits.h>
             [v5,05/17] spi: s3c64xx: avoid possible negative array index
             [v5,06/17] spi: s3c64xx: fix typo, s/configuartion/configuration
             [v5,09/17] spi: s3c64xx: move common code outside if else
             [v5,10/17] spi: s3c64xx: check return code of dmaengine_slave_config()
             [v5,11/17] spi: s3c64xx: propagate the dma_submit_error() error code
             [v5,13/17] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
             [v5,14/17] spi: s3c64xx: drop blank line between declarations
             [v5,15/17] spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
             [v5,16/17] spi: s3c64xx: remove duplicated definition
             [v5,17/17] spi: s3c64xx: drop a superfluous bitwise NOT operation

Series: spi: get rid of some legacy macros
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=824080
  Lore link: https://lore.kernel.org/r/cover.1707324793.git.u.kleine-koenig@pengutronix.de
    Patches: [v3,16/32] spi: bitbang: Follow renaming of SPI "master" to "controller"
             [v3,17/32] spi: cadence-quadspi: Don't emit error message on allocation error
             [v3,18/32] spi: cadence-quadspi: Follow renaming of SPI "master" to "controller"
             [v3,19/32] spi: cavium: Follow renaming of SPI "master" to "controller"
             [v3,20/32] spi: geni-qcom: Follow renaming of SPI "master" to "controller"
             [v3,21/32] spi: loopback-test: Follow renaming of SPI "master" to "controller"
             [v3,22/32] spi: slave-mt27xx: Follow renaming of SPI "master" to "controller"
             [v3,23/32] spi: spidev: Follow renaming of SPI "master" to "controller"
             [v3,30/32] spi: fsl-lib: Follow renaming of SPI "master" to "controller"
             [v3,31/32] spi: Drop compat layer from renaming "master" to "controller"
             [v3,32/32] Documentation: spi: Update documentation for renaming "master" to "controller"

Series: spi: s3c64xx: winter cleanup and gs101 support
  Submitter: Tudor Ambarus <tudor.ambarus@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=819912
  Lore link: https://lore.kernel.org/r/20240125145007.748295-1-tudor.ambarus@linaro.org
    Patches: [v2,01/28] spi: s3c64xx: explicitly include <linux/io.h>
             [v2,03/28] spi: s3c64xx: avoid possible negative array index
             [v2,04/28] spi: dt-bindings: samsung: add google,gs101-spi compatible
             [v2,08/28] spi: s3c64xx: remove else after return
             [v2,11/28] spi: s3c64xx: move common code outside if else
             [v2,12/28] spi: s3c64xx: check return code of dmaengine_slave_config()
             [v2,13/28] spi: s3c64xx: propagate the dma_submit_error() error code
             [v2,14/28] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
             [v2,15/28] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
             [v2,17/28] spi: s3c64xx: drop blank line between declarations
             [v2,18/28] spi: s3c64xx: fix typo, s/configuartion/configuration
             [v2,19/28] spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props

Series: spi: s3c64xx: add support for google,gs101-spi
  Submitter: Tudor Ambarus <tudor.ambarus@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=823919
  Lore link: https://lore.kernel.org/r/20240207111516.2563218-1-tudor.ambarus@linaro.org
    Patches: [v2,1/4] spi: dt-bindings: samsung: add google,gs101-spi compatible
             [v2,2/4] spi: s3c64xx: prepare for a different flavor of iowrite rep
             [v2,3/4] spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep accessors
             [v2,4/4] spi: s3c64xx: add support for google,gs101-spi

Series: DMA Support for SPI in PCI1xxxx
  Submitter: Thangaraj Samynathan <thangaraj.s@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=823850
  Lore link: https://lore.kernel.org/r/20240207080621.30742-1-thangaraj.s@microchip.com
    Patches: [v3,SPI,for-next,1/2] spi: mchp-pci1xxxx: Add support for DMA in SPI
             [v3,SPI,for-next,2/2] spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf

Series: DMA Support for SPI in PCI1xxxx
  Submitter: Thangaraj Samynathan <thangaraj.s@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=823413
  Lore link: https://lore.kernel.org/r/20240206034118.748801-1-thangaraj.s@microchip.com
    Patches: [v2,SPI,for-next,1/3] spi: mchp-pci1xxxx: Add support for DMA in SPI


Total patches: 74

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



