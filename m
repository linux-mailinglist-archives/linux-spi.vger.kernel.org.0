Return-Path: <linux-spi+bounces-2676-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA418B8B97
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F4BB21581
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC1812E1F7;
	Wed,  1 May 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfilV+CF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B2A12E1D1
	for <linux-spi@vger.kernel.org>; Wed,  1 May 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572033; cv=none; b=JNigsSH2DpN7lKHk8qUb5mAReNAZakHVrK24wa6gkMpNK0+FxaMI+JVVmo6eHvXN9JscXY+ah4qJRQCMBk8xC6/fd9Uv5SrTDw8Dqf+DhZPKqnvpw+Lq5lQ2dgq5d8caD6Z5uWhaTA1ytzm5Tkv35VSBFgowOI4AcEkqzRE/tsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572033; c=relaxed/simple;
	bh=AtbNBfNsdkCg6bOnfGhp848fFSxrMTfC8sOiOhanXoE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=D9LGIcqQcxjHBA0PAkYqRxYv7xEpUXifrfK4WpXhY59ipSPNzYpmAeXHR8jxcTALCfHkie9sLcB9vRRwYxkpQAAgpMQtmy9mNakQ2mMHuxdfsx32HYO7bIMSxvdlxzxECRM26j9wq+o2+BpneZh6/GixKFwZ0PzUDC7Oxkf8hLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfilV+CF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8615C072AA;
	Wed,  1 May 2024 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714572032;
	bh=AtbNBfNsdkCg6bOnfGhp848fFSxrMTfC8sOiOhanXoE=;
	h=Subject:From:Date:To:From;
	b=cfilV+CFmaDYGIQ8s4ERJPmbJpj7JWgJchLDKDEFj97JNb2+wyhsEJezoobGQBjO2
	 bX5gEHD2llvfnAo9FJltsnOxcknUGDPGzsShheZPSekU5umIzw073m/DYxjx3Rwwsd
	 3PnsojSzIPt5zwE7l9wwaJHZlcf1JYhAedWH0HhZ3//gB6+NXvQx8QNLT0HmbpD3Kd
	 LlYuElVihv3hfqicNXWWATTrFr0vgUjLAkA53w2DmXST2uK7n+NqMCNevLVwKzRz8Z
	 Um3fEDchdVSBvXcV4I1zwMxo2Nqbd2ZrexAYL9I+FyVp9onCj+LB7Q98LZpzDYWfEf
	 KyL6lKjIs68+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B023EC433A2;
	Wed,  1 May 2024 14:00:32 +0000 (UTC)
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
 <171457203265.29294.10133787100370795559.git-patchwork-summary@kernel.org>
Date: Wed, 01 May 2024 14:00:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: use spi_valid_{tx,rx}buf() in stats function
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=849468
  Lore link: https://lore.kernel.org/r/20240430201530.2138095-3-dlechner@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



