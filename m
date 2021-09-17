Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0385640F9E7
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbhIQOFx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Sep 2021 10:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241774AbhIQOFx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Sep 2021 10:05:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D83360E08;
        Fri, 17 Sep 2021 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631887470;
        bh=Ti2hG+uohaS5cflM277fb1zbK8m1rvMqeDlNJWBI0yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npPYpJQXtYOoqbc0I9+3y+vCs2phSiVQKR6UN9WLgAX9STVZ4CJ8b87t4y33Qh7TS
         Ql+oKe/leq1wFN3pA5W4mVIIbT+JDJDGpWJHFJgNtxHViljpL7WqmcB8AuZcf9uqwM
         jb7USg0mbSNCkO5ybOTZeRZayc/aKli7zxlQMtb6J/AlJkJ1Gt52QGZ6nxcVFoGCUX
         kxPYTu+zbsci7Qlm1hmwYbGg5+lN5OAhHDX4v7V4Fe1PVv+/3458FN2KAzfKGkr5i3
         bR1anisnCIc/2poTzJGDZ2E9XzW2T+lQE8l9+HUwpQKmOJkpa4xT9+E6hPgT8nheW+
         RbcioDOiljOUA==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: rspi: drop unneeded MODULE_ALIAS
Date:   Fri, 17 Sep 2021 15:03:41 +0100
Message-Id: <163188742108.50671.15947736105193832897.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916164423.134603-1-krzysztof.kozlowski@canonical.com>
References: <20210916164423.134603-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Sep 2021 18:44:22 +0200, Krzysztof Kozlowski wrote:
> The MODULE_DEVICE_TABLE already creates proper alias for platform
> driver.  Having another MODULE_ALIAS causes the alias to be duplicated.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: rspi: drop unneeded MODULE_ALIAS
      commit: 98c29b35a7e3b1ef7e64a8dd05a4383ea2e2ac72
[2/2] spi: sh-msiof: drop unneeded MODULE_ALIAS
      commit: 3323129a6db96b6878a260601b30651ca40caa54

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
