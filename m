Return-Path: <linux-spi+bounces-4190-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71490951DE3
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 16:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D106C284439
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730651B4C38;
	Wed, 14 Aug 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAJAA3O2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6F1B3F36
	for <linux-spi@vger.kernel.org>; Wed, 14 Aug 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647409; cv=none; b=j9Xbn+loQR7zNmVZ0FXpCHAlLU74QxPrNz2QAQ13iCaue3LN/yC+wBHuKq+ln2QDBvCsr0LrtoMtlLAyyjfrSS7/L3ii58aLDU//BXpMKtLuDJw1aXkdMu8Pu84ZhPAIQLoN/Oc2huKOHWrWe9fjLPvK3UP3xqoy/wTbZkx/eEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647409; c=relaxed/simple;
	bh=CmbZoU8wmUUMTHlbkXQQm1H0GJRyd+ISOLxwlD6o7wU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TV6r9eYDwjgGHbWkwxE3au3VsVO/lRVOEZ8zJiAyio/NuexC7u+m37MN16r9gRhhS8soyZdv1eYybUHraNinZeNcwvu3XqKYR4v0a1JoJMvtuEApkmXv4FKYlAXRZTVbaV9rrF+EtNFgNV7+G9C0PXhP95eUEZSt+dNiYLn/6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAJAA3O2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD810C4AF0A;
	Wed, 14 Aug 2024 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723647408;
	bh=CmbZoU8wmUUMTHlbkXQQm1H0GJRyd+ISOLxwlD6o7wU=;
	h=Subject:From:Date:To:From;
	b=aAJAA3O2sZ4xwsDWg2lIbVLhF4lRSTX5tQH82cMX2PxYHF1FotZWaJjqF/MhLbjmY
	 dFFmcyzJv/5Mgm+UG3E3YAxutKSSwA4y18VweCX02p5FZ9tB5rVH+C4d5FcIxh5/3z
	 SlyrV/EZbk4nPFrlPqPV6ix9o4FIgLuWSbnmf/dlBLWDxPHNap+jBW9NqWcfDbpo2N
	 05qL3wVeMm4nXDRIi8O2qJ0NjReqylrNxIApcqvI2zNR71nYPxZA2xNk3ulGI361Kk
	 9L9rztaixeNjXDgtoqltHFbEj8Nfa0G/C6ntws8o2z9cfZlSJRkHoKpgoB84O44TId
	 BfmLnpcuAIWig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DDD38232A8;
	Wed, 14 Aug 2024 14:56:49 +0000 (UTC)
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
 <172364740781.2292043.6683010862545965769.git-patchwork-housekeeping@kernel.org>
Date: Wed, 14 Aug 2024 14:56:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ (2024-08-14T14:45:12)
  Superseding: [v1] spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ (2024-08-13T16:02:20):
    [v1,1/1] spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


