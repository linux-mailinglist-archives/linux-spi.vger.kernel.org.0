Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD80268E66
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgINOxr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 10:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgINOxD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 10:53:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D5020715;
        Mon, 14 Sep 2020 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095181;
        bh=AsI0ct1p0pSdYZEWWvAVB8iDbmMRuFTNg+a6hkNRQWE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aymJRNOxMA8Qc9bmaU2kHiSy9B6DLf9D8TdPoFAVExZ1uMn+alPEu+gmVZtwqPKam
         kVyStoINZUaUau9MjrtUe0EbNw2So4V5y+/RmJ9D6Pj4tp909hkvYUgrDUohQsXkUH
         spYRsQH/5eDFajqfrBzijucWSk6FdNl0fAGPlWzI=
Date:   Mon, 14 Sep 2020 15:52:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Barry Song <song.bao.hua@hisilicon.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, linuxarm@huawei.com,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20200910100246.32696-1-song.bao.hua@hisilicon.com>
References: <20200910100246.32696-1-song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] spi: spi-qcom-qspi: replace spin_lock_irqsave by spin_lock in hard IRQ
Message-Id: <160009511833.5702.994806427999782707.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Sep 2020 22:02:46 +1200, Barry Song wrote:
> It is redundant to do irqsave and irqrestore in hardIRQ context.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qcom-qspi: replace spin_lock_irqsave by spin_lock in hard IRQ
      commit: bfc430cab8234273c23885211818f704b2bd1da9

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
