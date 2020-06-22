Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEB203A23
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jun 2020 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgFVO7p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jun 2020 10:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgFVO7p (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Jun 2020 10:59:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B08A20708;
        Mon, 22 Jun 2020 14:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592837985;
        bh=omX85vo/MUb3fVCU5fZbatl+q0rGgAnWht2MRheY7WY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HW/qIQW2aCc7KWWu1VOJjtYZbEW8t77d/oYyniNwqDxclRl6Ssg4odqksOL4lkbBm
         tbsWBsGAqgAlegUUnsWE/GWyqTfmKLt1UGU0nFUB35Lg73dlHeHBb/Lv6C6Z0DmeRq
         3HET/xbKKhmSaLLuNHq5StAzp5BHwtOF4DGjijAk=
Date:   Mon, 22 Jun 2020 15:59:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20200620022233.64716-1-swboyd@chromium.org>
References: <20200620022233.64716-1-swboyd@chromium.org>
Subject: Re: [PATCH v1 0/2] Some small spi geni cleanups
Message-Id: <159283798285.27744.2994917540889451941.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 19 Jun 2020 19:22:31 -0700, Stephen Boyd wrote:
> To follow onto Doug's latest spi geni series[1] this simplifies and
> reduces the code a little more.
> 
> [1] https://lore.kernel.org/r/20200618150626.237027-1-dianders@chromium.org
> 
> Stephen Boyd (2):
>   spi: spi-geni-qcom: Simplify setup_fifo_xfer()
>   spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily
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
