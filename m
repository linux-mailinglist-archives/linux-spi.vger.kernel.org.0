Return-Path: <linux-spi+bounces-5913-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347579E4754
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 23:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944E8B37944
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF41F03FB;
	Wed,  4 Dec 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtx/FCxM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB91F03F8
	for <linux-spi@vger.kernel.org>; Wed,  4 Dec 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343614; cv=none; b=q9O+eLBjIuFTPN1rnk+W2KV+CCCIlG5aynjOHu2XrguCKvR0CGqYZbGmpeH7ls7eTwApBYeOsc2ErKSJa5TwDIZdEMsNCzlbcpdOhuVn12LoO5exoaOm7wx3VOBh0KgquZjCm3qvcYtZuh05GI4kuhojRyUbg9EZcJ2clinMZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343614; c=relaxed/simple;
	bh=1JM6xHWKk/N5jAfcJ+XS5+Wfx7QnIJ2Zkhu6AElkO8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZAlc7m5bwaEQ8e76TiYcrJ/cMMWdvaUQk+w0tcIwvsc7ch9BMsTxdeYLMs4qNFwquGd4c6olEzrzcsLgKWrzZ3l8ZcKjDxerU5e9nD/J3+jPIP5A+OCrfaRbNtw5mAkS2/KMJm266LVAOmhqhIbPn2L0au0ooJnz3BAFnfEE0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtx/FCxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98604C4CECD;
	Wed,  4 Dec 2024 20:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733343614;
	bh=1JM6xHWKk/N5jAfcJ+XS5+Wfx7QnIJ2Zkhu6AElkO8Q=;
	h=Subject:From:Date:To:From;
	b=gtx/FCxMaWF4oNs17hGJCwBWmUE/5+YWFXd5YoAQ9eYqg2PBamFt0q5d/Dwn4uGbk
	 AnKvM6XMANHjgcSW2iqAtFImZ/47LvIUbTsWkC0QHv3a/q10uKwLY03e6xFGg3OT9T
	 uCGrNeX1+g7u9Uay+sRVdjXyqnwJgeAV79IYLw1OD35HnLab/F3jidZ3Yup+8j74BD
	 cr9LsYhtvVrSWbJ5uSg8p7X4FRzIcMGz1t8kHnNDGLlWiJdhRndIBWRarJ8lXCqQw7
	 cwwGAdWh7Gxvhb1Q/dQlYtmuI89/Xer3h261EUV/ETe1XnjV6KmqnBt7r5vqYZbyDL
	 EhGJkBxU97SiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38049380A94C;
	Wed,  4 Dec 2024 20:20:30 +0000 (UTC)
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
 <173334362873.1324266.18288925043629161488.git-patchwork-summary@kernel.org>
Date: Wed, 04 Dec 2024 20:20:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-kspi2: Add KEBA SPI controller support
  Submitter: Gerhard Engleder <gerhard@engleder-embedded.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=913880
  Lore link: https://lore.kernel.org/r/20241202194003.57679-1-gerhard@engleder-embedded.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



