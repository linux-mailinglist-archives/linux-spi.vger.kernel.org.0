Return-Path: <linux-spi+bounces-7164-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E809A64D6C
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 12:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB216CECE
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE723536A;
	Mon, 17 Mar 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgtYX/2d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9C233727
	for <linux-spi@vger.kernel.org>; Mon, 17 Mar 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212582; cv=none; b=YUachKy+A2gJVa6b+Bo0PL3bMu8H40n/K9ncrMDuFhZUxPIrrNLc4tOypwA7L7ARdag/TebkgZw5SxnOr318+WbqkdZCV+iA7cXp8iaWllgbvUR3o8aytshxauSYHQPKzujBFN5jChbDMIcmRkmWmVIP0gsvJcIuwbtUPuxh848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212582; c=relaxed/simple;
	bh=C6IcQoTNH0nBmiPpTbZ95RwvMeY8JWuz3twPjKDjO5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QkI3AH0uXY5bU0FkhRyAQjYbSw3+dJnlH3M1zjonXin6CPMXoJsfCiSlHJthoqvZpn+hh2zEL2rKFb6mV5Mm/9ajBYpMA6plCQmGgsJJvOsJzTNEpMoG8luLn2pUf66lv3+sRPRENLJvvXqqt+5AJdw0CZIJVga2XEuKcgLcJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgtYX/2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B345EC4CEE3;
	Mon, 17 Mar 2025 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742212581;
	bh=C6IcQoTNH0nBmiPpTbZ95RwvMeY8JWuz3twPjKDjO5M=;
	h=Subject:From:Date:To:From;
	b=KgtYX/2dpz2m6B4hayEYu8nT32TgWaqyusbGQTOWzL6y+tZ30Zntn8KlUO+tf+FDz
	 qd8CsEgr5uNZY9a7/zPzm1dF+pn9N2S+f2fgVahyAVoXtPPKa5HDfw7sQUkb7jYmNJ
	 9Uu6P6TFCLUUfS3MaJA/7QJKzdDpgjhOKGeS1V20D6D1iB6OFIB8dfyz8ecALU1RMg
	 1NEqPZLBZrEHUaGlu3O9p533Vch9sMEEjUu/WXiiWKG1nmHXhIVob40r17pupf1II8
	 S+dw9d0zYLvyVEeu/48uSOu28+PYafWn/BNPXHC2+qq/4TOjNKdb9DJqMt3o86Ht1x
	 yAxaAFclEiY2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343EB3804CB5;
	Mon, 17 Mar 2025 11:56:58 +0000 (UTC)
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
 <174221261674.3399077.3951514572664035896.git-patchwork-housekeeping@kernel.org>
Date: Mon, 17 Mar 2025 11:56:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add more devm_ functions to fix PM imbalance in spi/atmel-quadspi.c (2025-03-17T09:34:43)
  Superseding: [v4] Add more devm_ functions to fix PM imbalance in spi/atmel-quadspi.c (2025-02-10T11:10:07):
    [for-6.14,v4,2/2] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


