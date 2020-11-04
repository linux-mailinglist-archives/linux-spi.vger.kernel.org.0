Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA72A6F1A
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgKDUoE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 15:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730347AbgKDUoD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Nov 2020 15:44:03 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C578D20637;
        Wed,  4 Nov 2020 20:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604522643;
        bh=cuZz0DHyzGL1R58wJNLMdIPWiGUpdO7wEZ9iptA9HE4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pArsyvgIpyNybiM/mFMLy+4G+wB+7IhBGU8JNUsGAxKy84riZcJTl/z8qYhIlA4Nl
         WsuJvDGcL/ySNnnuyPEddHCHuK6LhjCeMA4QvjZuBxHK41gJbU3z3AGSeo2XtTjGDh
         7KN9u3LmJlj0hC30tts7TyfBB4Dtpi572TPZNOzQ=
Date:   Wed, 04 Nov 2020 20:43:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20201103140910.3482-1-zhangqilong3@huawei.com>
References: <20201103140910.3482-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: spi-mem: fix reference leak in spi_mem_access_start
Message-Id: <160452263225.7406.3013080277708725316.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 22:09:10 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in spi_mem_access_start, so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: fix reference leak in spi_mem_access_start
      commit: c02bb16b0e826bf0e19aa42c3ae60ea339f32cf5

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
