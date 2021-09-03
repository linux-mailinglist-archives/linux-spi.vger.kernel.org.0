Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB84001E2
	for <lists+linux-spi@lfdr.de>; Fri,  3 Sep 2021 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349613AbhICPUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 11:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349579AbhICPUS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Sep 2021 11:20:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A61D610CC;
        Fri,  3 Sep 2021 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630682358;
        bh=8G+tliPfC8rLYs7/1T2ci0+LLiBWSR8H0X7JG/QzYpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCdyvXI1ACl55zc4Rn+SQ5lST/UT+pwcavYtiotJDJqEkp/OyunApyBwNOPyKNebg
         5jPc8snRshnRCybDInizByx2aVMzfKqlxdXYNgmj5yWr4NDb/n8cX2SKbRyKgjs9oU
         U6Fxjbz4g4pYoW96rgxsbJIugXHe3bCggBgAjEsd9lMT/Z6qfqiTesQw2jnF93nIgO
         Luqy7XJOqEybszrGHPDZAzkcYjzvBK1haiKO+mHWt7uXTd40YPcyBL7Rf8fwnZZi+w
         NkvGhp0QCtDtWEA+l3UUoAbsmXi4/HZBFR1qLpPFip2SJ7aWMRNBN1xpXw/8/wqEAr
         MA/kaeLKk6Z0Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Tobias Schramm <t.schramm@manjaro.org>,
        linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] spi: rockchip: handle zero length transfers without timing out
Date:   Fri,  3 Sep 2021 16:18:43 +0100
Message-Id: <163068228056.51069.15541338141615688512.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210827050357.165409-1-t.schramm@manjaro.org>
References: <20210827050357.165409-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 27 Aug 2021 07:03:57 +0200, Tobias Schramm wrote:
> Previously zero length transfers submitted to the Rokchip SPI driver would
> time out in the SPI layer. This happens because the SPI peripheral does
> not trigger a transfer completion interrupt for zero length transfers.
> 
> Fix that by completing zero length transfers immediately at start of
> transfer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip: handle zero length transfers without timing out
      commit: 5457773ef99f25fcc4b238ac76b68e28273250f4

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
