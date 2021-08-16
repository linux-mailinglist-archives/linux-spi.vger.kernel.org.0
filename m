Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB603EDBFC
	for <lists+linux-spi@lfdr.de>; Mon, 16 Aug 2021 19:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhHPRFf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Aug 2021 13:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhHPRFf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Aug 2021 13:05:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA4CC60E76;
        Mon, 16 Aug 2021 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629133503;
        bh=2MfTOZHD9TI87+lfS9FZ9w1bRuykZIcLTr20xbCFSs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M89+DVBA2cPrgWKSC1h3Nqjc871mDYDmE7lt8nd8Ve58Z2J6FE57TaS6UKmQkHpZC
         TqzNKOYCcRSRvFLp8/rXfxI9T6uUzVtEq9n1ti8NKwYfz2W9h9OqMCkcnh3J1pioLm
         2vEFA0PGAJ7SWd9GvMRHfSR7iq67fHp/tNUpxbV8wGsNoKODy86pjyjU/hdfNmFRDv
         ClkfTmiXRtxlVJB2jeLgqVRaeV9U9WozT6zpBh3YyP9RgiOQYM+qYbp7q3573t3+/x
         O3QO++L9NqBsa1y6LekxaT7tIzqtUh6zZQ3nwD8hkk4yHqsTrNgmbFc9YvfsabelvT
         evs+vxZmn8TpQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Nathan Rossi <nathan@nathanrossi.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Nathan Rossi <nathan.rossi@digi.com>
Subject: Re: [PATCH] spi: orion: Prevent incorrect chip select behaviour
Date:   Mon, 16 Aug 2021 18:04:38 +0100
Message-Id: <162913253264.13726.7827917281505792734.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210816050228.3223661-1-nathan@nathanrossi.com>
References: <20210816050228.3223661-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 16 Aug 2021 05:02:28 +0000, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> When clearing the chip-select mask, the controller will switch to chip
> selecting the native CS0 line. Because the control register chip-select
> mask is not updated in a single write this will cause undesirable
> chip-selection of CS0 even when requesting to select other native
> chip-select lines. This is additionally problematic as the chip-select
> may still be asserted. With the ARMADA 38x SoC the controller will
> assert both the desired native chip-select and CS0.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: orion: Prevent incorrect chip select behaviour
      commit: ed14666c3f877c4c2a428a92bfeebfba3a4cfe2e

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
