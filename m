Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D596C20A2
	for <lists+linux-spi@lfdr.de>; Mon, 20 Mar 2023 19:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjCTS7i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Mar 2023 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCTS7J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Mar 2023 14:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF8A366A1;
        Mon, 20 Mar 2023 11:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4EC617BA;
        Mon, 20 Mar 2023 18:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111EBC4339C;
        Mon, 20 Mar 2023 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679338255;
        bh=mUlpbkNkN1W9Z3Hnv2LoFVuAyOp17FBJXxImNCU4ykE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IeOYaDHBGGzGU4ww4MuYiwjEd0VFO57+Z63IUVLQYAxRIzMBD9plxPB5zJyB67+iE
         EYKDYvDEUg0E5HQQKyaxjYYtN0LJvDaZdly2BywT2WZm8/eLd8+nRSrGgg8A9KSAql
         8uHrzZQ6IFYJ+vvAF/SUi5dT31HyQqvPq9ehvjIfRUiVo7CKGMZGGi1xCXK9XRQ5y6
         UV/bhxICZAs/jwDI/g5ZIFLubS+85wxURIVvuU4xyPMIR26BG0pCowZW3rF0YgyEqP
         esDwEhMfDgM5HlsKBRifUd+/WIuOKoKo5yDwWBDyiclQ5qUmj3WJQzgg7egSJah+cF
         8M6aG8jqexINw==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
In-Reply-To: <052af97ecbaa9ba6e0d406883dd3389fa397579a.1678891999.git.geert+renesas@glider.be>
References: <052af97ecbaa9ba6e0d406883dd3389fa397579a.1678891999.git.geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: spi: renesas,sh-msiof: Miscellaneous
 improvements
Message-Id: <167933825378.203761.13276201001333736980.b4-ty@kernel.org>
Date:   Mon, 20 Mar 2023 18:50:53 +0000
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

On Wed, 15 Mar 2023 15:54:07 +0100, Geert Uytterhoeven wrote:
> Make "clocks" and "power-domains" required everywhere.
> Make "resets" required on R-Car Gen2 and newer (i.e. all but SH-Mobile).
> 
> Update the example to match reality:
>   - Use interrupt binding definitions instead of hardcoded numbers,
>   - Convert to new-style CPG/MSSR bindings,
>   - Add missing "power-domains" and "resets" properties.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: renesas,sh-msiof: Miscellaneous improvements
      commit: a0dcd1ff96293775c3ec30ae0091713982c5c24c

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

