Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C263726E4FB
	for <lists+linux-spi@lfdr.de>; Thu, 17 Sep 2020 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIQTDF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Sep 2020 15:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgIQS7X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Sep 2020 14:59:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C02E02072E;
        Thu, 17 Sep 2020 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369163;
        bh=nX846neJ8m5az152DdhX1ym9dr0MQJHeVKSHdhXHATU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GnFLAAIYkgmFQ10RoepDl6D0BvxCNeA24gr9wucjU0619KdBHD9DW75Uh1KhzYEqn
         lrxFmQofPB58ojnbjPhZCXXSxvK3OJrYOQ8IsnNy36uzDBXBU3C3BZr7l0NSfui6rJ
         zygc/zHduzd/hNnOIwGBtZ8gTkwNALmkRX4p2Aws=
Date:   Thu, 17 Sep 2020 19:58:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Cc:     arnd@arndb.de, joel@jms.id.au, robh+dt@kernel.org,
        bradleyb@fuzziesquirrel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200909222857.28653-1-eajames@linux.ibm.com>
References: <20200909222857.28653-1-eajames@linux.ibm.com>
Subject: Re: [PATCH v2 0/6] spi: Fixes for FSI-attached controller
Message-Id: <160036909796.20353.1611199933443986586.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 9 Sep 2020 17:28:51 -0500, Eddie James wrote:
> This series implements a number of fixes for the FSI-attached SPI
> controller driver.
> 
> Changes since v1:
>  - Switch to a new compatible string for the restricted version of the
>    SPI controller, rather than a new boolean parameter.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: fsi: Handle 9 to 15 byte transfers lengths
      commit: 2b3cef0fc757bd06ed9b83bd4c436bfa55f47370
[2/6] spi: fsi: Fix clock running too fast
      commit: 0b546bbe9474ff23e6843916ad6d567f703b2396
[3/6] spi: fsi: Fix use of the bneq+ sequencer instruction
      commit: 7909eebb2bea7fdbb2de0aa794cf29843761ed5b
[4/6] spi: fsi: fsi2spi: Add compatible string for restricted version
      commit: b0e4dfe93714b21e2fa9b03819b3e99383e5c330
[5/6] spi: fsi: Implement restricted size for certain controllers
      commit: 49c9fc1d7c101eceaddb655e4f0e062b0c8f403b
[6/6] spi: fsi: Check mux status before transfers
      commit: 9211a441e60686eec2ebd8f7bd65c4f780416404

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
