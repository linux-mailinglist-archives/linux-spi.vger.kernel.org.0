Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC65602E7
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 16:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiF2ObL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiF2Oaq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 10:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE62E9E0
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 07:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A4F961F11
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 14:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1076C34114;
        Wed, 29 Jun 2022 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656513044;
        bh=I5UL10ZSSXTpQXbEea4cChBC5YnPaxujizez8/00zxU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ARyz2QxAT+3QOLmOSL6OykzGT5VsS0ptkrAoYRKe4y5tlR0o4X0hOnpv/p3x7QVeE
         rBjAIjSVLKpkcNDM2O0/DZi90ZXUCRmUxB8t8otN/rxvzFtHeYu3I0GGlXUo6VMCGG
         8GWMCm4cCfhtYfQj3+DQUOcP1yECwn4cqxqPfwlftOg6QwYcedOKW9dKk8Pha1yeCF
         vIeQAQqTkt5L+7U4S8C/cSNS767JHbAoBZVC/5EjTv7olkvsUKs5w5LzGMLpXzyrOg
         xkqRTPEydXHBk67wb5Qrb1vIGc/WMdSgQLPjYP8SVKLTHAhNH2+cfFWI6GLm2BGQOb
         VEPjB6v7A0GyQ==
From:   Mark Brown <broonie@kernel.org>
To:     mika.westerberg@linux.intel.com
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20220629113403.79942-1-mika.westerberg@linux.intel.com>
References: <20220629113403.79942-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel: Add support for Intel Meteor Lake-P SPI serial flash
Message-Id: <165651304367.1570120.15733357362437281609.b4-ty@kernel.org>
Date:   Wed, 29 Jun 2022 15:30:43 +0100
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

On Wed, 29 Jun 2022 14:34:03 +0300, Mika Westerberg wrote:
> Intel Meteor Lake-P has the same SPI serial flash controller as Alder
> Lake-P. Add Meteor Lake-P PCI ID to the driver list of supported
> devices.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Add support for Intel Meteor Lake-P SPI serial flash
      commit: 3f977c574dfd344bea562e9d28a17de90c46e95a

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
