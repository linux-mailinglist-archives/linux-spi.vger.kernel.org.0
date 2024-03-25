Return-Path: <linux-spi+bounces-1984-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9488B0AA
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 20:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6C61C3DF64
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521882208E;
	Mon, 25 Mar 2024 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIsy3cJL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BA4C637
	for <linux-spi@vger.kernel.org>; Mon, 25 Mar 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396597; cv=none; b=NyHiLNlxXxNpTY0EgX9dTinoz+bwYbDUuOXqjM7qhx1Gh6hpY6fGVOeU5SxJjPZvg8L5aseE19gXbgonIVqkJdzzC9d/RbhcjuB/GA/ZThxz7Y1jFHwVNlNDLxAelxK86KPEl8va9yVgPN/3UHl8f4HXM4kewvXotgO4tSBPU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396597; c=relaxed/simple;
	bh=y/fh9G/x3rhLTgZXHRjdd5ZG5aiR++D9Kzx2zLaGOvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Ync89tfxXgZSYY8AgnniPV/62OjlPoZlaxRF/sMP5Sz5Y29ppTR4c1LXzz5dfWCcMOb65TZDYhTFnRpDUBry1u709oymRNE+sHsM/HC+EjPRCOk1VjAizekQ633Z2qZFjtl+0mxe3EFqKF5a13AclFZRX/WTB2eNraGczNa9byI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIsy3cJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9652DC433F1;
	Mon, 25 Mar 2024 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711396596;
	bh=y/fh9G/x3rhLTgZXHRjdd5ZG5aiR++D9Kzx2zLaGOvY=;
	h=Subject:From:Date:To:From;
	b=vIsy3cJLGMq6/mdpmFTr49sEdeijlfvkHeBaQ5kP+6Ta5uQo2fYl57zqdOsE/LRRh
	 jkxC5ognS/14dMGtxC3P1R1IozANwxqOFTb9aFKiAwN46ZNKpiYJtWFJjejTX8fbSu
	 UBQbYbK5jjcWvhpNwo+Z/5AhiQRs/zvET7NTOfCHmoDWUZ3x9mwY1kZJJHoWlvQT/B
	 osLIXVR7D9M6IvytVgqd63Z8/rLTZtFoK+kHv11C/hk/c9/gd3ARO8JE87aomUovQh
	 XP0kjiQZAw8FTDAZcWIUunrjyJim9bKYVrUylJSqwjKsfO2OJIAUn3EU9R/jLndcP1
	 WorxdTQ9QO7bA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87CE0D2D0EA;
	Mon, 25 Mar 2024 19:56:36 +0000 (UTC)
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
 <171139659654.26564.9698562126479345583.git-patchwork-housekeeping@kernel.org>
Date: Mon, 25 Mar 2024 19:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: remove struct spi_message::is_dma_mapped (2024-03-25T19:22:53)
  Superseding: [v1] spi: remove struct spi_message::is_dma_mapped (2024-03-15T22:29:43):
    spi: remove struct spi_message::is_dma_mapped


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


