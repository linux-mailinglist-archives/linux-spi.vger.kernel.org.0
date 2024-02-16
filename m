Return-Path: <linux-spi+bounces-1408-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0D85831F
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469E21C20C73
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 16:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360F12EBF4;
	Fri, 16 Feb 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGaXspCH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DD5465D
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102586; cv=none; b=Q1i3/gAbJ5C+5MckkG0NqySq58/UXlaDbXIm79i14EcqZ4KqWYBGrfdYTK/fYt4zKXONbCuELtxObmgWyFKHUN9UT8bl6zRTnO7NIf54MRZSZedezH1daT11qJ9BE0D/DJ7j1btDm/lku8Dc1TwOL/RVrYap9fgkxr0e1aNTLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102586; c=relaxed/simple;
	bh=NgEq85/N9CKXUODJFIOORla1F17CnKhrz0dFjk+TRzk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bwCN/Ab8lD5nFsZknb0H7WHaDwfvMl3VS4Pebv+qlW3P3i1SZ5qIioKGA+7YtSHHhPnCMVI92l7KgHug0Du5urIprskSz92881aMoeZuWKZ7UAhhZbp8ErOI2pkcy2YLtDLBvK/+5A8TwBzal9AiwS5zXrECjaa4ZqzqtlTM+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGaXspCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3532C433C7;
	Fri, 16 Feb 2024 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708102585;
	bh=NgEq85/N9CKXUODJFIOORla1F17CnKhrz0dFjk+TRzk=;
	h=Subject:From:Date:To:From;
	b=KGaXspCH1xmhz0S9PdlrNUkIm4RGMfghPqrjocWMLZsfu8Gbi5rKEp7Ab8EhTntOS
	 TPXa47nZYpfey0XamHql4ro8ZpPT+zJC/9ES7470atTcD0pKZIRV/BXQAdvU0WAcjc
	 ONczSVoZFCxYiVQO8PGTZm5/fr3qmyOqsEF7gBctiseVKF/VhBAzxGBzzQQOzdPQlq
	 WKN0QwwDUKYLnfWy3ay4EDdpwmy+/Pi9iBiD3RI10mZ21bDXfTkYX7rqWhXvgZT6Mf
	 PXfnXd50TOHoGhmuK2FL99FsZsJz3pCqC/h3Z48uDc1xUMT/velBAe0IOZH0fCyi96
	 H+OXGN1T2x/zQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CF58D84BCD;
	Fri, 16 Feb 2024 16:56:25 +0000 (UTC)
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
 <170810258563.16776.12027256897928776511.git-patchwork-housekeeping@kernel.org>
Date: Fri, 16 Feb 2024 16:56:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-mem: add statistics support to ->exec_op() calls (2024-02-16T16:42:19)
  Superseding: [v1] spi: spi-mem: add statistics support to ->exec_op() calls (2024-02-09T13:51:23):
    spi: spi-mem: add statistics support to ->exec_op() calls


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


