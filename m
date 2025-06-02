Return-Path: <linux-spi+bounces-8358-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B68ACB92A
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 18:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2813B1709DD
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7022157E;
	Mon,  2 Jun 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4WNJPeV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB8213E78
	for <linux-spi@vger.kernel.org>; Mon,  2 Jun 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879998; cv=none; b=hwlnMxC08xY1jd66O5SgtoNlGYG4NyYArXdJNWcbjD7G8ugJ11GHRgKpNmShYfwHLQe/OPQk20b19TX2CO/a9y3uhaNMxUHROJpCRyyXekFA+eZvQYkMYrw58L/xEWhYGvckz5ORfddvswVsmlNCrzbmD30tZ9vVkI2CArlWaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879998; c=relaxed/simple;
	bh=bB00xXtrYyBAn5otrEfXMOL+xUSvUem7rLtcPKIVeaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oRAD2y2GQhITSLqFbPS2Bz1Bj3dPmb8CyroAA38MHa6aAsT8F2du4S8J46P4D4oE/NT8yLb7JVoHu1UfSAAULQNVOLk4tyQ/q4KlgFHpD4otDbrzL7rIuzs+MQISN0wy4iQpS7ZSyGPChDuFrk/DJMqgoc0a52VStE6BaPKBQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4WNJPeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D72C4CEEB;
	Mon,  2 Jun 2025 15:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748879998;
	bh=bB00xXtrYyBAn5otrEfXMOL+xUSvUem7rLtcPKIVeaw=;
	h=Subject:From:Date:To:From;
	b=Q4WNJPeVJQHyvS9Q2+4SgSGTVef1cISdHyn+p7IBBanZLEN1i+Dei0BAvbTMaIB1i
	 xvJbi5EmzWruLFOjmSyDEXGGGz50ce5dXdkqoN8jz6kmEvA0lUMEMbMGaHrhAHqxwd
	 xpheMZmHLo+1032gc45bE0ldI8dqLbXncTxPQzCN+mJSGLtUa9rjHmFlA9r0U2oYLS
	 xCokU9OTJpX0tcqilrHTTl9f9qe2IJJAHX5IiXl7fximOeFI8CACdaNATI0ttlxfw/
	 eZjLRNN3/sGjQHaBA5cVUtHlbA91yrppiF1eIw9QfYk0oZ0KV4vg25x4d+bzeT07TG
	 6mhlvqLdc0nKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEBBB39F1DF6;
	Mon,  2 Jun 2025 16:00:31 +0000 (UTC)
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
 <174888003047.807676.14031540239388952252.git-patchwork-summary@kernel.org>
Date: Mon, 02 Jun 2025 16:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: document the limited bit error reporting capability
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=966634
  Lore link: https://lore.kernel.org/r/20250527-qpic-snand-limited-biterr-caps-v1-1-61f7cf87be1e@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



