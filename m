Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4456AC044
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 14:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjCFNF2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 08:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCFNFW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 08:05:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E006A93E4;
        Mon,  6 Mar 2023 05:05:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 920A8B80E14;
        Mon,  6 Mar 2023 13:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E34AC433EF;
        Mon,  6 Mar 2023 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678107911;
        bh=VRHHZ5S0hUESvyjj5gGFFskHBuc8TKMpxLwWQsz+1eQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=u1QlB9nT0mJK/2kAu5yXrMYIE9cT7yoL/8dwdGU4kCOjqf/8JPJ6fwKFoNaOysH1f
         2z4R2Azk9agPswAwFuuup6QFvUFBSuk8YZWoW/CVRe2X77uxssrqlQ0SZkJkk2GysT
         A7lkp6HbalG4pBTOVNC8vgW2ZXvWjQvnWPf0d0MptImBoWD+kn5yQ2dMDpRgcEwqj3
         +KewWFjDdn2jmXO308RSa1/quhgt+VJfRDuwfrkzHR5dgN+zqXvoNE+0jsHdg/yl/x
         rm736e3KPncwcGwlsjAADRg/jFLLy9KPqGJh8G53vrlSB+GXAmnXlvQrBq9Tin7TT7
         lRL5TANsW9SCQ==
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
In-Reply-To: <cb7690d9d04c06eec23dbb98fbb5444082125cff.1677594432.git.geert+renesas@glider.be>
References: <cb7690d9d04c06eec23dbb98fbb5444082125cff.1677594432.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: Replace spi_pcpu_stats_totalize() macro by a C
 function
Message-Id: <167810791004.67440.16586593658572379579.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:05:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 28 Feb 2023 15:43:08 +0100, Geert Uytterhoeven wrote:
> spi_pcpu_stats_totalize() is a rather large macro, and is instantiated
> 28 times, causing a large amount of duplication in the amount of
> generated code.
> 
> Reduce the duplication by replacing spi_pcpu_stats_totalize() by a real
> C function, and absorb all other common code from
> spi_statistics_##name##_show().  As (a) the old "field" parameter was
> the name of a structure member, which cannot be passed to a function,
> and (b) passing a pointer to the member is also not an option, due to
> the loop over all possible CPUs, the "field" parameter is replaced by an
> "offset" parameter, pointing to a location within the structure.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Replace spi_pcpu_stats_totalize() macro by a C function
      commit: fc12d4bb3227f21e1e7d6d78231074ca542c060d

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

