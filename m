Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054242633E4
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 19:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgIIRMD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 13:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbgIIPcj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:32:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7681822240;
        Wed,  9 Sep 2020 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599665377;
        bh=TODrVcs9lgVCPiXcAEfLvUZlnsS84ktzJrcnCMX1MKg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FY4sgLDDXx1wg27+Ljvut8xHybpkWQIHYtUAsv96blD6Wh6IeNsMO5lKZ4mATR23F
         G2JVLlILS5NoIvW+hUvsFBsE0SCBbOD4sJNMPWwIiH4P5TcKH/x0yYb7nfTfqm+lH0
         ZCd5YGHXme1dc0s7OslYkmkiil92Mu448CHiBotA=
Date:   Wed, 09 Sep 2020 16:28:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>, rnayak@codeaurora.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Qiang Yu <yuq825@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        lima@lists.freedesktop.org, Nishanth Menon <nm@ti.com>,
        linux-mmc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <cover.1598594714.git.viresh.kumar@linaro.org>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/8] opp: Unconditionally call dev_pm_opp_of_remove_table()
Message-Id: <159966533166.54485.703021491015822828.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 Aug 2020 11:37:45 +0530, Viresh Kumar wrote:
> This cleans up some of the user code around calls to
> dev_pm_opp_of_remove_table().
> 
> All the patches can be picked by respective maintainers directly except
> for the last patch, which needs the previous two to get merged first.
> 
> These are based for 5.9-rc1.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-geni-qcom: Unconditionally call dev_pm_opp_of_remove_table()
      commit: 7d568edff5cb7968cc5f29e85da15f941b8070b8
[2/2] spi: spi-qcom-qspi: Unconditionally call dev_pm_opp_of_remove_table()
      commit: 062cf7fc927d2546b58ed128383e5c52f26a00a5

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
