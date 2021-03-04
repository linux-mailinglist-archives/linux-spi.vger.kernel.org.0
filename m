Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A932C9E1
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhCDBOa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 20:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235954AbhCDA6R (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 19:58:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55E4264EA4;
        Thu,  4 Mar 2021 00:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614819455;
        bh=Pq4DTgSCjnSumX710lov1lOw0nQOtcqw+vfcG1lo/Pc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Tdnob7jiXNdDi17lsuc72VMI3tt/UMDiEwW4yfC7c/TeL88U/lLgz2mfaSK6aGSQg
         QsBYbKsprv4EUhMtlsd7weUdDXdKAy4IYlnMrlU9Q9+dg3CKBEUBGaR8sPVnnpZ1+u
         a6C2OfxDOH3mHNG505Wr+I2Z+yQwco/0FILule0NmCqci5ODbhCRtrKIdriX5/9e89
         lxSyWkvPbTeBvel0Rq6Y6kuibJudzPdKQlRcX9FU1dt9MeWPefAo7koIQASIUep+rp
         z6KUBhK4p9FSJO6FjnGYCEcim29UcoRQX4hz4C18AEiQ0cruqRhkdNr9dzCY66taaQ
         yg3MHZBy8r1sQ==
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
In-Reply-To: <20210302124936.1972546-1-kuldeep.singh@nxp.com>
References: <20210302124936.1972546-1-kuldeep.singh@nxp.com>
Subject: Re: [Patch v2 0/4] NXP Flexspi driver patches
Message-Id: <161481938860.10000.18184476826270231027.b4-ty@kernel.org>
Date:   Thu, 04 Mar 2021 00:56:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 2 Mar 2021 18:19:32 +0530, Kuldeep Singh wrote:
> This patchset involves changes in NXP Flexspi driver.
> 
> Patch1 adds support for disabling AHB and enabling IP read only using a
> quirk which is later used by patch3 and patch4.
> 
> Patch3 and Patch4 are not related to each and are rather dependent on
> patch1 and that's why I kept them in series. This also helps in easy
> application of series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: spi-nxp-fspi: Add support for IP read only
      commit: 1e1c30db2ccba3ec891e683f5e8eca2aca6238eb
[2/4] dt-bindings: spi: spi-nxp-fspi: Add imx8dxl support
      commit: a53a9159a6774b393bb4b620430328940fa853b8
[3/4] spi: spi-nxp-fspi: Add imx8dxl driver support
      commit: 99a6a399a61e95cd6639453f87d5c96a121dec07
[4/4] spi: spi-nxp-fspi: Implement errata workaround for LS1028A
      commit: 94f302f374b4544fa4d84526569f884ebb008f4d

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
