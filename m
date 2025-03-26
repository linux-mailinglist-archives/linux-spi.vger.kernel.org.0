Return-Path: <linux-spi+bounces-7304-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F83A70F20
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 03:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D95188D3F8
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08976035;
	Wed, 26 Mar 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdD6FLJ5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4FEBE;
	Wed, 26 Mar 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956790; cv=none; b=KgGcbiTfYzwnfhKdc7xD3nisXk1ZEGJQ1YfMttR5JY91qMJt1t8zbYYPaZV4uONZ9DZN+RxCnKbKgR7bildaR89J+pXcmqocqcfLuIGjfDhhxioQj3uSsjkutofiSefSByzH2dWcryoAszIroN4XJFYogNNYjkJ4KKUF67rabrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956790; c=relaxed/simple;
	bh=D44cx0jW2bGZEBnOYyKyuSRGwhqRJ6+xdwOXivktl6o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RSVE4Aqlg1Ne2WmhyQXXaoXVOk8ucdHmsjPGNqxuM8RVSoUOZyhP2TCfssmG2usZQ9frLtwxegHUhMlWz5ecxbRRxFKlDhuU3b8m1Til2FIi4tMSztPMadcRycZfzVEhJuQnbFQmw9MjiO9Suckf/YDJwS9Q3krGB8DEdvcCsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdD6FLJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E897EC4CEE4;
	Wed, 26 Mar 2025 02:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742956789;
	bh=D44cx0jW2bGZEBnOYyKyuSRGwhqRJ6+xdwOXivktl6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VdD6FLJ59pU/XR5acfjywD6N3a5ASdHH6HlMz9P/uETdF1TOxuRygnH3vL0JK5FUY
	 ZzRnJHewdjdXqjq6dntMytP+d/yJGmV7hu3sIiI3qekRDaO8ZqvaLO3/PTFuM9d+YC
	 yFzkxXv/9yloaO+IJ9SU46eJJu6WijGbmRynQs97K4WsdDVSetAbf2oktn9yx7hXz6
	 NrfKLcxXWBpCeG4mXlZoVoeCxj7Rty4hYtv0S08czMqTo20Fh4BCKjuNMPj+Z5YMah
	 6W/6HFwyjBFIagdUV5Dph4/7QSKyXJFJYl0oPY9bz1/uBCWhbpRtCPJW53wYvBFu60
	 pWoWwLdz4Giig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7243B380DBFD;
	Wed, 26 Mar 2025 02:40:27 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <a34186c0c3374ac5ddcee4c723ace2c2.broonie@kernel.org>
References: <a34186c0c3374ac5ddcee4c723ace2c2.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <a34186c0c3374ac5ddcee4c723ace2c2.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.15
X-PR-Tracked-Commit-Id: ee2ecf2cf501eaa69dcd723d76b434767195b64e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47618bc875407b54296285e21d92d79889ce503a
Message-Id: <174295682612.817729.2409462583399641755.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 02:40:26 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 14:33:29 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47618bc875407b54296285e21d92d79889ce503a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

