Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400F13A7DCF
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jun 2021 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFOMIu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Jun 2021 08:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFOMIu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 15 Jun 2021 08:08:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C00261241;
        Tue, 15 Jun 2021 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623758805;
        bh=iwWAkQ8EfNfDiQN/eE3yRH0S5JId26sWMt3fVK6SYcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUFveoZXLqxxFiTBpI1+cztF4OfFgqVZJ1oejVT9SFRej9rSDvUpnoDgFi+KYjEoB
         CcYtm+FabcJArVao1zV5nOkWTs+StRSxreRahPbYvHPUczOkPF6ZEUW3qOxQhIjVU5
         rwOd+49RMGKmRcnb9EJUhjboHqnDQGwPR4OLgFVRp6TUvYiAB7avg8QCsa+httyt4W
         98Tz4gW5i2WoxygaI8W5/EF2RSIYv9WM42btkTLu6Psit5ag/BZ0en5/Cfo3ybcjf6
         fL8QftA+GWm675J8JF6ja4M5Up5oWpy+7kth2RvNxNpbfAMXVcT2HIs6STNn5Nz8va
         0axpT+/iak8wQ==
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v1] spi: add of_device_uevent_modalias support
Date:   Tue, 15 Jun 2021 13:06:24 +0100
Message-Id: <162375864905.30995.4383174665749502852.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525091003.18228-1-m.felsch@pengutronix.de>
References: <20210525091003.18228-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 May 2021 11:10:03 +0200, Marco Felsch wrote:
> Add OF support as already done for ACPI to take driver
> MODULE_DEVICE_TABLE(of, ..) into account.
> 
> For example with this change a spi nor device MODALIAS changes from:
> 
> MODALIAS=spi:spi-nor
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: add of_device_uevent_modalias support
      commit: 3ce6c9e2617ebc09b2d55cc88134b90c19ff6d31

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
