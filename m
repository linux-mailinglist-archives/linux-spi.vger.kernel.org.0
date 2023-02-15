Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A026981A2
	for <lists+linux-spi@lfdr.de>; Wed, 15 Feb 2023 18:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBORI6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 12:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBORI5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 12:08:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0E0274AE
        for <linux-spi@vger.kernel.org>; Wed, 15 Feb 2023 09:08:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 004A861CFB
        for <linux-spi@vger.kernel.org>; Wed, 15 Feb 2023 17:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC9BC433D2;
        Wed, 15 Feb 2023 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676480934;
        bh=QP1P9UIsTSfHgOMQWLc7pijXIPuwOBSOtqKVz3JoYWc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z8uF9c9+W556QgP/UhaLl19sRl1pBkKJSpAZbtvqq+ojDGnBdBK1wfvyB2ELU/G9K
         psDoBiF2MyQF8jZ44Ckx8mB52R/mquJVbtgV4Xoq4I4JwvIJUqnM/Qnw9kRlaQ50hu
         6hGzz20D4Rmg3ql1xUcI5bhZuUG03fBNORdByBAgvaDXu81jlDjOC+ILjsM65OoDHn
         6TvEeGZ8hDhzZTSVfZYyhN/sC68WXYxc4UwIU3YvpGCcB7GH7uV0chMCXSFuPqO/ue
         u+otjyV18Wd3tAlYO9GHNxE+it8Qfa1WzjOTlDMBxY0ym10Tu6rCooJoBfkUvANjTW
         JP7EJeAMYfpPw==
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Marcin Witkowski <marcin.witkowski@intel.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20230215110040.42186-1-mika.westerberg@linux.intel.com>
References: <20230215110040.42186-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel: Check number of chip selects after reading
 the descriptor
Message-Id: <167648093330.3474735.3443382740046621289.b4-ty@kernel.org>
Date:   Wed, 15 Feb 2023 17:08:53 +0000
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

On Wed, 15 Feb 2023 13:00:40 +0200, Mika Westerberg wrote:
> The flash decriptor contains the number of flash components that we use
> to figure out how many flash chips there are connected. Therefore we
> need to read it first before deciding how many chip selects the
> controller has.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Check number of chip selects after reading the descriptor
      commit: 574fbb95cd9d88bdc9c9c4c64223a38a61d7de9a

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

