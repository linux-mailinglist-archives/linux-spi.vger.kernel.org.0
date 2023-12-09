Return-Path: <linux-spi+bounces-191-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD180B5C8
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 19:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38766B209C9
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF1618E04;
	Sat,  9 Dec 2023 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg5oYApT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7011804D
	for <linux-spi@vger.kernel.org>; Sat,  9 Dec 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FD94C433C7;
	Sat,  9 Dec 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702144824;
	bh=rGlkDDD+phBc6CqISb9Qkwilj7wQZLzW1nqgoBX0DeA=;
	h=Subject:From:Date:To:From;
	b=Hg5oYApTcNN7qPvsW6zN1bFinwMly7Azs40L6QMK77r2JMvHfHf9ftJ/32s4Q3DU1
	 y8dwJzu6BDcjFhD0XJsrZy+wi83jX/hUDWp6NkvdAJr65YIQchO5D+yi7xeZU5mFsW
	 mF2NXWTvWHbt92UVtIxLlMElvz8EHR43ya/68eH7n9ERYlGAO9fWY1kcunBFJ8PsI3
	 zSbLmWkMHn38uKyzTnANn5OmFfzcMZsEMIXtCZuwZmFfbTyolZ5TZlTSn4gghdfWJ/
	 UzEsQ4rzVtgDA9fkk6sPKS0USqnkPW4FOLJyJRflsyFwK6OIFGVKg3Z9KOj+hBxQtE
	 r+GhkKnSYIrmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C842C04DD9;
	Sat,  9 Dec 2023 18:00:24 +0000 (UTC)
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
 <170214482397.31389.7755791671139897196.git-patchwork-summary@kernel.org>
Date: Sat, 09 Dec 2023 18:00:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: pxa2xx: Update documentation
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=808328
  Lore link: https://lore.kernel.org/r/20231208170436.3309648-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,1/2] spi: pxa2xx: Use inclusive language
             [v2,2/2] spi: pxa2xx: Update DMA mapping and using logic in the documentation


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



