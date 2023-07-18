Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B41757ADB
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jul 2023 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjGRLr4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jul 2023 07:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjGRLry (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jul 2023 07:47:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418DF170A
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 04:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD5D61540
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 11:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52465C433C7;
        Tue, 18 Jul 2023 11:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689680871;
        bh=UbRvein8uFH3U4D806i/zX6ZfUTveo9qV501ZshlA54=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ccHkVb0K/SZzULDlYVBTb9UxWITxi0/S+5cNBmX9M9HsKOte/mtpWz2fzTvRuG9Rl
         qPhqJi7EOSAhUfTu43NUaWBh5vpNktLoDHjw+eAKZC/fKYbJ+aWbTXWIdXBdg4lA8H
         fSNNI5moPXbSmtg9YTgPjkGJYIgL10aOZwAn7hct+nnaJ9pNV1CRH0ib2SbTNAM21s
         E2l/0PKbBEVi0jJYFf/FK/dYUFvLCVYyci3DqqVAAq8cOgm35ISmH7Ab6rvsLg/BuT
         XbNh+4ahZVi423TEy0pqJh4V9CEa1Noywo0DAn8XorH45mCXkBJOCLlOEYYldoAzA9
         GwuFH9HCcpD8w==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20230717085934.409476-1-alexander.stein@ew.tq-group.com>
References: <20230717085934.409476-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v2 1/3] spi: spi-fsl-lpspi: Remove num_cs from device
 struct
Message-Id: <168968087105.37796.7832748653786421970.b4-ty@kernel.org>
Date:   Tue, 18 Jul 2023 12:47:51 +0100
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

On Mon, 17 Jul 2023 10:59:32 +0200, Alexander Stein wrote:
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

