Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737EB74FA8E
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jul 2023 00:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGKWEN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jul 2023 18:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjGKWEJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jul 2023 18:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA34B1986;
        Tue, 11 Jul 2023 15:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E920615FF;
        Tue, 11 Jul 2023 22:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489BDC433C7;
        Tue, 11 Jul 2023 22:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113046;
        bh=WZFBYnlBH0nabsea0EgGhIkFx++Poh0q/PfFbXQbviw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ph2Q1Skexi74PjjyajBlIKdntO7u+CL65M1XUgzexfi6H3zQiGnmOzrafU9ad+3IG
         L61ESRw/Tmzu4fhwPlhSPbQRccH1z/zw65Lk55RNUKpBUHSXaPENU4qFPJlx4xCoHO
         Gltjwy8+YJ8I6rT+KgWV4CsnUlaImnHjnGv2xH0S644Efb2QzCeshIza4zkUrIVa0N
         sLK4RAwtOoD5pSvH0A2si3d5WPxqEJYD3kZiFjxqG9CWdmDag4GfrCLsmyYXbt+CJU
         OZj2/qG5cDFGHaZowRNDsoyKsCATQEtEH92XbpqEYby7/a8KpjPG+ggkSHn/98u1Sv
         HbQpyhGrm8EPA==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <20230705152603.2514235-1-thierry.reding@gmail.com>
References: <20230705152603.2514235-1-thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: tegra-slink: Convert to
 json-schema
Message-Id: <168911304501.642798.11023438191378643161.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 23:04:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 05 Jul 2023 17:26:01 +0200, Thierry Reding wrote:
> Convert the Tegra SLINK bindings from the free-form text format to
> json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: tegra-slink: Convert to json-schema
      commit: 8c87a46e2ce3d5aaf315ffb61dcda62417e41bbf
[2/3] dt-bindings: spi: tegra-sflash: Convert to json-schema
      commit: 17a9ab02f72c832293155a432895c889842b7da4
[3/3] dt-bindings: spi: Convert Tegra114 SPI to json-schema
      commit: b8968c388b69d9cf31d7f5b1721ac7fe9f932cb9

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

