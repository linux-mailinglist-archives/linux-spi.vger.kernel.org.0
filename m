Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D18349845
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 18:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhCYRhg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Mar 2021 13:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhCYRhU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Mar 2021 13:37:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A60B61A2C;
        Thu, 25 Mar 2021 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616693840;
        bh=6Ql/KyxL3rY0llO18x1iokuLqwO5tMJP51y5g3IBDy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/aOPBwT+kBVq267e3QGpELZs8u/VIB1L5qrzRwIfrF0Ujv/cmQMVJHmXgzNCM9Ha
         jQUgZAQLo7+rT7VenlbHseSzABzScsNPVG9m1GhyWvrAGlekpaWViHQ0vE6BXPZ8q0
         kNj3WiMK7QJTDoXRL6v+9YpFQ9PkJk2V7Az2tZUx8FbEn+r1P/boqQv8H7X4+1zsc3
         q1Ny7KKv0RU0bHftYx0ObZAJgh/uaCokU/h+ikN8mzU0+UyQzuXpo9668NoI9DuHRc
         uBE37mvotgnjxQq5Dh92R+lGj5/Z+FmyvVdFOworYwIBEmicGuEjp4iEKcWfHQqdgT
         6ntd/ea92jE4Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Heiko Schocher <hs@denx.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, Kuldeep Singh <kuldeep.singh@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] enable flexspi support on imx8mp
Date:   Thu, 25 Mar 2021 17:37:01 +0000
Message-Id: <161669381898.42255.12902469942541515996.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210316075928.1763460-1-hs@denx.de>
References: <20210316075928.1763460-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 16 Mar 2021 08:59:26 +0100, Heiko Schocher wrote:
> add compatible entry in nxp_fspi driver for imx8mp
> 
> @Shawn: If this series is accepted, can you apply the DTS patches from
> series v2?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643292.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643293.html
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: fspi: enable fspi driver for on imx8mp
      commit: 0467a97367d4767d284ad46ba0e6413b621256a0
[2/2] dt-bindings: spi: add compatible entry for imx8mp in FlexSPI controller
      commit: 2801a62dfad46ff228d00126ce8592594c1d0613

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
