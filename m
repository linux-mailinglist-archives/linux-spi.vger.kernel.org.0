Return-Path: <linux-spi+bounces-7325-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DADA71BF3
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292C41883FA0
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8909A1F4289;
	Wed, 26 Mar 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED0EQ9DK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C741EB5DD
	for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006597; cv=none; b=oUQ5sFl6GmQhJ1eKrPAZ3Q1v0X4ZcjGnLpdoyPLdu2laOuzLEjhz3LU2TT5SAnWlj/TaPPx/aZfCIu0ArE349DbBZp03hIRcQGovQpw1wPOgBdO6rzeHrnsdORvu5sqTpqYDLIAJ8KtEuT7AzuUyfkcIdns4q8Ik3iie/HobOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006597; c=relaxed/simple;
	bh=YsX3b8OZSkiIR+EOBXcONLJIYjER5yZQjM+VAELQGeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uXzuyrrIX+wG51p9TWC/gbrqsnYktCqoGUioMQPO/BBpnu+Wx8bs/8g043hksyjyVSLZHLf7cEsP2Ynp3weEXjcgmMl2uHdaTHD5MRjbz473gTJnLN1iGAm+gW2wyLhga45RFnq3Iul3EsfD5cpI4/vHTbzmj5ZPPJusHpPBfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED0EQ9DK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5307C4CEE2;
	Wed, 26 Mar 2025 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743006596;
	bh=YsX3b8OZSkiIR+EOBXcONLJIYjER5yZQjM+VAELQGeA=;
	h=Subject:From:Date:To:From;
	b=ED0EQ9DKMXLvttvDJYBydTkjB74pm2csdvVklu+CHv9ee5RIVa8LysZNCb1VJAu5d
	 aaJs2vHrH2uF3fgffw0a6C+4kl0UWQuLabJJJXcnD5RvkqP4XqZVjEsL0NiAy0Gpua
	 /ecolxMT7e0NmT0ZVMDkMy8Z9hikT/umvnhwDjLYJDmpcGKd9/Eko2g9ZJ4zGPuwpB
	 OhM5ZGWlIpMY+4o+pq6D/C4YQ3arogJLprcrhVhqfy8mLP/A9PCyuSDwb9jLjJTahi
	 y+5wJfa+I6vFB2r/Cemr7S4Nx0yCdxznq3QrXLzlXD87OfgrVXtpFFenaTuz3y9nMN
	 PgF4XdrY92RoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 386513810901;
	Wed, 26 Mar 2025 16:30:34 +0000 (UTC)
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
 <174300663270.1375130.9720534064581728916.git-patchwork-summary@kernel.org>
Date: Wed, 26 Mar 2025 16:30:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi-rockchip: Fix register out of bounds access
  Submitter: Luis de Arquer <ldearquer@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=946258
  Lore link: https://lore.kernel.org/r/365ccddfba110549202b3520f4401a6a936e82a8.camel@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



