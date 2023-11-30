Return-Path: <linux-spi+bounces-106-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497047FF1A2
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04221281D83
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C054A9AD;
	Thu, 30 Nov 2023 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN+xnG7j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE54A9A6
	for <linux-spi@vger.kernel.org>; Thu, 30 Nov 2023 14:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB274C433C7;
	Thu, 30 Nov 2023 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701354027;
	bh=12RG0ePoPwResfpHlWBmIVJgIxnKqZRtXEgwxzGzgY8=;
	h=Subject:From:Date:To:From;
	b=dN+xnG7jTuD/EgAJQzCfhRcl9cfqMwBJw2+7RsnGLcD76Bpacw46sRgPtFbQ3LHyi
	 tqBRJJO1pMdUVqnn+XhjCPyKtZPq+rMeJQg82IeKR7NbY/xTETlXhEEmY7syzFngDh
	 3Lk47nGiZWm1FlupTYhstTeiT/NrLwy+t2AYxkkQFQNDCqXzranV77tMqLJq1L736O
	 6PHXEZS7DnJS8VseFtLnS1AyWS4abcAd/2JgaWMh8++IkVs7ryijTk0iNRi1IKvLRp
	 Or54zZxol4u90Efd1Vmt1o/RoVEl/JOAeshuXjB93wmuIt93HrGQfnwmktL8PfDqjO
	 9va60jhA4+9ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B61BEDFAA86;
	Thu, 30 Nov 2023 14:20:27 +0000 (UTC)
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
 <170135402767.6410.2829735633111210031.git-patchwork-summary@kernel.org>
Date: Thu, 30 Nov 2023 14:20:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v7,1/2] spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP
  Submitter: AceLan Kao <acelan.kao@canonical.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=805109
  Lore link: https://lore.kernel.org/r/20231129064311.272422-1-acelan.kao@canonical.com
    Patches: [v7,1/2] spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP
             [v7,2/2] mtd: spi-nor: Stop reporting warning message when soft reset is not suported


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



