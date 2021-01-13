Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6F2F5183
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 18:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbhAMRzl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 12:55:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbhAMRzk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 12:55:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B06D52337F;
        Wed, 13 Jan 2021 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610560500;
        bh=x9rFdBeqTSdaYYBmWzZqpRoQH69zN2/eeBVqYuzyn5A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BFC+HDYxW+dFc2wL45vtNQIO9IUi7SfXNxrMsRqSQTF3mOPSeg4445ZMtI+6n2m5o
         hjCNSA9dzu+vTu+/mBJXxsulYYY4DQImRypNxMorqpa5EhBNupDaDPDMh9EcOn0O9a
         KufhZPx5J2P5vdon8RiU7DAbQP8Ew9Ar+kVAPVCaVswQigjbnre7Uz9Ex+XpF6/bAt
         Q26TfM306RRysaD3D3V0/jN2UEGSB4SxbmH+F2GZuSes4czmsT75sT892i1aWtAax2
         YWkvG//h631rhut9WgzLeVVHv89I+HYdrff4sxs32ks67CDV0JTY/SlP+qZ7Y5gAp8
         lH0h138kSOU2w==
From:   Mark Brown <broonie@kernel.org>
To:     sbranden@broadcom.com, rjui@broadcom.com, f.fainelli@gmail.com,
        nsaenzjulienne@suse.de,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com
In-Reply-To: <20210107164825.21919-1-rf@opensource.cirrus.com>
References: <20210107164825.21919-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] spi: bcm2835: Set controller max_speed_hz
Message-Id: <161056046630.11960.4692892345837780609.b4-ty@kernel.org>
Date:   Wed, 13 Jan 2021 17:54:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 7 Jan 2021 16:48:25 +0000, Richard Fitzgerald wrote:
> Set the struct spi_controller max_speed_hz. This is based on the
> reported source clock frequency during probe. The maximum bus clock
> is half the source clock (as per the code in bcm2835_spi_transfer_one).
> 
> If the controller max_speed_hz is not set, the spi core will limit all
> transfers to 0 Hz so only the minimum possible bus frequency would be used.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: Set controller max_speed_hz
      commit: c6892892a95debac8050579b0709214b7b28b514

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
