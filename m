Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62F3E2030
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 02:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbhHFAs2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Aug 2021 20:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241694AbhHFAs0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDD6261179;
        Fri,  6 Aug 2021 00:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210891;
        bh=SJngD0TLU06KGxhn5FSbzmHj0sNAqLNqGK3TJwK87Fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRxAgMe5obGiobD4uKlMY+JF1bnP2KKw1mO5exoIchNvLacRb9QdADJLBHA0RYjOF
         IT8K8Yv+zERFQ6hCfAogIHH+lnB3kKLDvbc/RDWLAIRSeh717m/7ZGx9qV83t3RJyw
         vPnVpNbgw0234NHkitFdlrUAyrp4MZaUF0HoYeErsIxdSYR5XkwsKq5C529AduqD4E
         ObbGCubG4rJkMvWPb01L6BzaWlZTeNQSUdBQWhbHddKnjk8g1ecoTpY67nnaIPXJ4W
         SByX82ZyaeoL0uX4rP5QDTyyuqJRLZS+gXXqK+hvhNghS4niHqXhPnUwmCALeMLOv5
         +rHq2/Vb/zrFw==
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        wsd_upstream@mediatek.com, leilk.liu@mediatek.com
Subject: Re: [PATCH 1/3] spi: move cs spi_delay to spi_device
Date:   Fri,  6 Aug 2021 01:47:44 +0100
Message-Id: <162821082762.19049.12115037494826323107.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719091611.15303-1-mason.zhang@mediatek.com>
References: <20210719091611.15303-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 19 Jul 2021 17:16:12 +0800, Mason Zhang wrote:
> As we know, spi core layer has removed spi_set_cs_timing() API.
> So this patch moved spi_delay for cs_timing from spi_controller
> to spi_device, because cs timing should be set by spi_device but
> not controller.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: move cs spi_delay to spi_device
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
