Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1C240D3F
	for <lists+linux-spi@lfdr.de>; Mon, 10 Aug 2020 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgHJS6f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Aug 2020 14:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgHJS6f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 Aug 2020 14:58:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 379432080C;
        Mon, 10 Aug 2020 18:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597085915;
        bh=hQXDCWWlQ1DnxMOL5VXJ+bAuZfFOfBLepB41/sfErNQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GWHXBAfhN9c4Xi+C3+oD1nMDSSew8bsntbkOwjZ/+ag8zD35AOfHxPWwsXUnZThvS
         jrvuEk6mLKnUDO9vBgApfdOFqu0wSQ1elF60FWOGMS4CTu4Wjq+WNP31wilciH/D1z
         N/LQKrlYdnltRo/tPLdHWEfmOtASnr6iEagbFTrQ=
Date:   Mon, 10 Aug 2020 19:58:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20200807121057.14204-1-geert+renesas@glider.be>
References: <20200807121057.14204-1-geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: lpspi: Add missing boolean type for fsl,spi-only-use-cs1-sel
Message-Id: <159708588098.21609.11539908447717402760.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 7 Aug 2020 14:10:57 +0200, Geert Uytterhoeven wrote:
> When running "make dt_binding_check" (even if restricted to an unrelated
> binding document using DT_SCHEMA_FILES=...):
> 
>     Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml: ignoring, error in schema: properties: fsl,spi-only-use-cs1-sel
>     warning: no schema found in file: Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> 
> Fix this by adding a proper type definition for the vendor-specific
> fsl,spi-only-use-cs1-sel property.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: lpspi: Add missing boolean type for fsl,spi-only-use-cs1-sel
      commit: 0454357faaf8eea07af4f01a9e7afde175377b41

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
