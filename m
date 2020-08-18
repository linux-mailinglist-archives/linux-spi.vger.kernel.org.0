Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96324248C30
	for <lists+linux-spi@lfdr.de>; Tue, 18 Aug 2020 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgHRQ6E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Aug 2020 12:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbgHRQ5w (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Aug 2020 12:57:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 012A7207D3;
        Tue, 18 Aug 2020 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769871;
        bh=HBpOEofl3RxwYpCB4vnFBeAjidPA8gPlcyiUVklhnbg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=OAlIGXjCkbyfmtsdpVgNoLTzSg42WvOEacWCzbV9ad9U+B/G1fFbpATz3wXQDaunH
         3aCJqtFgyouAkzKj/81u2VK7bIwOGIX/Wdn2k5eg3MYXje/PSEt4rrWcLnYcIaii+o
         0/v7ym90p+vQ5K34Ytiv3hDwPvagYMPMjeUWxZPY=
Date:   Tue, 18 Aug 2020 17:57:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
In-Reply-To: <20200804151356.28057-1-krzk@kernel.org>
References: <20200804151356.28057-1-krzk@kernel.org>
Subject: Re: [PATCH] spi: s3c24xx: correct kerneldoc comment
Message-Id: <159776983047.56565.6123675317860016583.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 4 Aug 2020 17:13:56 +0200, Krzysztof Kozlowski wrote:
> Correct the kerneldoc for structure to fix W=1 compile warning:
> 
>     drivers/spi/spi-s3c24xx.c:36: warning: cannot understand function prototype: 'struct s3c24xx_spi_devstate '

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c24xx: correct kerneldoc comment
      commit: e1cc0388d6fa420b1ccea05c59ea01182400ac6e

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
