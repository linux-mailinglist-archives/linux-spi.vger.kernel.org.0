Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC722EE15
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgG0N5Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 09:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgG0N5P (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 09:57:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19302070B;
        Mon, 27 Jul 2020 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858235;
        bh=7Wjw+pSHhPm0OgmFnjV6bkDENQpBkadoXEhgPMl9EFs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mgqEQiwBLI/SjkF3tzaRn8FqYjBxKBfpLL5pYsskhEGtbmMxh5frhdqMfoBnELdtM
         HJrjyAyFINYcZ/LrWcCFrF3IggTVqR2O3+kEP4YY7j+qMmzNe4hJwpUmgWpHuFaJkb
         LTJM9AFLsaykT0mwHoBFAMFz69oTKzTlTuFTKP/w=
Date:   Mon, 27 Jul 2020 14:56:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200719195630.148075-1-colton.w.lewis@protonmail.com>
References: <20200719195630.148075-1-colton.w.lewis@protonmail.com>
Subject: Re: [PATCH] spi: correct kernel-doc inconsistency
Message-Id: <159585821343.22560.13612653659579069895.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 19 Jul 2020 19:56:40 +0000, Colton Lewis wrote:
> Silence documentation build warnings by correcting kernel-doc comment
> for spi_transfer struct.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: correct kernel-doc inconsistency
      commit: cfd97f94d036bf36122fa19d075c5741347aa178

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
