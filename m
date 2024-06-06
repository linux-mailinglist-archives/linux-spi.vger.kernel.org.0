Return-Path: <linux-spi+bounces-3326-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317B8FE59A
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 13:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97463281484
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38A5194C99;
	Thu,  6 Jun 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYH7a0Mn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A913D2A2
	for <linux-spi@vger.kernel.org>; Thu,  6 Jun 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674030; cv=none; b=E3odSoEkcSevSeHOohEpz5Ryt53Y8KxCdsKdBB9vWUUx/F5iQmxAblOomhYRcwDx6amXlcn7N4Rh+s/w55kZmVjB3HEq/hDcvHIHul7HSZOG2CgsGT8YG3UTKLyjqzf1TWcHtfZCaDbTL/nDWm2IODWBEhAR9zDj43wvYQudaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674030; c=relaxed/simple;
	bh=jJ+lvH9xtPfqJEtzBQNS5XBbbs4TUCI3LnbMrPo0BeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FRsIzPOPZ3h5xsnV3ABQzGSJZVIUgjiNZ5iTRTrwqHDoP/2jRzK+71oHo3MssJo/4f7b7BadaLApJbIYlZtzjzIT/gK++ryE+VlZgx8lgPzMKPh4l4CCYwtiGjU9rAf1e9FCjLqjEN5EYyQ8MxRvb6FYPVF0jL3pEdBXmDjM6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYH7a0Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A3FEC2BD10;
	Thu,  6 Jun 2024 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717674030;
	bh=jJ+lvH9xtPfqJEtzBQNS5XBbbs4TUCI3LnbMrPo0BeY=;
	h=Subject:From:Date:To:From;
	b=DYH7a0Mn4ct7sGnWW8koSntbsoYHTGoSum3hrvsmLguwgk+SbLvh2EeqcGIM0Jzye
	 2QELl23x4GnAOnIUm7KVJ+rStK/XFmf3DGyGY+QXyBYV4vrZtKf4IylqZ549MPiAcj
	 y0XPN3Wc5K2KXVlRfR9F10Qg8imkxpS2RUJWu6yWv5LLgSvZwieQWd8fT1WKvNaHp2
	 LwU/YIWFjTvUGbTv0iepjtHr7hK7P+go5u7yH0/AivoqXkQ5vBN1NVDu2rcfZSf33L
	 xCnM8+APs3Rpq1SXuhSAPQGz3/crtT98Hrzt+NKatlqtnkCFqMD8J0CnXBLc1qQf3s
	 V8hVQt3mVsNuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 570B3C4332D;
	Thu,  6 Jun 2024 11:40:30 +0000 (UTC)
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
 <171767403028.12695.13510218793633257430.git-patchwork-summary@kernel.org>
Date: Thu, 06 Jun 2024 11:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: dt-bindings: spi: amlogic,a1-spifc: add missing power-domains
  Submitter: Neil Armstrong <neil.armstrong@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=859007
  Lore link: https://lore.kernel.org/r/20240605-topic-amlogic-upstream-bindings-fixes-power-domains-spifc-v1-1-380f29ba4a16@linaro.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



