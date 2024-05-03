Return-Path: <linux-spi+bounces-2741-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52C8BB1FE
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 19:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C47A1C20FFA
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 17:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964123749;
	Fri,  3 May 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knWm9WNs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF91BF24
	for <linux-spi@vger.kernel.org>; Fri,  3 May 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758988; cv=none; b=ok6IjbBPhVGQVqAoHsODn3tnmXhDTAbov4/dOM0Hs1ZegaJ1x3lu676DrJ+LW+lhvmVEzbtBy6DCZrNi0Cd6Mu4c6urwiguESctCUvd1ob5+KAAWChFVNkOB1AuljMk7eUK4kKEVzPmzo7aQNQ9E+ty5c1ZGRuMDx5Ni+JBbzXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758988; c=relaxed/simple;
	bh=qShR9+g5A2hpwDRBkU4pvAcglmGnyTPOugLV+JqtKtg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=n8pM4ZkStH4ScvVVf480wtgpONItX+vXY8h895F7p1A7jFR/2d9Z9moMH4AR7i9tggv4bqlamLAcXt6lxOR/xzUzwEM7ZyJX0pXBxr4XSY86VGpEpEz8Kv4oe156jv/1SWrQj4pXOE/+grue2XEOe/wpkyTbJrByx6KdEuHpeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knWm9WNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8F4EC116B1;
	Fri,  3 May 2024 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714758987;
	bh=qShR9+g5A2hpwDRBkU4pvAcglmGnyTPOugLV+JqtKtg=;
	h=Subject:From:Date:To:From;
	b=knWm9WNsSMBOMRsq3vR+as0oJjrau15r2sUFkl4VLcqz7yuQcgxolBWfx1H9hwWB1
	 s+RZ26u4I7TBJ/F4fy97zE7h0popviBeoO6VFDfOMuP43I52ZqevvC00f0w5ubHaSV
	 dZVEhb+dVBTKxOHWNkSLte4fNm8394Bty5U1DUkS8tTsG7xhUIT776xP8O69cn2hPR
	 lN11+GDfUwudYMUbPy4Fgv6ksVWZrEFDSr4rk9sS4J6k0IqlZpZyS8v4B3gSB6Q1+J
	 JwX2KWkCl6U9Ip5p5ARyc6XYtqPIfzTVHw15gBH+AWJbif7Eamg/PxRYhRdMsh4347
	 6y45KwIMzccHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4BC3C4339F;
	Fri,  3 May 2024 17:56:27 +0000 (UTC)
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
 <171475898780.28943.7441145011598734748.git-patchwork-housekeeping@kernel.org>
Date: Fri, 03 May 2024 17:56:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: bitbang: Add missing MODULE_DESCRIPTION() (2024-05-03T17:07:47)
  Superseding: [v1] spi: bitbang: Add missing MODULE_DESCRIPTION() (2024-05-02T17:15:18):
    [v1,1/1] spi: bitbang: Add missing MODULE_DESCRIPTION()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


