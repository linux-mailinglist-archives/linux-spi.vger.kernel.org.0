Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB16229978
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbgGVNpV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 09:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgGVNpU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 09:45:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBDBA2064C;
        Wed, 22 Jul 2020 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425520;
        bh=bhU2SrpxL6HK/PGcmY+z+DbNbJ/eMlUdGESTC5DRoYs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XqxGkFwjP4lDM6IyHBP02oBHIiEOzqliPZDN7yWLCZXeYg0ifhJa6kBA/f32DgLlI
         5nhB36jBo54jbTyLC0j21o0EsPGmSclCU84rluHtps2CVnNirULxctzCvkTEyDjKBS
         fojUfgiTnN7FbAE9NQJSJBc931uqTGSEjfTNsxbw=
Date:   Wed, 22 Jul 2020 14:45:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200721122436.31544-1-leilk.liu@mediatek.com>
References: <20200721122436.31544-1-leilk.liu@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: update bindings for MT8192 SoC
Message-Id: <159542550175.19884.9018022901634412745.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 21 Jul 2020 20:24:35 +0800, Leilk Liu wrote:
> Add a DT binding documentation for the MT8192 soc.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: update bindings for MT8192 SoC
      commit: 30962fe33ab5ed4bbd78c12f4b9e25a85c3e8d0b
[2/2] spi: mediatek: add spi support for mt8192 IC
      commit: 8cf125c403f4e0c7c7b78f34bbf9d7a7c55c1ff8

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
