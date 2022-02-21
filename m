Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1874BE972
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 19:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379084AbiBUPZC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 10:25:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379071AbiBUPY7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 10:24:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B51EEC4;
        Mon, 21 Feb 2022 07:24:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63AE3B8121F;
        Mon, 21 Feb 2022 15:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2486C340E9;
        Mon, 21 Feb 2022 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645457073;
        bh=Es8CyilU8tZmWWN+sDFjUFuj8k3qcZA/ED3G9yH3wUc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bsyw51rHynR4gU1dpOSE4lGIlDuHjZmX1tnH/xvOiGC01TJaNAsU6jmy/5MXYHerI
         QlyFk08czpWIHA0IeDj1Du4CYp4yBIVzWvhU7WjGCSNBpGH+hsabql38LHtD+BohZu
         4qmNOeMinFV0bHn82Q4At5DfNHCoyV/rYJQ5fRoUK4tOA7qjPVSIF8XNuOfVjYo/35
         8bdvAZcDpw/ILn8SOauf3+IwFrnYs9PA4wnhgMr3BYBKkIESBlwzg7mSl8jk9pR94W
         P8W1xKjd1gza+tOLixrX7sMS2BvD8FsoSlw9yGak4x9LlPYbqPo5sqaBLf8qURjreK
         dKOwtakDNJQUw==
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <monstr@monstr.eu>, linux-spi@vger.kernel.org
In-Reply-To: <20220126112608.955728-1-miquel.raynal@bootlin.com>
References: <20220126112608.955728-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v6 0/3] Stacked/parallel memories bindings
Message-Id: <164545707048.739789.8289707487294516050.b4-ty@kernel.org>
Date:   Mon, 21 Feb 2022 15:24:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Jan 2022 12:26:04 +0100, Miquel Raynal wrote:
> Here is a sixth versions for these bindings, which applies on top of
> the v5.17-rc1 now that Pratyush's work as been merged.
> (https://lore.kernel.org/all/20211109181911.2251-1-p.yadav@ti.com/)
> 
> Cheers,
> Miquèl
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: mtd: spi-nor: Allow two CS per device
      commit: b252ada293d5d30566121c61fa7552e74396d533
[2/3] spi: dt-bindings: Describe stacked/parallel memories modes
      commit: e2edd1b64f1c79e8abda365149ed62a2a9a494b4
[3/3] spi: dt-bindings: Add an example with two stacked flashes
      commit: eba5368503b4291db7819512600fa014ea17c5a8

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
