Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D22F8436
	for <lists+linux-spi@lfdr.de>; Fri, 15 Jan 2021 19:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbhAOSVo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Jan 2021 13:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388032AbhAOSVn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Jan 2021 13:21:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8B57222B3;
        Fri, 15 Jan 2021 18:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734863;
        bh=e0oNvf86GUa97Isa1a5/fLm89OCm35ofDxoL0Fvrm10=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rv2XEMqnDk1jnhPTGXA3wZ9vk740DBIgJ4HiBhn7CkDIFlPZWLvG7nymhtqVFq8v4
         cWvIRrVvBE1Eo4ufMQKWdeO1YlV34l4nwKw2eqmQ59tXjEjOPLxLsRf9T8ASJ+D2k3
         4gpCEG2Y2TMI5hWU9YXkcqiieoOYnBiebZA3BDy/bwx6TYj1mMppv0aS8Jo9O1Wq0M
         +jtXRKx+1vNDj7QaBHsvZ2/xFOFqT7XRZWPa4YE6uyC00eLJbdb0ZZpcYXDOnv+Wgr
         KeFKqZU2hM7shjV6RmbUVjZ0r+ASmlXrJYLsTfZbM3hXKwW+Uu9AMxplbLnghjSVX6
         rk4SU1XMYIjxw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org
Cc:     harinik@xilinx.com, michael.hennerich@analog.com
In-Reply-To: <20210114154217.51996-1-alexandru.ardelean@analog.com>
References: <20210114154217.51996-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH] spi: cadence: cache reference clock rate during probe
Message-Id: <161073482876.12522.5231767630721106173.b4-ty@kernel.org>
Date:   Fri, 15 Jan 2021 18:20:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 14 Jan 2021 17:42:17 +0200, Alexandru Ardelean wrote:
> The issue is that using SPI from a callback under the CCF lock will
> deadlock, since this code uses clk_get_rate().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: cache reference clock rate during probe
      commit: 4d163ad79b155c71bf30366dc38f8d2502f78844

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
