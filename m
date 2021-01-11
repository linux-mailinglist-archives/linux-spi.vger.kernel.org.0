Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB252F1AF0
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 17:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbhAKQac (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 11:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbhAKQab (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Jan 2021 11:30:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3C9E2076D;
        Mon, 11 Jan 2021 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610382591;
        bh=ErfxZFWurqb+Xsjw6YG/9WZ7cZchtIIaSJI3zox7pVU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lgSjhqyaduKGhXgoMNafkO5PHQje01xsK/0unrUZCP9kw51e9Odg80C8k2ekYwrg9
         ywGVeT7FhhpKHTmaf6psB8c/b7AAj41LmJ+3/jYRmeeb+1VeDoLdSmcamDeYspA73o
         2MEPhQNGy6wR4wY6bhlv1UFFDeZQkBqNczpAdfBCZt1dQUPZnsOZpQwS12h4NWdQNK
         spJ8b2W3bRka9Hvbuig4Mdb2Fr8BgUfH3FoCJ5viGe1xnNBOb2PCTh5OYyUi3HuNa7
         ueNtXZhyEw/C/PG9EdJQNDsQCOHKMRs4VtqQbe/y1ApNTngz7Yu90PEsdL5EtLjERT
         ugVk7k0uc9bpw==
From:   Mark Brown <broonie@kernel.org>
To:     YANG LI <abaci-bugfix@linux.alibaba.com>, kdasu.kdev@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <1610357189-60031-1-git-send-email-abaci-bugfix@linux.alibaba.com>
References: <1610357189-60031-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Subject: Re: [PATCH] spi: spi-bcm-qspi: style: Simplify bool comparison
Message-Id: <161038255869.32886.11006261963964555197.b4-ty@kernel.org>
Date:   Mon, 11 Jan 2021 16:29:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 11 Jan 2021 17:26:29 +0800, YANG LI wrote:
> Fix the following coccicheck warning:
> ./drivers/spi/spi-bcm-qspi.c:884:5-34: WARNING: Comparison to bool

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-bcm-qspi: style: Simplify bool comparison
      commit: 6650ab2a44268af8d24995d28ae199b57b2ebff8

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
