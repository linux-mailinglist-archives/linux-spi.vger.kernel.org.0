Return-Path: <linux-spi+bounces-7288-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B47BA6D7E0
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 10:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8867A4E75
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A77A25D91A;
	Mon, 24 Mar 2025 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4CgqPRJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC41411DE
	for <linux-spi@vger.kernel.org>; Mon, 24 Mar 2025 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810189; cv=none; b=hQDrYq/+vyF4Q6JEfudX5AnUFKxwMoqGTUSRYOAh5pgXdYtzef33MWbB4pS9wMCD7xzZ8vxluBvlfXFGogUXNa4oVLBk86KUHbQQ/38MAVTz6Q9IsyEabg99wuoahAcp03thfvZNiI+kVBfHLpZGcmHkjLTtsfd/EtoVsqITopU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810189; c=relaxed/simple;
	bh=T1LAqbtMqDo28N9eYK861DSAUXYt+EZBDPC5hehmzNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Bq5HgkH9OEQil5k/S6ioIiIp4cM4WX54qAlv6AwVOXbCW1jCkhxUtaDYkDgFQJmQamv+VHzqhk4kYwEWP4wdtGpMZtbfZbEATS0MVDNGTKFQCRwFrocxV9VGFgD+VBfkSVIUIuNJ7yFyU2Fz39RX7/T2i+DxXO53TUsO7lBR3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4CgqPRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90918C4CEDD;
	Mon, 24 Mar 2025 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742810188;
	bh=T1LAqbtMqDo28N9eYK861DSAUXYt+EZBDPC5hehmzNU=;
	h=Subject:From:Date:To:From;
	b=q4CgqPRJ6ukNaDK2UYEnvhBGXXBpFxlSRJMpaQBSK8DIZqvxuSQ/N2f0EKxNntZRY
	 X/fqKjvGUEt6ZEcqhN+Vaup4Kvr0noGaL2U2JGqortL2P+V+UghqBNM8Z4r3lTDSKt
	 tbeVJUPtR3nfOfxxLqqx8ZCgDSfkAN+AQRcBmdbn6/nihxo03SzZTA1vzbaqyCSUNy
	 qEGX45n9s8AbjCEKJGo7Kbo7h6Dp04uN6jS7VjLMZCFkT4kBFhEAUQdCCCQkJeCOQL
	 9z+EAXldVYAVgqsMCprCBPXFwYn6f+LRlRu2pw6F+63+68Pd8GCnqFY6jJmZwsmgYu
	 PF/MgfRh+Gr6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB222380AA70;
	Mon, 24 Mar 2025 09:57:05 +0000 (UTC)
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
 <174281022448.3311832.12574046857288559864.git-patchwork-housekeeping@kernel.org>
Date: Mon, 24 Mar 2025 09:57:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-stm32-ospi: dt-bindings fixes (2025-03-24T09:40:13)
  Superseding: [v1] spi: spi-stm32-ospi: dt-bindings fixes (2025-03-21T09:44:06):
    [1/2] spi: dt-bindings: st,stm32mp25-ospi: Make "resets" a required property
    [2/2] spi: spi-stm32-ospi: Make "resets" a required property


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


