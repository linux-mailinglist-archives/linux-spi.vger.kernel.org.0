Return-Path: <linux-spi+bounces-8337-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FEDAC81E2
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE1A1C0258D
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8417722DFBB;
	Thu, 29 May 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUR7T7Ay"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC0B22D4F1
	for <linux-spi@vger.kernel.org>; Thu, 29 May 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748541368; cv=none; b=TBXjNwt6imqpIfGVFbB+2eWfI82qG6fz6JTAcR7fWWKVC41q46rB3f9JuvfnpFwMqwFnhWXrZ7qlUeHuDUPSy4QGH7fDmFYBmkEN++hJ/oRrrEiiEYPh7ax9pk0EDq1uT0gBeEDpkzujAOkIBBsxIXA7cEdSU8SP3uKxjMxe5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748541368; c=relaxed/simple;
	bh=9BA9jzxIMHG0qA5HA408JLlor1b4+qJraFop+fV5kDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Tff41ZEFwcmc70nMSR7B5t3F3kPdTkGetjIdTf4AQTvP//bYP5ninLKCG1hbm6R0vEJcott9lzWDvWf5mi6uRFin/KUrIrZXPhVuOM/tknCauj43smVc7isFEhJel/iQ/iizK3WvFNIFqFfCKgV3Twu3+fXBYOkz8CoItQSkr9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUR7T7Ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F5FC4CEE7;
	Thu, 29 May 2025 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748541367;
	bh=9BA9jzxIMHG0qA5HA408JLlor1b4+qJraFop+fV5kDU=;
	h=Subject:From:Date:To:From;
	b=HUR7T7AyWXVPHP4VEtzUiOkaTwiaFTTtiDV92hbwgk62MMgL8bDWZwgyrLeLc+IR6
	 ulxywjhtavu5AEE92bLyqaK/ThK+1fNGRhjKi5qOLqxedDfbx4t+9xtM80u0O1OQwY
	 gZvWnphJzvuU/ziymXaaE+iFa+n6dXmVFqRwyMoB89OZOcv17T6loGsjHT1KJjSXcv
	 Swn/HeiGUh5+SicAYORBYloKdH2h/YAotA+cZlAGBcTI6J2XPUORenTZ1ZoyfqFerf
	 qGbWRJvllszT3jdmNV7V7N/+2mpv0BJv3qzvtwoQu13UcN2EQWfRVC33ui5LKYcpfM
	 BpkWO7ta03pyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF0380664F;
	Thu, 29 May 2025 17:56:42 +0000 (UTC)
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
 <174854140120.3345712.14770118272748252001.git-patchwork-housekeeping@kernel.org>
Date: Thu, 29 May 2025 17:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-qpic-snand: avoid memory corruption (2025-05-29T17:25:09)
  Superseding: [v1] spi: spi-qpic-snand: avoid memory corruption (2025-05-25T17:05:34):
    [1/2] spi: spi-qpic-snand: reallocate BAM transactions
    [2/2] mtd: nand: qpic_common: prevent out of bounds access of BAM arrays


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


