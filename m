Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177EF2F4EBF
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 16:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbhAMPaB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 10:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbhAMPaA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 10:30:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6CBF23437;
        Wed, 13 Jan 2021 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551760;
        bh=nGEiIrAwYDk5cc5c0NbgmPR1wJr88iE3TYoINs3MD0M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SO9mYsO0CWGdgXgH1F3G8lkMK+h2voo/zRGmBXunTY/OYQiYa97ZTKKFjBqyXjrF7
         0P8LgRK5NsvYMG+UXyrcCTl9mMf3V4QWHIQtjz9F3VgOm4w5tqzCBuIAutAGDr9JSA
         LRJORWVqhwUAC7n0ITsjFF1hI5BoiCiM1WHkdUpiH6Z8yOcFApk6fOHgKQ0qc3yMHE
         Kt+jdLSwFX3Uq6vK8FV5w3tBvP4o93KdvBJdtXfHSrfXECSdwmbQiOLrBoKWHY9gkV
         oxZGCt9/Y2+QwL2pSadjwSB6Ic/qJoaDHmHryMYV2h0wmdWj5eoABQadaMMEgje5Xk
         0ZBePyxXhQQfQ==
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Akash Asthana <akashast@codeaurora.org>
In-Reply-To: <20210112001301.687628-1-swboyd@chromium.org>
References: <20210112001301.687628-1-swboyd@chromium.org>
Subject: Re: [PATCH v2] spi: spi-qcom-qspi: Use irq trigger flags from firmware
Message-Id: <161055171028.21847.10972334360743536171.b4-ty@kernel.org>
Date:   Wed, 13 Jan 2021 15:28:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 11 Jan 2021 16:13:01 -0800, Stephen Boyd wrote:
> We don't need to force this to be trigger high here, as the firmware
> properly configures the irq flags already. Drop it to save a line.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qcom-qspi: Use irq trigger flags from firmware
      commit: eaecba8767835783bdd2f4e72406668cda7d8d54

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
