Return-Path: <linux-spi+bounces-7808-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C934AA5881
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 01:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEC03ADE74
	for <lists+linux-spi@lfdr.de>; Wed, 30 Apr 2025 23:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366D1BEF6D;
	Wed, 30 Apr 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Caqb5bV1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA462629F
	for <linux-spi@vger.kernel.org>; Wed, 30 Apr 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746054702; cv=none; b=WeSs3tNs64Gp5ATF3ExBHXiyZxqqL1denqUkyRlgfpgsxi/77eZA9uzyXyUkJ84rZgp8UbDHiQsf9Okl6E+urdf2DdOYRixrO7/yfvhRv/TmdMIcjWH5mnDoSnbAacD/GGQmD65WVSsplu1HsLYquHSj29A6EMNxkMfT1JHR2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746054702; c=relaxed/simple;
	bh=Ydv5qLItQ4WI5H/xHB7P3rvIBdJXom6IVBPX3sTWqLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uAf1jL+1C1Tmr0Yn9lcxGd5992kHVwCZVO5pBmjm602Ws0cd9ACuG2flNj1Qs5dCCtEVzdekth1arhrJ2zKBFfKFyiqFktffYan3OyloX2gmpN+8bJyZ5gf0o1j/0hGponV/lzLzLf6eVu0Q8EO71/Wn0v3Hr4GrtkKxh4yuBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Caqb5bV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D944DC4CEE7;
	Wed, 30 Apr 2025 23:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746054701;
	bh=Ydv5qLItQ4WI5H/xHB7P3rvIBdJXom6IVBPX3sTWqLA=;
	h=Subject:From:Date:To:From;
	b=Caqb5bV1kuVW+6F7npkCds/3gnoRLvTKEig2tebH4ssyFARAcXUMULJ1G63BSnE95
	 QlgR4uRwwygmGQcKjAdAmHYs5zu//oGHhkGgL5npBVLug5ZjgTMMBiY90aZMl3nRIY
	 5tvgJynlqj7dHNJBn6MsbrLo7/3IOTaM0NhqdZpS6JIrI0bKDyc6Phfkr+IEKemmCZ
	 DxAGTSq+s8I+d6w1zmzBIqFXydbrgQ/CUpnM4Tl8a2bZbnEWKF6AbDiKvcWpGcVyDe
	 OAIb2liM/+Pq4gUhcJPa3xNjJtTfLh4pKfIvPggWtavdV4CmWz+z18uDA9Vg/DvpU+
	 7goPr6Q1tcYhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF8C239D60BA;
	Wed, 30 Apr 2025 23:12:21 +0000 (UTC)
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
 <174605474075.2502485.14867510292966941980.git-patchwork-summary@kernel.org>
Date: Wed, 30 Apr 2025 23:12:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: fix NAND_READ_LOCATION_2 register handling
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=957592
  Lore link: https://lore.kernel.org/r/20250428-qpic-snand-readloc2-fix-v1-1-50ce0877ff72@gmail.com

Series: spi: axi-spi-engine: offload instruction optimization
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=957866
  Lore link: https://lore.kernel.org/r/20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com
    Patches: [1/4] spi: axi-spi-engine: wait for completion in setup
             [2/4] spi: axi-spi-engine: don't repeat mode config for offload
             [3/4] spi: axi-spi-engine: optimize bits_per_word for offload
             [4/4] spi: axi-spi-engine: omit SYNC from offload instructions


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



