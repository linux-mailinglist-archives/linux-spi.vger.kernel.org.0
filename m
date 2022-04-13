Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168234FFCEC
	for <lists+linux-spi@lfdr.de>; Wed, 13 Apr 2022 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiDMRir (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Apr 2022 13:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbiDMRin (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Apr 2022 13:38:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939346C94C
        for <linux-spi@vger.kernel.org>; Wed, 13 Apr 2022 10:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB0BCCE26C8
        for <linux-spi@vger.kernel.org>; Wed, 13 Apr 2022 17:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F12C385A4;
        Wed, 13 Apr 2022 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649871378;
        bh=0RPtgd1qClYIHhQ7dmPuWpuvG5riLw53lNvfFVuPIek=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UYgpByAoxucAVys9e9xYKVUUl+9fX1d+3JSoporNbm+03yuyIhNPkYX/qypGE/2EA
         TFuIN3C399Sa3t5ZRt/ViHUZ+QKml6VY0XaHhrh9lgrQ7BfmQ8C40QADB5nCQqnxZF
         OmYv2lTtZuxWdfFeBW1BipC32SjA3tQnb+lrz4yqKacie21EMYH4OVmhfriwrYUGj7
         2813GTYcycDXuHzK3mT4Kr5gS17mFe2MTexfnw4Q/9zwttXyqWv4wEruReUk9PwywZ
         dqeKag6b14hFtYhZaZipMastZ0EdRZS7yC250TI2p2K0io3Cg2szaCTn0t9EX6l+gD
         Oo6k//yqoyLCA==
From:   Mark Brown <broonie@kernel.org>
To:     mika.westerberg@linux.intel.com
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20220411112116.53281-1-mika.westerberg@linux.intel.com>
References: <20220411112116.53281-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel: Add support for Raptor Lake-S SPI serial flash
Message-Id: <164987137733.70105.17697260829140995605.b4-ty@kernel.org>
Date:   Wed, 13 Apr 2022 18:36:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 11 Apr 2022 14:21:16 +0300, Mika Westerberg wrote:
> Intel Raptor Lake-S has the same SPI serial flash controller as Alder
> Lake-P. Add Raptor Lake-S PCI ID to the driver list of supported
> devices.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Add support for Raptor Lake-S SPI serial flash
      commit: 299d8b74519d04042f8803d0604e08a1a7e31e5e

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
