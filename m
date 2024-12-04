Return-Path: <linux-spi+bounces-5908-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0809E3E53
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 16:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD792841A1
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EDA187561;
	Wed,  4 Dec 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdOwHzka"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FB1547CA
	for <linux-spi@vger.kernel.org>; Wed,  4 Dec 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326216; cv=none; b=GH1p3AWF4p1lNI6RpcVzFhpAXQuE5T+rR01QFAPN16re3y4IN2tyV3sr+3LptlPYmyGtOGyyvWRT4hgp1bEhyROxQzw74TIw6KR6gs61ydIYcFXkRAucOq/IwBFbckIBoSXnWZ38uInz52mDigO+h7h8pb5+uAQxZ1lhk0SzglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326216; c=relaxed/simple;
	bh=GCdKxZxioo3WCCepW3p8z9k2zFq91yYfVlwgPI5MNxc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Z0245s9WOvutPr18riokqdw2Mh4x42bIu3twRtCt7jEewMr/S/A6Y7cZfqm1I5ZUbDri5UR2jJToTL0RpOtWw9Ty9AtV/ho1u0MK+k2h4JPem4t20g1MQ3lmXiB0WHxiBVN90enl4UMvYdTyVPYsYFfx+NYT1OPGvLwVxqPW8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdOwHzka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8950AC4CECD;
	Wed,  4 Dec 2024 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733326215;
	bh=GCdKxZxioo3WCCepW3p8z9k2zFq91yYfVlwgPI5MNxc=;
	h=Subject:From:Date:To:From;
	b=GdOwHzkaDAd5wLiFSVJ1jUr+uAQ4n66MdkcEjbYVKpPNpG9eHZ28vIVF16tKf5xmk
	 6rIA4xfmz9ofItTCezyAPOg7NvLCbMPnanS5OAy/tnD0F7MFKZsx/VoiW3pIxdtJca
	 mDWPT6N6gh0DjyYK3eouysxK2wKXDm+CfVA1ZzHjTX2H4lCHLMpQVuW4/5F9arpr77
	 9/9pCTyMXUQF9IJ8g8HZ+lcSSwdYwTtaUXVQDeaEpudz22P2NYriKOgqeL94+Adkiz
	 jchOqYccOvohkz1i5FE8TNgwvimsSUsNPwkPfnogJ7158bBK26AZzRBIi9iVHyCaIT
	 G+RZkO8akibZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348103806658;
	Wed,  4 Dec 2024 15:30:31 +0000 (UTC)
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
 <173332622964.1232885.7619281174056531181.git-patchwork-summary@kernel.org>
Date: Wed, 04 Dec 2024 15:30:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: intel: Add Panther Lake SPI controller support
  Submitter: Mika Westerberg <mika.westerberg@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=914448
  Lore link: https://lore.kernel.org/r/20241204080208.1036537-1-mika.westerberg@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



