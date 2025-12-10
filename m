Return-Path: <linux-spi+bounces-11848-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFEACB2C04
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 12:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 709B83019BD3
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C502E92BC;
	Wed, 10 Dec 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0ECUMUG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E42D9ED1
	for <linux-spi@vger.kernel.org>; Wed, 10 Dec 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364401; cv=none; b=irNOeFSWiWxjLooGfs5RYjw2BRrRXpTovJ5se/kTLQotGOfNbiqqhjgAE8fejXCHKmWbpaRTCiEES19hhq1mTZv3w2o3/jvOjLiqe2BgqPTjTV3sQmtF68bmr3m+SiPri7bymdxOXOxJj1e/X3obnnHCX+VS+5Z2lGVC3XI3cQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364401; c=relaxed/simple;
	bh=sRFBRAhwOgHs8Uwv51R9WMye2Y1di0mfDnMjd6D0Vh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lhkKYwJS5YlVj2iupZDmnbJU+UzAezZ/so4dbptzrkgZVhEDfNcC7mC6+92gw+w0D7iuVXw8T77GeMpM/nfA7Br+5p1r/IeQQcX1b4qxNUdlx3ot5jG+fxR8b2H4MUboUzEeNcmJsGxHt3pHhIh8aL1a1BEJTgmofps6uo/pG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0ECUMUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C072C4CEF1;
	Wed, 10 Dec 2025 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765364401;
	bh=sRFBRAhwOgHs8Uwv51R9WMye2Y1di0mfDnMjd6D0Vh8=;
	h=Subject:From:Date:To:From;
	b=t0ECUMUGpkjQc08gvI/Yuhb5+ZezW0dILknSmdR9SzCtPKoAsXzNgbPS1N0edT6CN
	 lPv8brE129LVs3P82g5N0a/gvLZxhUGTLVi/PscFvL+UzB+5a6jZCVBQSAgqh/94e/
	 K3+3sXGZkeWcl0QkCifOINZNHkK16BP3NVlgFR16lP5GlhOVACmBT2/1KGSq60SiG4
	 X3gNnbQhE/zPgcfWpr9J+UWuV9fmVquaiXwxEosCJPNNbnAKHo90aOt84GhopsanIV
	 p/YiMJUzMMbmFP0Pi/UNB3Bv6bTYcOsDnbs76IjZ+3D2UePEbT8FGATM51fCIMpX/6
	 eOZZh0+Rr1Q5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79EF63809A1A;
	Wed, 10 Dec 2025 10:56:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176536421503.551958.17034272735857652560.git-patchwork-housekeeping@kernel.org>
Date: Wed, 10 Dec 2025 10:56:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: spi-fsl-lpspi: convert min_t() to simple min() (2025-12-10T10:50:01)
  Superseding: [v2] spi: spi-fsl-lpspi: convert min_t() to simple min() (2025-12-10T07:41:15):
    [v2] spi: spi-fsl-lpspi: convert min_t() to simple min()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


