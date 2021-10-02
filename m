Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECCB41F932
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 03:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhJBBiz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 21:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230255AbhJBBiy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 21:38:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18C24619F7;
        Sat,  2 Oct 2021 01:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633138629;
        bh=UO2tDW4yPvWgZoOwW8X9BhGvR9C/h3wSZ+rWGPfWzWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmMhvot0L0Pf3VCX3qb3L1T9UvpXxXZXIEpKSG6+taJHa32CkNopSbkP59ZTF24Sh
         jygcuP9NOnQ96KNwpa17xW481dacG5ZR1MBaHhcqi9DqlQ+0ZJycqd4E0OHpWtUWEc
         jVWdM8s3YLUj5mcN5fmq1WH4TF3isqTmgiRuSbGH8VpbaSBEDGxrSa48BHRJzUbbI2
         u14lqxXwqMfKASppc3TwIaPW9HJDxKEerJYavKiinrua2tF/LOzIjZWWxPR7+/QMC0
         a6cHPE6XEpM4go55h3CPVYSw/zb3TrwNYhmys1iv7qC4OiZXfP903A93PRU16yQpf0
         nfTtQ7N1ZBNzw==
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: don't depend on a specific node name erratum workaround
Date:   Sat,  2 Oct 2021 02:37:05 +0100
Message-Id: <163313862170.2275998.17835551600191166035.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001212726.159437-1-michael@walle.cc>
References: <20211001212726.159437-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 1 Oct 2021 23:27:26 +0200, Michael Walle wrote:
> In commit 7e71b85473f8 ("arm64: dts: ls1028a: fix node name for the
> sysclk") the sysclk node name was renamed and broke the erratum
> workaround because it tries to fetch a device tree node by its name,
> which is very fragile in general. We don't even need the sysclk node
> because the only possible sysclk frequency input is 100MHz. In fact, the
> erratum says it applies if SYS_PLL_RAT is 3, not that the platform clock
> is 300 MHz. Make the workaround more reliable and just drop the unneeded
> sysclk lookup.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-nxp-fspi: don't depend on a specific node name erratum workaround
      commit: 67a12ae52599c9f2f24ef14adb43fc3b164792b5

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
