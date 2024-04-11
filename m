Return-Path: <linux-spi+bounces-2298-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263428A0CE1
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84BE1F219C8
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4E4145345;
	Thu, 11 Apr 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul7Aecnz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3713FD80
	for <linux-spi@vger.kernel.org>; Thu, 11 Apr 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829410; cv=none; b=IFoWCgxDC8PViJm+Z5NzVeI73NHiG4oWBBWlx31lwIGl/bjsBk+KeyBhopaqHZLl2BPDxmUSnVTchurokKTFVe9m/6M4ueRTZLaqjgkLFmUlwbrt3GA6kIOWhJdUD/chqDsa194BWGZmPDut6J7jUFTiBRChZNGl4QPJafaQAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829410; c=relaxed/simple;
	bh=pJZMOh6IYrohCqLF5gO6563yyuz7hUCnxA35o5G3Xeo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qHLIzgrUDHCMHAL2TlW2Di38MGIFxaF8b86NldXrHOrekkBOoTVQ/ZfRHo6DZvpznHYlNkhjgMB4Z3XzQuGV6CuWW7dTyY/HwS+wVM9eXr/08LTeL9o1nq1vgIZ9ZNEQ3U/GDFR85E6Ah8Y7EszT9M09NYLxkZ9Y4IoWn/EMr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul7Aecnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0374FC433F1;
	Thu, 11 Apr 2024 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712829410;
	bh=pJZMOh6IYrohCqLF5gO6563yyuz7hUCnxA35o5G3Xeo=;
	h=Subject:From:Date:To:From;
	b=ul7AecnzfHa3BawHdQDwHjwDm+ywXgzv7pUvlpZzLWWdx5odMnhO/WJOq3BIm3LCS
	 hDBNBcQ7102Th46X/IPco6rVuga/RYdj09+1Pw81r/AmTtq6HQiP23irXyBXQVRUk/
	 WAt3nOjbD7GNwHytwjafIcHmO5+R4QWjYWbAK1BimLI+aGDicbn3nmZhdigiN72Y2g
	 UFJZ8MT7q+ARmHRox3TmE+0a3BkVsrMq7l3C4eXbmybOhrjA1JJaS68/NfrCKrrb5K
	 Vzb8qX4uUW07RKhcgh/Aa+Ipdl6wG4ZVb0wUkWf/pL9oZJgwZ/W4pJ3a9qjntOFTFZ
	 dnoyA9h4Ays2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7A2ACF21C1;
	Thu, 11 Apr 2024 09:56:49 +0000 (UTC)
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
 <171282940994.27031.4000438264637698446.git-patchwork-housekeeping@kernel.org>
Date: Thu, 11 Apr 2024 09:56:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add bridged amplifiers to cs42l43 (2024-04-11T09:06:26)
  Superseding: [v1] Add bridged amplifiers to cs42l43 (2024-04-09T13:21:23):
    [v4,1/3] gpio: swnode: Add ability to specify native chip selects for SPI
    [v4,2/3] spi: Add a mechanism to use the fwnode name for the SPI device
    [v4,3/3] spi: cs42l43: Add bridged cs35l56 amplifiers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


