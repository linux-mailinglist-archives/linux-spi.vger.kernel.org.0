Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75B55C173
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbiF1Kbf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 06:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344894AbiF1Kbd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 06:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF66C2F3B4;
        Tue, 28 Jun 2022 03:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D7AB618EC;
        Tue, 28 Jun 2022 10:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D279C341CA;
        Tue, 28 Jun 2022 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412291;
        bh=DC3SosWVleDuC54lFe3RBAgCx3NcMzRvnRRfzT1qGeQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I/SdXgOHd3IxZuzYEpEWShovO3gHPUUR4oa9GuFrk1qd7XHI7VOQZDGMxJBHAaFNU
         9pAczmA6K8YTtGecVZznCtWHsr+x1Bo9Bp4y95Q+trG7mgRkiijbpTvIENLSLkSRin
         oTeiuj+3TULfsgp8qa9tE+wz4fWVihEGKreZ+QGcA8IHtT8T0JUMNA1Lf7OMzLZKx4
         XljrYYsOPapZxG5KgWjb+LHiCCyhzjbnIWqc4xCFRnquCPkApxDE9sF25dN04m6Ray
         UbJHiLWScWPddkBQFt6q9VnVJe2yOfQKkOQYaj0thZuZ8VrlU11XDs2jfseUCtZo3B
         8mVv8c3Qxln5g==
From:   Mark Brown <broonie@kernel.org>
To:     chanho61.park@samsung.com, krzysztof.kozlowski@linaro.org,
        andi@etezian.org
Cc:     alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        adithya.kv@samsung.com
In-Reply-To: <20220627013845.138350-1-chanho61.park@samsung.com>
References: <CGME20220627014049epcas2p1fd6b4dddf5b40cd334708043a08ac2f9@epcas2p1.samsung.com> <20220627013845.138350-1-chanho61.park@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: move dma_release_channel to unprepare
Message-Id: <165641229004.254742.10031368402707043673.b4-ty@kernel.org>
Date:   Tue, 28 Jun 2022 11:31:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 27 Jun 2022 10:38:45 +0900, Chanho Park wrote:
> This fixes the sequence of dma_release_channel.
> Since commit f52b03c70744 ("spi: s3c64xx: requests spi-dma channel only
> during data transfer"),
> dma_release_channel has been located in the s3c64xx_spi_transfer_one
> but this makes invalid return of can_dma callback.
> __spi_unmap_msg will check whether the request is requested by dma or
> not via can_dma callback. When it is calling to check it, the channels
> will be already released at the end of s3c64xx_spi_transfer_one so the
> callback function will return always "false". So, they can't be unmapped
> from __spi_unmap_msg call. To fix this, we need to add
> unprepare_transfer_hardware callback and move the dma_release_channel
> from s3c64xx_spi_transfer_one to there.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: move dma_release_channel to unprepare
      commit: 82295bc0d192d7e35e0568b18ca66da2c3058fd5

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
