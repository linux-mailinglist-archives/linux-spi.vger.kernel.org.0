Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD24757AD7
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jul 2023 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGRLrz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jul 2023 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjGRLrx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jul 2023 07:47:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7321A8
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 04:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F7946152D
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 11:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55275C433CA;
        Tue, 18 Jul 2023 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689680870;
        bh=deIKf2GiM1a697arPbBiDtldpDieMARQbG/d3kRKvks=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mEAnHd0ID6BW2sP8lAXkk8LHrPVCGuD6BiS173EsvYEq2JH3g8XHq0CFmG/ZdPjlM
         hnhwr2JjbYxbNgEHGJudNFWc5OpoRIZIZ/q4AytrSI10u5zduM1CZE+rvxG+yL8f5U
         MzknNR5S5Xih4U1a1OkjQzO33LqEUFFgq/fh5uoTJLMygvY6PkPy/IaaPk6UQvIvQc
         4j5nY2PAYIEQxo4q+ge+0IBNu4dM7vJjh/p+fzxMpM4VXzaFXy36bqeGroJe9lXNkj
         vjBCG8m5Eu1QDbxZiUb369hlSWywNM/yt5qDEIIF99ViT58FzX/lq11bq4CZyd6Tv2
         bQZHVwAjyFNtw==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20230705090145.1354663-1-alexander.stein@ew.tq-group.com>
References: <20230705090145.1354663-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/3] spi: spi-fsl-lpspi: Remove num_cs from device
 struct
Message-Id: <168968087005.37796.1120936039472853867.b4-ty@kernel.org>
Date:   Tue, 18 Jul 2023 12:47:50 +0100
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

On Wed, 05 Jul 2023 11:01:43 +0200, Alexander Stein wrote:
> This is only used during probe() call, so there is no need to store it
> longer than that.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-fsl-lpspi: Remove num_cs from device struct
      commit: a55265eeedafee12d9743196ce5bb43266509c31
[2/3] spi: spi-fsl-lpspi: Move controller initialization further down
      (no commit info)
[3/3] spi: spi-fsl-lpspi: Read chip-select amount from hardware for i.MX93
      (no commit info)

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

