Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D683B1E4F
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jun 2021 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFWQLs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Jun 2021 12:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhFWQLq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 12:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F8016128D;
        Wed, 23 Jun 2021 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624464568;
        bh=kYat1lDcdPalxoyEdVzJzS8BZA5l+ubFAD8SJB7kRZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvV/5OyvJHxWST+toyxpna2dJTYbAWR3k21l1PTEi0vXnH++6SbvGvvkT22ICt539
         AxcIw7Bw0QlUVebTEbqNCQ2vqpwReVfMp147PnO2aqtjCmtHpzb4kWpAaiXmIU80Aw
         cF3L7RXcO2Fu0kgE2NGPmzmzOd2QmPYUqSfMLb1mWazxesMxXPB82cqHmcUtJLXK18
         g+c8AkSkLUqiPV/BuLEEDIuL4x5m7jFCFMJG63NTnCMlLouNuYkr4WKQtHXD/4mcZy
         zP8xjXOzuaELxGQsK0Jkf9Zy6O8yECMe2vFj+BDAip4hrgfRZ23AIwVj9M5Mu4TPA/
         Ga8e3Efqc4HKg==
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: use proper DMAENGINE API for termination
Date:   Wed, 23 Jun 2021 17:08:51 +0100
Message-Id: <162446446390.55587.10222548953553641662.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210623095843.3228-1-wsa+renesas@sang-engineering.com>
References: <20210623095843.3228-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 23 Jun 2021 11:58:41 +0200, Wolfram Sang wrote:
> dmaengine_terminate_all() is deprecated in favor of explicitly saying if
> it should be sync or async. Update the drivers I audited.
> 
> 
> Wolfram Sang (2):
>   spi: spi-rspi: : use proper DMAENGINE API for termination
>   spi: spi-sh-msiof: : use proper DMAENGINE API for termination
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-rspi: : use proper DMAENGINE API for termination
      commit: 29176edd6e7ad7333d0bb19a309b2104fa4f4341
[2/2] spi: spi-sh-msiof: : use proper DMAENGINE API for termination
      commit: a26dee29ec04a3f6779684852c36a2a71fd68fd8

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
