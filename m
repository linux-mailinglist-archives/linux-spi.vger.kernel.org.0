Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FFC5EC33F
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 14:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiI0Mst (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 08:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiI0Msg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 08:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622BC14AD4E;
        Tue, 27 Sep 2022 05:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F037B6189A;
        Tue, 27 Sep 2022 12:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CADC433D7;
        Tue, 27 Sep 2022 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664282914;
        bh=PG9v6mJH6eEZ8x3CFsDSJ83Cg3al2A78Zn1VJOPpuds=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ab38CFuBdw3Dh8IU2r/p09kz43wJPEZxx9TF/pgj3eMgU/XhcnPCY9KyKpixDUkGC
         zz5V6ej/SDxfmP0OyLLbQvpsP7R7G/iWAT+gC8VLOFdTnkgzBJEKOwwB8cSi7cf+AC
         e2zJGwRF3JOqqjLoOA7ffShNkKmRYB9ioqvgG4hunUFa5GziXnAunjeULc6qj4kSXR
         FJbEs9cTcrsRpxc8bSEnRn8ZOKzG35EbfRsj+rQ+hZdziup+z0S2z+ZGuHRY6M5ffv
         ZZ5H4QERUV4oU6PYkXa8gvF0VrKgHwy6Pu1A36w6UEhWd9+mKdQ/V/DAJtcJBD/6gG
         mbHgsN+Mtu7Uw==
From:   Mark Brown <broonie@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        arinc.unal@arinc9.com
In-Reply-To: <20220927031929.807070-1-sergio.paracuellos@gmail.com>
References: <20220927031929.807070-1-sergio.paracuellos@gmail.com>
Subject: Re: [RESEND PATCH v3] dt-bindings: spi: migrate mt7621 text bindings to YAML
Message-Id: <166428291253.354496.654801731263989122.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 13:48:32 +0100
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

On Tue, 27 Sep 2022 05:19:29 +0200, Sergio Paracuellos wrote:
> SoC MT7621 SPI bindings used text format, so migrate them to YAML.
> There are some additions to the binding that were not in the original
> file. This binding is used in MT7621 and MT7628a Ralink SoCs. To
> properly match both dts nodes in tree we need to add to the schema
> 'clocks', 'clock-names' and 'reset-names'. Both 'clock-names' and
> 'reset-names' use 'spi' as string so maintain that as const in
> the schema.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: migrate mt7621 text bindings to YAML
      commit: 048f71f7685706dcc859160cc74f73e361cfe6c0

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
