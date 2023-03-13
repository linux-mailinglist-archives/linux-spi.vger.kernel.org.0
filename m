Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5386B804E
	for <lists+linux-spi@lfdr.de>; Mon, 13 Mar 2023 19:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCMSVR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Mar 2023 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCMSUy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Mar 2023 14:20:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542986A052
        for <linux-spi@vger.kernel.org>; Mon, 13 Mar 2023 11:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AC46B8119F
        for <linux-spi@vger.kernel.org>; Mon, 13 Mar 2023 18:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D11C433EF;
        Mon, 13 Mar 2023 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678731624;
        bh=e4iDjFFifnWIUXzxVD4NHvk+JnQc7Z9d6pJraAh2rrk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lun584vHfXlo/oCplySL6ivdeVXJUtgqze5YcrLk1RHo6NyEJZxe7IfNbgGCFsZNv
         iXKyKwDVtno5ZmEdBfDAU2G9lcpTNAgp+jMWGsskuiazi/t0PFTs+EdSV7W8gRt+sD
         90DNmMbO7nWJjUzWY7c84xN+gYTRBu0huQeada5czK7XEai+2Mfv/sMLbSyIwZdndV
         EmsItr+cPyMfL1riratPKoyLlYdfyYIeiSfSxqmKfyWgYIeob70ITzi+61RxmNRYgm
         OMtNBmnu6p8uPEJKqaPOPeM+EtyFf6xBTehtPf7ElQUSjQKPSdLJ0Mz6eNYvy6Rrt4
         3CBiBDyPsYALg==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20230313083621.154729-1-alexander.stein@ew.tq-group.com>
References: <20230313083621.154729-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] spi: nxp-flexspi: Add i.MX platform dependency
Message-Id: <167873162353.102913.5111036044001481241.b4-ty@kernel.org>
Date:   Mon, 13 Mar 2023 18:20:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 13 Mar 2023 09:36:21 +0100, Alexander Stein wrote:
> This driver also supports various i.MX8 platforms. Add ARCH_MXC for
> selecting this driver without Layerscape support.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-flexspi: Add i.MX platform dependency
      commit: 0762875674b969e35371ec5fe4b594d7a92ab364

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

