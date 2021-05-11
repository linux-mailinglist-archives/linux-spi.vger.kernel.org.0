Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F45C37AE58
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 20:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhEKSXa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 14:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhEKSXZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 14:23:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ECF161207;
        Tue, 11 May 2021 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620757339;
        bh=dQSfzo4R/3bBzXJnzj5RGjeZMuoyysyyRwOn7nqufAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Br9lfyFUMm/nzSgM4wa1SPQ7Y8BLQV+PAPfTW39kKD5RNpD3zf2fgai81vBdytw0X
         Vg+UaILZy3hKNqn/HaQZ8iMpwB8M5RIYEA/VIYIk1pkCj7ypORYjY//jdjVe/OWmWP
         /kC1qRtKlDrFZRkbxnRpzxnB+CwsiAz22G73IyfO+bpRLeselffgG01wOpoZQXILit
         kpZhKARDGkHDTQT8saoENDfbQ36WPubpxejd0hGqUXGkO7u0YSZ4+Dcy2vNEityucZ
         XuLgfkOHiwzxracK8ZHoA+uwxImL+Whee4gAU7820+8UV22eqzxAdAgRqy6AHKXgpy
         Btqm7mrcBKmFA==
From:   Mark Brown <broonie@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] spi: altera: Remove redundant dev_err call in dfl_spi_altera_probe()
Date:   Tue, 11 May 2021 19:21:25 +0100
Message-Id: <162075727215.18180.3931869433075544732.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620716922-108572-1-git-send-email-zou_wei@huawei.com>
References: <1620716922-108572-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 11 May 2021 15:08:42 +0800, Zou Wei wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: altera: Remove redundant dev_err call in dfl_spi_altera_probe()
      commit: 532259bfd1c12d561215c32b94cd9bb7c997bc6f

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
