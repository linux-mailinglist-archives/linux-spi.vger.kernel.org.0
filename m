Return-Path: <linux-spi+bounces-7392-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E80A78D7B
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 13:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C22188F75C
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948EF20F07D;
	Wed,  2 Apr 2025 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lITHjBUP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB021EE7A3
	for <linux-spi@vger.kernel.org>; Wed,  2 Apr 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594593; cv=none; b=W9D1i6k0hBmXrmW+vdbXwOthX4DbAZ8Y1lmsC/9NWUEnQMtrGmezb9k5f1MuyhKJ8ysCyYfy9ajXRYZ3EPt6wt/FbhkPSfkDG8dWhKcbZtPXoo6JMLXA0n+UkTMKWHuvRLxae5/NyWVbDHqLAkyxvPfRqSlnp9xbDVZZb3amLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594593; c=relaxed/simple;
	bh=QdwJNhslLWsTYDyrOv7tYn9LdhaoPpXZpOM8xtIEWzo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kckpca+56e7cHXoMAC9VyrCJlwD7/+OYuxxvmgiiHocYK5jgnpRAXnBC60ypCQkMVBuJck3fXaYYj9KTyWuHH/2OSsHQeNLUkOBCRTyZAahK5OjVIc3bxT+hHhZmA2bg21kY0DZoM4SoP+y1hid7lEtoXvIqrn24LD04IawED1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lITHjBUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B03C4CEDD;
	Wed,  2 Apr 2025 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743594592;
	bh=QdwJNhslLWsTYDyrOv7tYn9LdhaoPpXZpOM8xtIEWzo=;
	h=Subject:From:Date:To:From;
	b=lITHjBUPkDC6nKDwhu3YnmM0BF1bHFp4G5vkxbC7H0WAJ8zMYDjTxrN3MA4I4u96g
	 VqQ9Fq8c6pi0dWGebxXJ0gcFgYsoH/A+Ss8R65Gd07U1i1kb7pfhiKWiPHhOX+EaXq
	 obudtGLgqWlE1aXFJlJb5qKrLEHhvhCE8ceLyywx55g0RL9GxdlFO+EtSj3dVeTI7x
	 w+HDhx/N0hSg1rB7CTBU11u5yM3wHaxBgcfTh5JWWoWLy3UBI7ejVqA9ArvG3lmcGv
	 lbTxVaqcWkl6uZUtJnBoB2PQ0LCIMlSl0G5IwY2JTW7rb1mAZ6kdEJfC3C1wELH4pF
	 wpA7OZptWF4Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1B9A380665A;
	Wed,  2 Apr 2025 11:50:30 +0000 (UTC)
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
 <174359462926.1480117.13347168299470022494.git-patchwork-summary@kernel.org>
Date: Wed, 02 Apr 2025 11:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: bcm2835: Do not call gpiod_put() on invalid descriptor
  Submitter: Florian Fainelli <florian.fainelli@broadcom.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=949108
  Lore link: https://lore.kernel.org/r/20250401224238.2854256-1-florian.fainelli@broadcom.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



