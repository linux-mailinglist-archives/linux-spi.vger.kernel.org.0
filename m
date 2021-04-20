Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE999365F7C
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 20:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhDTSgd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 14:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233521AbhDTSgc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 14:36:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCE4C61002;
        Tue, 20 Apr 2021 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618943760;
        bh=Vl/xDfhSSSaJydX/7Hg32mJnZm6/w8UcQTG3m5vrcuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUgPhxnv6izynLvQdPFBj2C4xdDAa0LJqBogAVwt3dctL/WvUb01Clwh5TugC5TwA
         6vZUBKlvaLmy4sXc2ep2lkWUsJSukC3X1dB5mVG/sYkomE5qu3iK2eotwVHwHOYOdC
         NbvDzx4LZT4CW4gxAmh/vzwnIjobOhWK0lpGIalCV3adsBiNBxWeuNeflLsfqxOtDK
         XF+eU42lbcisn/UtvAXAxx2J48H82gQttNCmEYsVBj4UGTCLs9Hhy1ZKf8xoK22bow
         cxBYmEk8MAtD52LgglRSdzl7c1gsafRd9iJI1vOIQ1jhScnDsiNWqRenUXEb1ZrD1v
         2RtsAu4vf+inQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH V3] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the json-schema
Date:   Tue, 20 Apr 2021 19:35:29 +0100
Message-Id: <161894372992.35357.4077976563390352628.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416194723.23855-1-zajec5@gmail.com>
References: <20210416062320.21414-1-zajec5@gmail.com> <20210416194723.23855-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Apr 2021 21:47:23 +0200, Rafał Miłecki wrote:
> This helps validating DTS files.
> 
> Changes that require mentioning:
> 1. reg-names
>    "mspi_regs" and "bspi_regs" were renamed to "mspi" and "bspi" as that
>    is what's used in DTS files and in Linux driver
> 2. interrupt-names
>    Names were reordered. "mspi_done" has to go first as it's always
>    required.
> 3. spi-rx-bus-width
>    Property description was dropped as it's part of the
>    spi-controller.yaml
> 4. Examples:
>    * drop partitions as they are well documented elsewhere
>    * regs and interrupts were formatted and reordered to match yaml
>    * <0x1c> was replaced with <&gic>
>    * "m25p80" node name became "flash"
>    * dropped invalid "m25p,fast-read" property
>    * dropped undocumented and Linux-unused "clock-names"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the json-schema
      commit: 7d82f89c39ad3193893d36924fc1f8d44f3dc612

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
