Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0AC561B9E
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jun 2022 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiF3Nor (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jun 2022 09:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiF3Noq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jun 2022 09:44:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5945DC33
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 06:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BA563CE2EC0
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 13:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD85CC3411E;
        Thu, 30 Jun 2022 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656596682;
        bh=gOapZKPagxR5YPBGWkDlKG7e7Jaka4zB/fFrnEhreDg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Mqj4XpO++FEy7oJLwM5E8G+L1ViypVH/0euQqI7kxsbPE5tJmfK0LqBIDRo3yTk6T
         G5AhJFGmTUv6tJdphqiRj4dOxCo4pq0XjSh2H9s7pjn3QPtDnU98LX3JMH54Kpcdgj
         mlSWWCkc9aQSBBsPhXjiVmrz3NgLsXa8f/Ugm0iu1mLk3xNZYgWemQeZ7MvgS3Ifbh
         phrrRGMio4mDa7+7FCbDrrpQEUiuk7/uAe7aAq01/x7HCdUwThsgX58YtjIS83UjCm
         TShMfUwQAJAiX16efnKstlAM4iMwXq2+lpX0Fe0KsWRkhqDpjCNIzke4guwjjdBwJ4
         IXM9CcpmbkGxA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, jarkko.nikula@linux.intel.com
Cc:     haojian.zhuang@gmail.com, kamal.ap@intel.com,
        andy.shevchenko@gmail.com, robert.jarzmik@free.fr,
        daniel@zonque.org
In-Reply-To: <20220630073305.632850-1-jarkko.nikula@linux.intel.com>
References: <20220630073305.632850-1-jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] spi: pxa2xx: Add support for Intel Meteor Lake-P
Message-Id: <165659668048.559112.12956890819194351645.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 14:44:40 +0100
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

On Thu, 30 Jun 2022 10:33:05 +0300, Jarkko Nikula wrote:
> Add support for LPSS SPI on Intel Meteor Lake-P. It has three
> controllers each having two chip selects.
> 
> This squashes a fix from Ap, Kamal <kamal.ap@intel.com> fixing incorrect
> PCI ID of 3rd controller.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Add support for Intel Meteor Lake-P
      commit: 3190d4be3764fd847d57e26197158940e89272ae

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
