Return-Path: <linux-spi+bounces-2498-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41FE8B0F35
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 17:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17BA1C2096F
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900F715FA80;
	Wed, 24 Apr 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht2fIvFl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04D15EFDD
	for <linux-spi@vger.kernel.org>; Wed, 24 Apr 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974186; cv=none; b=kFJ0eXrUW4+j5adzxvL148wyM5aGwp464iUcBoM22bdSTT2gnae/ir03gueTCmx66r04wZye0K48DGrGUFhP3eyz0oi5b9rS1esHIr7FCjBYp+CtwGMqty32XEUOnFLY7lLXh/gsXa0ZL7jgpf/2sxiCVxL97zNfhyo0E1gqZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974186; c=relaxed/simple;
	bh=Vkrs5YbMCbfLbNHfx+rx8/kRvcRwi5bDPhk/P1uX/WU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aZTgR3yM9K0uCLYef/nOBb7RHPmMzDLnpfDueotEWcFw9qBnykqmpo+ZM2BI2wGW94S0boLiOjyAi61owpN9Y1jgL3ShpsRwxH6s1zKm3T8K2pm9otc7g/eS2A6T3hhFC1uo0vWYCd6PBgmgvH45JhRaiP8/WX+F2xE246lgrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht2fIvFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13744C113CD;
	Wed, 24 Apr 2024 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713974186;
	bh=Vkrs5YbMCbfLbNHfx+rx8/kRvcRwi5bDPhk/P1uX/WU=;
	h=Subject:From:Date:To:From;
	b=Ht2fIvFltXQk/T9vZBCFB5FwIMd34FaC/IADc4vMTTJTyqrLN21GQ5Yuo7xa9XM5x
	 EQnnB0unjaW6F8drr1dFsRD+OTVgzf5zJ1xxeciDESr7ybw8knersFEdVTRRJe2FhL
	 3gWwhQYm90GqMOwg4vcUQxn6LMQfXlHJI9YHTIrCFOIzZzzrJWQKFjXY1YqERuKDLD
	 b4llifiZF1oTNpGMjwmL3+E9k7m+C6pHzqA+d5Q3WHSBe9H/y6pZugWsf9ClOazEH/
	 hDT/kdLKdh0CdBj+rZX88/q+oHYwjYMHxwIn/eXCBxuunCFp7YNTzDtBpn1jZb13+3
	 OiQJiQanuZn5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01E95C595CE;
	Wed, 24 Apr 2024 15:56:26 +0000 (UTC)
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
 <171397418599.23553.6636248235666171431.git-patchwork-housekeeping@kernel.org>
Date: Wed, 24 Apr 2024 15:56:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: dw: Auto-detect number of native CS (2024-04-24T15:06:41)
  Superseding: [v3] spi: dw: Auto-detect number of native CS (2024-04-16T15:52:30):
    [RESEND,v3,1/4] spi: dw: Convert to using BITS_TO_BYTES() macro
    [RESEND,v3,2/4] spi: dw: Add a number of native CS auto-detection
    [RESEND,v3,3/4] spi: dw: Convert dw_spi::num_cs to u32
    [RESEND,v3,4/4] spi: dw: Drop default number of CS setting


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


