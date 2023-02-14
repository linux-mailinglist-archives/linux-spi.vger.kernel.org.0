Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC91696FCA
	for <lists+linux-spi@lfdr.de>; Tue, 14 Feb 2023 22:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjBNVek (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Feb 2023 16:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjBNVei (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Feb 2023 16:34:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2738C1DB8C
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 13:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B79DB6191F
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 21:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D948C433D2;
        Tue, 14 Feb 2023 21:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676410475;
        bh=iAIuOZsPmoL4rBJr+rkObGTxbTsz4mAe3T9ttHs14lc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PeX8M7AKfGa0TNpTz1ZCpAOk8bdeylqiJLdcz8KgM/djQGUE77OwrsTzswS42dDHt
         kEoWsHTUU4unv5R/PJlf+V47nF+ZJqsv7OxMjCBeyxrurBNR8mr5a5+ayv0/nHGurs
         x9EleHsR3DCLH509Wd7rVD3G11fZ/Ah6yGQjD3V69nf3Csqtl4yFdsomOMpWNjzohJ
         360ZGLL87oCJwtKsU6L6kTgOMBlodrynnlToKMJSkkMx1WbSeJpQ/dluOBFc12Z2z4
         TRszi83Vr/NnmPe3axOj+nhCe1UpOiwnP1K46IJ+W8m6QfDL57T9DAuhrWnr1BqLoc
         PPb6Dg9VrwfEA==
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Vadim Fedorenko <vadfed@meta.com>
Cc:     linux-spi@vger.kernel.org,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230209211321.1427968-1-vadfed@meta.com>
References: <20230209211321.1427968-1-vadfed@meta.com>
Subject: Re: [PATCH] spi: xilinx: add force_irq for QSPI mode
Message-Id: <167641047286.3135776.10942759274485674855.b4-ty@kernel.org>
Date:   Tue, 14 Feb 2023 21:34:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 09 Feb 2023 13:13:21 -0800, Vadim Fedorenko wrote:
> Xilinx PG158 page 80 [1] states that master transaction inhibit bit must
> be set to properly setup the transaction in QSPI mode. Add the force_irq
> flag to follow this sequence.
> 
> [1] https://docs.xilinx.com/r/en-US/pg153-axi-quad-spi/Dual/Quad-SPI-Mode-Transactions
> 
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: xilinx: add force_irq for QSPI mode
      commit: 1dd46599f83ac5323a175d32955b1270e95cd11b

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

