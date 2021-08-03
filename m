Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0193DF7EB
	for <lists+linux-spi@lfdr.de>; Wed,  4 Aug 2021 00:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhHCWgQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 18:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhHCWgP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2EA360F0F;
        Tue,  3 Aug 2021 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030164;
        bh=M8Yp9DwOjs9wg1bcoU70ceYBfFNn2hATYIOUwiuL0b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HW//43zbinu5KbJyFHeoqnLDC0A7/E1i0vHpwsfGxq0i67eLT7XssCOhysMgwPxhM
         FD4eEkduny3fCMfZxm+1EXVcHmVhkPhBw7vm3nckb6yF+CANMLkfBg7Fo1SNT7kKMs
         mqaTR+wF8NdXhXmewuXe9jz+48XKAgXA9r2qQUIAPVGDO8QJEMwqWnqDlxFyStXmP6
         IG4Ez8UCOmXZcHATSVzcmc6vxgbL5uCM0+aHw8CfhOkqWTyZcqmT2cY/WpZPQ73kxM
         uMwF5wE7dPf9rcJ2/TnK3Xch1L2dj6Izsldet77wox3J7Wfj03xs6YsMZZdKzcqZQN
         EJK8MgQXJDEIA==
From:   Mark Brown <broonie@kernel.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: imx: Implement support for CS_WORD
Date:   Tue,  3 Aug 2021 23:35:32 +0100
Message-Id: <162803013700.42391.3354054402447618822.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727124226.5571-1-u.kleine-koenig@pengutronix.de>
References: <20210727124226.5571-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 27 Jul 2021 14:42:26 +0200, Uwe Kleine-König wrote:
> This only works when the native chipselect is in use. On a board with a
> Ti ADS7950 8 channel ADC. This patch reduces the time to read out all
> channels once from 280 us to 20 us.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: Implement support for CS_WORD
      commit: 6e95b23a5b2d1fcbe5a84a362170a4871a3d5731

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
