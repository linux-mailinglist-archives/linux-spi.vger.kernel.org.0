Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB66745FA1
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jul 2023 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjGCPO7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jul 2023 11:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjGCPO6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jul 2023 11:14:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF845E41;
        Mon,  3 Jul 2023 08:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E49A60C99;
        Mon,  3 Jul 2023 15:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4453C433C7;
        Mon,  3 Jul 2023 15:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688397296;
        bh=KxWo/RBht4/hO7fKbjafKIB1v9a+RFMeODCo/ZH8V/8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q6Qt98LXRrlu1CsaHLoLNHZQC4cBoAwklDiVxk77RSz7biBbSMUqvzCSDRDXfpeu2
         N5VqFnajgTl+dIyojz6QzVBn2gCIP7wKhUM5+B8kC36vqR3zOs2ET1jsTpcuBAxw0H
         3U4fFENl/xXcoaINsldYhtDp2QVmDNyTmaWBzBDt1G7yHXdZK1XPe6Oz2VKLIGGZp4
         S29QJsHZu45UN8HRRoVJsqEiAtTtPk2EpL9gHRll8u3ryCUQVyiUzsaWw48MFBR+fg
         30TdQexzlwOEoAmuM3W2DmC/qBaYc28e3lADSgmeE61Lde5XCXYN+KPcPnWU/k2hQU
         PMQTrA9J02evA==
From:   Mark Brown <broonie@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <89e9870a2c510387e4d7a863025f4d3639d4a261.1688375020.git.geert+renesas@glider.be>
References: <89e9870a2c510387e4d7a863025f4d3639d4a261.1688375020.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: rzv2m-csi: Fix SoC product name
Message-Id: <168839729549.111411.5009338824639946052.b4-ty@kernel.org>
Date:   Mon, 03 Jul 2023 16:14:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 03 Jul 2023 11:05:30 +0200, Geert Uytterhoeven wrote:
> The SoC product name is "RZ/V2M".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rzv2m-csi: Fix SoC product name
      commit: e1ef683c86d248e785499779156d9885fd4e85fc

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

