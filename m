Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C04F230F55
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jul 2020 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbgG1Qb7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jul 2020 12:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbgG1Qb6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Jul 2020 12:31:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64575207F5;
        Tue, 28 Jul 2020 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595953918;
        bh=fMNQi5A+NN2YwKr4BGffFEl5pIiiOIfMgqPkYAoC4Ts=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=J5LDSWxez+sdvsG5Q86BG2VchGVcuv+Ij5o934S/xyclHizLJ/DeUsKu94yFSRiyF
         zNwCTBa0xwGxWL6dTrstVII8B1s3mfB1uLSceZ3HCheQ7am8GFyOsG2DpO0hh/SH35
         YHc30CVV2cx04Nx81hneZecSPYBBAikJZ+xk4m6c=
Date:   Tue, 28 Jul 2020 17:31:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20200727172936.661567-1-vaibhavgupta40@gmail.com>
References: <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com> <20200727172936.661567-1-vaibhavgupta40@gmail.com>
Subject: Re: [PATCH v3] spi: spi-topcliff-pch: drop call to wakeup-disable
Message-Id: <159595388005.15302.729932493645865477.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 27 Jul 2020 22:59:37 +0530, Vaibhav Gupta wrote:
> Before generic upgrade, both .suspend() and .resume() were invoking
> pci_enable_wake(pci_dev, PCI_D3hot, 0). Hence, disabling wakeup in both
> states. (Normal trend is .suspend() enables and .resume() disables the
> wakeup.)
> 
> This was ambiguous and may be buggy. Instead of replicating the legacy
> behavior, drop the wakeup-disable call.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-topcliff-pch: drop call to wakeup-disable
      commit: 15b413d93ccd0d26c29f005df82c299c8f14cbd6

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
