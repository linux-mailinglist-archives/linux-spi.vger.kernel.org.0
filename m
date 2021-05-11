Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20A37AE56
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 20:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhEKSXX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 14:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231551AbhEKSXX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 14:23:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFF9C61264;
        Tue, 11 May 2021 18:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620757336;
        bh=WHWDb32n8erHoa2KBBUCLrLvLx9zfsrG16mxgBoCE2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvwfPnHpn+QdMPikfCiabHeLq+4VgtxfbsaaN1DSWqR2xzibetaaYfaJ7vdmm2vF7
         6WYSp3xWqoQVjbk7WwzhL4gA6bNSys5acvAe0wMi6nQ4F31hjW9cP2l+FZBc5Mz35z
         JF4MIl9DvlYQMQ+Xoi3ZFUtMTf3PB86U61ccjHk/yAIE6kyz3oVYX6RppZa2xGlkGi
         63jLB00ZxuwMUbHs63PacmFwkP4Vlaigiz91mANBojGFwk5vh0qJRRFWRCj+AR0mgY
         QEqlleJVYCEFacP8dSxoiB8lbJNqVHlJ6lqfTP6qPd4CkA3c8GrSy5JxIS/T34qIRw
         hoi6GmeDyZ61Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openbmc@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH v1 1/7] spi: Use SPI_MODE_X_MASK
Date:   Tue, 11 May 2021 19:21:24 +0100
Message-Id: <162075727216.18180.9757296985819359592.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510131217.49357-1-andriy.shevchenko@linux.intel.com>
References: <20210510131217.49357-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 10 May 2021 16:12:11 +0300, Andy Shevchenko wrote:
> Use SPI_MODE_X_MASK instead of open coded variant.
> 
> While at it, fix format specifier and drop explicit casting.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: Use SPI_MODE_X_MASK
      commit: 40b82c2d9a78593201a3a62dc9239d6405334561
[2/7] spi: spidev: Use SPI_MODE_X_MASK
      commit: dd507b5ec7ba44ab51e1a8404d04e815a91b472f
[3/7] spi: npcm-pspi: Use SPI_MODE_X_MASK
      commit: 56f47edf33fb55ab9381f61d60cf34c7578f3d75
[4/7] spi: oc-tiny: Use SPI_MODE_X_MASK
      commit: a2f2db6b2a8708f6ac592a362e34fb330f874cea
[5/7] spi: omap-uwire: Use SPI_MODE_X_MASK
      commit: fdb217a38808e041f6eca8c550f1b5981e401a45
[6/7] spi: ppc4xx: Use SPI_MODE_X_MASK
      commit: 4ccf05579b9d0f15443a0edc860e2be7472ccfc1
[7/7] spi: uniphier: Use SPI_MODE_X_MASK
      commit: 038b9de42269f33aca3e3741214c863a4e9328d0

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
