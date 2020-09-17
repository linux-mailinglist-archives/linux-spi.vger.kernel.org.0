Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A099B26E4F2
	for <lists+linux-spi@lfdr.de>; Thu, 17 Sep 2020 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIQTDG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Sep 2020 15:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgIQS7W (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Sep 2020 14:59:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CBEC206A1;
        Thu, 17 Sep 2020 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369158;
        bh=K65b5uwu6BBJYEakQqZwyDE4NmNQ1SYNF7QpjWNx7GU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VQLIgC+SmSGnhdCSy1v8HyagZYCrooCkwhZwXg6vXCW2YqbBO2f82DKNQ7sb/pRqo
         OASWvXAc4gMcU8VFp63Rv1tsVX+7ug0QDGNUCh4QFcVdYWIF8z3iAp0AbLcYLz2V7F
         vhlyP4V3jZE/KyjEV+X6DNJuEKBBSutiWBx0jCe4=
Date:   Thu, 17 Sep 2020 19:58:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linuxarm@huawei.com, Jay Fang <f.fangjian@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     felipe.balbi@linux.intel.com, huangdaode@huawei.com
In-Reply-To: <1600132969-53037-1-git-send-email-f.fangjian@huawei.com>
References: <1600132969-53037-1-git-send-email-f.fangjian@huawei.com>
Subject: Re: [PATCH] spi: dw-pci: free previously allocated IRQs if desc->setup() fails
Message-Id: <160036909795.20353.12025424361553094408.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 15 Sep 2020 09:22:49 +0800, Jay Fang wrote:
> Free previously allocated IRQs when return an error code of desc->setup()
> which is not always successful. And simplify the code by adding a goto
> label.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw-pci: free previously allocated IRQs if desc->setup() fails
      commit: 9599f341889c87e56bb944659c32490d05e2532f

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
