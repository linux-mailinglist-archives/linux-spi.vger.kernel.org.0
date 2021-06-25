Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C283B4462
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jun 2021 15:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhFYN1p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Jun 2021 09:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231715AbhFYN1p (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Jun 2021 09:27:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BC5361628;
        Fri, 25 Jun 2021 13:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624627524;
        bh=WxIJxli4AY2OzgvglrYAP6hXNTuIEOF4dbQeg0FimR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+SSMk/z2ZALvfqSOWl2NL3wHZTHkA7rCxXmHTqgmccZuc+Ntdm4uSCtIlk035EBc
         QsM5ld/mMaJcRK+3Ax9sWvOL1d41jo+P+ybEpH2P3d3Y9xYyVcaWF+FVAZkLOAx8Ge
         dyZeNDNao/gvReHdYAhPCdOTqmw/frR3dU1nhQhio5bmEgVaHOsub9QAqgvS6RYUft
         F89MMcOdZcwlUye5bduiNkdLO2sKHxz7JRSivkU/lTmWcXsPfC4j1Aew0+rR0Wn8Bu
         Sfs6gMDuNuUwaMRFtlYg9UM8EcqXYK9hR/HwsRwREY91DwRWO/Y0hlT1ulfk9ardYk
         XVns8hK7uK7hg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Colin King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] spi: Fix self assignment issue with ancillary->mode
Date:   Fri, 25 Jun 2021 14:24:55 +0100
Message-Id: <162462715507.45765.15783651843423653220.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210623172300.161484-1-colin.king@canonical.com>
References: <20210623172300.161484-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 23 Jun 2021 18:23:00 +0100, Colin King wrote:
> There is an assignment of ancillary->mode to itself which looks
> dubious since the proceeding comment states that the speed and
> mode is taken over from the SPI main device, indicating that
> ancillary->mode should assigned using the value spi->mode.
> Fix this.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix self assignment issue with ancillary->mode
      commit: b01d550663fa5fd40a1785b0f1211fb657892edf

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
