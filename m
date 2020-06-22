Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B9E203A24
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jun 2020 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgFVO7u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jun 2020 10:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbgFVO7u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Jun 2020 10:59:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D8120708;
        Mon, 22 Jun 2020 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592837990;
        bh=Rx2z5NK4KKWGugSx/gn2fQ0uqFJxseGFeORbKEalUZo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TJu5TXG41tQCWC7LsG9K03BGGRlZnAOiUz/UGAsvM81TRTQjg9Kl63hvGSB/laIvR
         O6CCqAku+1RJ5kOzAZ6+hSdp5NMiEY23Z6hbX2nTHfgMh1awDc2a65OlRZXZtNWgdo
         1cw6XA2eqZu3ElebDbYR7ADimZGC9/rpdWQ3o50w=
Date:   Mon, 22 Jun 2020 15:59:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     swboyd@chromium.org, Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, skakit@codeaurora.org,
        linux-spi@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
Subject: Re: [PATCH v4 0/5] spi: spi-geni-qcom: Fixes / perf improvements
Message-Id: <159283798284.27744.9640256219140180318.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 18 Jun 2020 08:06:21 -0700, Douglas Anderson wrote:
> This patch series is a new version of the previous patch posted:
>   [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt
>   https://lore.kernel.org/r/20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid
> 
> At this point I've done enough tracing to know that there was a real
> race in the old code (not just weakly ordered memory problems) and
> that should be fixed with the locking patches.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-geni-qcom: Simplify setup_fifo_xfer()
      commit: 0d574c6b59c6ac0ae5b581a2ffb813d446a50a3d
[2/2] spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily
      (no commit info)

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
