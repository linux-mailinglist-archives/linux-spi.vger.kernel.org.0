Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B3C5EC177
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiI0LdM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 07:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiI0LdL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 07:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DC923C8;
        Tue, 27 Sep 2022 04:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65BDD618A2;
        Tue, 27 Sep 2022 11:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57083C433D7;
        Tue, 27 Sep 2022 11:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664278384;
        bh=gpfGRrAWW5mkPRoJOdCRu0hfA1mpduu9wAyITqlMEDk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cS6z6QiCRu7eQFH+OiWE7ejo6olwc6VlyRXFy8wfsFM3Bbe2TCJzoKjxLVdYDc+wf
         jUThVcR4CiWE62YPgkzxZJq+mVMuXziVb7Z8TGAqryY4eVuCpF1M3mCYbSCcGNMGuH
         nsbnso6s4gw8l9axZkZZ7ax+sqnS1vOQ1oOXnhIOVw0Hxo9SVaoJwScXaoB0lZnJ+O
         Re/AecTRmWE9YzBBoTaMhUplz/nBEUh2XkcrxUgjbFPILFE19fbCrf11M9PXHcKILT
         eeYn3cCZ4v1AkTkjA0Ak6pVqJYytjzJHrkTI9Sx+kYxmWCv/adSNEouzFaVSw87/d9
         pFSQA2kIGYk7g==
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <a840ca8487cfd612fae2b20c98e93ae7c7f50ef4.1664204638.git.geert+renesas@glider.be>
References: <a840ca8487cfd612fae2b20c98e93ae7c7f50ef4.1664204638.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: renesas,sh-msiof: Add r8a779g0 support
Message-Id: <166427838298.302944.9343978718748524915.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 12:33:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 26 Sep 2022 17:05:42 +0200, Geert Uytterhoeven wrote:
> Document support for the Clock-Synchronized Serial Interface with FIFO
> (MSIOF) in the Renesas R-Car V4H (R8A779G0) SoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: renesas,sh-msiof: Add r8a779g0 support
      commit: aa69dc65e3b34ce67847f92be06ce9a624a02475

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
