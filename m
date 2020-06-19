Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62753200A0E
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbgFSN20 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 09:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732737AbgFSN2L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 09:28:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C552921582;
        Fri, 19 Jun 2020 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592573291;
        bh=woHoEU4qR1vtVDk6B4g7zX0biyS6r/lidqoPWMRgCmo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=oWAUvvSiXpJTenQdhbrdO2GPm2gCTdYtqIZ+XfDE4nNQILPYHkEWQkHefSeZX5ej7
         Q6ChI282ZFvsbrJk0hfvmXKhRFSnFuiVtPgIwkBv5hOFshKzeBjH3eoz9KV910p+m1
         bcP8m0pxd0npcncMY85QRiKi5+PLtaWpE1V7VcYQ=
Date:   Fri, 19 Jun 2020 14:28:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     skakit@codeaurora.org, linux-spi@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alok Chauhan <alokc@codeaurora.org>
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
Subject: Re: [PATCH v4 0/5] spi: spi-geni-qcom: Fixes / perf improvements
Message-Id: <159257327821.5984.3382372060351730090.b4-ty@kernel.org>
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

[1/4] spi: spi-geni-qcom: Mo' betta locking
      commit: 2ee471a1e28ec79fbfcdc8900ed0ed74132b0efe
[2/4] spi: spi-geni-qcom: Check for error IRQs
      commit: e191a082d764e80a36c198da61fbf2851ebf425a
[3/4] spi: spi-geni-qcom: Actually use our FIFO
      commit: 902481a78ee4173926dc59f060526dee21aeb7a8
[4/4] spi: spi-geni-qcom: Don't keep a local state variable
      commit: 7ba9bdcb91f694b0eaf486a825afd9c2d99532b7

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
