Return-Path: <linux-spi+bounces-5255-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB69A454B
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 19:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A452E2898CF
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B6917B50E;
	Fri, 18 Oct 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Puxr3E/w"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32E14900E
	for <linux-spi@vger.kernel.org>; Fri, 18 Oct 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273826; cv=none; b=MQTLyo6IQiJV643tXUfK0vB+uX0RYy3M67Z+8axYCFpaz8kE3uDbC5pLbdS35byyhStLX/Q7c91R/J77wRlLfDF80SY3y3CjXrTsWjQiXuZ6/B2rx7VvyravkY/IA0zwQou5qLP1nhhuhF2drpHJ3DxUGoQztymqcJU0kEK8g+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273826; c=relaxed/simple;
	bh=FSbbryJCxdbBD2a8PZ0bVn2TnDxZOrriIkNPKnOG3yo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QUwuhK7a04HGPiU6phYOYkXLUCE3w4IJJ4P/rluNmwLHp4UVn1cq9VLRaI06Dq3UbSa7eEdEwZk8g/oRlwLv0pnMaKiV9qUlITgyDOVpdPDbEIO8XqoIFOrg6p991Dw1JfxQWY8WtzphTEw8HyykjxRD7uLi/MUYo13paxMRwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Puxr3E/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935ABC4CEC3;
	Fri, 18 Oct 2024 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273825;
	bh=FSbbryJCxdbBD2a8PZ0bVn2TnDxZOrriIkNPKnOG3yo=;
	h=Subject:From:Date:To:From;
	b=Puxr3E/w3fqmCfiO3WC8qyVft8ckV6+NAyvFldwnzXBdLTdQ/QIpWI4MUvtXbSUrz
	 uiyPn2Ryqcoif3OAwp7XYUu7Tig/s8WyXtMjLyr0j/R5Pwwm7IMTB2TySUTXc/XraO
	 thAzcQNt2qCiNtzRCLM620GZ+ZWDXrzLh40LAW6S87WylTGntLtxCzYEWKhFtxjDsr
	 YVAbHH50cpKUU33oTFL1jf6ptcUAKZLqF9wxNRNULlFv+sZehxjzlwhANgOOWDeEYa
	 m7WTUGLcB0jBUN9KFaX6QLppmzGl+0jeeMsrYT5TDnp9oXXEQ+7xEqmI+UwcmJKwvx
	 cmZbfOZfeKfEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 374603805CC0;
	Fri, 18 Oct 2024 17:50:32 +0000 (UTC)
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
 <172927383068.3189326.13794370903384938008.git-patchwork-summary@kernel.org>
Date: Fri, 18 Oct 2024 17:50:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v4] spi: dt-bindings: brcm,bcm2835-aux-spi: Convert to dtschema
  Submitter: Karan Sanghavi <karansanghvi98@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=900284
  Lore link: https://lore.kernel.org/r/ZxEm-H-PjlQyXeOH@Emma


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



