Return-Path: <linux-spi+bounces-729-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77883B17B
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 19:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802FF1C24297
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 18:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0F2132C05;
	Wed, 24 Jan 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNX70h5B"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC2133401
	for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122225; cv=none; b=FAk3najiFXXG63Mypay4HgGtbuEBIyRCQPjA0MJIasQhwCW1Rsoidxz5WwsNoGE1Oew8mF0P0MYbzyacYegBXIN3OJFcvTbjKKkzrjh/Pqwy8I5mXI/PLK6F4fzHfJ4UF/nOfuw1uZiBAXEmkrgOcAWlAjSMA8c/vhNUzgHQhuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122225; c=relaxed/simple;
	bh=9FBFzzluxE3j+3FB06YBXap00AkPcjfgN5fOreRtpc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=k1yN2KzyEbc8PmwIviSE13PJ1wFDzveozebpNJeyF4bzmdJogJ3ZrZiOy0u9IVSQligaotZ7PcBSAlSCtnQ4qpyVR+1d2Ejuf5YmQ5dw0TqdWxNGyzUD8p5XHZSIqD+357SUfEoeGnf4wH0HVz5OWfzgJ5gBAw6+Fwt202+fObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNX70h5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3079CC433C7;
	Wed, 24 Jan 2024 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706122225;
	bh=9FBFzzluxE3j+3FB06YBXap00AkPcjfgN5fOreRtpc8=;
	h=Subject:From:Date:To:From;
	b=SNX70h5Bb1e260FVbCskYFS5hUb7e1nb73MwkjNeW7teH+bo8yCrgX5Lo3KWRt3Ql
	 4Xg4vuYwFErCDZjNQxPTNTdBBcXwn1R7gyVKYGdj1z75gp4rM1/E541b4HNGDpXJOo
	 OA/gh1gIJm8CZ/D5U7enF48yUSzPi3BZQvIebvZTaxeiVCjLSlVVxNqEawZkT76vpb
	 P1zzPk9ju/X1zIay9W8qzmOMhtGxpqbp0XkphZ+4lEm6QU4QaLT86gfMlvtKMi/RHH
	 X0kjWXW4+l1SHVR+x0vft/lM+dAoPVAtVVo+GQOo3sht+/VqD7w8FQc/MPtr+etHBN
	 JPshEKq9ILGCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E916DFF762;
	Wed, 24 Jan 2024 18:50:25 +0000 (UTC)
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
 <170612222499.8302.16891461150685397497.git-patchwork-summary@kernel.org>
Date: Wed, 24 Jan 2024 18:50:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: consolidate setting message->spi
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=819258
  Lore link: https://lore.kernel.org/r/20240123214946.2616786-1-dlechner@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



