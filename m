Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3AE4DCE99
	for <lists+linux-spi@lfdr.de>; Thu, 17 Mar 2022 20:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiCQTQo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Mar 2022 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiCQTQl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Mar 2022 15:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874B19EC68;
        Thu, 17 Mar 2022 12:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A977761844;
        Thu, 17 Mar 2022 19:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809B0C340E9;
        Thu, 17 Mar 2022 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647544524;
        bh=ykg1KH5dEqbUR92Jtvb0sC9BOYQ+JXC7cJqvpI326lg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H5ULBAuU1rOJDOtOukNoYygwYCLjM/N6DHYLE5C4uctK/IpO1XSY9zRAvsEQs7hDb
         d9p9LBwnqe+qNlCbs9BkVLL68XQ8rYA+Yto7jA350f+n7QolMj6yB8/+aN6khwmlGh
         57CJ3aO8mQ/NOYBUwnWLDyimMaIi+uIgwi+yfdwQopzbvppgMrYmj10jiz84S3R4Hp
         ml0VKHymrrBNVpaOLEZv/yhlzFyJCi57rOxBocuBX0TuZShYWc4zXX01dffH/uchF3
         mk8WALf6CYvjY0mYvtXpXVXZDlvZ/Est/kN8ZHlNvzCfJ+ZGUgkiQSM2gWi3rteTmR
         UoK48H4EHjjrw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20220316175317.465-1-biju.das.jz@bp.renesas.com>
References: <20220316175317.465-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] spi: Fix erroneous sgs value with min_t()
Message-Id: <164754452224.3036870.14152748900950117581.b4-ty@kernel.org>
Date:   Thu, 17 Mar 2022 19:15:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 16 Mar 2022 17:53:17 +0000, Biju Das wrote:
> While computing sgs in spi_map_buf(), the data type
> used in min_t() for max_seg_size is 'unsigned int' where
> as that of ctlr->max_dma_len is 'size_t'.
> 
> min_t(unsigned int,x,y) gives wrong results if one of x/y is
> 'size_t'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix erroneous sgs value with min_t()
      commit: ebc4cb43ea5ada3db46c80156fca58a54b9bbca8

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
