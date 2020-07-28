Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DCD230F4A
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jul 2020 18:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgG1Qbj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jul 2020 12:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1Qbi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Jul 2020 12:31:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35132074F;
        Tue, 28 Jul 2020 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595953898;
        bh=Y0EPEDkatR+hm/L7ATXN1AYrEx5ot0z2XTn8p1lfn9k=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XsRz5Yx7Izihr2u416eX8IBjcMS96IE8jzSRuNznwvv0+/j95cjao21EeiSrmjeZ3
         65A97uQibhrgzNSHlpxwWWbCufCCH30RGGIlVKkElq2eLBIvQnWU3Imy2fYJJZVZt6
         hArbZ6K4Vaqk3RsJ82a0O9wfFKLSIN2lacNA8/0k=
Date:   Tue, 28 Jul 2020 17:31:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20200727131742.82289-1-vaibhavgupta40@gmail.com>
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com> <20200727131742.82289-1-vaibhavgupta40@gmail.com>
Subject: Re: [PATCH v2] spi: spi-topcliff-pch: drop call to wakeup-disable
Message-Id: <159595388005.15302.1247752401935651695.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 27 Jul 2020 18:47:43 +0530, Vaibhav Gupta wrote:
> Before generic upgrade, both .suspend() and .resume() were invoking
> pci_enable_wake(pci_dev, PCI_D3hot, 0). Hence, disabling wakeup in both
> states. (Normal trend is .suspend() enables and .resume() disables the
> wakeup.)
> 
> This was ambiguous and may be buggy. Instead of replicating the legacy
> behavior, drop the wakeup-disable call.
> 
> [...]

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
