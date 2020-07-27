Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178AA22EE12
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 15:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgG0N5L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 09:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgG0N5K (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 09:57:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010CD2070A;
        Mon, 27 Jul 2020 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858230;
        bh=801YCg5Y2Y26M201PENQ7hgJs7fduBKQjxO6+Sz7+JY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=SGeS0YfCR7+mMcTuYhMJIsImof8BWpf6MYL0XCGO3jf5X2zyp0QDOPri8alZeVcx5
         6Wf23TcrjK7uRLMctXEZ/Sb03IsEcoEQLIodxiYEKPNrmp3qpTuspaO5T6H6vwleRR
         cPRsFmw6aoFz4gd6A0sR8Ti0kBCRPRdhn58T36X0=
Date:   Mon, 27 Jul 2020 14:56:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200725050242.279548-1-colton.w.lewis@protonmail.com>
References: <20200719195630.148075-1-colton.w.lewis@protonmail.com> <20200720143655.GA5949@sirena.org.uk> <20200725050242.279548-1-colton.w.lewis@protonmail.com>
Subject: Re: [PATCH v2] spi: correct kernel-doc inconsistency
Message-Id: <159585821343.22560.16007476069938782361.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 25 Jul 2020 05:02:57 +0000, Colton Lewis wrote:
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
