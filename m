Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB768351327
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 12:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhDAKRW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 06:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233845AbhDAKQu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Apr 2021 06:16:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C05F56108B;
        Thu,  1 Apr 2021 10:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617272210;
        bh=/D8KExDdCxvtfXrh0oom2ZstMvfeYfgS+/IAEsjWZMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VE1T6TOZEAOinOwOXB0W5vFDj//VaRaPmJozKr+CBJ2Qxmaa84Rw9LgvnjkF31qD5
         6wJoSREHH+XbDJ5YOVPBjyLPH5WvM3hr8HhbtdMykVbvQqcFOIzNNQJQx5avb6Amzo
         8fyhIDsiHA9qkjicOOVLCtoGjb+UvgzdWH74kQLDG8l68yYluZXzhpDzkBCsLmCOhb
         9Co7JgAxl4Tdp2QWbYMsurluhrqyR9hWMb6mjwb6i2RVx1Rs7zpSCIHCuY1l3JKm6D
         tXR+MRwI5tillpcedy33kJvoqBFVBSYxbHbQQ8miNm2GhrQaMKp7jlTzJyWBJodwcr
         j5Q9ddVxFx3Jg==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nishanth Menon <nm@ti.com>, Pratyush Yadav <p.yadav@ti.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: (subset) [PATCH 0/4] Convert Cadence QSPI bindings to yaml
Date:   Thu,  1 Apr 2021 11:16:16 +0100
Message-Id: <161726952255.2486.16196604421904035265.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210326130034.15231-1-p.yadav@ti.com>
References: <20210326130034.15231-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Mar 2021 18:30:30 +0530, Pratyush Yadav wrote:
> This series picks up Ramuthevar's effort on converting the Cadence QSPI
> bindings to yaml [0]. During the conversion process, I discovered that
> some TI device tree files were not using the compatible correctly. Those
> are fixed in patches 1-3.
> 
> [0] https://patchwork.kernel.org/project/spi-devel-general/patch/20201116031003.19062-6-vadivel.muruganx.ramuthevar@linux.intel.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[4/4] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
      commit: e54338004c032b0bb556c7a56db8688454b6587e

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
