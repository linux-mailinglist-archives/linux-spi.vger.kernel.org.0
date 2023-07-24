Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CA760049
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 22:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjGXUMf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGXUMf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 16:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A01D10D9;
        Mon, 24 Jul 2023 13:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D816A61383;
        Mon, 24 Jul 2023 20:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657E1C433C8;
        Mon, 24 Jul 2023 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690229553;
        bh=yI+t0tsle3ZPixBpc6BGQ5Mbxz2IXUw9G9/llSuxVYg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=P1zGePN7fWRsLvfUZ8kIrQLVNxHzhdYoyXsfSZkDbWaJk+bOU6m+1aJpQ32nikuZL
         9F2/0Ul3Ns6Q4+47JprinPDNAVYqL/ngZn+udj3IfP/ReKS5avZigNFWZj36L5G9zb
         r3hHfx4utK20Iqn+3AkytfoY66RJrpJEChXHI/YryAv5VlQoKyvVIRDRUjaMT04DmP
         75yY/hnLrZHAsKOcLB+xJxd1Sb/wq/c1qO/vMBJkVdydlDKL0VrYPoUY4khZpGSxsk
         sN1Vlh82CX84Ss5PSyVMZYpR/sai5qACIgSPBP90DP9+W4p+haFgBP4vPXmxDQq/5C
         +GwVrjcTUQMAA==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
References: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: media: amphion: Fix subnode
 pattern
Message-Id: <169022954911.1351900.17929422978163204640.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 21:12:29 +0100
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

On Fri, 21 Jul 2023 13:10:18 +0200, Alexander Stein wrote:
> DT nodes use dashes instead of underscore. Adjust pattern to also fix
> warnings regarding nodes in arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/3] dt-bindings: lpspi: Add power-domains
      commit: 49aa77165c00e5047b17b0072bbb41cc83a9f197

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

