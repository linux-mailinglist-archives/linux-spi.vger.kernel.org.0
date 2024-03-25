Return-Path: <linux-spi+bounces-1980-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264E88B4FF
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 00:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38705BE18EA
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFED13D61F;
	Mon, 25 Mar 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOEDgUr8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15E12FF60
	for <linux-spi@vger.kernel.org>; Mon, 25 Mar 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381420; cv=none; b=OWiQ9Cr/C/stmnyHchbwC7IbssxicV61f6cpYO1euicn/6+30gAb7aF1z+e967+xW1s8JssKEE4HbxRUqgJKSms3ncehcSAb6fZtQLc+jPSAfJk/NMDbkaGPvwx/9LKlVmzjdyD9EUxfx4PLKKCv3kEx9aoS7aw2DRulMgL9oUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381420; c=relaxed/simple;
	bh=qUyRRVG4rjThKr++Grc9DnBz2cIpkgwzXB/QanPJiaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jrRXJGAtkE5ZbnCFrQ3NfM6cDDpLNzmXjXRwCwH1VaCJkwFODt7EI4+t/A30Cl2skGxgQJ5dydWXDwClbSEGp7XmKi0f7WJ8VnsXZeX8XPxoXekJ+Sp3+aXuUgzd4xgZqcRmb+FmtllixNm6WskLilXhQM/au1i96Los+ZLalow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOEDgUr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4229CC433C7;
	Mon, 25 Mar 2024 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711381420;
	bh=qUyRRVG4rjThKr++Grc9DnBz2cIpkgwzXB/QanPJiaY=;
	h=Subject:From:Date:To:From;
	b=uOEDgUr8+OblfIqYu4mieAGy9BWl1ydWxqi4BmYyvxw/8gkafRcLvcdJRfQWzamOS
	 GnCqMEXjPus6P884UIGkyP/CQ9fHQF1Mr8DicoKDnizlFI3dTjY4xl2vpp2xNt1JHJ
	 0DgUEUM/JzQqKBBdEfVUBNj31qQZ3Lw9tn+s+ROBK9CGpQtIAVDh+O4wbKVCjGX0xt
	 v+JlitAOKjvywsjGBtEpWik+5nf8HekQAx2erx2enUN578XygZzVmZvyMhlAYgpwvI
	 YLUmfA3SGvWvWPrXelQ3Ds/gycWJhRxOeDTnJ/AA2FFSnadLMMYOjjCvETY+RFnV4q
	 gxLB6gDv2Hnsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3027DD2D0E0;
	Mon, 25 Mar 2024 15:43:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171138142014.29845.7827202904009483116.git-patchwork-summary@kernel.org>
Date: Mon, 25 Mar 2024 15:43:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: iio: core: New macros and making use of them
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Kees Cook <keescook@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=830860
  Lore link: https://lore.kernel.org/r/20240228204919.3680786-1-andriy.shevchenko@linux.intel.com
    Patches: [v4,1/8] overflow: Use POD in check_shl_overflow()

Series: [1/6] mfd: cs42l43: Tidy up header includes
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=819531
  Lore link: https://lore.kernel.org/r/20240124151222.1448570-1-ckeepax@opensource.cirrus.com
    Patches: [1/6] mfd: cs42l43: Tidy up header includes
             [2/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
             [3/6] mfd: cs42l43: Add time postfixes on defines
             [4/6] mfd: cs42l43: Add some missing dev_err_probes
             [5/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable
             [6/6] spi: cs42l43: Tidy up header includes

Series: [v4,1/6] spi: cs42l43: Tidy up header includes
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Lee Jones <lee@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=820947
  Lore link: https://lore.kernel.org/r/20240129152557.3221212-1-ckeepax@opensource.cirrus.com
    Patches: [v4,1/6] spi: cs42l43: Tidy up header includes
             [v4,2/6] mfd: cs42l43: Tidy up header includes
             [v4,3/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
             [v4,4/6] mfd: cs42l43: Add time postfixes on defines
             [v4,5/6] mfd: cs42l43: Add some missing dev_err_probe()s
             [v4,6/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable()

Series: arm64: exynos: Enable SPI for Exynos850
  Submitter: Sam Protsenko <semen.protsenko@linaro.org>
  Committer: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=818256
  Lore link: https://lore.kernel.org/r/20240120012948.8836-1-semen.protsenko@linaro.org
    Patches: [1/7] dt-bindings: clock: exynos850: Add PDMA clocks
             [3/7] clk: samsung: exynos850: Add PDMA clocks

Series: spi: get rid of some legacy macros
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=818763
  Lore link: https://lore.kernel.org/r/cover.1705944943.git.u.kleine-koenig@pengutronix.de
    Patches: [v2,01/33] fpga: ice40-spi: Follow renaming of SPI "master" to "controller"
             [v2,13/33] mtd: rawnand: fsl_elbc: Let .probe retry if local bus is missing

Patch: Remove the @multi_cs_cap to prevent kernel-doc warnings
  Submitter: R SUNDAR <prosunofficial@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=822924
  Lore link: https://lore.kernel.org/r/20240204154506.3561-1-prosunofficial@gmail.com


Total patches: 18

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



