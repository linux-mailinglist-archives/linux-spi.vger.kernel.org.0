Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0CD2EC003
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 16:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbhAFPAb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 10:00:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAFPAa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 Jan 2021 10:00:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26FF123110;
        Wed,  6 Jan 2021 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609945189;
        bh=NmLEKaHFaQj2FdVXf3M8f6wskoQf6jjP+lz/quwA+0I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Qv9F7qK/tJv/ZzILdFas5ooDo9Wv55uDWWxbtf+7wA2ky12xqxOqB46ms3OWIgrA8
         fgeBUnvh4Hy3IK3vawN43+jjFGLiHdWE7muoW2gH+oQfcnKdARKsXc8D+fTLoKdk6v
         7TiknfwYlXw1kExVh8XLX69j1jL37/r/TIF96cWLkJlnPrCd1B3SlXC2pXC4kUUVPm
         yUC3WBMRDWyra/DCTx02LjHZRWprwo+/V84G9e7WmKWKSm1S0CCthOgvv9YsRzLgni
         fsQCK8IEnjm2PfEUNOd1A9ZVsA0TDcRyl6VCTF/xrcM4+pbbXiiX4ELb2sAIn1uh/b
         kPv2NPVkQYiFw==
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20201222184425.7028-1-p.yadav@ti.com>
References: <20201222184425.7028-1-p.yadav@ti.com>
Subject: Re: [PATCH 0/7] spi: cadence-quadspi: Add Octal DTR support
Message-Id: <160994515510.52247.9169476392444387381.b4-ty@kernel.org>
Date:   Wed, 06 Jan 2021 14:59:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 23 Dec 2020 00:14:18 +0530, Pratyush Yadav wrote:
> This series adds support for Octal DTR mode now that SPI NOR supports
> these flashes. Patches 1/7 to 4/7 and 6/7 fix some minor bugs and issues.
> Patche 5/7 lays some groundwork by implementing the supports_op() hook.
> Patch 7/7 adds the Octal DTR mode support.
> 
> While the main aim of this series is to support 8D-8D-8D mode, other
> modes like 4D-4D-4D or 2S-2S-2S should also now be supported, though
> they have not been tested.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: cadence-quadspi: Set master max_speed_hz
      commit: 3a5c09c8d1ed9a7323f0e5c435021531f0865c16
[2/7] spi: cadence-quadspi: Abort read if dummy cycles required are too many
      commit: ceeda328edeeeeac7579e9dbf0610785a3b83d39
[3/7] spi: cadence-quadspi: Set dummy cycles from STIG commands
      commit: 888d517b992532df2b6115fbdc9620673ca7c651
[4/7] spi: cadence-quadspi: Fix dummy cycle calculation when buswidth > 1
      commit: 7512eaf54190e4cc9247f18439c008d44b15022c
[5/7] spi: cadence-quadspi: Implement a simple supports_op hook
      commit: a273596b9b50c76a9cc1f65d3eb7f8ab5c3eb3e3
[6/7] spi: cadence-quadspi: Wait at least 500 ms for direct reads
      commit: 0920a32cf6f20467aa133a47b776ee782daa889f
[7/7] spi: cadence-quadspi: Add DTR support
      commit: f453f293979fb648d2e505c132887811acb6bde6

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
