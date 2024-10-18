Return-Path: <linux-spi+bounces-5258-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356389A487F
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 22:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645D21C213BD
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74E18CC18;
	Fri, 18 Oct 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cphwbOEc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F462CA5
	for <linux-spi@vger.kernel.org>; Fri, 18 Oct 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284621; cv=none; b=P8yH5INYXR5M5aFqohAiA2nsMHhqlfXknuuMnjqwfHwKGo4wfjEhmUjJl6WRsnNYFsXAQRPPTJg3rWbdhPSwLI3TwsFzUjYG1OvYrdVr0ooyFDc+lvBvJ7rhtBlI1HHKVE99oE41BeKfG2CniqxSz5HPunaCCfIqxoIoOM292U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284621; c=relaxed/simple;
	bh=IIWVF3+K1jjtYgiSyYB50BBBrq6DV4l9S4UdMerKsIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=foPB464QfNIt8kUnQZazxjDHLDG3oNhsM2FGKkQALr4rGUVsLwO/967jWtJcpN1+aadMO4NRMx3VNwPuVP5l7msGx/8Crr9XdY7nIjrUuqfRDU6ids1oSjrc330TLJO+mKiEezREov8R0l8fGlCkDYdPKvsLS9XCAsAJzrR+57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cphwbOEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E9AC4CEC3;
	Fri, 18 Oct 2024 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284621;
	bh=IIWVF3+K1jjtYgiSyYB50BBBrq6DV4l9S4UdMerKsIk=;
	h=Subject:From:Date:To:From;
	b=cphwbOEc7u5tcuN9BG/dBCTKxd6eEvhfU33FMRhPH1I4ORDkVihWyAC0HuOwU1oJc
	 xFfjalCbBTpqavf6nKfjxxFLyDdRyGNG6BKOaFMRVsCV/I9Pi/KvB47/XYgX85zPgM
	 nch7rfw/VgzFtaoIUOtj1Mc0PluSnyMD0qI/S7R3jkZRYGr7MH9lZTdpWZmy8+mkp7
	 69zJjb6jk3nJbk6gog90lf9wN19GWVT7Xy72JAVdQVHn8z8vW3+tww7cvuvmcqMB5/
	 V/0tLCtpdDDRaaXxV4bch34ISYttT9kP8hd8VA0Yp1WEiiHI6RBW9jDj5RY1VoLpWQ
	 qWM+0EMuRoEKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B974C3805CC0;
	Fri, 18 Oct 2024 20:50:27 +0000 (UTC)
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
 <172928462628.3260492.16538068470598119119.git-patchwork-summary@kernel.org>
Date: Fri, 18 Oct 2024 20:50:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: make class structs const
  Submitter: Bartosz Golaszewski <brgl@bgdev.pl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=900702
  Lore link: https://lore.kernel.org/r/20241018122437.64275-1-brgl@bgdev.pl


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



