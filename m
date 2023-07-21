Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0598C75C725
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jul 2023 14:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGUMuT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jul 2023 08:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGUMuS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jul 2023 08:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B86510CB;
        Fri, 21 Jul 2023 05:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9B9D61B1F;
        Fri, 21 Jul 2023 12:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60618C433C9;
        Fri, 21 Jul 2023 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689943816;
        bh=O1jJbBEcaURn4zEGQ2aRZSKmYUb+p4lmuCCmyb9Qvp8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bpu0BUiupIfVegnNJ+wLKfTgXQzT+x5YufL5i/oNwOh2vqofQ1+qvykE2sGLXeU3k
         SwHVaXGHwMV54Sfo8803R2ogAfCwOJWMY3YpaxfPSolZDOLMd4uC3dFptoDzUFhNwm
         8KPnr1ejSciq1YGHk4tNsZKIX7Jix4XVcXY87LrFEKi3hZNh27RlSS0k0HF+sJFIch
         XM4/Rb9e4VMXqsLdMA0JI0kyGOhoopjAZ6WDkrcLwchl8LAUsW//x0HZ73GP7sSKUi
         SnzU/ex/JbhZk3Te/9DVwB+ML3iJ2F/D9Zt2bMPEA5ZM+INp1bA/sPlLOPvwQDOttZ
         MXEPn3+X7lTww==
Received: (nullmailer pid 785149 invoked by uid 1000);
        Fri, 21 Jul 2023 12:50:13 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ming Qian <ming.qian@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>, linux-spi@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shijie Qin <shijie.qin@nxp.com>, devicetree@vger.kernel.org,
        Zhou Peng <eagle.zhou@nxp.com>
In-Reply-To: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
References: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
Message-Id: <168994381338.785121.14262858445617202831.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: media: amphion: Fix subnode pattern
Date:   Fri, 21 Jul 2023 06:50:13 -0600
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On Fri, 21 Jul 2023 13:10:18 +0200, Alexander Stein wrote:
> DT nodes use dashes instead of underscore. Adjust pattern to also fix
> warnings regarding nodes in arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> 
> Fixes: 38ad8b32f3af ("dt-bindings: media: amphion: add amphion video codec bindings")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/media/amphion,vpu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/amphion,vpu.example.dtb: vpu@2c000000: 'vpu_core@2d080000', 'vpu_core@2d090000', 'vpu_core@2d0a0000' do not match any of the regexes: '^mailbox@[0-9a-f]+$', '^vpu-core@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/media/amphion,vpu.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230721111020.1234278-1-alexander.stein@ew.tq-group.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

