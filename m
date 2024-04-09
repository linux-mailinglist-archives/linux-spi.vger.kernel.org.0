Return-Path: <linux-spi+bounces-2252-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BA89DB65
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84C8B25DA6
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9A12C531;
	Tue,  9 Apr 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbAG2J89"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D912A144
	for <linux-spi@vger.kernel.org>; Tue,  9 Apr 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670993; cv=none; b=d/7qt16z7un0ZHnTTqGH8nwqFFeIN0m/mUKeiX2d0RxrQ/dUtP2qWBTsvxvGs74CKY3QL/cM7wjwyxpPULQMy5YZ0TmPGuqGCYcFrYeD3FbSVVXrSjjOuripJ8YojoHE/86RIUlGKnhI2ygER3BlCoeYeRU5CK+0P+Lf4CBhj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670993; c=relaxed/simple;
	bh=gYz6poWC8uLKS0kQcBn0B8zyJHVGDk6MTFkv8x/5QJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qYtffh5efVJPtXWEsTt6f32AkXd7Z6X2kYXcD5c5dYrpVb/5rcrwi32RC7HaF9n67GM1onmjNXT7Mucr3k1q7S0YIGCiehYhbgHy4XUAYGVYw0ggarYl7VwUSQC4lwZ6rDbNW1n8MB1d1QZ1gziwiB7VSfawZHixkmT6NaRnyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbAG2J89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0203C433C7;
	Tue,  9 Apr 2024 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712670992;
	bh=gYz6poWC8uLKS0kQcBn0B8zyJHVGDk6MTFkv8x/5QJs=;
	h=Subject:From:Date:To:From;
	b=FbAG2J89dJOmCDDm7FrMtDoj9n4v/HsCLT3Y3xtBMsw9tc2G7syLJxg8GY4vNk3qX
	 Hzr26Ignycx63Cl/1DW4/fDKQ02q7ipyP/0b1AYJ3k9joXlPVGdwqoE4UuPE0PNwT6
	 z4p9jrwnnviH2U9ODEV8WyK8MilYIVxhavvxJRWdTGWKbVQeoUvoiJzOiljzuDPl+e
	 s3IsK9vIA+Lku6EWTdaGpqrYPFoQ7b+C0metmcQypMB/s5naqCcAujvFf2QkNJyLnp
	 WAHd1Ro/AgyxnmhReJrwiSl68bPHocqzig6F22nwWntq5ECuB+HeX9UUPec0Zl1hFY
	 V/XqyJ3mkOgkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0226D6030D;
	Tue,  9 Apr 2024 13:56:32 +0000 (UTC)
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
 <171267099284.17729.4267174520051403369.git-patchwork-housekeeping@kernel.org>
Date: Tue, 09 Apr 2024 13:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] Add bridged amplifiers to cs42l43 (2024-04-09T13:21:23)
  Superseding: [v3] Add bridged amplifiers to cs42l43 (2024-03-29T11:47:28):
    [v3,1/3] gpio: swnode: Add ability to specify native chip selects for SPI
    [v3,2/3] spi: Add a mechanism to use the fwnode name for the SPI device
    [v3,3/3] spi: cs42l43: Add bridged cs35l56 amplifiers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


