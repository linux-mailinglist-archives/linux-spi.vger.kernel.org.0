Return-Path: <linux-spi+bounces-5652-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF649C119E
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 23:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1914D1C225DC
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C97218958;
	Thu,  7 Nov 2024 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQmBegm7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA98218306;
	Thu,  7 Nov 2024 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018125; cv=none; b=DgZB6ZZHMnlfNre6QtyIPM9U04S9AoTd3tqQujPrsWazw1snAtCxD3ImYKbV8VdtLgaQq98aWOgFl0Nevjwx7TI0u+pOBUf2PCK8nmujLINbLS2x7EvBQr3S2ZmU4Vij4M4xuLl0oM5iv0UEw9aq0jyVcKBT1Mt1G7YJY3do6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018125; c=relaxed/simple;
	bh=PdtO2MEIQYQ4ZG0wpFxfLGfh0uY9i61SU4NbtWCocAY=;
	h=Message-ID:From:To:Cc:Subject:Date; b=HnjLJJdu6FgV1n8BrnF2QV6MNMLn+/9kbEEJkqrSNT3mNIZk49H5CsmnP0TOzD8OFDrih1GE5uve5DsfLlSpkw1IvEX3cxVsu4IVogweoMwIfURKFJc5F1vkkF8N2p4xPMp301yAODBaL6KmOjiZdV7R3Ujsy6jEz1S/sXWezQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQmBegm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEB3C4CECC;
	Thu,  7 Nov 2024 22:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731018125;
	bh=PdtO2MEIQYQ4ZG0wpFxfLGfh0uY9i61SU4NbtWCocAY=;
	h=From:To:Cc:Subject:Date:From;
	b=nQmBegm7nn3evR4PdKoCop5TkH/d+6oznYh6MDq7dgMnITCZPqlvXunriBUyryyQU
	 JL1PiaEOVMpgyR6yN51Ahwe0M68m12YNR997qafKvmXxa9Pu5q+7S0WKXekcjQXdr9
	 M6yaURaogC1B6rehV0yXMcAiB3U+xr0PDYuH8b9dHqyKPB2eb1NB8kwzuYkbjAI4Zj
	 yAwNDBX/Vl+ouwr7mmNxMLBegpHpiyGxx+GQCfJWlhTlUsEtsylNNowrO0gQFoPp6v
	 bx0219UnT34XPRPzIb6hLLm3iQ1TaQxFQV88JW+ZQDccvvdi9EHSxaGNbxFUZ5whci
	 cLlaWc0+qI7GA==
Message-ID: <b4e4042a741922cda75f4ee1b55234f9.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.12-rc6
Date: Thu, 07 Nov 2024 22:21:57 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 25f00a13dccf8e45441265768de46c8bf58e08f6:

  spi: spi-fsl-dspi: Fix crash when not using GPIO chip select (2024-10-23 22:37:54 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-rc6

for you to fetch changes up to ebdcba2126a817da4efc085c9d4dce0c51942eba:

  MAINTAINERS: update AMD SPI maintainer (2024-11-04 14:07:09 +0000)

----------------------------------------------------------------
spi: MAINTAINERS update for v6.12

An update for the maintainers of the AMD driver following some job
changes there.

----------------------------------------------------------------
Raju Rangoju (1):
      MAINTAINERS: update AMD SPI maintainer

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

