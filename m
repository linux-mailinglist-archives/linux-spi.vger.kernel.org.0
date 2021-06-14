Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB33A6F7D
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jun 2021 21:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhFNT4Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 15:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhFNT4T (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BFF061166;
        Mon, 14 Jun 2021 19:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700456;
        bh=pfvyb0jidlarTsyWtWgnBF/ajfQV7+sJk6PrDnRx2Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYiZfiArLF5t+CmxdNLyMJk8Siy7II8mnXCsgrUJlVfcJ8Qnr4JdUGNkjYfMRHgwa
         NNXdWHAjyx+otL2JNZwcprX3BCokbyCwXAheUrgWJ2T9w2Iry5gaKJzoQsBk9qPIwO
         4pAXgU5/R/SDoPQEI7kIlqIG58MKCX+vgwGUy4NqJgBfKNsk5Q6j+ujH7Op7skwY7O
         nnI7kuL1K1A1oOxnyOmCGQMignRslxJzxGPkNIbqDwkHlGs3phqUXeto+SvMNr4Gno
         YTBgFkS9h/zUrzA02zTwHO0L6k+lh4jfWaM3eVMn2i+YZLjkZbo4LHztTBuFrKiWrH
         IiZzu8R8h36kQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] spi: spi-mem: fix doc warning in spi-mem.c
Date:   Mon, 14 Jun 2021 20:53:30 +0100
Message-Id: <162370043177.40904.6648020119213126524.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210601120721.3198488-1-yangyingliang@huawei.com>
References: <20210601120721.3198488-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 1 Jun 2021 20:07:21 +0800, Yang Yingliang wrote:
> Fix the following make W=1 warning:
> 
>   drivers/spi/spi-mem.c:819: warning: expecting prototype for spi_mem_driver_unregister_with_owner(). Prototype was for spi_mem_driver_unregister() instead

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: fix doc warning in spi-mem.c
      commit: 3acbacfcb3a78eb53d6fa7bc1599dcdaf043465e

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
