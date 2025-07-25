Return-Path: <linux-spi+bounces-9191-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F6B12779
	for <lists+linux-spi@lfdr.de>; Sat, 26 Jul 2025 01:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469FA3AFEC6
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 23:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A125F97E;
	Fri, 25 Jul 2025 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2cpmFgz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD19257AF9
	for <linux-spi@vger.kernel.org>; Fri, 25 Jul 2025 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753486187; cv=none; b=d3rEhbyi5eplWlzQGuCNwm/brFTGP5EMFHUR3tI5VXdUJj6JwLaPiSU0I6GNiI9mdvohcK18+ZO0hPNBhWNoy66+YJxU22F8je8m2iY88hUt5EUZvaJh1bpDXfxWm39xuzbnr+VoIK2XHSPHCO2M+pujepPhTQpP27XLTlMd7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753486187; c=relaxed/simple;
	bh=xvnZQfkzw0O06ydxIMmoMYPesJcpz2xuow87DVde1WU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=l+i8YY1LljkGlWr23q30T3YkZzEeuO4jq1zkCivOzTqC9/zMtg/FfQIFt+gUMrcIK5Ff2ZOEmNn9ghuFRZCfGf9uqSHnHRn1ArIii+Y4uQ9pkd3wB7JOqbu/589vrsEei04qrgd2AAZCU3Pd0cAB/4JtWB7GYfeVxHogwvO0+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2cpmFgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2BBC4CEE7;
	Fri, 25 Jul 2025 23:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753486187;
	bh=xvnZQfkzw0O06ydxIMmoMYPesJcpz2xuow87DVde1WU=;
	h=Subject:From:Date:To:From;
	b=R2cpmFgzQRcJTtn0tSaJKfhoN3ME3xZh2p8VDjLfvEULydfLBCARR2OC7tf7R/PFd
	 Dsz1vbOS54Z+9N1EZkAKXAhE8ez0vgv01urOSQHPoIMXh/kjwzsfuWBZQM4m+TJOMu
	 HfYsutUFpYLjq0ZBKC43KXNSjmSsHyXcyNxJf7rwTOUiDEDz7bo1E4Uae0VcFJWYG5
	 lm3hHqLV4VgYTFZbdEQWWq0SYUk60xKOhAXhTMQC9MjXf5tYiZNtuEsxlbzjOF4/zS
	 GSvF1gQQ2AgXtbdt6ga3GdjSIFO2vbKH5P7tR2XHSdNaG2I6xJCybAdowvH8wc1elc
	 dw1jfkQx0igIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1335383BF4E;
	Fri, 25 Jul 2025 23:30:05 +0000 (UTC)
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
 <175348620422.3444832.6352646340921263187.git-patchwork-summary@kernel.org>
Date: Fri, 25 Jul 2025 23:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: SPISG: Fix less than zero comparison on a u32 variable
  Submitter: Colin Ian King <colin.i.king@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=986012
  Lore link: https://lore.kernel.org/r/20250725171701.839927-1-colin.i.king@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



