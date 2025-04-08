Return-Path: <linux-spi+bounces-7460-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1669FA81031
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C00461F71
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80C022D783;
	Tue,  8 Apr 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk1yIxWq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FB23534F
	for <linux-spi@vger.kernel.org>; Tue,  8 Apr 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126196; cv=none; b=m459MM6h105yFhUA3oBlefLDjk7BnXKocvxiiBVTnrn7+DFqyFMvDrlgPX4UUKfYUg9WLFbnqHgCrnJoDhOedivxamGcrt962QNX24V3ICV+1m2uevCS8hJTf7OMzZUJZh6GiHPPE/AniT4Ewh9ssxufnlPK/wqf91Wt0IkoTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126196; c=relaxed/simple;
	bh=avG+eSbDZI4yte/I07TGta97j8OPAg1MuzJF1omHntE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=q5LSHogCwJSVfiRqsmBXmtUpXEJSdw3EvCHyGNPKvrNGnU0CKNJSmtvTpEovbA49Un9xxreWuOjR/rHJO4Fdn6xdY8xnyptaVzIcFETl/I/5OvBKzAgBGyC6vOqyhRLhtqA2H1UG5xjfahTrzOeRvNWM3ZO86ZXc72+ITtIFvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk1yIxWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC77C4CEEB;
	Tue,  8 Apr 2025 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126195;
	bh=avG+eSbDZI4yte/I07TGta97j8OPAg1MuzJF1omHntE=;
	h=Subject:From:Date:To:From;
	b=pk1yIxWqzKBCfSqJy0MmvGquV5mN1X9/+TdPwsmyraoWpvaEwstXTszGhJOVL4P4m
	 Md2f8Q56BI18a8vbEn44BeWm8kNkuHjV68cjFEOkb/GSdZsdXov6/m6Dq7V9YUnEYF
	 Kb3EvjIItqh3WxEYaeUeuyrZOgcriIZ536VJ0VFhxGonYSOBsNwbTcBFEOGnbSnYuO
	 hHuDAYCsu/bV5/UBkKTpEm1R9YNy+/FT/B3utk3chaSv1H+FKCooq9ohNFtlE9P5dz
	 o8E98KVXCce1qKRtCCdEs7ADYIoJttq9k3nyAGZbANEyn4Wjk4M30yUEKP+5ivZjxO
	 B5OfGrdmd1QUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B63E238111D4;
	Tue,  8 Apr 2025 15:30:33 +0000 (UTC)
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
 <174412623228.2024234.6175433987996989570.git-patchwork-summary@kernel.org>
Date: Tue, 08 Apr 2025 15:30:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: xcomm: use new GPIO line value setter callbacks
  Submitter: Bartosz Golaszewski <brgl@bgdev.pl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=950964
  Lore link: https://lore.kernel.org/r/20250408-gpiochip-set-rv-spi-v1-1-597660766654@linaro.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



