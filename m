Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED62B414BB6
	for <lists+linux-spi@lfdr.de>; Wed, 22 Sep 2021 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhIVOX5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Sep 2021 10:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233079AbhIVOX4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Sep 2021 10:23:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5570B611C9;
        Wed, 22 Sep 2021 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632320546;
        bh=4cJZ5I6cxt16Zn/TWjWztzP7sL+qEV4/h+OKC342ltI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGLwaWGg1d2TaAvbe7UgnTJt74d+9fXqpiIhu5d1kSP3CVdCSpmD//WCvIJLflCKX
         XFNVqg5Ldb9jW6ZQ0slmZZ/ryOUV11VIxy1Vng0S5ibiIcHg2M7puxkgxhdUCFBks0
         NCr3/5MRDffbb/52+TnzBnoWhRQFCiVpvfRkfvupMuvTUQu8C8KgX/Hb+xZ9LixuG9
         jbXSjyiCMNOkt7GUWiopt1/S/2MRi4iP57G7qk85AhuKZDHjh0wch/8HPVheY+IBaT
         kmb50kbBLAkZLJYC1ggPj301qx5XXkafjwA1OMc5TQS46kdpG2jZYfvc0jA/nptda/
         V/cFeuzux23Fw==
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-spi@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH] spi: Revert modalias changes
Date:   Wed, 22 Sep 2021 15:21:37 +0100
Message-Id: <163232044596.53545.7821409613425487197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921173222.46514-1-broonie@kernel.org>
References: <20210921173222.46514-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 21 Sep 2021 18:32:22 +0100, Mark Brown wrote:
> During the v5.13 cycle we updated the SPI subsystem to generate OF style
> modaliases for SPI devices, replacing the old Linux style modalises we
> used to generate based on spi_device_id which are the DT style name with
> the vendor removed.  Unfortunately this means that we start only
> reporting OF style modalises and not the old ones and there is nothing
> that ensures that drivers list every possible OF compatible string in
> their OF ID table.  The result is that there are systems which have been
> relying on loading modules based on the old style that are now broken,
> as found by Russell King with spi-nor on Macchiatobin.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Revert modalias changes
      commit: 96c8395e2166efa86082f3b71567ffd84936439b

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
