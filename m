Return-Path: <linux-spi+bounces-3358-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04463900B21
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 19:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970CF1F24F95
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1B1974E3;
	Fri,  7 Jun 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAbF/NWE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342816D338
	for <linux-spi@vger.kernel.org>; Fri,  7 Jun 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717780831; cv=none; b=JN8qz1g+VdhmdXCmXnW9fi81O9ahv0WETtyYSVgXUNzhUeZ5fkUfdf35kJ1dN0WhhwafrWaTegHmx/1SYaNTYELDOZYkXI0zEdSQGHsdPzmroDslHeyq6x7HFHfL30+xbFR8BZVKnl0IbNuD6tFCW1Dts9LuWSdp0/7gfd6WJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717780831; c=relaxed/simple;
	bh=pUN1WzW+s/bheAqAW0xn/Bkdkg0Ts/Z0xV0YXG8I+Sc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pcgDlsGFroqINqFYszQSxsFzYVtd6CQKTKqfmKPX7TC9wBFTVV3iUuh6ojKekaRXo+zYv61YUIaMNQpUVp8RUYEWKS+3aJ6qBYptMeiZOBvk4jejboIJf27oFW+ZFCBr5ZhgWo+9hWOEJhibGXHhtRucVft/Yjje1iXwNuZ7jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAbF/NWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B801C2BBFC;
	Fri,  7 Jun 2024 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717780831;
	bh=pUN1WzW+s/bheAqAW0xn/Bkdkg0Ts/Z0xV0YXG8I+Sc=;
	h=Subject:From:Date:To:From;
	b=SAbF/NWEuMZNMNX8GAVPz2TlkbFYfxwxpS3YbLDtbMDcZAFry9fgb75ViVPiRm045
	 emQ1Ho6tAbmzrs4JhdtJifqOY8jEh+yb4hP0F/ss3okQQoveD719eBKbeCBj4p7GqT
	 OokukgJz6E+KWYv+XflrDVdKO19/WC98bkVzCK66SJM96nUo8daaf37v9iGOn43Di9
	 iiSgFG+cR5EQt+sY+Sf3T2xnQ+i4VtikbSiYrck7cJcadzZYk98sXgtu9K3XL4v794
	 J+iY+LMri54rg/S8xcoispji07bqGCaoxcvVCpTQLbrESvAiRR5U0BK8/skbkoIqYo
	 hyatea2o+7B1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0714C43168;
	Fri,  7 Jun 2024 17:20:30 +0000 (UTC)
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
 <171778083084.11224.11587823330825300156.git-patchwork-summary@kernel.org>
Date: Fri, 07 Jun 2024 17:20:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=859891
  Lore link: https://lore.kernel.org/r/20240607103423.4159834-1-ckeepax@opensource.cirrus.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



