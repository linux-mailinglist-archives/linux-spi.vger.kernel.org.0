Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA92F4EC1
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAMPaG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 10:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbhAMPaG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 10:30:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05C7323383;
        Wed, 13 Jan 2021 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551765;
        bh=PHjVF9XXPvKg6/Tdjg1GEBq/X/hLVqnaQSAZDktWM6s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mw249fIN7eWt1+14k/RnfW88lJAHqPsy83R2WuvBH7KsID4IU770F4wtYGUlQAwYC
         iNFsda3CTiiOyYZ8bsf+R7SWhfsRf/Mw1vqqpIafJ9lLEfAI/PKMriN6LNn3t1trg9
         xM4OVVvNrR9SX9FNfF4X+SNAi61NWCIaGgiwVie4+RQ4TZPFRk5GZdWhv0JgvscxTS
         3XS6zMK7MxgffNqYXS8RUPZaZ+TqhN3R01QlvlAs2VUDDcYuFfgSmSLZdQQuu92enn
         lueuIvlHCSrilB+4W6cDwA+6Fh1Dyvu5KfdwkONavmtiMT7sU0j7unwmwS3Usj9bfV
         yU8384u8Iiesw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-spi@vger.kernel.org
Cc:     vigneshr@ti.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        p.yadav@ti.com, linux-mtd@lists.infradead.org
In-Reply-To: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v9 0/5] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC
Message-Id: <161055171029.21847.3382759454400721764.b4-ty@kernel.org>
Date:   Wed, 13 Jan 2021 15:28:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 24 Nov 2020 12:18:35 +0800, Ramuthevar, Vadivel MuruganX wrote:
> Add QSPI controller support for Intel LGM SoC.
> 
> Patches to move move bindings over to
> "Documentation/devicetree/bindings/spi/" directory and also added compatible
> Support for Intel platform.
> 
> dt-bindings: spi: cadence-qspi: Add support for Intel lgm-qspi
> (earlier patch mail thread and Ack-by)
> link: "https://lore.kernel.org/lkml/5d6d1b85.1c69fb81.96938.0315@mx.google.com/"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
      commit: ab2d28750aacb773dc42d72fbad59146e8a6db5e
[2/5] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
      commit: ad2775dc3fc5d30dd51984ccbaa736cc7ea9caca
[3/5] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
      commit: b436fb7d29bfa48ff5e00cbf413609c7a6d4d81e
[4/5] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
      commit: eb4aadc31ef4224b926d5165048cb297f4bda34f
[5/5] dt-bindings: spi: cadence-qspi: Add support for Intel lgm-qspi
      commit: fcebca39938fa9f6ed03f27fc75645ad7fd489e9

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
