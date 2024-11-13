Return-Path: <linux-spi+bounces-5699-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668F9C7A8F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 19:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA151F2373D
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA785202650;
	Wed, 13 Nov 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5X3Gu1R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B36202631
	for <linux-spi@vger.kernel.org>; Wed, 13 Nov 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520823; cv=none; b=Ct5e0keu58YaEChlhaM5eho3TjKEC1B7d+aAmJKPQFwv0Ow/1u/TRQ+x6GLCRssqQGK4aJ8vdJI4qfCBoNkgab5Eij8Te1uQZdYb3hVwbvLYxkjntyNeEIDlwVBTotWjxii9uiDa6S+qIeiXsSkdTVqCef/9YMdjRnMD4BGlm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520823; c=relaxed/simple;
	bh=RXgUFm/CJAOPxcUuHgYi+KoNEoZSpLU6Fq0hxgXB6f0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=c15EnPdYkwKaRukGTPk0MD175rFB2i23Svbfz/gddjaifj+6/vl9FTWIfX2XiEWKOcreQsSF0pZP/hHPuFp25lBQ22roxzcD7msJLMmlrtBpkZLeOMr2lQzvB96V9BNp4E0R1diXB3YlRjjvr2AiLo54f2UF0MExkG1XW+by/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5X3Gu1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50773C4CEC3;
	Wed, 13 Nov 2024 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731520823;
	bh=RXgUFm/CJAOPxcUuHgYi+KoNEoZSpLU6Fq0hxgXB6f0=;
	h=Subject:From:Date:To:From;
	b=g5X3Gu1RxZMUboiBO+Jx8UnoKMrLcSEuPhwjsraRKm8ZlyPeP8Ud2nhfHZ5RKPCrC
	 UBDur/blL1c9EEkYPtYixnke1fI+6kFqS3CClV0EJuhVXV0NYBeGTuYJ8VkN2RtHEl
	 SiAZa9q/2zN0F8voi/SgJLI+QFq3U96JFHIKoa4RfXw0bQxeGIXqkSasgxu7wrcJYS
	 Xvsd3BIi/Wn4H5FSK8UXsQvucz2QRBHTD2OzI2oV6MCWspC2C+0Ws5DfXVMyizc+wA
	 fShLs4PasBbragHa2+q2RyMJhHvRhkO24ZnTTuNiyEJukb/rbOIxzDvVPp/k1KuZCU
	 jcMhopbrEGnvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B357D3809A80;
	Wed, 13 Nov 2024 18:00:34 +0000 (UTC)
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
 <173152083323.1306368.778712364934052914.git-patchwork-summary@kernel.org>
Date: Wed, 13 Nov 2024 18:00:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Delete useless checks
  Submitter: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=908720
  Lore link: https://lore.kernel.org/r/20241112081637.40962-1-zhangjiao2@cmss.chinamobile.com

Patch: spi: cs42l43: Add GPIO speaker id support to the bridge configuration
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=908865
  Lore link: https://lore.kernel.org/r/20241112131434.678882-1-ckeepax@opensource.cirrus.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



