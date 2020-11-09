Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD902AC567
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 20:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgKITsx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 14:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgKITsx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:48:53 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F48206E3;
        Mon,  9 Nov 2020 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951332;
        bh=kMkAVnPrTNNKTSeBrObHdVcCpDzmYBMJRxph5AFbL70=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ywmaE1NF+b3KWAzL3RmcM4WYdpKuPjZ7K8Fl4iKs4m1vPZWeOhAvYvTNsqegudrMV
         fe55jRfvgIjzl99pNnPpI6IVG8pT67TWOzPGl1cYkcHNlBh/j/AyO3Z5qRh38Eh+bd
         gEqHhZL3RzDNx7llYdx6u8SbGGgL7cn6thxtFz30=
Date:   Mon, 09 Nov 2020 19:48:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     mcoquelin.stm32@gmail.com, Zhang Qilong <zhangqilong3@huawei.com>,
        alexandre.torgue@st.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org
In-Reply-To: <20201106015357.141235-1-zhangqilong3@huawei.com>
References: <20201106015357.141235-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: stm32-qspi: fix reference leak in stm32 qspi operations
Message-Id: <160495129748.49337.12708904135369234683.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 6 Nov 2020 09:53:57 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in two callers(stm32_qspi_exec_op and
> stm32_qspi_setup), so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: fix reference leak in stm32 qspi operations
      commit: 88e1419b5ee30cc50e0c4d5265bdee1ba04af539

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
