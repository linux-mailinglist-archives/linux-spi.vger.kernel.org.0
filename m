Return-Path: <linux-spi+bounces-10685-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A70BE08B2
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 21:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B78E3508454
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97507305042;
	Wed, 15 Oct 2025 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+vDSlhq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137330276F
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557821; cv=none; b=YmzMZn+CjisLOpVzNJuRs/awfuKCOlrO93NM4uadTNsxBEF6hI5s58cncniok4BU+5C4x/oYZOJ6zdPD7QxShTLfilP9bxkMWiJPga6NEj1RUM1Y7PRQDf6VSt99SZJVuMP3WknV3RVPsN5bfNOeUTpZu1Su+78B0G2AVs8ZYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557821; c=relaxed/simple;
	bh=Bv5KzdKqSqnt4jMwus12xrmKK0cxkMdGie9ckUMPD6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=j45JZZFHQK7ZhuJzTIAsx6R99jppb29I205hqPyokaNcozF2fb25Aui4uz6zxx+eUyu8rirD+ObPR6HK86Zf9l0PxCgnPtDLntIoN0nYtPcubBtpMHCWyt1pA7aoNYvLGgz1sLtYr9qa3PwuaH+OzgrRTpkxWid9yV8rN0LelF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+vDSlhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF17C4CEF8;
	Wed, 15 Oct 2025 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760557821;
	bh=Bv5KzdKqSqnt4jMwus12xrmKK0cxkMdGie9ckUMPD6w=;
	h=Subject:From:Date:To:From;
	b=H+vDSlhqmAjZR2kCXVFZVuKZBer/y+nnglxWKrQ8qoYRJGI8LjEFplGCj1lirFOdc
	 PdBNvEzdMt4NZXnGoFTrlJldVprsMapLXDAfgxQCho3hEYqlVjr/An57dDKJlMTkuj
	 t1RtuyEne9Iq34HogRny8RBBI7Ca324OhY7NFAa5ct2MEg63IXPOOY0vL8MkMRl2h+
	 vChm3qAi51cMmIq1oEFO1YmYWbul5eqdJtIB0DCyy97yAeH2SHJQ1SXHWw9fdg/fIc
	 lNkmpt/KqJt7NDi+a0IEFXifUrANx1963XeK2h3umJVQZWHH5reg7aG6gS9P1JHXYQ
	 8VFxC0tMb5CPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1BDE380DBDD;
	Wed, 15 Oct 2025 19:50:06 +0000 (UTC)
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
 <176055780555.1026937.17497148625218623979.git-patchwork-summary@kernel.org>
Date: Wed, 15 Oct 2025 19:50:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-nxp-fspi: few fix for flexspi
  Submitter: Haibo Chen <haibo.chen@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1004799
  Lore link: https://lore.kernel.org/r/20250922-fspi-fix-v1-0-ff4315359d31@nxp.com
    Patches: [1/3] spi: spi-nxp-fspi: re-config the clock rate when operation require new clock rate
             [2/3] spi: spi-nxp-fspi: add extra delay after dll locked
             [3/3] spi: spi-nxp-fspi: limit the clock rate for different sample clock source selection


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



