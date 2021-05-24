Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8852038E5FE
	for <lists+linux-spi@lfdr.de>; Mon, 24 May 2021 14:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhEXMBf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 May 2021 08:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhEXMBf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 May 2021 08:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 054216128B;
        Mon, 24 May 2021 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857607;
        bh=cpBDu2w/z1YJxw4Gy1TQTrhQ5gIYKChQPLjl+piDaUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBa2sCcgFrqRqqmB4d58KJGzx3lZsrYXbdKTKmdX6YDipl+gXK9BvNOSfgsnljE6E
         ufiTyI6I6ySJ9sbb0EA69cLLtICqLeBemsNesOXJgZqHB54vW2Q8IThMjRFS37vVy7
         bAINgwMOXFoPKb33cIfRKz5K2H2Nub6wE8vI0v6an9OIHHcvOi4gKldNDlV2xzmB+3
         FZTQFe8/JhBlWd8nzZ2ec45i4L1uqlxjSL8xFdk3XUqX2VLsKv0t1PiwDHgSjb94Y/
         cvPoDxqNmZTp1sxkgNa5ExWoEAcb0p9aDPU7CVZu+hBTgcRtMqFO/7a/m1B34dCpHS
         u7SpKY5i2/3SA==
From:   Mark Brown <broonie@kernel.org>
To:     David Bauer <mail@david-bauer.net>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: ath79: drop platform data
Date:   Mon, 24 May 2021 12:59:48 +0100
Message-Id: <162185759495.49562.10449348259264010206.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210522074453.39299-1-mail@david-bauer.net>
References: <20210522074453.39299-1-mail@david-bauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 22 May 2021 09:44:52 +0200, David Bauer wrote:
> The ath79 platform has been converted to pure OF. The platform data is
> not needed anymore because of this.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: ath79: drop platform data
      commit: 42a7dfa26fc6df1624d7c2955200e5053dd0b818
[2/2] spi: ath79: set number of chipselect lines
      commit: ab053f48f9264ed5c714d0427b3115f121d4c476

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
