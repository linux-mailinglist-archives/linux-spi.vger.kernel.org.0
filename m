Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6814C3A6F7E
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jun 2021 21:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhFNT4Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 15:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234187AbhFNT4V (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2886C61246;
        Mon, 14 Jun 2021 19:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700458;
        bh=lXE4ojg3vZj00rQa1Ur3m9EtSTs5cJ9y0Aq2+yVMsFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGr52i6SQTs4RQitog0bgHqDGHFM6c915vC6lqKr6Tu2zBYG4P5SvTYu2oEOqLH/n
         Q6g2gl6jHIUzHS1jIp9RzkEYENknJX6no2Ahduz6n4CO7yjJdeY5NL/3mVlRblQWpg
         nQa66e7nEvZ+kuKWvnYKJfxXme1xaFWwUBLE2p7nZ0LrhsM52y8HAmOrBQ6OXDhZk6
         CTKUCyDIlwOqdA1iA8qPcl3ts4hXOogMEpWHE97cxuMx9iU8YTaJa3rSFqxKsTImZi
         31I9QnzKIsY7HwRnFLZIdR/kZaZ+OxFmIB4KvYeJnCnAWNh4NH2tq7qCWK1WpmyRdf
         pE4kVqd1vH6gg==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        zpershuai <zpershuai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: meson-spicc: fix a wrong goto jump for avoiding memory leak.
Date:   Mon, 14 Jun 2021 20:53:31 +0100
Message-Id: <162370043178.40904.8100844708897155437.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623562172-22056-1-git-send-email-zpershuai@gmail.com>
References: <1623562172-22056-1-git-send-email-zpershuai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 13 Jun 2021 13:29:32 +0800, zpershuai wrote:
> In meson_spifc_probe function, when enable the device pclk clock is
> error, it should use clk_disable_unprepare to release the core clock.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: meson-spicc: fix a wrong goto jump for avoiding memory leak.
      commit: 95730d5eb73170a6d225a9998c478be273598634

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
