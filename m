Return-Path: <linux-spi+bounces-3524-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5722091230E
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E3A1C2136E
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C5495E5;
	Fri, 21 Jun 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isoiTF3f"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B7171679
	for <linux-spi@vger.kernel.org>; Fri, 21 Jun 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968229; cv=none; b=q+FOl+MSz9eBTd4N7SdyInSHajtzSjHPH0GNas6cQFfz+/KJuuzU9Irwo79UdvbdW9Oao5uyMy0TUy1lkhRSidGph9oRMVWYPm8v9m/xpOpw5+zrXTLCEG2sWx9p/8ybrRp4gJyLhSyBskreXZEbmrf4U45O8xUtFY4EZ7exDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968229; c=relaxed/simple;
	bh=aut7tly8ZlMRbrnG2Va0+81iYopyr4pnpKAGlPD1q+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LFlXioYu6T0ax9LYsdMfXrXsMfCMX0JaPSBV2FnG+EP5gl0dJ29pXsm/YiZB0GE0Lz7mueqqqKUix04cwjBy/uk/qbd0tTEO6XcTQkIDy78mZYP0v/EmXX5rLLoBs9dDIAarVZyN3tfzXqAElir7u42SUowhLOIJczMihJ2RHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isoiTF3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37E8DC2BBFC;
	Fri, 21 Jun 2024 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718968229;
	bh=aut7tly8ZlMRbrnG2Va0+81iYopyr4pnpKAGlPD1q+A=;
	h=Subject:From:Date:To:From;
	b=isoiTF3fUjAg+jtZAedwQZl/qqmdT4vjpnkjL7+q2Kq36i5KIU0GMpFLB/3NOvZ6N
	 M9eZ6i/mTMyVNjuIav4tHfstQ/hIk7hBrbSuiv6RBML3/ILRZq5hhqJKTT/YT0T6Ay
	 wLlPV4KMlZfEiJK+1HTdgk3iipABHudQY3AI9zIcyMlAy/T6Fn/gVeAtKlIIHtn4xC
	 WMYUhxQ2EWYAhDez8Ko5H8xfAYb3rUY2yVlvbIc0C42OSCkU6H57nw6KL51jqQcLc5
	 gDx5s2kL6oDFpCfXP7DjzVaKOUMe7VA3ME4MPsORhJ5SQ2n9vMaa+HEF4bRPXWn3nf
	 2CdFf17n86e4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E20BE7C4C5;
	Fri, 21 Jun 2024 11:10:29 +0000 (UTC)
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
 <171896822906.22393.11089273660408342428.git-patchwork-summary@kernel.org>
Date: Fri, 21 Jun 2024 11:10:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/2] spi: cs42l43: Refactor accessing the SDCA extension properties
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=863426
  Lore link: https://lore.kernel.org/r/20240619121703.3411989-1-ckeepax@opensource.cirrus.com
    Patches: [v2,1/2] spi: cs42l43: Refactor accessing the SDCA extension properties
             [v2,2/2] spi: cs42l43: Add speaker id support to the bridge configuration


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



