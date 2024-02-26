Return-Path: <linux-spi+bounces-1510-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF145867C95
	for <lists+linux-spi@lfdr.de>; Mon, 26 Feb 2024 17:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A485296790
	for <lists+linux-spi@lfdr.de>; Mon, 26 Feb 2024 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CF112BE8A;
	Mon, 26 Feb 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2uE3Pvn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C312C522
	for <linux-spi@vger.kernel.org>; Mon, 26 Feb 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966229; cv=none; b=uHV+H0C9GQOTGVV4hLRmZmHtL+XA8jn9lXlfcctrDebm9M6yjlkH7AIOnTxqBNWkYSaZpkho69T+nj9ZKMD0k2Z6PV/b8wDtVeMr9v5tD4VX+AZ7uOpjyda/ZoVzyH88+RWepIklJAHI4ztOyUgEp+COGkHulj1CqNv9wxBjOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966229; c=relaxed/simple;
	bh=TUlpXjd3Guyz3IPW85S2GqwBDfANrEwd9P8bve11iNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Bq/hiHLJiUgqimw1tKBtcRbH9sz0hSvny0FGKJNCQ60JOPaOGeJWDSRFDg3aHgedXZLEu4OuuPVCS+2eM+S5pOPRfeyTJx67mYhqo9kIR98UNbwalyXJ7nkgFg3VrLkxSVDP6N3keeBHATxq6XryEPjfbcvogIjnCnEtvLkqD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2uE3Pvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44BA7C433F1;
	Mon, 26 Feb 2024 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966229;
	bh=TUlpXjd3Guyz3IPW85S2GqwBDfANrEwd9P8bve11iNM=;
	h=Subject:From:Date:To:From;
	b=B2uE3Pvn1d0P6NUsQd3f/FXochyRtbxoYRYeOS9J0cYM1sbQ9Jh6DsVlgA5fe/JPc
	 FuQ2WgvQNUrGG96ppqbqCa2ZrAlGlGNMzjCnyPPoj3vWSveezt6wQiqL5W/Y1IuoC7
	 5esyAy+CAYwVtPKnH7jqwtYhTIxae/DvMKhYBiywkSfMWZVKjicimFEFB9Lq4UCHRX
	 meDSL6zFcBUFwV2MtYqpszoHxGqJKqhSJXA0FXnhT+rCQYLX7Ddn70LuWWboXjTIZ8
	 i25OLVwEIRSGyxh4qISPHUEyirKvj7N2n/YjMwmGG/R6gh0wJnLxmxpWSN33c0HRPi
	 6M+wqTYovvflA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22D95D88FB0;
	Mon, 26 Feb 2024 16:50:29 +0000 (UTC)
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
 <170896622908.14525.10817694370891897329.git-patchwork-summary@kernel.org>
Date: Mon, 26 Feb 2024 16:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: spi-mem: add statistics support to ->exec_op() calls
  Submitter: Théo Lebrun <theo.lebrun@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=826855
  Lore link: https://lore.kernel.org/r/20240216-spi-mem-stats-v2-1-9256dfe4887d@bootlin.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



