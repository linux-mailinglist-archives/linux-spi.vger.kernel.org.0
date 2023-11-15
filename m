Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670287E22B3
	for <lists+linux-spi@lfdr.de>; Mon,  6 Nov 2023 14:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjKFNDp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Nov 2023 08:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjKFNDl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Nov 2023 08:03:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBA110A;
        Mon,  6 Nov 2023 05:03:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4B3C433C7;
        Mon,  6 Nov 2023 13:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699275819;
        bh=JhxQ4u/qMC60fSJVdjEYN/spA/OnlG3WT3EXnXH+T7M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QggcINbbJRyNRYpSC2A9TY5xFzLBF/4H+qi/J8vgwdpJQnu+Cdaz0wI5lW8VqMeG5
         rr7Xr9kaMerKCJj/Kw44cwwMnCbwpwdMIm4nLcep+7SSwcjyc3FZsAvfsaOlgzYlWc
         qM51WPlgwImZJaDRIEpER0VdXBlHbFpRjJ7UtakvFYvfia7MPpskAzSlYcqvy6zkpM
         hkGhvOpQyZuw9IsBM3RbjxF8vJ4Pp0NRiVCabPMJIJXGcttR51+Qxb2nV3A/qJzU5k
         QICrJZDK0yYPAPFHrnN1X4sj/RRVcVKxQ3mwzhFTJ4d4jSGhy5NURnVKFCcRA6tXYf
         ko6zsyaVCfNrA==
From:   Mark Brown <broonie@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
In-Reply-To: <1699037031-702858-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1699037031-702858-1-git-send-email-radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] spi: spi-zynq-qspi: add spi-mem to driver kconfig
 dependencies
Message-Id: <169927581730.3037377.1844652491397531332.b4-ty@kernel.org>
Date:   Mon, 06 Nov 2023 13:03:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 04 Nov 2023 00:13:51 +0530, Radhey Shyam Pandey wrote:
> Zynq QSPI driver has been converted to use spi-mem framework so
> add spi-mem to driver kconfig dependencies.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies
      commit: c2ded280a4b1b7bd93e53670528504be08d24967

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

