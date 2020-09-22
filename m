Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8DA27370F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgIVAHR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 20:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgIVAHQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Sep 2020 20:07:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C0A3207C4;
        Tue, 22 Sep 2020 00:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733235;
        bh=jTcLwk2meC5XIRV3w91joYvcB3r3fu8MLecHbdXctwM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EhjjpEYWVdPCF5KrCkF1W7Jduw/uUEdmwjlmXRMHe5Lp1S5FeSr7UFBOwx4UUe0GH
         qFqAnIC9cbcOe26gofFAxwsvprIJOtfn9SrShbMwiilcuupscjY84Y04poZSIVtaa/
         6FUlybf9xygrcM7rs/CJP+tU4/KE078ffrG7gYJ0=
Date:   Tue, 22 Sep 2020 01:06:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tali Perry <tali.perry1@gmail.com>, Nancy Yuen <yuenn@google.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Avi Fishman <avifishman70@gmail.com>
Cc:     openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200921131106.93228-1-miaoqinglang@huawei.com>
References: <20200921131106.93228-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] spi: npcm-fiu: simplify the return expression of npcm_fiu_probe()
Message-Id: <160073317818.6418.1783401283377039582.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Sep 2020 21:11:06 +0800, Qinglang Miao wrote:
> Simplify the return expression.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: npcm-fiu: simplify the return expression of npcm_fiu_probe()
      commit: 4c3a14fbc05a09fc369fb68a86cdbf6f441a29f2

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
