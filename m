Return-Path: <linux-spi+bounces-1960-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A15E885B6E
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 16:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51ED1C21923
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD828613E;
	Thu, 21 Mar 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVfn9o7t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816B86134
	for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033827; cv=none; b=GEFA2ARrepLvSAD5QydQy+7qRxn3QjSM0/3lRnwlPri2nbeocI+XxK6yS4rWnzHTtaqBl2w98bmq/RVW5xh1mr5mqGyTfdF+lb/nBnDSKzmnw/HgQ6dMHDTXLT4aVgm7B7lb7QOhF7/lTif9cJydPCZxEcV9x5c97loWKiPjGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033827; c=relaxed/simple;
	bh=9qMGKNPT1WDQ2huQdcTOgcGtsk+Q7Yh0B9gHzMnEm9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TAN9LDadY8sAx04NgdhK/XGrXd7gmsK4bPXrt/PGR+LLt/xfu7/qamSDgVBZu6wohQX+QiTAde8SJI28HI/LGn1bytx5/mqYmMJS0PzKu6m9cL8WWfesBP4oMrWY6iPGtCjjyFugIt4+r4rKwb5d81QS3scLxxRuEhyd/X/F0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVfn9o7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E01D3C433C7;
	Thu, 21 Mar 2024 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033826;
	bh=9qMGKNPT1WDQ2huQdcTOgcGtsk+Q7Yh0B9gHzMnEm9Q=;
	h=Subject:From:Date:To:From;
	b=VVfn9o7t7FLRqvwdg5Gzu7KE0mstZNi/n9CN+jve/jXe8I5DbaVn5XAjbiXgMQxcA
	 0QJQEYv7l3xKUokl07Dh88+28tjKoprbRg9SdVWeOxPeTO0ZkmTSAPhmI6yO78etEG
	 3XKtvhjbEX0sdw7NzfD0hwBx/TpV4l30amdp3DwHo0lmaOMtyML1gdEflAEZQAJgVp
	 RD4eFxq1b2mavXF/TOfro8KyQF9QsEfL3pruFxK0H5TtE8bLst0Eos66iAqZzJG74A
	 Pwb0qrek5FrUjOHBhGoQ7JBc+eAHUsYz+1oQQ/5M9yw3Mgun1K0BA4jGwzUu4wMmA6
	 sWfCl7TroAoug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD86BD84BA6;
	Thu, 21 Mar 2024 15:10:26 +0000 (UTC)
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
 <171103382679.10740.10206482480718642631.git-patchwork-summary@kernel.org>
Date: Thu, 21 Mar 2024 15:10:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Fixes NULL pointer access in spi-mt65xx.c
  Submitter: Fei Shao <fshao@chromium.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=836944
  Lore link: https://lore.kernel.org/r/20240321070942.1587146-1-fshao@chromium.org
    Patches: [v2,1/2] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



