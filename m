Return-Path: <linux-spi+bounces-9537-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85D2B2C89A
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D142817A59F
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2824169A;
	Tue, 19 Aug 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOOvajSM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC124502C
	for <linux-spi@vger.kernel.org>; Tue, 19 Aug 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617996; cv=none; b=IM8GNCC+lSwYPWwl7BIeLjrGA8/vqLgkStu2WUnMGlB9aeqbi+80JXFh+NyQofBEPiJ1eUD16xfWQFLP1MefMhPdp29w07R0xZmtnwCKvgYF7xeWRVdBtebSHuVVTPDDBa39A7Ae0MnEhxVZpozO0O4EnnSHa3vXvdjQk7TcHy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617996; c=relaxed/simple;
	bh=9fYRjnYRT3c7PoZVqhLp4shJaQO2lY89SMbXYbZ1Xvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BsdYodXYrywIawZN51h/urPoJ5fMvQCm+8RZ9Jp5dIFrGfX4zdeJ6iGDaSBMd4EDKKLE7dfQOUlwzgrkjQ7INjUMYWd9xpsxjHV7FwafLiLRn+dG++iAfdvUl9IYYwgqfHzBUFDUVfgrAl6czMnQ+kshbem8UdmYHWJ31B62GfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOOvajSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FD0C4CEF1;
	Tue, 19 Aug 2025 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755617996;
	bh=9fYRjnYRT3c7PoZVqhLp4shJaQO2lY89SMbXYbZ1Xvg=;
	h=Subject:From:Date:To:From;
	b=KOOvajSMOgmj9FMCYRFimwjD+lsmzUcMkrqmWbJ4kQc39sGO+kp+e6VZ1YdcqoY8r
	 mwgomk/diiJCq0DBaChmhl+LQo5m2h//YsGoyuxJlQnJlwM6ui+J/ima/pohK6YT2h
	 zUrBR/NEtlfpAErGxP1uJRnfBeVH6/uc0hlWQjcOCxyQo4AW17zBoKxGGHCQg/CAr8
	 bV534GdW/FI3cHDsCmlaF9WoDdyDmWQiRt5qhawnGwi37XGlyZhFUJoEEc1cvtm7eV
	 6vEL0NnSs+NJfGMi/cyhBr3bRq+ZvVZmwb2dF6nCLln3E/cBQHSUbK2vCPg/3tXZCz
	 sQJlEj3eZm5vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE5BC383BF58;
	Tue, 19 Aug 2025 15:40:06 +0000 (UTC)
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
 <175561800552.3596927.1716430244831277486.git-patchwork-summary@kernel.org>
Date: Tue, 19 Aug 2025 15:40:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: SPISG: Use devm_kcalloc() in aml_spisg_clk_init()
  Submitter: Qianfeng Rong <rongqianfeng@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=992845
  Lore link: https://lore.kernel.org/r/20250819040239.434863-1-rongqianfeng@vivo.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



