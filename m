Return-Path: <linux-spi+bounces-5626-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2919BC877
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 09:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCEA1F2224C
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B26E1CFEB1;
	Tue,  5 Nov 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X03UL9VH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA41CF2B2
	for <linux-spi@vger.kernel.org>; Tue,  5 Nov 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796983; cv=none; b=vBrZgjiZrZWzr1AkzWAtlp+WHlOolfTfQMfti/EDusR0jg1InV9HNDBlaO9qHszP5JOxO9arSWwLvAywf4W4NfYMGmpV+5NvZPG7t5sHL9nK6RmUglByPJCktv19tW1uREu4cFzhB4fc6zX9zd9YZBfqBY7n7cBamMjvOVIhKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796983; c=relaxed/simple;
	bh=CaKUH3XuKIpHSjKZeFUVT23vudN5AlEPLxVNtjzi+Jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=drgije+jpKxE2PkrJ87d6XkNTdR1QI+2PoO1mmHD486eAWbiQ5YDa1yPShull3Sr7l3MNAqN04kWod6kSHFuWos1HS7WBnaXAlQC5MmyfFm/lb7erISKmPPUdqsy179tncZ5rJZ4imFnudr2EHbSF9fu1oJbVle/PRofD0lbxr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X03UL9VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68529C4CECF;
	Tue,  5 Nov 2024 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730796983;
	bh=CaKUH3XuKIpHSjKZeFUVT23vudN5AlEPLxVNtjzi+Jw=;
	h=Subject:From:Date:To:From;
	b=X03UL9VH0VAqGGPmx0VO2SzQJvy3zV9g/zAESLgXVN4yXHWbRSbU6f5SHzpmzEi67
	 aHyZ5Fn2L9ahxbcztNqqRy8cMC8OSJfXcm3+p6+x+3UApjQ2hYjVEUnp04+15XmT5w
	 cj6IfbOZGiSDfQC7lH70hZYjQzbrrotbKv7KxD9fMjEeK29pHcpTWRPeAHg0DLJ8Xn
	 N5CoAqt8709vfVZZgUzVzVcKlRm2QDKA9fNgoc6GAJF9EXZHW2SaGXHXbstx6AEK0A
	 te7s10YgrRXEmo6+wnMqT8cZ3rV25oQ9y7w8pp3L1dT+bGjZB6mBxrnjRd0k1jtQhv
	 CfFb+Kuw2748w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37E1D3809A80;
	Tue,  5 Nov 2024 08:56:33 +0000 (UTC)
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
 <173079699171.478319.17340561645549046848.git-patchwork-housekeeping@kernel.org>
Date: Tue, 05 Nov 2024 08:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Apple SPI controller driver (2024-11-05T08:08:28)
  Superseding: [v3] Apple SPI controller driver (2024-11-01T19:26:12):
    [v3,1/3] dt-bindings: spi: apple,spi: Add binding for Apple SPI controllers
    [v3,2/3] spi: apple: Add driver for Apple SPI controller
    [v3,3/3] MAINTAINERS: Add apple-spi driver & binding files


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


