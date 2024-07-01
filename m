Return-Path: <linux-spi+bounces-3709-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD191E1E6
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A507286EDA
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53A15FD15;
	Mon,  1 Jul 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDemwOCT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60943144
	for <linux-spi@vger.kernel.org>; Mon,  1 Jul 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843029; cv=none; b=OMH9vOpj0/l1gl9vkdQ+rFCYHa57XmZMADGNKQL9LKy9Qh3N/ek4btq++ie2atcHIMR8woJibIHPTIlVOM1WOqd07wQLDKOCsK7TCwlhzRF9XFwq8eayZN1dIcA3RA0AK01sC/fQf1eiqa6hpJhvZDswMhGDojI7+f9eoImyyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843029; c=relaxed/simple;
	bh=Nn5CtJXc+cB1ugZ9iNfQ2t/+/4qsbkdIl1T5NVcizAA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pFSz7ipznJH0ers9oyHZo7PCg8EnumZ4pUUddZhn6ehuVnnuQp/Bo9Q3PIM8fOQZaqkq8ryXKeq0xoLvcUWqMrHGbrJz6MM/Fs+8nJnt1U9GAhUfzPrmmn8RZanaLxbvCGmjN6wNlyc+Vly2EdtOjcSq44s4thaatKPat+d5yzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDemwOCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E92DC116B1;
	Mon,  1 Jul 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843029;
	bh=Nn5CtJXc+cB1ugZ9iNfQ2t/+/4qsbkdIl1T5NVcizAA=;
	h=Subject:From:Date:To:From;
	b=fDemwOCTxi9sMdSIkP0hd4mA/tPV0TGda79LuGYCnIw/vvj5EdScOWgBsOcLy1fZF
	 bkIklvZBHrPBbpKCwxxwF0NcxAKUlV4/togq0M32+3nnr8bf0Xi5PVYiplvdTm+J+K
	 X/xqM3R3qDIhs6DoKXyDOW38cBDy2Az+frHfXdjryV71g/Y7++Ri7FOF66VbWwja6t
	 PTqrdV55yptmQsTMW1RKvNXaowZMJwPgzyRLC2JcbH3fNKmozpYFwc8SnwFGu5HQzv
	 pW8vEauNpBHHQRkuYz0hHN6ZduBJwKj5bKFEPbbhs/3bqzyLXPPD1WNGf1jkvjOq72
	 nsaux1bJREwZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E39AC43446;
	Mon,  1 Jul 2024 14:10:29 +0000 (UTC)
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
 <171984302938.20385.10761891045159476270.git-patchwork-summary@kernel.org>
Date: Mon, 01 Jul 2024 14:10:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: davinci: Unset POWERDOWN bit when releasing resources
  Submitter: Bastien Curutchet <bastien.curutchet@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=864766
  Lore link: https://lore.kernel.org/r/20240624071745.17409-1-bastien.curutchet@bootlin.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



