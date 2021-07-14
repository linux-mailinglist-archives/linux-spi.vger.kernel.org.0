Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1573C8814
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbhGNP6x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 11:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239701AbhGNP6x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 11:58:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76DE8613CC;
        Wed, 14 Jul 2021 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626278162;
        bh=gEu+Jtcj2NEsaDHGvOg2sAtFey9JYCHOR9qWF+uXbd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6AFgLkI6XAzOujcUunthnH4B4C3MzeetcWKP2sRJ34JV2Vwjhcx6flvENIZeP17Y
         jcUqvVNek2KNPG2CQXeJhDDmMT0xAIpUPnWB66apMJZpZrHGTc7XP5gd4dj0TDso+s
         k3JeVZG0XoyCp4khoKeGKdCJhBkG+j3mBii2AsoA7Vs0zAvQBFsS1TtzRjHCSHqDc7
         tcjEtmoxySC/YiZklCdf3PGRUXIawsg8RZqqrF7E08QJABHrHIWiDBfEuMkcLwrCgK
         c1JmGHCu1rzHD7hOIx/yel/VIsXCULAFUhncOQFw/1p0ArVt+aaE5JloG3NLpfrm+/
         V98Bd2oATMhlQ==
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, wsd_upstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, leilk.liu@mediatek.com,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: mediatek: move devm_spi_register_master position
Date:   Wed, 14 Jul 2021 16:55:14 +0100
Message-Id: <162627784666.55213.16618385116168293690.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210713114247.1536-1-mason.zhang@mediatek.com>
References: <20210713114247.1536-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 13 Jul 2021 19:42:48 +0800, Mason Zhang wrote:
> This patch move devm_spi_register_master to the end of mtk_spi_probe.
> If slaves call spi_sync in there probe function, master should have probe done.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: mediatek: move devm_spi_register_master position
      commit: c934fec1c32840224fd975544c347823962193b2

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
