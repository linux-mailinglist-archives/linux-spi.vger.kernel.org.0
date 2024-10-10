Return-Path: <linux-spi+bounces-5196-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A76998873
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 15:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E651F21DFD
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF111C3F26;
	Thu, 10 Oct 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bxf3hthY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998E1C2DD5
	for <linux-spi@vger.kernel.org>; Thu, 10 Oct 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568575; cv=none; b=CebihlspzjaVc9gd2lc8+G/RDnHWBmXi2jtiyjNgO+MDQuxFg3Y2g6iZrofngsUPxsbQSUXd553C3HXKZCp+K4GX3/0h8UV3FQ7iPs6SLwd2A4BTfj9HfoAtNyEfdmgmBldwBENdnR6BmnXt9eCpSXxJ0hq52Rt+HD0aynMRFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568575; c=relaxed/simple;
	bh=Hlcu07iij9PpSxXllGP8r2RDjP9syGykd6OSR8suhRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=maIDv9sr+ewEE4SvfhGyha1ItN4qy1tL5FB06EiF80mEp/oMubV1qV/pfXPdsablYhpjBlD+VsA/Nnd2LlEJqbM9WIqBCfpDfYvQMVZvn5RLf3eJ68YxaIh0tuSBJOCH0nEfluc2c0rrsucK4gG+1oQ/bP7mHlho5eMtU2odhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bxf3hthY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232B9C4CEC5;
	Thu, 10 Oct 2024 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728568574;
	bh=Hlcu07iij9PpSxXllGP8r2RDjP9syGykd6OSR8suhRc=;
	h=Subject:From:Date:To:From;
	b=Bxf3hthYiLCdeyOIiHndwfjS8MicW+twlo43sswljVFpubuchCZOi0RUq9NnAKL+w
	 AXbyampv5c+FaVPlkq2thjy6BB5cK8k1LL6j3UkhzyPb5DFE/H/FVs9T0F6I6wSOwj
	 Lk9rSnh3SzqBAtCZFKIT5l5xvh2LvOSNHHwNQSVuCCEnNxmwadFO0P5HhpbQjpqWUu
	 +v876pMjwsMFf+OU1XJwAnDCNFMpR7Eynl7g7koykh9AAI6WN4HkobR4xIk7OJcU61
	 jq5qy6NKhFh6yVFb4UeKCwQydtYscE2cpzIpDFh9qOCmLlRGCqLo8SNF/RH5Dh/irY
	 wm/FB8TlOVC2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE15C3803263;
	Thu, 10 Oct 2024 13:56:19 +0000 (UTC)
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
 <172856857821.2031924.4960877765389659560.git-patchwork-housekeeping@kernel.org>
Date: Thu, 10 Oct 2024 13:56:18 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: stm32: fix missing device mode capability in stm32mp25 (2024-10-10T13:33:03)
  Superseding: [v1] spi: stm32: fix missing device mode capability in stm32mp25 (2024-10-09T16:15:52):
    spi: stm32: fix missing device mode capability in stm32mp25


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


