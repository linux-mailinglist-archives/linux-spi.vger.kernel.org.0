Return-Path: <linux-spi+bounces-8629-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC976ADDAF6
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 19:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBC64A10CC
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB1F26FA4F;
	Tue, 17 Jun 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p80xafJG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87E26E71F
	for <linux-spi@vger.kernel.org>; Tue, 17 Jun 2025 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182975; cv=none; b=UlGng/eND39iMXyeyUbhVoVtfAIOEwZRVqG2JBlYZb9EOrpDbGUQqMKS3on6BbailT4W1Z6HFzFymL7lXiS0+g0pwpkXEeY2t7a21ZoFm3GT7X6E1/QYjauWwwulgCe5323aSbL5y78zvzfjukgiBEDBQlkLPjRHIc2nH+9HqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182975; c=relaxed/simple;
	bh=x3gK0LPWZQ8KBQIhDTIYhDxSeWTtuVYJVxgKCXgYioc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fuRQAFG59tOoM/yQjsdBKtkm6zdFh7fmxN4LLv13X5BLOV6R41mHaV4P1iFeKyZt8XFxM94ODda37hklYJa7JcAFas4cPrdNYpZAfmFd/DwJqbQAJwSpeefWu9lYQC0PraH88Pos7H+5P/wmzoLvFCHwWrcvLPUoFqcOgEg6sDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p80xafJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7567AC4CEE3;
	Tue, 17 Jun 2025 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750182974;
	bh=x3gK0LPWZQ8KBQIhDTIYhDxSeWTtuVYJVxgKCXgYioc=;
	h=Subject:From:Date:To:From;
	b=p80xafJGQZVJSqP+J93Tw7dAp8T87j5Cmd4693xW3H911GanGFufR7nTgG6G40MUR
	 2RVMhjGpbFHYS3WKkKqGlVzagjWGWRG+23DWHFFA92YmGL20IMYIJ0Ky3NbKMe/8su
	 4L18MlmGrwGa/8/kYjMpxlzLCBwX5aLZkbSEmgNX4u3ytYC2Uk7PKx6uttbafwyWi4
	 vtUIKbqn4UB8nutVfWuGupM5TkqRPs7rTnEMWQvndbxVKQo/nKdHmy0/l/Gnd0bOR5
	 F4qe8iR4RLi35pbBdxaqWk6qkgzZ9BmhT7gBNOTRvd/qqE0xgeFPqRkHwP6eXAR1Yo
	 Hsny7AP8PmllQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CEF39EFFE0;
	Tue, 17 Jun 2025 17:56:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <175018300278.3252503.11244139897663196097.git-patchwork-housekeeping@kernel.org>
Date: Tue, 17 Jun 2025 17:56:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] locking/mutex: Mark devm_mutex_init() as __must_check (2025-06-17T17:08:11)
  Superseding: [v6] locking/mutex: Mark devm_mutex_init() as __must_check (2025-06-09T20:38:39):
    [v6,1/3] spi: spi-nxp-fspi: check return value of devm_mutex_init()
    [v6,2/3] leds: lp8860: Check return value of devm_mutex_init()
    [v6,3/3] locking/mutex: Mark devm_mutex_init() as __must_check


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


