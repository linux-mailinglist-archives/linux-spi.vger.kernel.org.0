Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893B022EE1A
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgG0N50 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 09:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgG0N5Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 09:57:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F6F2070B;
        Mon, 27 Jul 2020 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858245;
        bh=Ds3makuOPDIExLgnbfW/yVHZhFV8wpApbDHJ28L6frk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zdyQetnFeoKFYw1KanW41myJQWy7nkJqbX+NiyLY0bdpeTMFDAZ5/DCyG9GwxCg9P
         9VUhVFKuUE0wpaG76u7keC+6wS+mcW1NOI/Km/sK21/C+fg1a6lHPRv1dLZrvs6ObB
         9+tEvWTj5a8bv/wAdUES9lMGqJ+eQFjIth5EkhOA=
Date:   Mon, 27 Jul 2020 14:57:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, shawnguo@kernel.org,
        Clark Wang <xiaoning.wang@nxp.com>, s.hauer@pengutronix.de,
        kernel@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com
In-Reply-To: <20200727063354.17031-1-xiaoning.wang@nxp.com>
References: <20200727063354.17031-1-xiaoning.wang@nxp.com>
Subject: Re: [PATCH] spi: imx: enable runtime pm support
Message-Id: <159585821343.22560.13240672066683447553.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 27 Jul 2020 14:33:54 +0800, Clark Wang wrote:
> Enable runtime pm support for spi-imx driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: enable runtime pm support
      commit: 525c9e5a32bd7951eae3f06d9d077fea51718a6c

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
