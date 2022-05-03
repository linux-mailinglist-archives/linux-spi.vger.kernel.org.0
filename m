Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C551890A
	for <lists+linux-spi@lfdr.de>; Tue,  3 May 2022 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiECPy4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 May 2022 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiECPyz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 May 2022 11:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F4F3B3FE;
        Tue,  3 May 2022 08:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C87F66168F;
        Tue,  3 May 2022 15:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EAEC385A4;
        Tue,  3 May 2022 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593080;
        bh=KkuXBkxl3M1SrH9rLok6F19ml6E97xmqNVUAIDYkAao=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tkCBD57f4XuGs75eNLeGYryfiWyg7qyPfjTS6XQ4AE+XBPnow2RzhMXWphNrq5rns
         4jcXJ5UaKfSwOXfY87Ztyu4nBPyPoJkW/zE8NVSCBRa0GfGkNJjEWVRSw3I+JTiSsf
         ESxKe9L8fH+bhTTw6OnH0vmt52hattDLjsGanMW2aEajKTWN7wyvhxK303N10010Tq
         IbXP55iAaVJ12+2+IwQ16Oycy+NKYvYKyP+nV0bznCMj+ExlTFcwT2tc0vMVdPufIA
         Bwu/8TrpumXCZBp9WgMtdJvJdB/DCQptNkZlz9Y1pvywxU32BSAw6kISkddSFgyKeC
         5tZVOXQpUKWAg==
From:   Mark Brown <broonie@kernel.org>
To:     biju.das.jz@bp.renesas.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, geert+renesas@glider.be,
        Chris.Paterson2@renesas.com, biju.das@bp.renesas.com,
        linux-renesas-soc@vger.kernel.org
In-Reply-To: <20220501082150.24662-1-biju.das.jz@bp.renesas.com>
References: <20220501082150.24662-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/G2UL SoC
Message-Id: <165159307802.184303.18335939609476308379.b4-ty@kernel.org>
Date:   Tue, 03 May 2022 16:51:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 1 May 2022 09:21:50 +0100, Biju Das wrote:
> Add RSPI binding documentation for Renesas RZ/G2UL SoC.
> 
> RSPI block is identical to one found on RZ/A, so no driver changes are
> required. The fallback compatible string "renesas,rspi-rz" will be used
> on RZ/G2UL.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: renesas,rspi: Document RZ/G2UL SoC
      commit: dfc6597eb1e1604575c6e061e1a9be0048d17b2c

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
