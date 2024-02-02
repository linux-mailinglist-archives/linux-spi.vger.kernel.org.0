Return-Path: <linux-spi+bounces-990-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A939184755B
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 17:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DCA1C273B7
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB71487F0;
	Fri,  2 Feb 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tigc1zZk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE061487DB
	for <linux-spi@vger.kernel.org>; Fri,  2 Feb 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892627; cv=none; b=f8gQfqdXh3T1CABLeG1wdedQoA41RRAn+u+1/ZgrNuXwmi8C6mpbuTEE1h8RFD64yXffQAkgLXt5Zr5KINXDoyz4jTTV3F8Vq9Mq3kpdRQpuAef/Drjo7/Bp1+nEhXd7/kX4KT7G/GG8baW4afwevANw7RRyoxYjO2CDZRragx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892627; c=relaxed/simple;
	bh=DSQWUaYeVcj3OHV7RiUIZd0x/OSdYE80eg/sofgSgV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KdAcJeKfSziZf1K8QDmyEBJmBOBHcOuEdXcX02y3wosQRgCSLL4PyDYs1mYB62Crsoo4pcB6YG6Fo4tXBC1Xx9wFc7pBrdunfjJigw9HZ9cTL1xtf8G6yDbGoKp3bFElwlLZeJqeL35If7eJY+xskgPOwSnv8g7X1l1gdFRhO18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tigc1zZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E79DC433C7;
	Fri,  2 Feb 2024 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892627;
	bh=DSQWUaYeVcj3OHV7RiUIZd0x/OSdYE80eg/sofgSgV4=;
	h=Subject:From:Date:To:From;
	b=Tigc1zZkx9t/IKzgcvMGNcfjDAM3Pm+0CF7dM/OEjP18x29hDDzY2LEVEHf7/Nt6t
	 PyuSzQpZ8LLghD1+DCV+zvCC61SiID+87TmhMVmc4AUrwkm+0OSkySLBabrpcJZCAn
	 b5+/oLXseWv3JwkzH9dMq88SFWCPL0V2DdOKewfNlUkFHfbOi8a7U2aS+GtXJkqRfz
	 TjQQl/cXMqY+XGH/xXkW8Elv7xZQg2VkyTvTha/ndBZiPpH//1lNYEBZFYY7YY4BKk
	 M1Zpm//LG+EXQKFFRL5/eSU+nGCfzjiVB7Ck2wSMgl2lezFvg38b1cCUxknjvnypeZ
	 P94A7mDWW+smg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E849C04E32;
	Fri,  2 Feb 2024 16:50:27 +0000 (UTC)
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
 <170689262717.23524.6961366850313781086.git-patchwork-summary@kernel.org>
Date: Fri, 02 Feb 2024 16:50:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: cs42l43: Clean up of firmware node
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=822478
  Lore link: https://lore.kernel.org/r/20240202103430.951598-1-ckeepax@opensource.cirrus.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



