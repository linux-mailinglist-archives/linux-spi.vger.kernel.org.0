Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F137524C74F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 23:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHTVtB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 17:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgHTVtB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Aug 2020 17:49:01 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA2021734;
        Thu, 20 Aug 2020 21:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597960140;
        bh=AH1kpXXk3IR45xkFIyr0JzpEiDAPHJrtMYQecq9vuQE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=L3lQNHTjZCesSSuZluNQKjjIGQZ18h2VF5N5UEOhipHYoCCubUweKGLb+4vqmne9o
         60Z1Ud9ITca2LurQEEeYE1wpNrcBhURKlKRiLcl9li9UlFoE8eMxEaPDc+QDBH6ncj
         bt1iPZencgb1CMN71gI+4g0Cn7i5XZ8wCHQ+GRdo=
Date:   Thu, 20 Aug 2020 22:48:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200819123330.22880-1-festevam@gmail.com>
References: <20200819123330.22880-1-festevam@gmail.com>
Subject: Re: [PATCH v2] spi: imx: Remove unneeded probe message
Message-Id: <159796010777.44514.368618244956650857.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 19 Aug 2020 09:33:30 -0300, Fabio Estevam wrote:
> There is no point in printing a plain "probed" message on successful probe.
> 
> Just remove it and make the kernel log a bit less noisy.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: Remove unneeded probe message
      commit: c76964e810a55c30cc407760d7cd79b5df53ecc6

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
