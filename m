Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC942DA23
	for <lists+linux-spi@lfdr.de>; Thu, 14 Oct 2021 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJNNU1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Oct 2021 09:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhJNNU0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Oct 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 981D5610CC;
        Thu, 14 Oct 2021 13:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634217502;
        bh=2Y4MOAQW4HFkZljiNR3nqwQNImxzaqyGsG+crhjKtwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNTtYog2vhcv1cfih+Qr7jmL1FqR5wZp5jZlws7h3mIz72opcpjj3jwz7Xx83aSxv
         SiJhKXu0qdX8H1YTx5qouahWJ9JvtVNYcdWneVGb0HS/dAZ+NEQOnkruVOZQik4AhK
         c2icQV3WbWF3u+8+0jqheqg2mcZU1pYJHFeXjHZGsV9vc1ClwVDXWb2lXZv0od/fGH
         nDtaPjPvd3gyk3PGIjzUEkTIKQmOUZFMrx8ehwRridlzaoiOw4CSdwhYWxjc1QEoYq
         GnWlOFsjVdUwicVYIL3Yl7HI558IIKjyzyOExwJkQqQ66FZD1PIeKHyGzab5rgkyBO
         kIiI/Mityj5Rw==
From:   Mark Brown <broonie@kernel.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: (subset) [PATCH 1/2] spi: Make spi_add_lock a per-controller lock
Date:   Thu, 14 Oct 2021 14:18:15 +0100
Message-Id: <163421748241.2468431.371668707165941948.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013133710.2679703-1-u.kleine-koenig@pengutronix.de>
References: <20211013133710.2679703-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 13 Oct 2021 15:37:09 +0200, Uwe Kleine-König wrote:
> The spi_add_lock that is removed with this change was held when
> spi_add_device() called device_add() (via __spi_add_device()).
> 
> In the case where the added device is an spi-mux calling device_add()
> might result in calling the spi-mux's probe function which adds another
> controller and for that spi_add_device() might be called. This results
> in a dead-lock.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi-mux: Fix false-positive lockdep splats
      commit: 16a8e2fbb2d49111004efc1c7342e083eafabeb0

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
