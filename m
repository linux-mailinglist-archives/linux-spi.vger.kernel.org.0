Return-Path: <linux-spi+bounces-3174-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC48D623E
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 14:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0EA1F26710
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333EA158847;
	Fri, 31 May 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjeRNTEb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F353138485
	for <linux-spi@vger.kernel.org>; Fri, 31 May 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160213; cv=none; b=tiGGi7uSXyp0dDYN5viydt/DcwQ/9jaopfQRNpBGlTu7RYl7E1VbZz9lm+3sgh9LacyKmzDCYaPFdqn9JuAJRYqbBPXlxEbmo7xaZR5K8KqWZ/vulaipugh2+sedrQ3RyYTCw7Sp2u8Q2pE7+q8CAJZwJnhkVydZk8yv9N9rVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160213; c=relaxed/simple;
	bh=ycVAQALWfLNKrm1UusIj/8edYPcb6Mtn2Yob52JjblE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZqTuFkuH7Cq2n9aJrYr/JOKR3MbkntzTfKqu2omVtyKSlq0IYHPkb/IFwikh4khCQr9UjLD7YN8JlmiTOgXG+GNqRwFeoJjUn1hH+C5OkRJ4rg9sNWBOd02DiwD3cTaNpL8A/vT121xJpxihTurNgos+G8JiWsOFZx9Go0GUPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjeRNTEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95CCEC116B1;
	Fri, 31 May 2024 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717160212;
	bh=ycVAQALWfLNKrm1UusIj/8edYPcb6Mtn2Yob52JjblE=;
	h=Subject:From:Date:To:From;
	b=UjeRNTEbeRnGirII1CdEiR4ehcEPDXZZbQfPl988K4VSqOlohS8ROvpveVSax0mSv
	 81iwL1Iza37rPcNCirkTheHH4WqF3s4KT7A4biK8JpR+HB/mk4i3OkjM8F7FMsiPlt
	 jjbA98GBH5lTEteIP1UniIHa4CJHzybuVKZAC4qCwHXxRizfQL/HXzRmOIIhJFeaUh
	 5EAHv40lXMo4wzihEMgFBKNmi3f/EoQnk5GIb/cI9UN+h7X75SbdHG1JeqUj3SOG0j
	 U0DlCsamWxQPQVWZXBxZtU2EyNElnEAqEihZFBv6ts5t0hhzAbBKtMd2E2WY3u5sMq
	 Qq2S57KijuaOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8622CC4361B;
	Fri, 31 May 2024 12:56:52 +0000 (UTC)
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
 <171716021254.9976.8834975884606581598.git-patchwork-housekeeping@kernel.org>
Date: Fri, 31 May 2024 12:56:52 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema (2024-05-31T12:29:37)
  Superseding: [v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema (2024-05-14T07:00:47):
    [v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


