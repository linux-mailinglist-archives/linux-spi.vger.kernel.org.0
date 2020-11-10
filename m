Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E511A2ADB2E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 17:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgKJQD2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 11:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732688AbgKJQD2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Nov 2020 11:03:28 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9BB2076E;
        Tue, 10 Nov 2020 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605024207;
        bh=shaEvOfhvlLh7qAMOuQ5TgOXTPXfVs1cbi/5iTs73sg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=p1Hl2fL4alJhilBzc6vxvcQrsAYKnnVHiA1u6RedRTUZDbHgBRzTPCo9S4A4UaRkL
         SnooDQpTOrQUnW4J0AIhKB0cgeyRJA8nFdg0q2auYrIO233KtE9e/1MQ/T1zYd3ap+
         P3tIwMksaPrCeu/ruCsCKWpwefsJEuCcznPpfoUc=
Date:   Tue, 10 Nov 2020 16:03:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        Zhang Qilong <zhangqilong3@huawei.com>
Cc:     linux-imx@nxp.com, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com
In-Reply-To: <20201102145835.4765-1-zhangqilong3@huawei.com>
References: <20201102145835.4765-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: imx: fix reference leak in two imx operations
Message-Id: <160502418758.46020.1548144022419486388.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2 Nov 2020 22:58:35 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in callers(spi_imx_prepare_message and
> spi_imx_remove), so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: fix reference leak in two imx operations
      commit: 1dcbdd944824369d4569959f8130336fe6fe5f39

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
