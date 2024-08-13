Return-Path: <linux-spi+bounces-4181-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12C950D26
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 21:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACB0286275
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659952C1B4;
	Tue, 13 Aug 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daqlKkq9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F61DDF4
	for <linux-spi@vger.kernel.org>; Tue, 13 Aug 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577439; cv=none; b=U0380wtidfq263UHVfvaGsK5Gh2WF1ZLj9yYVY2VTkkzBLamSrKT5U0mGS6MYuOE4FQaO8OAdfsPO7kv1lKEkc9ZoSA0citBK39ChAxgvz4NKSx8PO/4SoKOUNj7GkGVBYgjQ/pgAx7ce/75tkwBh6FMjYM6ojZAaqg1fAX556I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577439; c=relaxed/simple;
	bh=1YoVx6bZNBsQkPWQdO/r54lol/Oxd/mBYXwX8Lbmc4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aH6mGBirfofItLlImnF5aimHReuQ3LrZGf9pOpmBxC1mVimUu15lhUEKQYZ54lBruFmdb9/gQs0h8jJXsdi3pm+cZ9+2UtpiMoS5OSE9dv9fwbyyr0aDl7xKhDaO7S9FaMZnWk4RgcWqXqKGn0nuKPy4kwwgaRZFC4bn7h5hQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daqlKkq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF70FC32782;
	Tue, 13 Aug 2024 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723577438;
	bh=1YoVx6bZNBsQkPWQdO/r54lol/Oxd/mBYXwX8Lbmc4o=;
	h=Subject:From:Date:To:From;
	b=daqlKkq9sEZrRqE0GH1urW0PHmdhB/ZXYEOQ46FL2VWzGgvRqRFM0FwFbnnPblc1q
	 0GBuTjzBUl6X/4QBma2DBUP6tI10dJpJAuYkhy3eQE0Vrw/nZuKObkXWDtFP6oyrOb
	 4bf0ADeI3ndpHDQVJT/uDRcMQJGdiwNEcJ0hHJpZL5cJkpu+l0NCfnxGsRPCuWcVIq
	 TkzW9uqEBJIKhiZB+cOY9mX09HemDY22zmcJnIYU/n2uG2vMOt7pmI1EYst20VIH4X
	 AK0oYRQUn51GJEb3Czt4v7OHBxnGqNGJflrwiFOJYsXQjCC62WZkFSsr1vDqxWVZoA
	 FS2DGIeGEiykw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E4ED03823327;
	Tue, 13 Aug 2024 19:30:38 +0000 (UTC)
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
 <172357743735.1734125.17750921757350255548.git-patchwork-summary@kernel.org>
Date: Tue, 13 Aug 2024 19:30:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2,1/1] spi: dt-bindings: convert spi-sc18is602.txt to yaml format
  Submitter: Frank Li <Frank.Li@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=879290
  Lore link: https://lore.kernel.org/r/20240813154444.3886690-1-Frank.Li@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



