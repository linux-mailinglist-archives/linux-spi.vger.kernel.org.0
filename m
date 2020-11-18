Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2A2B8632
	for <lists+linux-spi@lfdr.de>; Wed, 18 Nov 2020 22:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKRVAZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Nov 2020 16:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgKRVAY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Nov 2020 16:00:24 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E39246AA;
        Wed, 18 Nov 2020 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605733224;
        bh=spkhx3mTpbrol3ioqiZqCn/UIi+RkhiA4Wro0eYHxEQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EeMU8cTGdzUJR9azgm0SOrPvB0s4X42/hQeUl94rRcUuTp6rHpD1AwJM2zdT3i5N3
         Gq6hmSfgTCamiyhDYlf3ojlEDpgR+Yob+kZI4St106SaY2Ei5dG4U94W352xsnRaby
         tZkkex1wKCsk7dgkereJsY6Mpb5JuSqchK/wLYoU=
Date:   Wed, 18 Nov 2020 21:00:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     s.hauer@pengutronix.de, shawnguo@kernel.org,
        Zhang Qilong <zhangqilong3@huawei.com>
Cc:     festevam@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
In-Reply-To: <20201106012421.95420-1-zhangqilong3@huawei.com>
References: <20201106012421.95420-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: mxs: fix reference leak in mxs_spi_probe
Message-Id: <160573320342.46706.17251700312199098743.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 6 Nov 2020 09:24:21 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in mxs_spi_probe, so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mxs: fix reference leak in mxs_spi_probe
      commit: 03fc41afaa6549baa2dab7a84e1afaf5cadb5b18

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
