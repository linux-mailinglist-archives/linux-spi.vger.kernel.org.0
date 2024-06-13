Return-Path: <linux-spi+bounces-3394-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5019067C2
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 10:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9391C228F0
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9D13D53E;
	Thu, 13 Jun 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsdFiIvv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2113E038
	for <linux-spi@vger.kernel.org>; Thu, 13 Jun 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268629; cv=none; b=SQGPY23VMks5IFRzYQ7Rb3HSpuIYXKt4M5CUXUrlKpQqpzwvp5dgzyOYDi4Zpl/uK14iX/W1ygBF61GtPWrnml3KLKrwdAT3i6pIcdQ53BuSo7S8N117TN9i8nn84cDpQjNSsS21Qv71+v0Zu9V5nQsaWUntsoVT0UzjoJH69hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268629; c=relaxed/simple;
	bh=BkaVg3YH4KwIaGxoC3hzxPsiCUpqJ2TmVgRFn2cDnFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sTIgZ46TonF1g22smZ366GmN0rtqMYnEm7cDg9sAXRhrg8HUrCtKCHzCPlPIagVVzFl+XGV+cePapDw9+gxAy2rp9hxp079B2Dlxr1Qch496udWKGfC8SbANj4tT57O1ST3DSIESF2RNCiKjf0MVFgg0vTg8w6FrzKq0/B7TVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsdFiIvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6656EC2BBFC;
	Thu, 13 Jun 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718268629;
	bh=BkaVg3YH4KwIaGxoC3hzxPsiCUpqJ2TmVgRFn2cDnFs=;
	h=Subject:From:Date:To:From;
	b=HsdFiIvvmMFoixierCiNd5Y/au27uMa1zw4/MCL8W99ti2LM842tfD4IrpN2xRhyB
	 mlMLklqztRXC0K8dWupq9fLLHFH6uvuZGZSbCjqcpvsr/mHfwEx8hMbCYM/FyuobRo
	 Gn2B/G4Efzn3bwQF8mX18OpQL3aFBof63zEG85CLNQimPOXfqyW3RzA9Hf/XTxjnpc
	 MI3w3GFqibx7Hhjb9XDbcZNfpYfNBtYAazpFfmCgU0k6eCGWCvVJKu/KIrN2EE5q5m
	 HMKNI9GpgNKR1EV+y22dxaZn4PQjOlOy0jIyiMi0EpOA7aN8cm9P7n8h2gL7aAVlfy
	 vXjAxiHz6x6SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EDADC43612;
	Thu, 13 Jun 2024 08:50:29 +0000 (UTC)
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
 <171826862920.8281.11784930023099814352.git-patchwork-summary@kernel.org>
Date: Thu, 13 Jun 2024 08:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: meson-spicc: add spicc loopback mode
  Submitter: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=861116
  Lore link: https://lore.kernel.org/r/20240612-spi_lbc-v1-1-d52e8c8011bd@amlogic.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



