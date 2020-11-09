Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A62AC562
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 20:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgKITsh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 14:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729899AbgKITsh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:48:37 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 157B2206E3;
        Mon,  9 Nov 2020 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951316;
        bh=e6AtaRbKq0BHW2zVKVpEgVu0o9ZE80SKGtkiHFRIGnE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CcYgJ+PbQ69GE/1BA++mzs/k0wfI424RSpMFYpowVkrp62Lp+ddSPWJx2KLhu+c1H
         6qXRaRTHbhkpa03tWJ2++JxBV4Z5+EDuK7YvPL2742GNyl6oYBHrUmnBAazemfOZjs
         dSbaeQks/F2JuvO5qMUVK8XEP7eSZ+HgXWwLBk60=
Date:   Mon, 09 Nov 2020 19:48:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20201103140947.3815-1-zhangqilong3@huawei.com>
References: <20201103140947.3815-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: spi-ti-qspi: fix reference leak in ti_qspi_setup
Message-Id: <160495129749.49337.6906868883042164608.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 22:09:47 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in ti_qspi_setup, so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ti-qspi: fix reference leak in ti_qspi_setup
      commit: 45c0cba753641e5d7c3207f04241bd0e7a021698

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
