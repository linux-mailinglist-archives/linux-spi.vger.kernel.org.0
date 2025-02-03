Return-Path: <linux-spi+bounces-6608-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB0A25E05
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FF83B4563
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15C112E7F;
	Mon,  3 Feb 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1URV35M"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD139FC0E
	for <linux-spi@vger.kernel.org>; Mon,  3 Feb 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594522; cv=none; b=XfC0TdQw6uuBFwcIXDtMaC1MB2CZwBi14ofVWfpQiHkqojgFr9zsm8xUFoz2qK5IjSceKkmBmjwhBpRtQ5NCvPjqTHmNtzngsBDqJn+lzg/5Tj7Ea0+gZZQTUlKyT7z58lc8zKB4wdhXa++Cl+/ylT/+mOn/LOhEoTpe2EfiUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594522; c=relaxed/simple;
	bh=4NBE/QhhePvMFBZcY3bupmf6eU2IDYbef0CWTJ4iMn4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZTrKUVR9Boh9LHjryldWkqbiTPILhcu+0vRKgN8S2aIsGcHKdsCRALzMfpmadKKhCOLkuwsGiP++RKVEG8tEHCFVNr6R5yQLPp7AaUHvRJGeodD9yHoPjHbmpHVZ8k33bUcLXjIlpx3OkFb5JB6YUS8U9uE3Wrjp5JE393sdeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1URV35M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3229AC4CED2;
	Mon,  3 Feb 2025 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738594522;
	bh=4NBE/QhhePvMFBZcY3bupmf6eU2IDYbef0CWTJ4iMn4=;
	h=Subject:From:Date:To:From;
	b=F1URV35MoPRvPyHDZWNERHvk9r5XId3qmTmLffc7axvM5eG4hakKjaoon+I7QPwR4
	 dyiKwXldU13k7MmnnGO6wuZvJeLKn2TLIQ4xQ5HunjaxgaG3/IxK+Nf3ZgkBBpjMjc
	 xBNgg9LnjBDlxhsOs7a/H82ZH5V+9HT2mdtv9djq0zHfWuGppZvQ5Wx803/4cHSGOl
	 AQ2zjMnyNj6ohMbVNNiPmsJMTpORHajJKapSYUBCaayehCXnhKxp+rH/baRAH83cqJ
	 bFq3wmy8iB6IPKJ/WAm/bOP29YWAfMGfZ49SnXSHP0k0yL+QyZAvE4x243XSum6gW8
	 bgTfyob96tfUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100D380AA67;
	Mon,  3 Feb 2025 14:55:50 +0000 (UTC)
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
 <173859454892.3265457.14067115420163399664.git-patchwork-summary@kernel.org>
Date: Mon, 03 Feb 2025 14:55:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi-nand/spi-mem DTR support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=924284
  Lore link: https://lore.kernel.org/r/20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com
    Patches: [v3,01/27] spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
             [v3,21/27] mtd: spinand: Create distinct fast and slow read from cache variants
             [v3,22/27] mtd: spinand: Add an optional frequency to read from cache macros
             [v3,23/27] mtd: spinand: Enhance the logic when picking a variant
             [v3,24/27] mtd: spinand: Add support for read DTR operations
             [v3,25/27] mtd: spinand: winbond: Update the *JW chip definitions
             [v3,26/27] mtd: spinand: winbond: Add comment about naming
             [v3,27/27] mtd: spinand: winbond: Add support for DTR operations

Series: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
  Submitter: Raphael Gallais-Pou <rgallaispou@gmail.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=921258
  Lore link: https://lore.kernel.org/r/20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com
    Patches: [1/6] usb: dwc3: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
             [3/6] mtd: st_spi_fsm: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
             [4/6] ahci: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
             [5/6] net: stmmac: sti: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()

Patch: [v1,1/1] spi: realtek-rtl-snand: Drop unneeded assignment for cache_type
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=929099
  Lore link: https://lore.kernel.org/r/20250129152925.1804071-1-andriy.shevchenko@linux.intel.com

Series: Add QPIC SPI NAND driver
  Submitter: Md Sadre Alam <quic_mdalam@quicinc.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=911204
  Lore link: https://lore.kernel.org/r/20241120091507.1404368-1-quic_mdalam@quicinc.com
    Patches: [v14,1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
             [v14,2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
             [v14,3/8] mtd: rawnand: qcom: Add qcom prefix to common api
             [v14,4/8] mtd: nand: Add qpic_common API file
             [v14,5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK


Total patches: 18

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



