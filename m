Return-Path: <linux-spi+bounces-9113-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49A3B07A24
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155B71882D6E
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0430E22F762;
	Wed, 16 Jul 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSJySVrK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3507223301
	for <linux-spi@vger.kernel.org>; Wed, 16 Jul 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680385; cv=none; b=ljXb5lf58qQU1Okmpd1dVLKL4Wv3Tizv148EGPug6WxFf+3OhGW245Kpf8FBRo8HH/TKQDETE1BG30mQ57Gk+ldVRazFre6igNhrNAXfxqcXdyWHPpd3us4g8hacobB9e8VnIonC8S8NmqfyYSfbugtKQjxFgFleAJNpi2iiVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680385; c=relaxed/simple;
	bh=hGbAYDGNCT4vSwsi905KOdDrajj2C7S1kwBOXX74/f0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FX+z3ZvoLkBRnGrcXrwqv8epC5znS5dZ2LUg23mdELC68ENkNNQ++/prVnZ9miLn4x1yTSRCZ0yk734lLHTG7OPs3KJKu4fhVenixgMP7Q2j2kcgHdeSn4wpJRAukjpsZGtFoWX+T0GZWceSsHLbdGoRVXS9qioYsxPkzCSSO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSJySVrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64003C4CEE7;
	Wed, 16 Jul 2025 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752680384;
	bh=hGbAYDGNCT4vSwsi905KOdDrajj2C7S1kwBOXX74/f0=;
	h=Subject:From:Date:To:From;
	b=rSJySVrKiRFeoMAKOep4tkaJyJnfLVPejpx0Hp9KRZSRDEfJlIsoDIe683N9v+E1/
	 uQd6XuqnfnvJtYgM1lFM7e1d5smMw737FQHv/17E+6vqDoXjkCf8PDiOeje49RzpIv
	 xEBo3MkYHp7IRDFiu+PDDFDuFBhAD7Z0jew7cE3Zf+rIcjJeg5+kwl/HplVmHNiSye
	 kn/FwGv7Bywt8C8us5gtkGxqhKt8l2WY81PvSz9rnIZz4KYWN5HlbHU3hN0ejDyQwN
	 tktxNE1YczECSx/6ZaNgTMP82RF18tKT5ZiVWGm1tVoUZNEw6kiHKQ45nw5Owu8ub5
	 NWfmUIP9kdN5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B224A383BA35;
	Wed, 16 Jul 2025 15:40:05 +0000 (UTC)
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
 <175268040434.1234742.7729684554590796862.git-patchwork-summary@kernel.org>
Date: Wed, 16 Jul 2025 15:40:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: gpio: Use explicit 'unsigned int' for parameter types
  Submitter: Darshan Rathod <darshanrathod475@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=982893
  Lore link: https://lore.kernel.org/r/20250716095906.21812-1-darshanrathod475@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



