Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0353C8816
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbhGNP64 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 11:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239748AbhGNP64 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 11:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CA86613D1;
        Wed, 14 Jul 2021 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626278164;
        bh=T3tWRNqEl5egHYoESD+A3uK6ll8OfKGi/QN+AIQONqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBQkOP/8GgDQylBlHJAoHmsvdYeXOkIQU4cZeXubhCrS4EJOGIZHdxaGmwubo2RiF
         VNhl+UzvYhR3el1ojxDcjPqxsDNOFT+wwR+slq09lhfx8PmPa8qoiGDI/ppEEA0W3r
         M2AId0td0ov/ib7QuQy/bUR1UyCg80IelM4YDYTysDSpBT6I+JydRqaC2VzLRXAtPP
         Pg/CuJlSGddho+JnDXtcxIB3vDsoiqPRZK9rPDsqNAl+8pS005SldE3gny3xyMs91N
         PbNBHVTI3bZjHMPiXESnSKhE7sktAMNVFOj8FR2dUNRZbonYaRho2Zvudgr0xXBJoT
         AtuzOZci3KzbA==
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, wsd_upstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, leilk.liu@mediatek.com,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: mediatek: add tick_delay support
Date:   Wed, 14 Jul 2021 16:55:15 +0100
Message-Id: <162627784665.55213.15880844679522922656.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210713114048.29509-1-mason.zhang@mediatek.com>
References: <20210713114048.29509-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 13 Jul 2021 19:40:49 +0800, Mason Zhang wrote:
> This patch support tick_delay setting, some users need use
> high-speed spi speed, which can use tick_delay to tuning spi clk timing.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: mediatek: add tick_delay support
      commit: f84d866ab43fcc27b417c86357d6534f157a3d89

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
