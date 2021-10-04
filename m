Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965F94214B0
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhJDRE0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 13:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238063AbhJDRE0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Oct 2021 13:04:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60B80613AC;
        Mon,  4 Oct 2021 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633366957;
        bh=rM4XL6Z8AQ2Jr789epSG1lyE4bclKPBGD2if5O2EWwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNY+thIwk7ivEf+G4Z/kBZqUyGVbUs/Cn1tIaqrYaLFtvkKL7kFgCjb7z43r8G6Qk
         LR5znwHKJfIZDiPZaxR3gMWv0vPjYv5+Kyb3WXVudlVTG6pIqNUVDAHDE1fLp8Xlhs
         Rskd2QKsdQ+zITT8kNFuO9WH2ucSgzeb+b0dm+LAKHRxbK0dw1Mky0lBHiw/8l+ERj
         Mw59OcBXyg+vUK3wFXOl55esjSgFBEyfYg8XPpbSyx7ox4FVF87pgEwsKluqmiHke5
         X56rbBdZmiQ1ebMDl8G7iSaPs0prb2eOSpDw2/3ntOa+dPeNZaDii3k0y4C/q/kzvw
         aN5waer83rAiA==
From:   Mark Brown <broonie@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>, dan.carpenter@oracle.com
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        jpawar@cadence.com
Subject: Re: [PATCH] spi: cadence: fix static checker warning
Date:   Mon,  4 Oct 2021 18:02:29 +0100
Message-Id: <163336693658.3340457.1861391456245819827.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1633244658-14702-1-git-send-email-pthombar@cadence.com>
References: <1633244658-14702-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 3 Oct 2021 09:04:18 +0200, Parshuram Thombare wrote:
> This patch fixes Smatch static checker warning.
> CDNS_XSPI_CMD_REG_5 is used in ACMD mode and currently
> only STIG mode is enabled which doesn't use CDNS_XSPI_CMD_REG_5
> and hence everything was working in STIG mode.
> Since plan is to use same function cdns_xspi_trigger_command()
> in ACMD mode, increasing size of the array passed to it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: fix static checker warning
      commit: 79bffb1e97a349238a0b5535c9356e48b987b8bd

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
