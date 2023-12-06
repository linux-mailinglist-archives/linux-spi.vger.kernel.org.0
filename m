Return-Path: <linux-spi+bounces-162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F14807415
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 16:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE299281984
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0804597D;
	Wed,  6 Dec 2023 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPZtmvO0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA039FFF
	for <linux-spi@vger.kernel.org>; Wed,  6 Dec 2023 15:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AFD2C433C7;
	Wed,  6 Dec 2023 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701878214;
	bh=P8AKRWz0/QExSLmRZiESJwJFJD+8jWkZugoeoOIyq8A=;
	h=Subject:From:Date:To:From;
	b=sPZtmvO0rlAPAXRbqgE57TkBeyckHPysaFJTMni7wrqB1s/StB8wgG7i0EZhVnvJ8
	 Ro2Xb1HCbfsXropikR0IVqtxIxQ8ULG+GuhGKB14++ZXew/YFtzksmb9C9k1cTe/SR
	 1f+Eo16GKrEvpDZEX4ibtDFkNKJB2SBJjxtYXUVEDU5gxKAU/jpjlxjcDSUSmMNIcr
	 jpdE3QZRHnhD7MtyuwE4YcIqW60ShjkfiXQzJbx3qvrmmtU13JQHXH1N2OyCo7ffEc
	 JAY46WGopT8ohjl0PVtKINSruw/tZTk2s0C8/lRbdFgi1Mt/Z1/9NUoSSMhyufCrTB
	 v8xUZIlWXtM/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F958DD4EEE;
	Wed,  6 Dec 2023 15:56:54 +0000 (UTC)
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
 <170187821432.10129.16407193755604087861.git-patchwork-housekeeping@kernel.org>
Date: Wed, 06 Dec 2023 15:56:54 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: cadence: revert "Add SPI transfer delays" (2023-12-06T14:52:33)
  Superseding: [v2] spi: cadence: revert "Add SPI transfer delays" (2023-12-06T14:43:51):
    [v2] spi: cadence: revert "Add SPI transfer delays"


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


