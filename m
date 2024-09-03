Return-Path: <linux-spi+bounces-4548-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204EC96A513
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 19:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536911C23D80
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6E18DF98;
	Tue,  3 Sep 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcACAXWC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CC18BC1C
	for <linux-spi@vger.kernel.org>; Tue,  3 Sep 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383432; cv=none; b=OPnCbs6MJDmEuLMPPcHuAniFEiNR8hhJXMZbxb6R9pW4R96W3BdFYyFMFegoAwPCH4656cglEV8i9/Un667oufLDOLOHjrsPrESQ9rBt/UkRIMRl8LqErtSOOT4d/v77jrcWfYbXlXBhJGNnsroilQLQ04ANipBf9lawiEuW9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383432; c=relaxed/simple;
	bh=WfGPWy6LTQMKupXn2xr1r02SjIoAZyN9oEa37I/6WJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RKMiYkp1WIAo5UfDqFl/ohr9ALc12Utyl8t5slf2EdZBn+kv2Q/LS3WY6xCYS4cYyXX/7Ae+8geoboseVLUFOoT0dmd367vqsGa0u1aBG3K3eLt8uSrx74Xoi8FnbxnXAju+1x1TjQzWD5KHFrHUaYbi9oCQm9hm7oZbkACJyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcACAXWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CF8C4CEC4;
	Tue,  3 Sep 2024 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725383431;
	bh=WfGPWy6LTQMKupXn2xr1r02SjIoAZyN9oEa37I/6WJE=;
	h=Subject:From:Date:To:From;
	b=lcACAXWCX6kV7PygS8u959TY8caTiOo+EYMy3R3HDvMIIO7lkQnBgKGrpeuxVaJhF
	 r3NtaHkFLK+1NLomd2upqUZCKMNM6IlhoFqtaiuvH83O2tZyu3TJ3FiQ2QlK6IXwCi
	 XVi7dVwnJMVeHcCo0mCI1Q2282EglPJrABzelpGnNGJ3/nHGCL7auY8/BOdKLFDJOP
	 Zo1vgcfyiaqhJdE+RmBCcRWlShCPs/nfdBfsvHlvm2zwfwFAPRw6HSu7tB+jsq9BQB
	 xZMdEm+tLIRZSUSH1oOhVS6EJuwpeqseoZKN1FZYI9rFY1SJ4Of5KgWDpHgRJTTJUM
	 lWKx0+DEFruww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5E663822D69;
	Tue,  3 Sep 2024 17:10:32 +0000 (UTC)
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
 <172538343123.376917.14068609795734214901.git-patchwork-summary@kernel.org>
Date: Tue, 03 Sep 2024 17:10:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spidev: Add missing spi_device_id for jg10309-01
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=886269
  Lore link: https://lore.kernel.org/r/54bbb9d8a8db7e52d13e266f2d4a9bcd8b42a98a.1725366625.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



