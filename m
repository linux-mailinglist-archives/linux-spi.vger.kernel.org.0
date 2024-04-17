Return-Path: <linux-spi+bounces-2397-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F598A8177
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 12:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0111A1F22213
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6B013C9A6;
	Wed, 17 Apr 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7nOVviz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675313E041
	for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351434; cv=none; b=NnOqpYueseNWWGD4XznC2HNrd2YLtgeEMsAlzoIadJ84uoVeDp93tISUoQE8QO+2h2r0a+AZ0PNYxNqmR9oBs8EZ7zxZq6CTJwvpttuYDv9S8aM6gya/dTZO0CnTf9/RW/MIMO9gE+I6QiYBGKDvdzNHkzPjhZd1gs2Cvltql3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351434; c=relaxed/simple;
	bh=TVQJNskexyWKC9o6jiMZJZuK2csHqqLJe19k94aArw0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SLeLbpnkJ8II5pLiYW+yh8CxiwaWkAqQCrXnaKpnXaRIItiU2J9qNdh1WD2I5EgynEMSIUuAnZbjcW6dKWisI1gKgwaY+L6Sm6cp6yuq26vTIl3i7c18BnQcvD/mKSSkBYTT+S6jxleAizUR5SmT1TelIz/3wVPMxQz25BPGud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7nOVviz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B3E9C2BD10;
	Wed, 17 Apr 2024 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713351434;
	bh=TVQJNskexyWKC9o6jiMZJZuK2csHqqLJe19k94aArw0=;
	h=Subject:From:Date:To:From;
	b=N7nOVvizsOYEWPT5oSLZcL2U7paAtUNWKPnck37GW76qeQrr5HBiRaq/oMes82nLZ
	 Iy3LSQg8SNXqLBG6887y8rqZX6o8trATxuxHaKnQG85+EXxADQdsdlKsRwen38PUS8
	 6Gc3BRQpoZ3xQoufybTOAMGfMZVOfcan2sNpJmkf4zy/YEF1PynF7AnQDk7OYL7+d0
	 SrKDGZY/QR+IBplzaHHCSm/K+YSNCH0F4+HAM2rWllbFKqgN1V5c7QwqyPIksGqqwW
	 vBJV7ecqkfDjdwjzj2Q1AhtIgGq/oRsn7l4zaE/4JaHjHwjkxVNMkyPNpgAQpNgkw3
	 rGqieQWH1WfsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85A85D5B3FD;
	Wed, 17 Apr 2024 10:57:14 +0000 (UTC)
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
 <171335143450.22263.10225259082886286624.git-patchwork-housekeeping@kernel.org>
Date: Wed, 17 Apr 2024 10:57:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: oc-tiny: Remove unused of_gpio.h (2024-04-17T10:47:30)
  Superseding: [v1] spi: oc-tiny: Remove unused of_gpio.h (2024-02-28T19:37:31):
    [v1,1/1] spi: oc-tiny: Remove unused of_gpio.h


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


