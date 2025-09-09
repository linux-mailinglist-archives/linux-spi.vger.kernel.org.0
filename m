Return-Path: <linux-spi+bounces-9952-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDB8B4A1A9
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 07:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B929C1BC185C
	for <lists+linux-spi@lfdr.de>; Tue,  9 Sep 2025 05:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C827CB02;
	Tue,  9 Sep 2025 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTQblllN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB5246BA5
	for <linux-spi@vger.kernel.org>; Tue,  9 Sep 2025 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397419; cv=none; b=nau/U5LP0SpIE9OETetj+Kfp9CwccpuIItGU0p3AwUcVSuD75K2CE78qcumvBjA1E6zVSyZ8YtSl2ug4EKKK/K0GWfx1StdmrDGoK/K+09u2/8OJUVo3JWX/C/sn1S7MOllZEX1lGE10DkSSSlp6tN8JCgA92uX0iLnMCE0tOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397419; c=relaxed/simple;
	bh=tFNR+7k/gMkReLCo7mVEzsgh5MGEyA5qIcfqQHkdJKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RdrrUpwQdl4aHVl7bHHPODWn1iZE5B85CrBl2WPPM7DOIbiL3RWSXpNo81guJ2rBB/IzCSnP1XqNWErexjcHZJl+9pfLX7WQXLYb3YNRghl9kYA9Fxt7kiyxJlglOSPPG19LgoKMpdDkgWDcKOKhRKWf/DefYXZMmmGVevN6g1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTQblllN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62600C4CEF4;
	Tue,  9 Sep 2025 05:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757397418;
	bh=tFNR+7k/gMkReLCo7mVEzsgh5MGEyA5qIcfqQHkdJKY=;
	h=Subject:From:Date:To:From;
	b=uTQblllNq1TZmm3Ub00VdJ5P0zvmskef8oTPlj9So8SZ2vzkCr6V0wKpL87zNHoRa
	 J02O7KlRsYbtDabCggp/KLGd4UXFkYdfyKudxhZJezmLQw+kXjWGbuUCHVshxjU+9O
	 KTXlqvANqmGkUz3TH8uZt7lMOFalVcd2duxc3wNYYOoy7ujQ0mX9v4msEoCIBrmd3b
	 Rb/Le+G7tN30D7lcG1WAIEgmBEECO5IeixogayAw9yAN5wIF2+hVnsJnXlQRJ+iK43
	 mvSmWwqs/eHSJgz7Dp2Ck62XP/hVIv8DBTxmMKx/oQlxLgNdNiFtr17xsbIXP2CDoe
	 4ou9tlR51kTYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD5383BF69;
	Tue,  9 Sep 2025 05:57:02 +0000 (UTC)
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
 <175739742162.525002.1962004628090729794.git-patchwork-housekeeping@kernel.org>
Date: Tue, 09 Sep 2025 05:57:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] support for Amlogic SPI Flash Controller IP (2025-09-09T05:13:25)
  Superseding: [v4] support for Amlogic SPI Flash Controller IP (2025-08-29T05:16:13):
    [v4,1/3] spi: dt-bindings: add Amlogic A113L2 SFC
    [v4,2/3] spi: amlogic: add driver for Amlogic SPI Flash Controller
    [v4,3/3] MAINTAINERS: Add an entry for Amlogic spifc driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


