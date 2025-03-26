Return-Path: <linux-spi+bounces-7332-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EEEA71DCA
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636491889BBE
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43692192F5;
	Wed, 26 Mar 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr6TDZnf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFB2054ED
	for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011790; cv=none; b=XsZu0L0YgsYCLA0hIN7kkc23WftGkCDlVjCXJVDh0yiaR8MHaeIKBOzAgML2Bb1OdQ9rGL8qoD8TtHcf6SZMWDs9IZnufQAQ/y4gUFdXlzGrh3cItF8iz5KnqaYCJcrM22Uklz9NdEfKd09oDjVDcAf9SQ3iM7SmOLYVK6uSl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011790; c=relaxed/simple;
	bh=K9y0mUEf2Ia8a+URGnadgFRipo/zxLopyZUdNh9VIhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Y4h8B9qMSuDW7QzjKfocmGI5RU1uXRWkO4BxtFhrYmmIhC7m7rfEY4MUnHC+Zo2XmQZnKAlkaHwygvYWzq+jqerT1x/ygrSkvpENIRTHw4UWEd6KfzFSKMgs7H1g0f8U61OzpftMx2iufNuKB1ycNMCNMZLPx1EhXhSzbc7BsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr6TDZnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8142EC4CEE2;
	Wed, 26 Mar 2025 17:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011790;
	bh=K9y0mUEf2Ia8a+URGnadgFRipo/zxLopyZUdNh9VIhA=;
	h=Subject:From:Date:To:From;
	b=sr6TDZnfDSFn6YWy9GjhzYMVVyuDNW18M8+tDcpTw6cM5eV+FVSq3B++8k3qJOqvV
	 ov+fxr1qgO8FaCx0WuL5n7KXUm7NAF+pIHezXvq/sojtlNTkZxV/01sttcH3bjqmA5
	 4HiJCXfqTWn7ZSCftRFyuffnATtybW9lPpulxhrbiub75rg8h09hoVjqri3Fr2UAGy
	 Ok52mZEtkscX+1FP0t5lr2UUqQdh2Y8cXpMBvwYLH4hue/oRWnhJ71i3JqOQXAw+yz
	 1x8EsYhwNUyJ9opMeeDJep1JzZKML5X2RVJGGysmm43xEIm3mIEKa4J30Tmzcc0zVt
	 M8W30aEUr7JYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EFBAC3810902;
	Wed, 26 Mar 2025 17:57:07 +0000 (UTC)
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
 <174301182657.1414559.10835383676018464046.git-patchwork-housekeeping@kernel.org>
Date: Wed, 26 Mar 2025 17:57:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spidev: Add compatible for LWE's btt device (2025-03-26T17:24:45)
  Superseding: [v1] spi: spidev: Add compatible for LWE's btt device (2025-02-21T15:56:44):
    spi: spidev: Add compatible for LWE's btt device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


