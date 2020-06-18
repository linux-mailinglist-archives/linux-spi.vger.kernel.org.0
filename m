Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D01D1FF9AB
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbgFRQsz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 12:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgFRQsy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 12:48:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1709D208C7;
        Thu, 18 Jun 2020 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592498934;
        bh=JjYy4elxxB+2wBR7hAUU2Tjb0skJmcm3jUXYNY6Jq38=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FNKtWEyWKqxztlMMa/0EFi/o/yLTGyx7C/kLP+hw6kYFEh+cL+puFC/uZLMr/IV8H
         CC/T8I0fKH9brkUZq9gyAvaxTk8XUJ3IowINRZNe8lH2mQKIRVw44AFu/+Z6FYkxjf
         zQQaa6RxMAEAZGQ0ND+6+hKdYO4n4M+NN7gUiczA=
Date:   Thu, 18 Jun 2020 17:48:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Dilip Kota <dkota@codeaurora.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org
In-Reply-To: <20200616104050.84764-1-dianders@chromium.org>
References: <20200616104050.84764-1-dianders@chromium.org>
Subject: Re: [PATCH v3 0/5] spi: spi-geni-qcom: Fixes / perf improvements
Message-Id: <159249892720.8894.5843182459934461610.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 16 Jun 2020 03:40:45 -0700, Douglas Anderson wrote:
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

[1/1] spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
      commit: 539afdf969d6ad7ded543d9abf14596aec411fe9

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
