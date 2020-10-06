Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5FD284ECF
	for <lists+linux-spi@lfdr.de>; Tue,  6 Oct 2020 17:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgJFPWQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Oct 2020 11:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgJFPWP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 6 Oct 2020 11:22:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B39B206DD;
        Tue,  6 Oct 2020 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601997735;
        bh=gGFFKOYWD32Z85Ha3gjhDPcj1DnSsoFGs28UJqXpmQ0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RLS3rz5B2f71cZWm2lEXIpUpc6lKf9iNNkpgGnCG1jHrncUcd1dgp8zfTBWJVSr8q
         CwAsab3KqgIvsZgyrbwTVL8AxRt5oph/S6A4IddXsuPUfJ3LqFd+cWaMdIHrz0pkcj
         IDHQhu3lOVfACpNAGXNJqSds+dXXg+Vg7+8qWXqU=
Date:   Tue, 06 Oct 2020 16:21:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200929073755.3741416-1-ikjn@chromium.org>
References: <20200929073755.3741416-1-ikjn@chromium.org>
Subject: Re: [PATCH v4 0/4] spi: spi-mtk-nor: Add mt8192 support.
Message-Id: <160199767221.51670.15465712925313409583.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 29 Sep 2020 15:37:51 +0800, Ikjoon Jang wrote:
> This patchset adds 36bit dma address and power management
> supports for mt8192-nor. Additionally, use dma_alloc_coherent()
> instead of kmalloc() for internal bounce buffer for platforms
> of only supporting 32bit addresses.
> 
> Changes in v4:
> - Drop two patches from a list which already addressed by
>   an another series and not directly related with mt8192 support
> - Fix 0-day ci 'shift-count-overflow' warning
> - Fix missing 'high_dma' initialization for 36bit address
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] dt-bindings: spi: add mt8192-nor compatible string
      commit: 9935b612a5dba99cf8dc0f9fe7592a2a35c005fb
[2/4] spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
      commit: a1daaa991ed1f13b86f6d9df174f21c4e23d33ba
[3/4] spi: spi-mtk-nor: support 36bit dma addressing
      commit: e836d4cf615f89c6695408e5dcacdefa5cf50167
[4/4] spi: spi-mtk-nor: Add power management support
      commit: 3bfd9103c7af07915a84a6849e718622936233c1

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
