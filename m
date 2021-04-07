Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F273575FA
	for <lists+linux-spi@lfdr.de>; Wed,  7 Apr 2021 22:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356143AbhDGU1W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Apr 2021 16:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356306AbhDGU0z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 7 Apr 2021 16:26:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 564DF611CC;
        Wed,  7 Apr 2021 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617827205;
        bh=aBi+ztS1JcoQHX4AoXcwLhI2piOEHtrnfEvzNlbOAyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2w3YlXmQEzhw8sGgU8CvwdVE9XXYLC2Umo4SQJHUTdkF4Ffc83AXYa7/o+yA38SY
         Nhl67rL4IuJXLPdU72sIgazOtIPPYQFFVWZMUmH3BwEO+80E2ACj0bMyPvyaXhFlfT
         wCpi3aRvwdipZQWrUsfCF1rbvO/nAvmZiKEE/Dj1Ee/7fBcDvYDe9AoQBHgouf7fXu
         fMbRYh/f9gnOejaplgGrabJnX0yGOJ9UJ3mJRBzWLzLincHMuLZf8/R4wuS8tgo+p2
         Cti/K/Iwu/cgSSryFIAz1sxr3BIGaM63ebbl1y6mn/u0m3JDgiFCbfHpmAvgpLa8B+
         7OhmhT1nUOOzg==
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, huangdaode@huawei.com,
        sfr@canb.auug.org.au, linuxarm@huawei.com
Subject: Re: [PATCH-next] spi: hisi-kunpeng: Fix Woverflow warning on conversion
Date:   Wed,  7 Apr 2021 21:26:19 +0100
Message-Id: <161782716302.42932.3548818185133947415.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617762660-54681-1-git-send-email-f.fangjian@huawei.com>
References: <1617762660-54681-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 7 Apr 2021 10:31:00 +0800, Jay Fang wrote:
> Fix warning Woverflow on type conversion reported on x86_64:
> 
>   drivers/spi/spi-hisi-kunpeng.c:361:9: warning: conversion from 'long unsigned int' to 'u32'
>   {aka 'unsigned int'} changes value from '18446744073709551600' to '4294967280' [-Woverflow]
> 
> The registers are 32 bit, so fix by casting to u32.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: hisi-kunpeng: Fix Woverflow warning on conversion
      commit: 9a446cf97af70ee81ba177703b67ac4955a5edcc

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
