Return-Path: <linux-spi+bounces-10234-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6D5B94FFF
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 10:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2505189CB23
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42873128CD;
	Tue, 23 Sep 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxwIn3vV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8012C78F58
	for <linux-spi@vger.kernel.org>; Tue, 23 Sep 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616211; cv=none; b=HZXmr6Q0IbMVCqs1x2FOyFbai70NXQ15Zo1FdEsxllZTI9UYsqgVsponB5peBHf/Zrr7D9EJ+ulydwXOG8tgHEjUsgpgNAjqejAff27Xf1JCf9VwgVTbxN7Pjayu42yaGf/yyJNeFRCrBlmem28FhrE3HhSntzrVaJOny0Tj0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616211; c=relaxed/simple;
	bh=tdkOKIthABV+1stqP4tlhnF2Q0EbeASCuOPBGA4HZB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UsBuHOnufbbmfDpk6LEiV3GNnb6IjMipP58GerjubeVjGBoGQ5jSUfrM8WZVDbH5GASb8qrGn98nNgrfzpA+V0PzRjWpblNP+1buGrcPP4RB5br/1NJ7Y5EHZpo0u3d2uK7aNok2El3JmC/dqbNGhKIkE3vl3DiRpvqf+raOg4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxwIn3vV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29011C4CEF5;
	Tue, 23 Sep 2025 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758616211;
	bh=tdkOKIthABV+1stqP4tlhnF2Q0EbeASCuOPBGA4HZB4=;
	h=Subject:From:Date:To:From;
	b=dxwIn3vVhZhkJEmMFlBr2u8t2+qikJd+EtxCkmOwpRZJU5cc4hCuE/N8amphIfE/7
	 fkQ/A+MIK8iOjfpzUCwd2wMywSHV0CTKu4oXbnOin9AaVzkAGMIjNCVbOZOLaVoorF
	 6IjFacJKwY5rTYhAyvsynfhWZSenpsN0JYxQyG85USpGgnksWObhgI3dUWtiJVd0lv
	 K6OWHr86TSl6hxk1/PDpAOF3P2pUbIb0SKBQOH+FHyamNmPcDDde6sSs0R17urfit7
	 MuyZGyYYgcKZPiEbaE/XI7/XUALo8ZUhOx6mKJLhTEV4Y+RHmrL1/CcnPmAMDPNZ5u
	 wZ9EMVIJp2Ikw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 75BB839D0C20;
	Tue, 23 Sep 2025 08:30:09 +0000 (UTC)
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
 <175861620793.1332476.13472031121392552220.git-patchwork-summary@kernel.org>
Date: Tue, 23 Sep 2025 08:30:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/5] usb: misc: ljca: Remove Wentong's e-mail address
  Submitter: Sakari Ailus <sakari.ailus@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1004874
  Lore link: https://lore.kernel.org/r/20250922120632.10460-1-sakari.ailus@linux.intel.com
    Patches: [1/5] usb: misc: ljca: Remove Wentong's e-mail address
             [4/5] spi: ljca: Remove Wentong's e-mail address


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



