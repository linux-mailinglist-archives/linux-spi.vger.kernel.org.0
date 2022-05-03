Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB4518909
	for <lists+linux-spi@lfdr.de>; Tue,  3 May 2022 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiECPy5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 May 2022 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiECPyz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 May 2022 11:54:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B93B3F9;
        Tue,  3 May 2022 08:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00237B81F2E;
        Tue,  3 May 2022 15:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A422C385A9;
        Tue,  3 May 2022 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593077;
        bh=iTiarTkByZ5RFQ9pQrV9iuj93cpQAxWxhkeao7MmLRY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oQLRr72ENUz0DJtAhTaDsSR5JQg0UUhqNY1z+mBh/J9QSVRMHq3PRd4+R0Uf0ZRYR
         wvYXr7t4DqXElh0fWn+cV3KGPdz1EhPUvX42E0g5ScW0L03HtsHVTzQrBdTUM8Dl+I
         slMVp9SF2zkRjLaubne8yTvOS7I9BEj1BHJiJdODXmgdP7TJNiHF7shbrJ+3tvSFTV
         PO7dl2Qxu/tOu5b6RHspmYJ/i1ueBI4JQCN3H9qUqmoHHzW8hqQ5Yhz8X0/ReKrXDb
         TSh5EkMwWPY5R+tMx/k2d1MrAbhfred1l7jiWM+KfwRKQ1V5OfB0W+1+1VP8Jg6obu
         uOUJMjfGzjwAw==
From:   Mark Brown <broonie@kernel.org>
To:     dan.carpenter@oracle.com, gch981213@gmail.com
Cc:     linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        gch981213@gmail.com
In-Reply-To: <YmwjUcTKyQNrrn2g@kili>
References: <YmwjUcTKyQNrrn2g@kili>
Subject: Re: [PATCH] spi: mtk-snfi: preserve dma_mapping_error() error codes
Message-Id: <165159307628.184303.16325175750153523597.b4-ty@kernel.org>
Date:   Tue, 03 May 2022 16:51:16 +0100
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

On Fri, 29 Apr 2022 20:41:37 +0300, Dan Carpenter wrote:
> Return -ENOMEM of there is a dma mapping error.  Do not return success.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mtk-snfi: preserve dma_mapping_error() error codes
      commit: 73c1a5153ec8c53100b13bccafbb29cd502ee086

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
