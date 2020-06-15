Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B761FA49D
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 01:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgFOXld (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 19:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgFOXld (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 19:41:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BD52080D;
        Mon, 15 Jun 2020 23:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264492;
        bh=N1Ij/usB8zQH3UBOLC7sOuqSq5QNpKZThVTtUkokQlU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kvFwLRFSbEs5scz61K7kuHQL196g5fyYJPoHYLKA+b/8sSSzZW+z0JTFrUwPYQ1it
         l3zXX3FSQv2cQ6/9Dep7/KG1wkUqiJU5uF4WKW7zYSwH//iofye5WkOtT7cxxx+D0J
         NMiwC4OSbciUwPUuyr3j0oBN/0W+xSoNk9tlvl6c=
Date:   Tue, 16 Jun 2020 00:41:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 0/2] Add MSIOF support for R8A7742 SOC
Message-Id: <159226448569.27735.1827248945903303044.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 9 Jun 2020 21:54:12 +0100, Lad Prabhakar wrote:
> This patch series adds support for MSIOF on R8A7742 SOC.
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (2):
>   dt-bindings: spi: renesas,sh-msiof: Add r8a7742 support
>   ARM: dts: r8a7742: Add MSIOF[0123] support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: renesas,sh-msiof: Add r8a7742 support
      commit: 6383b118efafff8cce8fc8fa5b7e893a523b698f

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
