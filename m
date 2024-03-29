Return-Path: <linux-spi+bounces-2110-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58593891838
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 12:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB09A1F21F22
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD437BB0D;
	Fri, 29 Mar 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKeRvDMp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2172A1A5
	for <linux-spi@vger.kernel.org>; Fri, 29 Mar 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713408; cv=none; b=LwdsuM7lZw6gtWWpcVmoMFQFcFHoGju4/PgWu3vOXCydZ1cJfO+bdCIHGV2lYqAOAs8YBrQoaNO2K5vcwZgxD32O7m/nkz7Yk7iPpMhdexX+wJ9QqSeVzfBOKsNlSbLGLbjy88/5OugYeKYXtrbKLbtW7WrFirvqi8S27Ydu8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713408; c=relaxed/simple;
	bh=idWe/9G52ikRrWTYGd4yXAPzIziTjJFuceQIFhnnKGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cyZXfcXMUFOLpO6uZEL36S2wqSKQ3j1KkAwW9G/jreeUmY2XuwinSXq0fZ1qFHy82ozPK7PhtZhHiMmoEeTe/EhGovcdPzukhk1c0hldA1NJym9Ou/yRIoakOzZt5l7UNq0MbTc+v8yK+kfUVTLhRlwyk19/V/uRRFyFpEJHrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKeRvDMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89F5CC433F1;
	Fri, 29 Mar 2024 11:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711713408;
	bh=idWe/9G52ikRrWTYGd4yXAPzIziTjJFuceQIFhnnKGA=;
	h=Subject:From:Date:To:From;
	b=TKeRvDMpzp4exeqTtnZUq45zUl3lo2RW861WGfpOoFUKVw5brFWuEA3hc25ftz/s0
	 viX437Z4dnCMhVyTHSot5dgeCKNDxlJKOlQQPGO2bpjcLyJtskw5r5ZO4pYm6EY3tP
	 GXryciBb2xyfd4ew/bdpXCwc3/tX6v2G4YeMiVRo8fzgOUZEs05MHQjlkV2adNyBqk
	 xDywg8zExaRnRnjX38On9OBhfn5H6lG3hOMMuBXJINWLUNX1+Z7mET8Z4YY4k5S1S9
	 1pljIT1q6oL9v5l/u1UX/Ndk0kMUN4kVeGShXIwnVZgDXhJrP4z6GrOw1WzcwogChY
	 tPeC7pcKGzdbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B895D2D0EE;
	Fri, 29 Mar 2024 11:56:48 +0000 (UTC)
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
 <171171340850.935.14180008637676300730.git-patchwork-housekeeping@kernel.org>
Date: Fri, 29 Mar 2024 11:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add bridged amplifiers to cs42l43 (2024-03-29T11:47:28)
  Superseding: [v2] Add bridged amplifiers to cs42l43 (2024-03-28T14:01:18):
    [v2,1/3] gpio: swnode: Add ability to specify native chip selects for SPI
    [v2,2/3] spi: Add a mechanism to use the fwnode name for the SPI device
    [v2,3/3] spi: cs42l43: Add bridged cs35l56 amplifiers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


