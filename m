Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83D32D7D61
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436686AbgLKRwn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:52:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391661AbgLKRwc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Dec 2020 12:52:32 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Simon Glass <sjg@chromium.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Alexandru M Stan <amstan@chromium.org>
In-Reply-To: <20201204193540.3047030-1-swboyd@chromium.org>
References: <20201204193540.3047030-1-swboyd@chromium.org>
Subject: Re: [PATCH 0/3] spi: spi-geni-qcom: Use gpio descriptors for CS
Message-Id: <160770909978.26609.8148318232199741085.b4-ty@kernel.org>
Date:   Fri, 11 Dec 2020 17:51:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 4 Dec 2020 11:35:37 -0800, Stephen Boyd wrote:
> Collected patches from the two series below and associated tags so they
> can be merged in one pile through the spi tree. Merry December!
> 
> SPI: https://lore.kernel.org/r/20201202214935.1114381-1-swboyd@chromium.org
> cros-ec: https://lore.kernel.org/r/20201203011649.1405292-1-swboyd@chromium.org
> 
> Cc: Akash Asthana <akashast@codeaurora.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] platform/chrome: cros_ec_spi: Don't overwrite spi::mode
      commit: 74639cbf51d7c0304342544a83dfda354a6bd208
[2/3] platform/chrome: cros_ec_spi: Drop bits_per_word assignment
      commit: 7a5172b7990d97ab9ef64e6d9063aa68099ea023
[3/3] spi: spi-geni-qcom: Use the new method of gpio CS control
      commit: 3b25f337929e73232f0aa990cd68a129f53652e2

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
