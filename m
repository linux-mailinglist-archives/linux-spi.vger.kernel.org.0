Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3831283DD9
	for <lists+linux-spi@lfdr.de>; Mon,  5 Oct 2020 19:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgJERzx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Oct 2020 13:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgJERzx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Oct 2020 13:55:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0B92083B;
        Mon,  5 Oct 2020 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601920552;
        bh=/YYqoxgnewwjyfR7ZhR+yOk7SdtO5OpBzT2DcHZa1Zo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=a8uDN8e1TjwS2NrxJagJf99/dyQQbVvUwuSssqO6wDi/6OS4y/Xf54vjmpfXAhnr4
         7ya0wac5/Djy6TzhWJhMe1i1ang9ZGML6n+C0JgeMTVxk1govWSu3e3IreoG+Lb1yR
         2aAAIGT7o7lfvxCm6AAfASN7xlGSOkft70nWdJ5Q=
Date:   Mon, 05 Oct 2020 18:54:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20201005112549.22222-1-geert+renesas@glider.be>
References: <20201005112549.22222-1-geert+renesas@glider.be>
Subject: Re: [PATCH] spi: renesas,sh-msiof: Add r8a77961 support
Message-Id: <160192047990.23319.4803614539729270841.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 5 Oct 2020 13:25:47 +0200, Geert Uytterhoeven wrote:
> Document R-Car M3-W+ (R8A77961) SoC bindings.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: renesas,sh-msiof: Add r8a77961 support
      commit: aef161f4f1b829e91c4aaaac75c2b8fcdbc033fc

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
