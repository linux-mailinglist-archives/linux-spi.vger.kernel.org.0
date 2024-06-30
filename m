Return-Path: <linux-spi+bounces-3690-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D991D037
	for <lists+linux-spi@lfdr.de>; Sun, 30 Jun 2024 08:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD201C20ADA
	for <lists+linux-spi@lfdr.de>; Sun, 30 Jun 2024 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38472837B;
	Sun, 30 Jun 2024 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t101y2lA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF943F9D2
	for <linux-spi@vger.kernel.org>; Sun, 30 Jun 2024 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719730596; cv=none; b=F5gHc84eXdvaIXM7wJ/dv9H8OdnO/u1SldEKc6/A218TN/BETrX2NG99FGlsRA7vqLwn9jq1scFI7/JbfwG2wZRp83hXcD4/eqUbcQV9XERWsniSxnI0OckfD6C1TjwC10pbWA7Y+h4QpdKmC1tNVV69trfwG/x4J6WC07t6SKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719730596; c=relaxed/simple;
	bh=mm7lFu2/HaeLOHbcKLj6shEHg2A/Y4+ouag9kXo7YdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mm+MSMW0CpNccl4jwY35Jx6gRfSQNt/7pB3BPFfCpYDLNp5W0QdHCLwFXYFqhsn27wn3oF2Z5JvHL5/RYt5lA0iOnpyyugC8U/R7ygBf5iWrEPyVZ4bNvSuQzDdoh7KKtMu+KL+TWkpfZoeZtz9mIkplMS2PwGdYofbNTvM//mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t101y2lA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1095DC2BD10;
	Sun, 30 Jun 2024 06:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719730596;
	bh=mm7lFu2/HaeLOHbcKLj6shEHg2A/Y4+ouag9kXo7YdE=;
	h=Subject:From:Date:To:From;
	b=t101y2lA5Dg8BUGTStMVlEOqfNoCz7SXlAn8vFBcLwWiH+zUw3R/kcB+ODVR+bFWN
	 LBbALYk/XKvnutUFlty+20Pt1F3ZbfQIYXQHBQfeWagzY6G9EkyYnlByuFEXsdp1J/
	 FwNMPWehne7d5C/RrqTMTqaUjaJf2xCUYsUbycXMb173hiJSJFbbcYSdzTFd5IhkmX
	 VlqNXiD8hX3yVeSmlNiXTCfW7TpAlmxrjAtmnmSFpwqAshZ7x9a4mwYg8UbJWD6WYV
	 6KIc+imvZlXaUCeWfu8+qrqpEKKbGRAUzZBfmDw9+/Oh4T1sz647w6jfCqs1JROrM/
	 RwUdf47P5WdFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0F38C433A2;
	Sun, 30 Jun 2024 06:56:35 +0000 (UTC)
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
 <171973059598.4820.13933426593014111719.git-patchwork-housekeeping@kernel.org>
Date: Sun, 30 Jun 2024 06:56:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] arch: riscv: thead: implement basic spi (2024-06-30T06:38:20)
  Superseding: [v1] arch: riscv: thead: implement basic spi (2024-06-30T06:35:41):
    [1/2] arch: riscv: thead: implement basic spi


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


