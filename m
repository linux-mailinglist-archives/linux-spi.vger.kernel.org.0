Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B92A6F1E
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 21:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbgKDUoP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 15:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732407AbgKDUoP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Nov 2020 15:44:15 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A023720637;
        Wed,  4 Nov 2020 20:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604522655;
        bh=phWy8wFs8Ni447e7zJCWex9IyDOgystXGx2LhFrSuXU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lHeZ8c8cjP2z7YbzhkQIqjZ8QYW1DHL6slov+fl9jqJAdCYlRaVyk3IMNwk6ZkO7p
         6keEOEh1f6QX1tZOVSZTvgGyYarp1jNC4vbTwp+2BvwRgpwd0ippvTgmS0XI74EEeQ
         pD1if11oi8sY09Zzx1+8q5qgBiSpqQ9EZ+vK8OCI=
Date:   Wed, 04 Nov 2020 20:44:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>, olteanv@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201103020546.1822-1-qiang.zhao@nxp.com>
References: <20201103020546.1822-1-qiang.zhao@nxp.com>
Subject: Re: [Patch v2] spi: fsl-dspi: fix wrong pointer in suspend/resume
Message-Id: <160452263225.7406.16957258089179572669.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 10:05:46 +0800, Qiang Zhao wrote:
> Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in
> remove path"), this driver causes a "NULL pointer dereference"
> in dspi_suspend/resume.
> This is because since this commit, the drivers private data point to
> "dspi" instead of "ctlr", the codes in suspend and resume func were
> not modified correspondly.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-dspi: fix wrong pointer in suspend/resume
      commit: 9bd77a9ce31dd242fece27219d14fbee5068dd85

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
