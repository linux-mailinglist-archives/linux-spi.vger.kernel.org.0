Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DDD268E7D
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgINOzm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 10:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgINOxM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 10:53:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C52B20715;
        Mon, 14 Sep 2020 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095191;
        bh=20if88FRBdbGtqEL7fqEJYDNeUXmQ356etNiMZV1+CE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uCocBov4oB89i1msgky0qozFIo2EsmibalIP2pTGI/lPgGGMyi64MKwK7Nr1Covfn
         PvDaHOqUIms7/uIO2Rt8r11q/k1pGzTc7AeuCUcxfhbSnRSOqeoL9nCQ6Xp1ehYJku
         lzHp6XZ1KcUwubSFEWuM/zwBomMxg44gf+dSisAc=
Date:   Mon, 14 Sep 2020 15:52:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
In-Reply-To: <20200910152539.45584-1-ray.jui@broadcom.com>
References: <20200910152539.45584-1-ray.jui@broadcom.com>
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add compatible string for brcmstb SoCs
Message-Id: <160009511834.5702.10954218363830361529.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Sep 2020 08:25:36 -0700, Ray Jui wrote:
> Add compatible string for brcmstb 7445 SoCs.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: Add compatible string for brcmstb SoCs
      commit: d9f0cf9f1176d36d3824459d5b061f4719fcbb8a
[2/4] spi: bcm-qspi: Add compatible string for BRCMSTB 7445 SoCs
      commit: e0eeb76b818ad93718f9640b0bdad909b453a3b8
[3/4] spi: bcm-qspi: Fix probe regression on iProc platforms
      commit: 9a852d44b26f8e60e2ae13df563824c0f8489135
[4/4] spi: bcm-qspi: Clean up 7425, 7429, and 7435 settings
      commit: 3cf5d198785a6b454e6a97246795b0043aff9ac1

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
