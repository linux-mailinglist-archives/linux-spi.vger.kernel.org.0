Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0D218DC2
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgGHRAs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 13:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgGHRAs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 13:00:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C87A207D0;
        Wed,  8 Jul 2020 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227647;
        bh=1xdSfEui0pHtusS3nafiXh2nqd9RiHYsA1DNZtHS3jg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=S6bNQfODgfdu7yrPOrPMpgtmChn10kaXQb6iyaCep/5Mzg+L4Oko6LARmsYTWjnYG
         YVr2T7nmnnosRo93afxtlzgmWk7PN8MTKwC2aV6GWdUqBhEPDqOtXxGCKig33NgRGl
         ygwaflTxd9fJBccrzidVqaPfOL82ky3I8xy3HrM4=
Date:   Wed, 08 Jul 2020 18:00:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peng Fan <fanpeng@loongson.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1594111842-9468-1-git-send-email-fanpeng@loongson.cn>
References: <1594111842-9468-1-git-send-email-fanpeng@loongson.cn>
Subject: Re: [PATCH] spi: atmel: No need to call spi_master_put() if spi_alloc_master() failed
Message-Id: <159422764255.28955.1390293097777324594.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 7 Jul 2020 16:50:42 +0800, Peng Fan wrote:
> There is no need to call spi_master_put() if spi_alloc_master()
> failed, it should return -ENOMEM directly.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: No need to call spi_master_put() if spi_alloc_master() failed
      commit: 2d9a744685bc3a4bf1d097782550c450ff0c3b04

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
