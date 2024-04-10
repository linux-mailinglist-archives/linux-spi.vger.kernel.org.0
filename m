Return-Path: <linux-spi+bounces-2288-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F208A00C1
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6422CB24BEB
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 19:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F2E18131B;
	Wed, 10 Apr 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m23PhWEd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E315DBB7
	for <linux-spi@vger.kernel.org>; Wed, 10 Apr 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778028; cv=none; b=FpTfzK/6S9nJde/pn8TmNEs/Y+Ier4dPlBuzY0DOHMZgfokOIdy0HeB4Nw1OhRi72vwxhhqYDZwETitVFqc05TgJqWlV2NT3zaCdKNw49Lv8+x8djiZ5d5wwztgGTbvV1OMNnmP+2YmTzfJK+dgHsctQM+BkGWSSka+uaGV1dX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778028; c=relaxed/simple;
	bh=EhbwVHElSY4W4YDzxLKExKfjFfLrtccN1qY5XMiL9+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BwidGEcBqeau+3QXBgGOu+FeK3TjG+izT9jJc1zJs/AJ/98I+o2N0tmeHKK4imiYzz+22T/14laxDCXgh+hl/5oFsRrgaq1zeFslKEoV1gjQfVs/w6BBp34rS91FdMNjJtVyXzKYviAkEWQN1zZWMHcJagbRT+HUywD34SIk+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m23PhWEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D468DC433F1;
	Wed, 10 Apr 2024 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712778027;
	bh=EhbwVHElSY4W4YDzxLKExKfjFfLrtccN1qY5XMiL9+c=;
	h=Subject:From:Date:To:From;
	b=m23PhWEdhCwWA3W+S9cClzn76Ofy6yRuMPOK9X9LJbj5WDHo2X8xFk2ldqtgFB2fO
	 e6ybDCX4w3bciK536Sstvd9fm5S3qtXCOqdiKu3bj0zS/j6DXbF7JL7Fwsb9tquftr
	 c+hOzgyOz6n+KFkpzvptY3TEDLgje1suhWu671RH7+qHvZwiUEYVfFQOqf40F5L2pu
	 zAf8ZIM8c5/29Xe+h18yBLC0ch12cEoEZGG09ZJSEFT1PcbTq9AuYjA1FixUVuIBhe
	 b8VcYaI3nLhLLfWliv199icGCKmzknhkcJgMIgMRUG/tMO3feYF/hARJ9tOP3FQd+m
	 SYAuKmf/rPdqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3A2AD60311;
	Wed, 10 Apr 2024 19:40:27 +0000 (UTC)
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
 <171277802764.23055.14461048942517920896.git-patchwork-summary@kernel.org>
Date: Wed, 10 Apr 2024 19:40:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cadence-xspi: use for_each_available_child_of_node_scoped()
  Submitter: Kousik Sanagavarapu <five231003@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=843241
  Lore link: https://lore.kernel.org/r/20240410130205.179069-1-five231003@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



