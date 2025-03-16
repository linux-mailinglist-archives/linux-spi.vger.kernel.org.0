Return-Path: <linux-spi+bounces-7158-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8EA63430
	for <lists+linux-spi@lfdr.de>; Sun, 16 Mar 2025 06:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239B23AC67C
	for <lists+linux-spi@lfdr.de>; Sun, 16 Mar 2025 05:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE5D531;
	Sun, 16 Mar 2025 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYwygn1C"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50D2E339D
	for <linux-spi@vger.kernel.org>; Sun, 16 Mar 2025 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742104557; cv=none; b=FFP+VRYEKnZsUyTRLO+dZD7lXl2JKHbcI7wnrTu+X9qRxgKqL6tz9/Ozbf7pBefU5yrXOwKU026P4cOOxECDxsoYqEPqP149hJL0vQFTNVOZrkl/g7oxUlvj9wBZPYeTrriWu5BXCLft8Y29tPIk4faqVlLD2TLl1giejgRefyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742104557; c=relaxed/simple;
	bh=Bf65U6qNHeEGChC4Ka7cud1BavucPij69XO/mMAAZjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZpM8ic6PNGkXMFVkHCkDzrrYFQ9kMqz1VwW4H2VVkX7fACo47d2gYzP+u6lWYxZ19TqaeyGI0FL/mSbOnytttRzXQwiiWb8pNBi+bvWX/yf8FMjcmL/CpaT3ka/RA3YpSSY3rvm9d4tiMciW4tf9yqpaV509opyIDS86YvUIa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYwygn1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDF1C4CEDD;
	Sun, 16 Mar 2025 05:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742104556;
	bh=Bf65U6qNHeEGChC4Ka7cud1BavucPij69XO/mMAAZjA=;
	h=Subject:From:Date:To:From;
	b=PYwygn1CvGCPvIRPHcdC7SR0+Kwh9fLl0MgZz5f2JVh76rvfv5IyoiovzNZeEN6OU
	 WrF6FcXNg4YE6GwlP5fmGSlkkzJ+e1WknOi8IjWBBzKawDW+q0idID7K5dY62Au/tK
	 B6ANt0kBSBuzZIEQA8YmOM+/2UzhppimATOMXkKFmVa/QC++xwFPIQO1Uq5EbGaW8H
	 1acREbGRJMRgvPkC8klH4KD+n3Uch6zXM3NZvHG+VciMeuxelRppTHaS48LMvutpKo
	 JcKFL6fjVXBs4wmLPVS5aIiQYQG4/Rd1jDNPzhoS9EuLiLwbnvaNNY0z6Q2LT37r/+
	 duiJjiJvjRIOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B23DB380DBDE;
	Sun, 16 Mar 2025 05:56:32 +0000 (UTC)
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
 <174210459134.2734842.16993002328840179364.git-patchwork-housekeeping@kernel.org>
Date: Sun, 16 Mar 2025 05:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-mux: Fix coverity issue, unchecked return value (2025-03-16T05:46:06)
  Superseding: [v1] spi: spi-mux: Fix coverity issue, unchecked return value (2025-03-15T04:59:22):
    spi: spi-mux: Fix coverity issue, unchecked return value


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


