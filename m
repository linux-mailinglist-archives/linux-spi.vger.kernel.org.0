Return-Path: <linux-spi+bounces-3519-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA99112C7
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 22:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BC31C209DD
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 20:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0C31B47D7;
	Thu, 20 Jun 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRi9OkkP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F2171A5
	for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914231; cv=none; b=jsrVNaT5ZDC7wGGqmUAaSYCl6Xlhel3sDjtkUqWLVWYhvTtQHpJ+i0qKEgd9ynjCE/xeLRtYujPmJJfE8nMfoKNrsgUdm59a4GImgx+ANBltwTHBOxu5LEwlqy69/3iwDShJgnPSgJawv8akpUyHkeQwR4zgxfCprA4Lqbt2aF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914231; c=relaxed/simple;
	bh=xM1QJifOBajnI9X/3axqnByvaq12z9KPBhcKo3w0Unw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jUoF2aH+h2DHwKo5zRuhmECa45fftgngU06fJxBYvkHrMg7ZH20RYwo/UzV4V2muPqfJJaak6c5jTh+HP3o+1NX1uQjyrQaruuGOPjTWg1CZZHxDg7CBEKf/26W2eDuAwi9kJhLrYZAi38spsBnPDvEzWNtjeOuexWy5Rqk7n48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRi9OkkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA4EBC2BD10;
	Thu, 20 Jun 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718914230;
	bh=xM1QJifOBajnI9X/3axqnByvaq12z9KPBhcKo3w0Unw=;
	h=Subject:From:Date:To:From;
	b=MRi9OkkPDzlm50aid7o9E0OnZJ/lsKklCkYccagJSGPR+5sE/FP/xCd87c/0NFnU1
	 jFBa2sd15JBzc0FsFoqFlZDy/DN2KQCXwitaz0AYseGJgTKumIru+fVv6rkgknmuia
	 cswawiACH6amF7iQPJMvAoW8gsLxy1RUf/Lh7E+KxzIf94t3MocGKLIOi1Vf2qQ+O4
	 c+otCjZEKGhh2uCbi5daMUeMivP2iuX40SWAPAjWjAaKmCdZXMYSnHyyVyYNXqA1m4
	 qnnVKcYCpmsQfkDsMS8z8sNl76LvC4vjNGSiol/bEKxg6FDYWXPB3/CKCYgy3lmtlO
	 wzbQyYfLZuzFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2749CF3B97;
	Thu, 20 Jun 2024 20:10:30 +0000 (UTC)
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
 <171891423071.14354.9087755907911611019.git-patchwork-summary@kernel.org>
Date: Thu, 20 Jun 2024 20:10:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] spi: spi-cadence: Enable spi refclk in slave mode
  Submitter: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=862658
  Lore link: https://lore.kernel.org/r/20240617153837.29861-1-amit.kumar-mahapatra@amd.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



