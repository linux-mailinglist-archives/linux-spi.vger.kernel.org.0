Return-Path: <linux-spi+bounces-3832-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E221F92D795
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 19:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0FE28212C
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD3834545;
	Wed, 10 Jul 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecr44/Lj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68880192483
	for <linux-spi@vger.kernel.org>; Wed, 10 Jul 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633237; cv=none; b=N1x/B1Zw3+wSYI/lZBpgEi4GC0Wmy62ZmpIv7jXX7gcLxOumNUOp3gUvdNUxhKf36wZKok4JsPEs0dz9w7yyMBlttOZR8409gupPJ2NPIY01AaIkV9515kwQFaVbChN7w/VJ6TKfEZzdkjkw+aHqL/McFwPFyAfVQrWefGG1CT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633237; c=relaxed/simple;
	bh=gLrPBpToDceY5wqaW8PYi0IuqvLacgMsEPPS09BCs3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=e0U6V/I40dD68NCf1Yo6sHrZ7L09J54V/4DQiKV+O1iNmpLBrlyFRh0dDDmlHWDvj1g9ymEoG8eM/E3TYkTye2bdxrlEJSVU+YalZU3A/cdjqEnNk926fHbYfvawLBp2TbPSMpjqivT/OpjQa5vd6zaKaVlgRD2tPATAwXgPmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecr44/Lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22E4EC32781;
	Wed, 10 Jul 2024 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720633237;
	bh=gLrPBpToDceY5wqaW8PYi0IuqvLacgMsEPPS09BCs3E=;
	h=Subject:From:Date:To:From;
	b=Ecr44/Ljj9fGh+zZ13RmRJn89YSUXzdQbQ2KMUpT6JV3CuAjzdfEhE9sgE+bhUMEu
	 EEFFsq+7kaSRV+afwERywpHQE9gsvtdyDHV17bHVyVUMVDNgQyOoDk0SwxFymKh8Tl
	 vNnU7tnSYusqHauqW/Xjmcy2p65djTTL2+A7+XIjIGNFBxEK/G4eWFTLn0CaQPylwv
	 FkqomAxh+SLREySI5HVQmuUZXNwQhKLs8zOqrePXlczCNMGFwbnqllWrXeMihnTpR9
	 f2/8mGmOvyHOYJgCDJc0QH6d1Mx4DixxI1XUPEimd7dK5RL5Ia+Z/40IUmBGvqAuxr
	 b1VvQLGcuxsAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06C3EC4332E;
	Wed, 10 Jul 2024 17:40:37 +0000 (UTC)
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
 <172063323696.3690.3996858183016805745.git-patchwork-summary@kernel.org>
Date: Wed, 10 Jul 2024 17:40:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: fix spi-mux/spi_optimize_message() compatibility
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=869461
  Lore link: https://lore.kernel.org/r/20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com
    Patches: [1/3] spi: don't unoptimize message in spi_async()
             [2/3] spi: add defer_optimize_message controller flag
             [3/3] spi: mux: set ctlr->bits_per_word_mask


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



