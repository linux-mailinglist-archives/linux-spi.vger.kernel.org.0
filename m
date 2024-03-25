Return-Path: <linux-spi+bounces-1978-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC0B88A9D4
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 17:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5CB1F35CDA
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCF212E1D2;
	Mon, 25 Mar 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXWdZPhx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854316F91E
	for <linux-spi@vger.kernel.org>; Mon, 25 Mar 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378599; cv=none; b=sob+ZeUhbT2T1RI4dwpkzshsIZmoOel/UnF9UOFlXchotLicazE1DHAN3Ox7x9hhC5oqiyE1e/7TX/lx/ynEVZOVlQ4pEpfUBv7WPmU4QuLV97AJFAgU3YR3Ti+6Uu7ihugAQOKoogwcxLayAkoBCqR0AbPABwFIPMxKGXxfN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378599; c=relaxed/simple;
	bh=TNaEsVQymByE8LdC0R6SQJEwFxBZ1/N1XhnxDAaLwQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JO39ES9six12M1V6EIvR5JuMajfHvFXdWt1MicOfour76RD27YLOx59ARLrq/t5SDtQ6fitR6cpCqVTTLmnfF9D762peotKawMnv3vAgtxWR7ukjwjo63I0YZVmAkrfi8+iP7YQNx3xQWi1zGbaOWUP+Fd3nlxNkdvF4S+2BNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXWdZPhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FB55C433F1;
	Mon, 25 Mar 2024 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711378599;
	bh=TNaEsVQymByE8LdC0R6SQJEwFxBZ1/N1XhnxDAaLwQo=;
	h=Subject:From:Date:To:From;
	b=AXWdZPhxwQSOSILNQ6B9sp2ZXJqpk8V58XmnXC6KMBYOpdtMISrXOQXy0Rd3eFBZ4
	 q2XQh7ZAK3iD7iu7UxBOCyMv9e4emLc4LeiydTHPizSVNiN59SikNQYNC4p++wGJ7u
	 qz+ut3QxF89DwbgXvbMEIrp15jQKIqsGGmXyCwmo29TkR9SMGZovQkXZDZjDsXcbF8
	 2idu7+Oat5VqToWVe77EXtNwd7e0ui41xhLcQlKMHpAsTikf77xNsLnEu8jQzC86zk
	 NlXPoWhZxW5lZC+StHyXLpzZOh3CeMHk0BU7axwsNWrI/c8IzqWpz5OIIMMdMJklIb
	 mBWf67X2PBRyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25B83D2D0EA;
	Mon, 25 Mar 2024 14:56:39 +0000 (UTC)
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
 <171137859914.15287.4388980857167647250.git-patchwork-housekeeping@kernel.org>
Date: Mon, 25 Mar 2024 14:56:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: rspi: Get rid of unused struct rspi_plat_data (2024-03-25T14:20:04)
  Superseding: [v1] spi: rspi: Get rid of unused struct rspi_plat_data (2024-03-07T15:50:45):
    [v1,1/1] spi: rspi: Get rid of unused struct rspi_plat_data


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


