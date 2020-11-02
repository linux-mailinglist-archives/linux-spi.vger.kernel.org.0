Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C32A3151
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 18:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgKBRTT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 12:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgKBRTS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:19:18 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B13322265;
        Mon,  2 Nov 2020 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604337558;
        bh=G132oiBAqGZzAt6ayKNV+WY49D+wGXCkJisp3UaoB5s=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EwN7Xn8CLrM0Wwbrhm5ZUSLfd+EjMQQmK4zxPg+AFGhGMdXOAVTFX49dyKKJpqqQ8
         0I8roK6OMwBOLhPVy5Fj1SVwv9JR0Pk0v/MBC0EjdvbQdCjvWvIQmNwPDnOKKXVmBZ
         z7L3BFwSfEO0YC/IIr3epL/a6WJwM70iEL8yNdIg=
Date:   Mon, 02 Nov 2020 17:19:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20201102145651.3875-1-zhangqilong3@huawei.com>
References: <20201102145651.3875-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: img-spfi: fix reference leak in img_spfi_resume
Message-Id: <160433754396.19045.3227753127410915691.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2 Nov 2020 22:56:51 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in img_spfi_resume, so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: img-spfi: fix reference leak in img_spfi_resume
      commit: ee5558a9084584015c8754ffd029ce14a5827fa8

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
