Return-Path: <linux-spi+bounces-4054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4693F061
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 10:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A9E1C21860
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B713CA95;
	Mon, 29 Jul 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlZh82NM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B560139D12
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243411; cv=none; b=DlHn2cpWNyzAEiSHZCOo2AHx3r5gyXibOiIeONnqG+I4+8Catw6aoqtc1xt6LtT5Bx8OA3vGLC5FS0oUC705+DJYpcmJ+xndZSBVZiVcuwZIPB9YtmT29M7fkrMzK201/8Nt5eXa2PNRW5r6Rt3eF8TXoLYW3pooFbhoBEexOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243411; c=relaxed/simple;
	bh=2F0NdEgz78hSzeLpxcqC0pqZMeLD5wVVtGjDNqhE1Zo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=O0nkEO3jBHrj4nhWwl8VuoDVAtLtIM0xcGfjRkhzMjFu/pElNiVqybkyqWhGJWhWftASTh1lusvpoHMknMHQO3HHIYE2Q83kdzmDBrEp4MjPMq7gETOcXeON/3gVzNxmI7WVpycGKm+OUwGuyFrLMdVPnW8hFsXpevt4fqyLeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlZh82NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2930C32786;
	Mon, 29 Jul 2024 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722243410;
	bh=2F0NdEgz78hSzeLpxcqC0pqZMeLD5wVVtGjDNqhE1Zo=;
	h=Subject:From:Date:To:From;
	b=dlZh82NMYjJ4ijExwX0qkF6PUVyiYuw0LrVkjHLZgShOuzOaOYEznOL7donFhEAdk
	 yTsxqFCco2+L6gW92g/+1hB5ZXU/1h+5dOpYrQOEATSDprSOj0v0p1CNjnTC08th/A
	 AV6kL8DQ8WiPH9CjzOgQaXeRdb6RUdmMtXnnLzu/fBHt4O0Ai3Rfv4bUEnEz5E4uy0
	 JunNj1j7fP+zTYq0hcySpEQjqP8rEModWieLQe0j3dcgRpcynZLRQzFNLo+5qxgYLo
	 /drqoNvyBJ73y75ND4iqOm1sE7QdwRqhPwHDZAT6qfToHGfvtVE9NTfzm846YtiKu6
	 bQyu8EEpoJUdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8C06C43445;
	Mon, 29 Jul 2024 08:56:50 +0000 (UTC)
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
 <172224341075.9608.13377051987594413086.git-patchwork-housekeeping@kernel.org>
Date: Mon, 29 Jul 2024 08:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: add driver for Intel discrete graphics (2024-07-29T08:43:14)
  Superseding: [v4] spi: add driver for Intel discrete graphics (2024-07-28T13:06:26):
    [v4,01/12] spi: add driver for intel graphics on-die spi device
    [v4,02/12] spi: intel-dg: implement region enumeration
    [v4,03/12] spi: intel-dg: implement spi access functions
    [v4,04/12] spi: intel-dg: spi register with mtd
    [v4,05/12] spi: intel-dg: implement mtd access handlers
    [v4,06/12] spi: intel-dg: align 64bit read and write
    [v4,07/12] spi: intel-dg: wake card on operations
    [v4,08/12] drm/i915/spi: add spi device for discrete graphics
    [v4,09/12] drm/i915/spi: add intel_spi_region map
    [v4,10/12] drm/i915/spi: add support for access mode
    [v4,11/12] drm/xe/spi: add on-die spi device
    [v4,12/12] drm/xe/spi: add support for access mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


