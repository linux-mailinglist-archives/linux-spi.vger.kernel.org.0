Return-Path: <linux-spi+bounces-7537-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD4A850CD
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 02:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB4319E4672
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2872356DE;
	Fri, 11 Apr 2025 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOnp/4Sl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F56215162
	for <linux-spi@vger.kernel.org>; Fri, 11 Apr 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333194; cv=none; b=JcIsNmAHt73QKOAwzKC31zHvZK7s5E1FfNsmszscz6wB6YzgAhNIgtb4cXSDYPYfNFbI6EfDq/gXT72G9rsgn0HYW/1oBXnBZLi8wqtgJyLPjBlLkRLLmSABikiQvvWlXmXqC12dLhNEqDfLx3fTqwDrBw/JzloSykNqiVedZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333194; c=relaxed/simple;
	bh=jq2lbyRLEBadDvI/8ZSiFAjgVIZh/Kqn8DW0XgpHelY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KTyw/5vEbmvOjwZcS1p6iF6k+OcvBmUsMmRmmheJlqVSitDrVTH4ccQB1zbijHGL5Z34IX58ajgK7CaSk4WIVaeiUwDtFyXJjs0xxqJcvuduFlk0Du4Xswx8UurfCHR3OZPxjAkwlP2NutZ/5pluW/z2MNoTNrKIEfAeqedYOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOnp/4Sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216D2C4CEDD;
	Fri, 11 Apr 2025 00:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744333193;
	bh=jq2lbyRLEBadDvI/8ZSiFAjgVIZh/Kqn8DW0XgpHelY=;
	h=Subject:From:Date:To:From;
	b=WOnp/4Slcp7/wJ8ZJpU3kfPzd/51cGbmciOH3EWIfvTxXyBmbGOLcv+a//TRbuvmt
	 /P9jRGW3Kn6hBzi/ootuWVEUSZRlSBsJ3b/f1burtkpFb+I9ZFkR5YhSH+Ajdq0XKf
	 u6CnAEhl+ri6+gje0BGxkIC54XFhaQIeQMKbrfy9rHSFRFK0XYy2H79DmZWGgixPlW
	 nvsD+kYuHYjGBRJu8RfEag7VmkiytUmLYuO2Wg6YpBx+65oSQDmXT5HqY/N7YvjQxw
	 g9mS2W0DusYHOkWPgQTvDDbNwxa+V382msp574gaY60qDtTcBkeAjh3Uk6NB+rA89b
	 uLCa59qfKxQeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B28E0380CEF4;
	Fri, 11 Apr 2025 01:00:31 +0000 (UTC)
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
 <174433323033.3879897.5675743791062427751.git-patchwork-summary@kernel.org>
Date: Fri, 11 Apr 2025 01:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: amd: add CONFIG_PCI dependency
  Submitter: Arnd Bergmann <arnd@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=952064
  Lore link: https://lore.kernel.org/r/20250410140809.812863-1-arnd@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



