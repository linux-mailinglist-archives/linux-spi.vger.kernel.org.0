Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBEC248C42
	for <lists+linux-spi@lfdr.de>; Tue, 18 Aug 2020 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgHRQ7g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Aug 2020 12:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbgHRQ6M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Aug 2020 12:58:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FB020825;
        Tue, 18 Aug 2020 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769881;
        bh=Y0JyT1VBXWla9wUbnH2/QclnosDNqZICZilelSmjd8M=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wZcymM8MsArDbP4k76safGV4LS+DoI2LzG5+sN7l48vmcBkLUk3dsLAJxuRovfkdH
         0R6LIvQPti4WQOjC1mM3W74TDeR4OlrX0FkPdBqWiZvxEt9Z/+csJ9iDY0eI3+QCSK
         Ziarl9BA5k1GrRltlMCZ1BWzbO8km6i3KhG8XYuE=
Date:   Tue, 18 Aug 2020 17:57:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     xiaoning.wang@nxp.com, linux-spi@vger.kernel.org
In-Reply-To: <20200817235812.19518-1-festevam@gmail.com>
References: <20200817235812.19518-1-festevam@gmail.com>
Subject: Re: [PATCH] spi: lpspi: Remove CONFIG_PM_SLEEP ifdefery
Message-Id: <159776983047.56565.9470268746172574515.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 17 Aug 2020 20:58:12 -0300, Fabio Estevam wrote:
> Use __maybe_unused for the suspend()/resume() hooks and get rid of
> the CONFIG_PM_SLEEP ifdefery to improve the code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lpspi: Remove CONFIG_PM_SLEEP ifdefery
      commit: c3158a891bcc4c79523804e0d09a195fb1f815b4

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
