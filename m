Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8F41F893
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 02:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJBASW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 20:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhJBASW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 20:18:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA724610EA;
        Sat,  2 Oct 2021 00:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133797;
        bh=XoESlOgXD7gA/gwzvFCnOXxEc6BCvHDmyfV8dM0b4gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+BkYXCngJnrbXJitP5/gxGS8OAWgM9qQJh/xim8ynlqJhnXLacYzRu0d5j22SlNG
         KxHJ2z3nv1bdodRgH9Z/e8Z5J5G3ymU2QcUe7hAjqcFwSW5sca67sKnPg6GBPZX+kk
         6p6ccH9jMe2uJhCnbzdSjAo6RJCjY7jZFLFCP81zhGmL0TV0SrtopTCqsjgZeQHu/K
         Owq6V3MRwqfPxu7Pm/7R4HwYdXcQdCsj0w/sfZU1U3o2AHkUyuwGcVRNqUwjqXR/2C
         6DpRRXCwzw1FNy9JL5kFy7PUsHUOiXIaoxlBkTjJxqwnt0GI1sJEA7sDTvRua08BvQ
         VnG9TGNmNkT9g==
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, wsd_upstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, dafna3@gmail.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kernel@collabora.com, enric.balletbo@collabora.com,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] spi: mediatek: skip delays if they are 0
Date:   Sat,  2 Oct 2021 01:16:22 +0100
Message-Id: <163313375302.13893.4068868673523917902.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001152153.4604-1-dafna.hirschfeld@collabora.com>
References: <20211001152153.4604-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 1 Oct 2021 17:21:53 +0200, Dafna Hirschfeld wrote:
> In the function 'mtk_spi_set_hw_cs_timing'
> the 'setup', 'hold' and 'inactive' delays are configured.
> In case those values are 0 it causes errors on mt8173:
> 
> cros-ec-i2c-tunnel 1100a000.spi:ec@0:i2c-tunnel0:
> 	Error transferring EC i2c message -71
> cros-ec-spi spi0.0: EC failed to respond in time.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: skip delays if they are 0
      commit: 3672bb820f3292b6f035469f863c020317a3dd28

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
