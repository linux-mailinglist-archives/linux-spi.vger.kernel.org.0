Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C477339860
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 21:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhCLU1I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 15:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234819AbhCLU0h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DAF864F84;
        Fri, 12 Mar 2021 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615580796;
        bh=fu+kGgm4qzieFTmHcK/JuBsoyQPQ9nadDIEi+NM6t6c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j2rEo+64fdPsIc6zRy2N0lEMXUyr6i5VK307b1CxRlPikSAK5PIaSJi1kZFr9biJX
         jVVnBXXxtr+zQX/EfNPRyuklpH4tfIh++11DLAwpKrfxZD2PQTmivNJkiVGNwXbF+W
         CdyatQ30MHwHqlvAf+2Ac/pdlkawP7tY/RxLHwmgJNGAjf5XQgn1gCMPwQKWkZxIBe
         2fs00yBRz+cI2ODEXpO+T41z5OCqISH5mXyNB5TWyWt+fhX+aJGwZjjyUt1LWWP35W
         8aIObKUsUlxOKSN4yFVI49BvBMBLHp6DYgknGYo4CeFpsTJI7INWV65bjvjCjREACC
         c7jiXjdTfPSNQ==
From:   Mark Brown <broonie@kernel.org>
To:     amelie.delaunay@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     linux-spi@vger.kernel.org, alexandre.torgue@foss.st.com,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <1615545329-5496-1-git-send-email-alain.volmat@foss.st.com>
References: <1615545329-5496-1-git-send-email-alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: avoid ifdef CONFIG_PM for pm callbacks
Message-Id: <161558072332.11700.9252088324748070873.b4-ty@kernel.org>
Date:   Fri, 12 Mar 2021 20:25:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 12 Mar 2021 11:35:29 +0100, Alain Volmat wrote:
> Avoid CONFIG_PM preprocessor check for pm suspend/resume
> callbacks and identify the functions with __maybe_unused.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: avoid ifdef CONFIG_PM for pm callbacks
      commit: 12ef51b116693bd77395a19ba135df68ee1673f0

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
