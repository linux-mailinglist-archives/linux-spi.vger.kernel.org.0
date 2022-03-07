Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E1A4D088D
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 21:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbiCGUkt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 15:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiCGUkk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 15:40:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2587B562;
        Mon,  7 Mar 2022 12:39:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19E756150B;
        Mon,  7 Mar 2022 20:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485ECC340EF;
        Mon,  7 Mar 2022 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685584;
        bh=mZvkk4eExyyshNaj1KkfsbMVNXCaa6NAACmHjXogaa8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GIrCUnOhLb7pfVCwvXPpt8dnoS+MokHmtSh3YR2uHJZ/4wim7fXxYTx8AZWAQ7CMI
         lUzB5E6I5sYQPVFI4uCL64CAubi3e8nml1IqfH4lWhvx8vz4OXzvwyUnIcxoUinfrG
         meF2kFpQlf1PZSilnA3L0J4wvz1hAf32HvW/KSzig0//tcbBw+MAXvPcXcuJ2QPx7M
         KZ7KU6ieJN+h5GVcyYPy9wIbrXiy9jBeEpMJff6np/eijZaeRTlifIFNGPgUNoLhZU
         xD5gpGlwRcPEnq9SzHFpU75u/+87icOHtyixrdWRjToteDe7GkJJFtRFxqFAVq7wqy
         ATS3Gxc+XrAbw==
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220307113529.315685-1-jonathanh@nvidia.com>
References: <20220307113529.315685-1-jonathanh@nvidia.com>
Subject: Re: [PATCH] dt-bindings: spi: Fix Tegra QSPI example
Message-Id: <164668558302.3137564.11139957927665508409.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 7 Mar 2022 11:35:29 +0000, Jon Hunter wrote:
> When running dt_binding_check on the nvidia,tegra210-quad.yaml binding
> document the following error is reported ...
> 
>  nvidia,tegra210-quad.example.dt.yaml:0:0: /example-0/spi@70410000/flash@0:
>  	failed to match any schema with compatible: ['spi-nor']
> 
> Update the example in the binding document to fix the above error.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: Fix Tegra QSPI example
      commit: 320689a1b543ca1396b3ed43bb18045e4a7ffd79

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
