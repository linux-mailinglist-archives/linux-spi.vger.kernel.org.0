Return-Path: <linux-spi+bounces-5084-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A798CA1C
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 02:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD2B9B21E63
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6A1103;
	Wed,  2 Oct 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUY5lNHm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBDC391
	for <linux-spi@vger.kernel.org>; Wed,  2 Oct 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829629; cv=none; b=QAK8WxZZy/TsbHV3sPc2Bj6kCH4bClr8vyQExBSo7uTooCzyXt+TAnVMdmZ/BrZtuPJUfLFTVuPzPElEaiH4WwztYrjEsQfIcPvnfad+eUDMgb2XqlxwE4BHwe9RTRxBQJ7Um27MOaDR6vY9tpFVdrc7U0989d6WAojXr4D3wdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829629; c=relaxed/simple;
	bh=g7r2ZW8d0bSK6hTlqvr4tHe4D4s48ThSKfFsCbcZWC0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZhQNlqxGVcwfEEdPhWtt3sk3Ilw+OyhZ5wU9Zw0BLhJ/ks7N5G8zBZhSOISzo4GGQP/drwPvL+42AB4nme4AiX3XnRjezA8KeDyazJOIN0wjKnhbGXIXwS7ajQzCB1AvRiW4Uzv7URJg3q9e8qtE2PKkkvfyNQTo1Kc4ZmRon14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUY5lNHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7045C4CEC6;
	Wed,  2 Oct 2024 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727829628;
	bh=g7r2ZW8d0bSK6hTlqvr4tHe4D4s48ThSKfFsCbcZWC0=;
	h=Subject:From:Date:To:From;
	b=jUY5lNHmsu80fDWk/bR2QGR1+7Nv2PJtl/ghz5wV4+Z7rSoIYwrQ2ihBUkrxA7c9T
	 lLTYr6aZQAkuWBtaDK+jxbu3oO32s6v+3KmsjPZf7bZOlXYK9JOZ3xTzVJS64eW+4d
	 lnTSOs1A/qjAAal4hRfc/vY2BIPszMUMA4k89/S8ceK5iu4351C1zxtT3egEl4g6jR
	 aiV5t6gw+FoBQPm+2/9ordbMWhIZteWRCa0238X66ZhpYqmNzlQDFCyfE9sgKcQt1F
	 5MyuVWMyulvnd2i1kVJEgLUzVG/HGIwvE7Qy3oSrGs3k4xxFhv6my4QuViCaF/IqFL
	 AVzWEJW/JP18Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF0A2380DBF7;
	Wed,  2 Oct 2024 00:40:32 +0000 (UTC)
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
 <172782963149.678430.17417490511822093744.git-patchwork-summary@kernel.org>
Date: Wed, 02 Oct 2024 00:40:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Fix pm_runtime_set_suspended() with runtime pm enabled
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=891972
  Lore link: https://lore.kernel.org/r/20240923040015.3009329-1-ruanjinjie@huawei.com
    Patches: [1/3] spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
             [2/3] spi: spi-cadence: Fix pm_runtime_set_suspended() with runtime pm enabled
             [3/3] spi: spi-cadence: Fix missing spi_controller_is_target() check

Series: [1/2] spi: s3c64xx: fix timeout counters in flush_fifo
  Submitter: Ben Dooks <ben.dooks@codethink.co.uk>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=892483
  Lore link: https://lore.kernel.org/r/20240924134009.116247-2-ben.dooks@codethink.co.uk
    Patches: [1/2] spi: s3c64xx: fix timeout counters in flush_fifo


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



