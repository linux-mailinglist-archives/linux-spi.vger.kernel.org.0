Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B53E4617
	for <lists+linux-spi@lfdr.de>; Mon,  9 Aug 2021 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhHINGz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Aug 2021 09:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235107AbhHINGv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Aug 2021 09:06:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3003D60F93;
        Mon,  9 Aug 2021 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628514390;
        bh=er6P7KMpkJN4hEnMUEV9ytmn+sMhCbCLS0cRciYT8LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCR86qqZ7cNIOOzwPkGV66KKwrf4Thlw4ncEC54o9lZiu94cFwT6rdJyNM7/R2wrc
         sR9yHFkKAEKbujkgr0ht/BX4BmBKt4p+9D+rJ6rmG1M4NHSilswcsgZDFQHZrGFMoL
         q3QEd6VelLKNhW96A9WoyqsjIMXfYYv8183/jeceCRE3wHESXhdb7kSgU/GDpgZoQ3
         otjuag/v5ykNEaGMeGFpjJd/k/8EmpygHVcIfP8dFo6DiAYIoX79IpzycJJuJgYMMW
         5vfKCc2U/BwLHHnTi88XJaWq0N3lMiDK0phEWVlqwZLTbfGwEQlA0r7csUW1fUE/yp
         lmP0RARJCxMkA==
From:   Mark Brown <broonie@kernel.org>
To:     zhengxunli <zhengxunli@mxic.com.tw>, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, linux-spi@vger.kernel.org,
        vigneshr@ti.com
Cc:     Mark Brown <broonie@kernel.org>, juliensu@mxic.com.tw,
        ycllin@mxic.com.tw
Subject: Re: (subset) [PATCH v2 0/2] Add octal DTR support for Macronix flash
Date:   Mon,  9 Aug 2021 14:06:05 +0100
Message-Id: <162851432637.51983.3793788915457019257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 5 Feb 2021 17:36:46 +0800, zhengxunli wrote:
> This series adds support for Octal DTR for Macronix flashes. The
> first set of patches is add Macronix octaflash series octal dtr
> mode support. The second set of patches add the Octal DTR mode
> support for host driver.
> 
> Changes in v2:
> - Define with a generic name to describe the maximum dummy cycles.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: mxic: patch for octal DTR mode support
      commit: d05aaa66ba3ca3fdc2b5cd774ff218deb238b352

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
