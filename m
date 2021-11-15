Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48B6451DC5
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 01:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbhKPAeG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 19:34:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345114AbhKOT0e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 14:26:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DAB4603E9;
        Mon, 15 Nov 2021 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637004069;
        bh=n4RSNS1q7HCJvn1KQvDmyb9KjGebaLgi1rOppNq++UU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SBG6SDGc4iPsi5ym3hlNu6MyXK/NRrPT8cY9Da1LLIhvc9SxlebJq1UwquTW/ptd4
         b+HOAf8ZUy5pgGPGI5SjOzCmQdfaBj5O1VYAX3IZyrB4gb0SpCSVy29eDUKFVrEmFj
         KparZuwHl+iR2jzL/uCnJ2L7M4J/Ba87Ngbqw7Oj29qeaDQxmcfM1Yu0l+Nnu6thnS
         gwIO9CQZTYNDMJXUJuLgJTybBQB4igZqmc89UNJzlTCJApn8lpiLvIY8yeVQtX5Qa4
         t9HjC975WYCOEmN2ManStcwHxwliyt2QRjRj2H6X9TM7jY/jQ/ZegV9u7lqsm936Lw
         oKbolq7eEfedA==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20211109103134.184216-1-alexander.stein@ew.tq-group.com>
References: <20211109103134.184216-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] spi: lpspi: release requested DMA channels
Message-Id: <163700406833.683472.6864557606413819705.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 19:21:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 9 Nov 2021 11:31:34 +0100, Alexander Stein wrote:
> The requested DMA channels are never released. Do this in .remove as well
> as in .probe. spi_register_controller() can return -EPROBE_DEFER if
> cs-gpios are not probed yet.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lpspi: release requested DMA channels
      commit: f02bff30114f385d53ae3e45141db602923bca5d

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
