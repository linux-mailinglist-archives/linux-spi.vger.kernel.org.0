Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456483F207F
	for <lists+linux-spi@lfdr.de>; Thu, 19 Aug 2021 21:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhHSTXM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Aug 2021 15:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234568AbhHSTXK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Aug 2021 15:23:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 656AB6108D;
        Thu, 19 Aug 2021 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629400953;
        bh=KiZYO4duYYNwbLg9ulKN1nt3300ulbAtss6GNnstqCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QuQEbw3zTRR7mPEeuUs1OaHWSP9UrSzmiebf4b1UgIQkufl+zQM+qFFuW8DxFmmOQ
         zli8sb9jICWcSOWV6Xcd3PwZNBxAqCXlY6fVO911HnRB+vp9KvxOx9wFZXQGHD1KWy
         AwedLwW2lV/9r8s884Ej/cb0z3wE1ksoLFIlcTSzkWFwMEa7qPlGr1zNg4gCeTcrbB
         8bT4rdSK7fnmFRLRkyBUtcf609wol29RdSm0Z+wS+LdSiyn/jpr4NCDeP3jghzijgs
         g2BqAMQ42qjdbqFC6d7OLKdJ3TIBWolnaskABFUXf+RPw/oV86/3EnSXZThAPkq9aK
         zjS299wI1QQXw==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        zhangqing@loongson.cn
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: coldfire-qspi: Use clk_disable_unprepare in the remove function
Date:   Thu, 19 Aug 2021 20:22:07 +0100
Message-Id: <162940054524.48223.7873981207290967023.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ee91792ddba61342b0d3284cd4558a2b0016c4e7.1629319838.git.christophe.jaillet@wanadoo.fr>
References: <ee91792ddba61342b0d3284cd4558a2b0016c4e7.1629319838.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 18 Aug 2021 22:55:56 +0200, Christophe JAILLET wrote:
> 'clk_prepare_enable()' is used in the probe, so 'clk_disable_unprepare()'
> should be used in the remove function to be consistent.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: coldfire-qspi: Use clk_disable_unprepare in the remove function
      commit: d68f4c73d729245a47e70eb216fa24bc174ed2e2

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
