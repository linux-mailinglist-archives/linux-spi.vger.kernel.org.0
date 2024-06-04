Return-Path: <linux-spi+bounces-3214-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB18FB212
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 14:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7821C21085
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 12:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7F145FF6;
	Tue,  4 Jun 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbeFLy3n"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687DBE7F
	for <linux-spi@vger.kernel.org>; Tue,  4 Jun 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503844; cv=none; b=bKK2MMfeqbRx5F7pPvMRNYuRWTuQjxhFmQP0Nfh2axKFGt+XA0WiHhRJoakGQ1jvy4EEGiqapb6afB3nKqxLiCVR4f8+apLhytbEItDnDvfP1hrADiXjUcs7CZUBQIZVez6VnDhjK4Tm280NuIJaowiyZYaX6+KVlE9nA7YYJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503844; c=relaxed/simple;
	bh=IhG7a4di6FC+xLgXKrXkSDStQzPP1w9v/fiWto6ijSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PwjtOkJ0Z+WikiTYEed38iX/AzmMmziehFePYHhdDewGKpnQo9OjTRnOUKE5UkV4vC1QVGq0WqYrjc3sbiC47Ibwrgjtlqp4U+tABDfGaUgrmUN4xkXoOgkt4dMGuCX5va2RYXvV6tLn6vfgcH5ktpuWMtM0uqVln++GGaVXu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbeFLy3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B44A7C2BBFC;
	Tue,  4 Jun 2024 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717503842;
	bh=IhG7a4di6FC+xLgXKrXkSDStQzPP1w9v/fiWto6ijSc=;
	h=Subject:From:Date:To:From;
	b=fbeFLy3nwgMi5zSc7bOntw4W6JSxpqt+I9Yaas8Mq+IEyCAcd8Vkjd+pgStZ3N0ys
	 rkleMgBEr+PHY/bs2qKt6rOVh1Tiduwv6t8Dau/tiNXO/PbJYq5LXI7T6oLleS83Tm
	 lpeOvU+90ovHTj57guYSU4esnJWZsV8oY6YQovAPj7KCyR7z6Oq7hslH5Gq7QOdvJs
	 thjABX1YReYVyheL/kv3oSPFDgI9I04bkrCr7NUDWxY3IaGK0oJMXwWD2/8OcBg0EV
	 tZ4zxXi+qFWaBhjWUQ8W1Cg2YW8c+ADxqhI4X+q2duATNt+wSAMjmLcmLgibl/fmMo
	 /CK2IxRYajrYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C1C7C43333;
	Tue,  4 Jun 2024 12:24:02 +0000 (UTC)
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
 <171750384256.25580.16582238488723190844.git-patchwork-summary@kernel.org>
Date: Tue, 04 Jun 2024 12:24:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/2] spi: lm70llp: fix links in doc and comments
  Submitter: Kousik Sanagavarapu <five231003@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=836118
  Lore link: https://lore.kernel.org/r/20240318154540.90613-2-five231003@gmail.com
    Patches: [v2,1/2] spi: lm70llp: fix links in doc and comments
             [v2,2/2] hwmon: lm70: fix links in doc and comments


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



