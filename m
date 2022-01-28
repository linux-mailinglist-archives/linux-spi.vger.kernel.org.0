Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F9A49FD60
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jan 2022 16:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349822AbiA1P7K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jan 2022 10:59:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53368 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349827AbiA1P7I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jan 2022 10:59:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A45FEB82647;
        Fri, 28 Jan 2022 15:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72045C340F0;
        Fri, 28 Jan 2022 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385546;
        bh=5H5s0l6yCQhly+8x0Oor+5F+3OJGLb5LwhDdxGtOqDg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UYaH1+Zp2r25QElQQBR6m6foWy41RKYHVdGigFcfVAE4y8idUS8rYqvlpKoY6o0g8
         SY4YsuqnT3m0Sl/ZwSNqdk2SePgl2gxzV7CPJrTvKoReVQPkywuQszOfGtxSvvxLAe
         sVMJZc77jVGE+CowNchBVskqWfLRWLLD+zpMr12PpdXAFQr9Th3MREG8Gb3Nm13XIv
         eqIYGDVaExqmjVIcyio55b/igSijGB2Q/xXUtoUpMpLu3eOXfCkm/fo6TzJqklD+dM
         12ESPKMYw9OWYEvwSh/Dp1nVrNvgcc46F7qU/+jZmPtfsZCYNDxDl1c+Rpzzge24N5
         Thjv4jm6avuyQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20220126231326.1636199-1-robh@kernel.org>
References: <20220126231326.1636199-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Fix 'reg' child node schema
Message-Id: <164338554519.1711475.1675932359217709506.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:59:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Jan 2022 17:13:26 -0600, Rob Herring wrote:
> The schema for SPI child nodes' 'reg' property is not complete. 'reg' is
> a matrix of cells. The schema needs to define both the number of 'reg'
> entries and constraints on each entry.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: dt-bindings: Fix 'reg' child node schema
      commit: 60b1e97140a487608b7cbde774b3cff1b5a99c00

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
