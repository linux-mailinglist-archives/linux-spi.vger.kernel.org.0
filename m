Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391A43E2038
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 02:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhHFAsg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Aug 2021 20:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242622AbhHFAse (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A89EF60F14;
        Fri,  6 Aug 2021 00:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210899;
        bh=TwXuMV875p6zjhqmaCTkfv94OzqOszN/pY3u1piXC/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/ioGjgHMJOan4ghUNw+kqGWFNB1604iPhjPrZBQBW41RtWix85SKHVl0RTJpALMk
         /5fz4xkKdJ4Z+JCNAFpQLP88dC9zpME/uoxHYohQ3XNqZ02Yo1ol39fOze0aMW/xgP
         OnBjYHpnEclzjGNozDnJseEhtSwD35UfrAJy7CjjWvHHIF/3mlddwNohceG7SHfnpC
         9hWzptLHYpPaJTmhjEjw9VjIIEc2pXYcCKR6zdjZmaxuaEqaY4abivxQqsMgxkRhmC
         Q+oCCxUOd3hBRgnn1phR72zVwsb9ZDqTXD34RgnmbF/comVaEd/qLcP/Tn7R//8SzP
         x+F0oSFmvBxQA==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/2] spi: move cs spi_delay to spi_device
Date:   Fri,  6 Aug 2021 01:47:47 +0100
Message-Id: <162821082762.19049.10460753888752180575.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804133716.32040-1-Mason.Zhang@mediatek.com>
References: <20210804133716.32040-1-Mason.Zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 4 Aug 2021 21:37:17 +0800, Mason Zhang wrote:
> As we know, spi core layer has removed spi_set_cs_timing() API.
> So this patch moved spi_delay for cs_timing from spi_controller
> to spi_device, because cs timing should be set by spi_device but
> not controller.
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: move cs spi_delay to spi_device
      commit: 8c33ebfeeb597ea953df93f84ea25482d29c664f

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
