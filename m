Return-Path: <linux-spi+bounces-6089-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0039F4FA8
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 16:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3CD188BFA3
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 15:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C238F1F4E4A;
	Tue, 17 Dec 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaK4xjp7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8941F4705
	for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450012; cv=none; b=qmQ4wr6HgyVkqdE/3IBs5yzEl/+BgJrMsF1Lxx0WrKLwZGgw64MwGqyz+cvIp6tUNoWkmOZAYOIwXHBnXECXvGTL4wDhyNY6MJlbykn3irEiZqEuvxKys5E1Dn39wzlGAYtR1KwaTGMH+T/X9WKXOfkeJSF40nRnX+1JOFyBttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450012; c=relaxed/simple;
	bh=7hs36jmixk7Mtx2Rkn5p8lFNiX3NCmEJtzKpHLfBwnw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uWPpVwZNEcJkc9IKRPbGgyVlWuQRY/uJfjSMPRi1BTpAgwfLhA/0CJuaLFztiB5/xO/wnUB3XemS3lWAxWfJo7doF+0KNtfCqVANXZogO5YqSpQ3eTwrTz6bniLfz8APgkCSdZ39XyquIMJIgIbJT/KAwEEPd4UXgpxcFt+T2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaK4xjp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E03C4CED3;
	Tue, 17 Dec 2024 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734450012;
	bh=7hs36jmixk7Mtx2Rkn5p8lFNiX3NCmEJtzKpHLfBwnw=;
	h=Subject:From:Date:To:From;
	b=AaK4xjp7vf932xsIL3krEIrgvpkUILEdEgchdlKZzq5eb7IRgHjdTAizlbX92DMhF
	 UDMq1i+ooOJEEery1//TcZV4X5vtfGuhseZCpTMv6oLKBV5RPtqDDOJ6VXJ01Scjx2
	 r5sSEHNhYl6/1G5uEl1w9aDo+qkfebHayA4yJplF9wGto3PRZDPBiZZ8GUPj5WvVeI
	 AHfvDy4Tq+ds2wBEDBIyIdIM6UcjwbMEKOBAetipiu1n9XYut/6REfeNvi2R4Dd4H+
	 GgiFbrJODfQ9SYqpcXfSCo36aERiwVPd8kiLNbOrmJgCN5ilA6hMVVxfDqXmOCdpz0
	 jCpMCgbQp2AxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 750583806656;
	Tue, 17 Dec 2024 15:40:30 +0000 (UTC)
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
 <173445002904.940256.4395765637482335971.git-patchwork-summary@kernel.org>
Date: Tue, 17 Dec 2024 15:40:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spidev: Align ordering of spidev_spi_ids[] and spidev_dt_ids[]
  Submitter: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=918647
  Lore link: https://lore.kernel.org/r/20241217114226.1223724-2-u.kleine-koenig@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



