Return-Path: <linux-spi+bounces-2239-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059D389D216
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 07:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E51E1C23BFA
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 05:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E069DF4;
	Tue,  9 Apr 2024 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O66dU2vJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97C657D4
	for <linux-spi@vger.kernel.org>; Tue,  9 Apr 2024 05:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642197; cv=none; b=gkq+gd2OiZ7P3/HT4zh6Cc5eIGUkb3lmLH7WHzbdsdQlHHQnEe+8b70B/kLm51UUiM9S9iBPNDF4XNiBWsNYWFLaGw4B41Qk0nUMuo5kEuf1r9g3U4oz2claKIFmQEw2oja1fFBfbW3zxk4N+cl9CAfrYdFQ1cWWpi5YaFpd1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642197; c=relaxed/simple;
	bh=28R0yBgFanOfGgbm0BF0GEMLg2a5amQ34324Qc85W34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=q+ecg2tyUS5pAIUmDJqobsOQi/j3rfzwJ58vgTvkfeHTFtTwC2UrSAPM3jcZFlDI0qA71Wcg2Jfa8VahAApGyyW4js/FOZSFS4w1MQMlFIUHxovb9ZPBgtqQeduBN6VnK0BdOg+ZUCIn2roBwqHvCKo567cBCsddwEDS6m7MLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O66dU2vJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 835A3C433C7;
	Tue,  9 Apr 2024 05:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712642196;
	bh=28R0yBgFanOfGgbm0BF0GEMLg2a5amQ34324Qc85W34=;
	h=Subject:From:Date:To:From;
	b=O66dU2vJ4J5T/Ofr9jXuyLO1TjoJmo/ODETHP1YIuka0zuxNcm6XDW5zMN2BlsnRX
	 2ApulORWLnUWxKsR8RSFBLUsDs2YrQcl2MRr6OlWSIG3koQH7AFmU48fYwCISgUmkv
	 EM10+wEGA/ait8E7JANKc8rLlMcqb5ZcaIk9NQNeQJDrAntbNLtca5ZoN13D9mkopk
	 6lhtW9eKRgkv3d86YpqSVZlp593WTNFPYeKxz6UgeUf9ImxRccINm0OTb4+mUY3yMT
	 tU0qTEyJCDJd7+ZtAdGkUKp3uVK4PrUqoFqBj/64l5rPCDLH3HTd229JQanRP462rI
	 ArbZ7z13VDCug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D5C9D2D0F5;
	Tue,  9 Apr 2024 05:56:36 +0000 (UTC)
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
 <171264219639.14995.16514306690151285182.git-patchwork-housekeeping@kernel.org>
Date: Tue, 09 Apr 2024 05:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] fw_devlink overlay fix (2024-04-09T05:37:01)
  Superseding: [v1] fw_devlink overlay fix (2024-04-08T23:13:07):
    [RFC,v1,1/2] Revert "treewide: Fix probing of devices in DT overlays"
    [RFC,v1,2/2] of: dynamic: Fix probing of overlay devices


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


