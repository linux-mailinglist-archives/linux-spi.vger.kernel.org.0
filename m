Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E15D2B5515
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 00:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKPXeP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 18:34:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbgKPXeP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Nov 2020 18:34:15 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456092223C;
        Mon, 16 Nov 2020 23:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605569654;
        bh=D7yocYpQlGBMGi8zfgT854t0AeFrG4e6Fg24oMC0B0c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=u3PgcTbciaosLZxanZrxUsUof8Djtkam9pEtKY79hjSyzPci4++6v137b+BrX/+PJ
         sogy2ic+iQcIAT27OFhkDiST0FIU2OwXf6tINbhNovf7RDkeYy72/k+u+QEbaZxL0t
         T1Td0bNKXNFof4H9nALD0Qos4NUj/OjoLih/JHIU=
Date:   Mon, 16 Nov 2020 23:33:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bayi Cheng <bayi.cheng@mediatek.com>
Cc:     linux-spi@vger.kernel.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1605084902-13151-1-git-send-email-bayi.cheng@mediatek.com>
References: <1605084902-13151-1-git-send-email-bayi.cheng@mediatek.com>
Subject: Re: [PATCH v1] add axi clock control for MT8192 spi-nor
Message-Id: <160556963073.29969.12445750916599680297.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 11 Nov 2020 16:55:01 +0800, Bayi Cheng wrote:
> bayi cheng (1):
>   spi: spi-mtk-nor: add axi clock control for MT8192 spi-nor
> 
>  drivers/spi/spi-mtk-nor.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> --
> 1.9.1
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mtk-nor: add axi clock control for MT8192 spi-nor
      commit: f32cce8483f18a098ae50b524f926ef0f2bd2e12

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
