Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F7A4538C6
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbhKPRvi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 12:51:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239074AbhKPRva (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Nov 2021 12:51:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1875D61BE2;
        Tue, 16 Nov 2021 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637084910;
        bh=wIKh0WcsNtHmlfe5fOp7/cA+RTW7MaJZwB4/9JnEE6w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=puM+q2s2VWYQLzN+VqIEszcxfiQ9bVHnzHTNJow/lxc38/1jZPUrnvbdK6j6HjGlz
         p+UiggkVPALrNzHruqK8ANkWQsPzOLtk54CUxBp01GAmudSaVgRsH2ADCDoR+KbZWm
         IEpz/vshs7szDDvA5AlfdJ+DRyG8coqBecKyJsYPShFcwjnKjYD4SeEChHIxbSFnl/
         GxCzpmTTDlGGAGxochE4c/19Ox7i6KLrhX2dsLdz3HJjwQ+tyfadkgmiH7E3gsoKE/
         Pqzr7EJxNQ3ZZiRW91M6jZTNNUaDqjPafZIbvjVZ6l2V4oCCaPS3uf2gmlvlbbpxPr
         X3unXOA9YJl4A==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
In-Reply-To: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
References: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 0/7] spi: dw: Cleanup macros/funcs naming and add IP-core version support
Message-Id: <163708490881.808930.15381710289711581016.b4-ty@kernel.org>
Date:   Tue, 16 Nov 2021 17:48:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 15 Nov 2021 21:19:10 +0300, Serge Semin wrote:
> I was going to submit a cleanup patchset for the DW SSI driver for a
> long time, but due to lack of free time couldn't make it so far.
> Nandhini's series [1] made me to proceed with this task so mate would
> finally have his patchset accepted and merged into the mainline kernel.
> 
> There are four cleanup patches here and three feature patches. In the
> framework of the former patches we convert the DW SPI driver to using
> module namespaces and provide a better code organization. In particular
> the second part concerns the methods and macros naming unification (using
> a unified prefixes of the code object names) and the CSR fields macro
> implementation using the bitfield helpers available in the kernel. The
> later patches introduce the DW SSI IP-core versions interface so it
> could be used for a version-specific features implementation. Nandhini
> will be mostly interested in the later patches in the framework of his
> series [1].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: dw: Add a symbols namespace for the core module
      commit: a62bacba81c477a6fd8f15da593ad02305a3d6da
[2/7] spi: dw: Discard redundant DW SSI Frame Formats enumeration
      commit: 21b6b3809b840ad3d3f0689aac227929c04e9518
[3/7] spi: dw: Put the driver entities naming in order
      commit: 725b0e3ea899ff1cb799756ade302e7bc13a8559
[4/7] spi: dw: Convert to using the Bitfield access macros
      commit: ec77c086dc5b2eb422ff588f91cc011137fa9ea3
[5/7] spi: dw: Introduce Synopsys IP-core versions interface
      commit: 2cc8d9227bbba7d6f3790a86f1ff0d665a75f3b8
[6/7] spi: dw: Replace DWC_HSSI capability with IP-core version checker
      commit: 2b8a47e0b6984b9795baa20ddcbd37e9ea9b2a91
[7/7] spi: dw: Define the capabilities in a continuous bit-flags set
      commit: 44ebcb44584f81d1d38fafb45cf57d651f44616e

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
