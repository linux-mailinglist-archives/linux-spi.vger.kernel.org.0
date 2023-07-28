Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB577676BC
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjG1UGA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjG1UF7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 16:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A24487;
        Fri, 28 Jul 2023 13:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E03621F4;
        Fri, 28 Jul 2023 20:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B37C433C9;
        Fri, 28 Jul 2023 20:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690574757;
        bh=2p+4I23zbjL5pyHGpkjvrrPEIKrCNNgOL7k5ZAuRxpU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fQhUqeULDwCJAU9J7VNEGHLKULbv2a7KBy12RFbSfoc3d/ufZ5KAOvtF8Mot8XEs5
         m/6ecDSY10/Kur+BC2BxTAIt+0e46hVdU/K/chVWwjfdhJmG8Jqy2WYb3pOwS7JeJh
         DpgRh4MacUkY+GuOcc6UcGItLLFWWwpPLgNQcN5APyxp+oQplrL1Hlf6CF/9AZxAv7
         /XkLa2bGwwMAClBJfQJ9DPDps8CDL/yiX2RQr6eE/3ZYb3Vqof0qUmA8+iKH/uYJKc
         OHAwbv62nINHXin75ZYy56B6lAQz1JKeMUZS1jP1k8Q97RwAhJiT4SNWxCwim4eGjA
         X922gOk8+6m3g==
From:   Mark Brown <broonie@kernel.org>
To:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230728060804.22796-1-alexander.stein@ew.tq-group.com>
References: <20230728060804.22796-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] spi: fspi: Add power-domains to the DT bindings
Message-Id: <169057475588.253217.3864846125343786277.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 21:05:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 Jul 2023 08:08:04 +0200, Alexander Stein wrote:
> i.MX8(X) based SoC use a power domain. Allow supplying this domain in
> bindings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fspi: Add power-domains to the DT bindings
      commit: 026badeb7055e41000e4b139833ca5bafe360eb6

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

