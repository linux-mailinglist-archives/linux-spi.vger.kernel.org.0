Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12D4BBBFB
	for <lists+linux-spi@lfdr.de>; Fri, 18 Feb 2022 16:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiBRPTQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Feb 2022 10:19:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiBRPTP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Feb 2022 10:19:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5ED3DA6B
        for <linux-spi@vger.kernel.org>; Fri, 18 Feb 2022 07:18:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF42261DE1
        for <linux-spi@vger.kernel.org>; Fri, 18 Feb 2022 15:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08C0C340EF;
        Fri, 18 Feb 2022 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645197538;
        bh=hcRvx0Ywj+TB/gCIhkL3uw/r1RniEysS1pWcKFyZmjM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z306sWwActO6Ke3KmO5oXk+IbHs2HIGWgp+nmeS9zPk20EV5zQc1e8jjJFJexy6dj
         O3gLEVKITFFENuSY+nZ44OZn3i/OfBB77hVYvAc5vfCRZyrnwWG7r8prPgA5mrfUAr
         SSyV/qCA1J0O0dfMo+NLZgGCD1BcYBlDoXePJiLWrmbq4Ke0gCoYv+8weko2THLrrl
         /Qonjszw5Fp0qXj79xs0qp3osYLqAnbK2eV4gBCM6pnmxLlwqAtck+SjcrS8S0UiIs
         ewoN1oc43taA6jKNPfrZwyf3db78q0jX6zQt/+C8I5zKJkxAlSARnLf6WtF/eaC3GQ
         gjc0gvj6UgBuQ==
From:   Mark Brown <broonie@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <56e1588d-d53b-73e9-fdc8-7fe30bf91f11@gmail.com>
References: <56e1588d-d53b-73e9-fdc8-7fe30bf91f11@gmail.com>
Subject: Re: [PATCH RESEND] spi: use sysfs_emit() for printing statistics and add trailing newline
Message-Id: <164519753763.3453177.3574979011781104924.b4-ty@kernel.org>
Date:   Fri, 18 Feb 2022 15:18:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 18 Feb 2022 14:58:35 +0100, Heiner Kallweit wrote:
> Use dedicated function sysfs_emit() that does some extra checking,
> e.g. to ensure that no more than PAGESIZE bytes are written.
> In addition add a trailing newline to the output, that makes it
> better readable from the console.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: use sysfs_emit() for printing statistics and add trailing newline
      commit: 043786303b175977e515d4e99cf6b5f886b136dc

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
